if did_filetype()
  finish
endif

if getline(1) =~# '^#!.*python'
  setfiletype python
endif

if getline(1) =~# '^#!.*bash'
  setfiletype sh
endif
