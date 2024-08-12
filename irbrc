require 'irb/completion'
# require 'irb/ext/save-history'
# require 'irbtools'

IRB.conf[:SAVE_HISTORY] = 200
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"
IRB.conf[:AUTO_INDENT] = true
IRB.conf[:USE_READLINE] = true

# module IRB::Color
#   TOKEN_SEQ_EXPRS.each do |token, (seq, exprs)|
#     seq[0] = CYAN if seq[0] == BLUE
#   end
#   remove_const :CYAN
#   CYAN = BLUE
# end
#
#IRB.conf[:LOAD_MODULES] = [] unless IRB.conf.key?(:LOAD_MODULES)
#unless IRB.conf[:LOAD_MODULES].include?('irb/completion')
#  IRB.conf[:LOAD_MODULES] << 'irb/completion'
#end 
