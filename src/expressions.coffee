module.exports =
  tmux:
    clientsList: ///^
      ([^:]+):\s               # TTY path
      (\d+)\s                  # Dunno wtf that is
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
      ([^\*]+)\*\s             # Window name
      \((\d+)\spanes\)\s       # Pane count
      \[(\d+)x(\d+)\]\s        # Dimensions
      \[layout\s([^\s]+)\s     # Window layout
      @(\d+)\s                 # No idea wtf that is
      \((\w+)\)                # Window state
    $///

    panesList: ///^
      (\d+)\:\s                # Pane identifier
      \[(\d+)x(\d+)\]\s        # Dimensions
      \[history\s
      (\d+)/(\d+),\s           # History line count
      (\d+)\sbytes]\s          # History size
      %(\d+)                   # Don't know wtf that is
      (\s+\((\w+)\))?          # State
    $///

