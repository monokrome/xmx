# TODO: Change things to use format instead of regex
tmux =
  clientsList: ///^
    ([^:]+):\s               # TTY path (client identifier)
    (\d+)\s                  # Active session for this client
    \[(\d+)x(\d+)\s          # Dimensions
    ([^\]]+)\]\s             # Terminal type
    \(([^\)])+\)\s           # Encoding
  $///


  sessionsList: ///^
    (\d+)\:\s                # Session identifier
    (\d+)\swindows\s+        # Windows in session
    \(created ([^\)]+)\)\s+  # Creation date
    \[(\d+)x(\d+)\]          # Dimensions
    (\s+\((\w+)\))?          # Attached state
  $///


  windowsList: ///^
    (\d+)\:\s                # Window identifier
    ([^\s]+)\s               # Window name
    \((\d+)\spanes\)\s       # Pane count
    \[(\d+)x(\d+)\]\s        # Dimensions
    \[layout\s([^\s]+)\s     # Window layout
    @(\d+)                   # No idea wtf that is
    (\s\((\w+)\))?           # Window state
  $///


  panesList: ///^
    ((\d+)\.)?               # Optional window identifier
    (\d+)                    # Pane identifier
    \:\s
    \[(\d+)x(\d+)\]\s        # Dimensions
    \[history\s
    (\d+)/(\d+),\s           # History line count
    (\d+)\sbytes]\s          # History size
    %(\d+)                   # Don't know wtf that is
    (\s+\((\w+)\))?          # State
  $///


module.exports = {tmux}
