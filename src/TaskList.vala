/*
* Copyright (c) 2011-2018 Magnus Lundin (https://magnuslundin.se)
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

public class TaskList : Gtk.Grid {

    private Gtk.ApplicationWindow main_window;
    public List<Task> tasks;

    public TaskList (Gtk.ApplicationWindow main_window) {
        this.main_window = main_window;
        this.column_spacing = 6;
        this.row_spacing = 6;
        this.tasks = new List<Task> ();
    }
    public void add_task (Task task) {
        this.tasks.append (task);
        this.attach (task, 0, (int)this.tasks.length ());
        main_window.show_all ();
        message ("Adding task to position %d", (int)this.tasks.length ());
    }
}