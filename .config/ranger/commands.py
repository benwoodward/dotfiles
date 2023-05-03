from ranger.api.commands import Command

# Reveal files in Finder
class show_files_in_finder(Command):

    def execute(self):
        import subprocess
        files = ",".join(['"{0}" as POSIX file'.format(file.path) for file in self.fm.thistab.get_selection()])
        reveal_script = "tell application \"Finder\" to reveal {{{0}}}".format(files)
        activate_script = "tell application \"Finder\" to set frontmost to true"
        script = "osascript -e '{0}' -e '{1}'".format(reveal_script, activate_script)
        self.fm.notify(script)
        subprocess.check_output(["osascript", "-e", reveal_script, "-e", activate_script])


# Reveal file from Finder
class get_finder(Command):

    def execute(self):
        import subprocess
        import os

        finder = self.fm.execute_command("osascript -e 'tell app \"Finder\" to POSIX path of (selection as alias)'",
                                      universal_newlines=True, stdout=subprocess.PIPE)
        stdout, _ = finder.communicate()
        if finder.returncode == 0:
            selected = os.path.abspath(stdout.strip())
            if os.path.isdir(selected):
                self.fm.cd(selected)
            else:
                self.fm.select_file(selected)


# Quicklook / Follow files in Finder
class follow_files_in_finder(Command):

    def execute(self):
        import subprocess
        file = '"{0}"'.format(self.fm.thisfile.path)
        script1 = "set thePath to {{{0}}} as text".format(file)
        script2 = "set name_ to name of (info for thePath)"
        script3 = "set a_ to count thePath"
        script4 = "set b_ to count name_"
        script5 = "set minus_ to a_ - b_"
        script6 = "set parentPath to text 1 thru (minus_) of thePath"
        script7 = "tell application \"Finder\" to set target of front Finder window to (POSIX file parentPath)"
        script8 = "tell application \"Finder\" to reveal thePath as POSIX file"
        script9 = "tell application \"Finder\" to set frontmost to false"
        script = "osascript -e '{0}' -e '{1}' -e '{2}' -e '{3}' -e '{4}' -e '{5}' -e '{6}' -e '{7}' -e '{8}'".format(script1, script2, script3, script4, script5, script6, script7, script8, script9)
        subprocess.check_output(["osascript", "-e", script1, "-e", script2, "-e", script3, "-e", script4, "-e", script5, "-e", script6, "-e", script7, "-e", script8, "-e", script9])

follow = False
class follow_files(Command):

    def execute(self):
        global follow
        follow = not follow
        if follow:
            # Too speed up things delete lines below and uncomment one liner.
            
            # Creates a finder window with file revealed
            self.fm.execute_console("shell -s open -R %s")
            
            # Updates Window Manager Layout CMD+OPT+CTRL+SHIFT+R / Change to yours or delete entirely if not needed
            self.fm.execute_console("shell -s osascript -e 'tell application \"System Events\" to keystroke \"r\" using {control down, command down, option down, shift down}'")

            # Sets Finder window to Gallery View, removes toolbar and moves focus back to terminal, in this case to iTerm
            self.fm.execute_console("shell -s osascript -e 'tell application \"System Events\" to click menu item \"as Gallery\" of menu 1 of menu bar item \"View\" of menu bar 1 of application process \"Finder\"' -e 'tell application \"Finder\"' -e 'tell the front window to set toolbar visible to false' -e 'end tell' -e 'tell application \"iTerm\" to activate'")

            # One liner
            # self.fm.execute_console("shell -s open -R %s; osascript -e 'tell application \"System Events\" to keystroke \"r\" using {control down, command down, option down, shift down}' -e 'tell application \"System Events\" to click menu item \"as Gallery\" of menu 1 of menu bar item \"View\" of menu bar 1 of application process \"Finder\"' -e 'tell application \"Finder\"' -e 'tell the front window to set toolbar visible to false' -e 'end tell' -e 'tell application \"iTerm\" to activate'")
            
            # Change to your directional keys
            self.fm.execute_console("map <UP>       chain move up=1;    follow_files_in_finder")
            self.fm.execute_console("map <DOWN>     chain move down=1;  follow_files_in_finder")
            self.fm.execute_console("map <LEFT>     chain move left=1;  follow_files_in_finder")
            self.fm.execute_console("map <RIGHT>    chain move right=1; follow_files_in_finder")
            self.fm.execute_console("map <HOME>     chain move to=0;    follow_files_in_finder")
            self.fm.execute_console("map <END>      chain move to=-1;   follow_files_in_finder")
            self.fm.execute_console("map <PAGEDOWN> chain move down=1   pages=True; follow_files_in_finder")
            self.fm.execute_console("map <PAGEUP>   chain move up=1     pages=True; follow_files_in_finder")
        else:
            # Revert Finder's view mode and closes it's Window / Change to desired view mode if needed
            self.fm.execute_console("shell -s osascript -e 'tell application \"Finder\"' -e 'tell the front window to set toolbar visible to true' -e 'end tell' -e 'tell application \"Finder\" to set the current view of the front Finder window to list view' -e 'tell application \"Finder\" to close its front window'")
            
            # Reverts key maps on stop file following
            self.fm.execute_console("map <UP>       move up=1")
            self.fm.execute_console("map <DOWN>     move down=1")
            self.fm.execute_console("map <LEFT>     move left=1")
            self.fm.execute_console("map <RIGHT>    move right=1")
            self.fm.execute_console("map <HOME>     move to=0")
            self.fm.execute_console("map <END>      move to=-1")
            self.fm.execute_console("map <PAGEDOWN> move down=1   pages=True")
            self.fm.execute_console("map <PAGEUP>   move up=1     pages=True")

# Toggle Finder's red and ranger's standard tags on selected files
class red_tag(Command):

    def execute(self):
        self.fm.execute_console('shell -s if [ "$(tag -l -N %s)" = "red" ]; then; tag -r "red" %s; elif [ "$(tag -l -N %s)" = "" ]; then; tag -a "red" %s; fi')
        self.fm.execute_console("tag_toggle")
