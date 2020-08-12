/*
* Copyright (c) 2020 Magnus Lundin (https://magnuslundin.se)
*
* This program is free software; you can redistribute it and/or
* modify it under the terms of the GNU General Public
* License as published by the Free Software Foundation; either
* version 2 of the License, or (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
* General Public License for more details.
*
* You should have received a copy of the GNU General Public
* License along with this program; if not, write to the
* Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
* Boston, MA 02110-1301 USA
*
* Authored by: Author <magnus.lundin@hey.com>
*/

public class TaskMan : Gtk.Application {

    private TaskList tasklist;

    public TaskMan () {
        Object (
            application_id: "com.github.magnuslundin.taskman",
            flags: ApplicationFlags.FLAGS_NONE
        );
    }
    protected override void activate () {
        var main_window = new Gtk.ApplicationWindow (this) {
            default_height = 300,
            default_width = 300,
            title = "TaskMan"
        };
        var headerbar = new Gtk.HeaderBar () {
            show_close_button = true
        };
        var add_button = new Gtk.Button.from_icon_name ("list-add", Gtk.IconSize.LARGE_TOOLBAR) {
            action_name = "app.add-task"
        };
        headerbar.add (add_button);
        main_window.set_titlebar (headerbar);

        this.tasklist = new TaskList ();
        this.tasklist.tasklist_updated.connect (() => {
            main_window.show_all ();
        });
        main_window.add (this.tasklist);

        var add_task_action = new SimpleAction ("add-task", null);
        add_action (add_task_action);
        set_accels_for_action ("app.add-task", {"<Control>n"});
        add_task_action.activate.connect (() => {
            var task = new Task.with_data ("Task #" + (tasklist.length ()+1).to_string (), "", false);
            task.task_deleted.connect ((s, t) => {
                message ("Deleting task");
                tasklist.remove (t);
            });
            this.tasklist.add_task (task);
            message ("Adding task #" + tasklist.length ().to_string ());
        });

        main_window.show_all ();
    }
    public static int main (string[] args) {
        return new TaskMan ().run (args);
    }
}