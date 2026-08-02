
# ~/.irbrc — comfy IRB & Rails console with popup autocomplete

# --- helpers -----------------------------------------------------------------
def try_require(lib)
  require lib
  true
rescue LoadError
  false
end

# --- base IRB config ----------------------------------------------------------
ENV['IRB_USE_AUTOCOMPLETE'] = '1'     # ensure popup completion in modern IRB
try_require 'irb'
try_require 'irb/completion'
try_require 'irb/ext/save-history'

# Prefer Reline (needed for popup menu). On some setups USE_READLINE=true conflicts.
IRB.conf[:USE_READLINE]     = false
IRB.conf[:USE_AUTOCOMPLETE] = true    # popup completion (Reline dialog)
IRB.conf[:AUTO_INDENT]      = true
IRB.conf[:USE_COLORIZE]     = true
IRB.conf[:SAVE_HISTORY]     = 10_000
IRB.conf[:HISTORY_FILE]     = File.expand_path('~/.irb_history')
IRB.conf[:INSPECT_MODE]     = :pp     # pretty print by default

# Friendly tip if irb gem is too old for popup completion
begin
  ver_str = (IRB.respond_to?(:version) ? IRB.version : (defined?(IRB::VERSION) && IRB::VERSION)).to_s[/\d[\d.]+/]
  if ver_str && Gem::Version.new(ver_str) < Gem::Version.new('1.9.0')
    warn "[.irbrc] Tip: `gem install irb` to get the modern popup autocomplete."
  end
rescue StandardError
end

# --- nice printing ------------------------------------------------------------
if try_require('awesome_print') || try_require('amazing_print')
  AwesomePrint.irb!  if defined?(AwesomePrint)
  AmazingPrint.irb!  if defined?(AmazingPrint)
end
try_require 'pp'        # fallback pretty printer

# --- quality-of-life commands -------------------------------------------------
# `ls`, `show-doc`, `show-source`, `measure`, etc. (no-op if not present)
try_require 'irb/cmd/ls'
try_require 'irb/cmd/measure'

# quick benchmarking helper: bm { ... }
def bm(label = nil, &blk)
  require 'benchmark'
  label && print("#{label} ... ")
  t = Benchmark.realtime(&blk)
  puts format("→ %.3fs", t)
  t
end

# shorter `ri` docs: `ri 'Array#map'`
def ri(topic)
  try_require 'rdoc/ri/driver'
  RDoc::RI::Driver.run(RDoc::RI::Driver.process_args([topic.to_s]))
  nil
end

# --- IRB last value helper (robust across IRB versions) -----------------------
def __irb_last_value
  if defined?(IRB) && IRB.respond_to?(:CurrentContext) && IRB.CurrentContext
    IRB.CurrentContext.last_value
  elsif IRB.conf.dig(:MAIN_CONTEXT)
    IRB.conf[:MAIN_CONTEXT].last_value
  else
    begin
      _ # in IRB this is usually bound to last value
    rescue NameError
      nil
    end
  end
end

# copy last result to clipboard: `_` is last value in IRB
def copy(obj = :__USE_LAST__)
  val = (obj == :__USE_LAST__) ? __irb_last_value : obj
  s = val.is_a?(String) ? val : val.inspect

  if RUBY_PLATFORM =~ /darwin/
    IO.popen('pbcopy', 'w') { |io| io << s }
  elsif system('command -v xclip >/dev/null 2>&1')
    IO.popen('xclip -selection clipboard', 'w') { |io| io << s }
  elsif system('command -v xsel >/dev/null 2>&1')
    IO.popen('xsel --clipboard --input', 'w') { |io| io << s }
  else
    warn "No clipboard tool found (pbcopy/xclip/xsel)."
  end
  nil
end

# --- Rails niceties (only when Rails is loaded) --------------------------------
if defined?(Rails)
  app_name = (Rails.application.class.module_parent_name rescue 'RailsApp')

  IRB.conf[:PROMPT] ||= {}
  IRB.conf[:PROMPT][:RAILS] = {
    PROMPT_I: "[#{app_name}:#{Rails.env}] » ",
    PROMPT_N: "[#{app_name}:#{Rails.env}] » ",
    PROMPT_S: "[#{app_name}:#{Rails.env}] %l ",
    PROMPT_C: "[#{app_name}:#{Rails.env}] * ",
    RETURN:   "=> %s\n"
  }
  IRB.conf[:PROMPT_MODE] = :RAILS

  # console helpers
  if try_require('rails/console/app') && try_require('rails/console/helpers')
    include Rails::ConsoleMethods if defined?(Rails::ConsoleMethods)
  end

  # colored logs inline when needed
  try_require 'active_support/core_ext/module/attribute_accessors'
  begin
    ActiveSupport::LogSubscriber.colorize_logging = true
  rescue StandardError
  end

  # short aliases
  def r! ; reload! ; end
  def m  ; Rails.application.routes.url_helpers ; end
end

# --- Keybinding cheatsheet (Reline) -------------------------------------------
#   Ctrl+R — reverse search history
#   Tab    — popup autocomplete
#   Shift+Tab — reverse in popup
#   Ctrl+K — kill to end of line
#   Ctrl+A / Ctrl+E — line start/end
#   Alt+.  — yank last arg from previous command

# --- Optional: token theme tweak (safe no-op on older IRB) --------------------
if defined?(IRB::Color) && IRB::Color.const_defined?(:TOKEN_SEQ_EXPRS)
  # Example (disabled): tweak constant color
  # IRB::Color::TOKEN_SEQ_EXPRS[:T_CONSTANT]&.first&.[](0, IRB::Color::BLUE)
end

