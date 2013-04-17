module.exports =
  tmux:
    clientsList: ///^
      [^:]+:\s                 # TTY path
      (\d+)\s                  # Dunno wtf that is
      \[(\d+)x(\d+)\s          # Dimensions
      [^\]]+\]\s               # Terminal type
      \([^\)]+\)               # Encoding
    $///

    sessionList: ///^
      ^(\d+)\:\s               # Session identifier
      (\d+)\swindows\s+        # Windows in session
      \(created [^\)]+\)\s+    # Creation date
      \[(\d+)x(\d+)\]\s+       # Dimensions
      \(\w+\)                  # Attached state
    $///

    windowList: ///^
      (\d+)\:\s                # Window identifier
      ([^\*]+)\*\s             # Window name
      \((\d+)\spanes\)\s       # Pane count
      \[(\d+)x(\d+)\]\s        # Dimensions
      \[layout ([^\s]+)\s      # Window layout
      @(\d+)\s                 # No idea wtf that is
      \((\w)+\)                # Window state
    $///

    paneList: ///^
      (\d+)\:\s                # Pane identifier
      \[(\d+)x(\d+)\]\s        # Dimensions
      \[history\s
      (\d+)\/(\d+),\s          # History count
      (\d+)\sbytes\]\s         # Size of history
      %\d+\s                   # No idea wtf that is
      \((\w+)\)                # Pane state
    $///

