ROBOT : dialog
{
    label = "Forward Kinematics";
    : edit_box
    {
	key = "a1";
	label = "Length of the first link:";
	edit_width = 6;
    }
    : edit_box
    {
	key = "a2";
	label = "Length of the second link:";
	edit_width = 6;
    }
    : edit_box
    {
	key = "tita1";
	label = "Degrees of angle tita1:";
	edit_width = 6;
    }
    : edit_box
    {
	key = "tita2";
	label = "Degrees of angle tita2:";
	edit_width = 6;
    }
    spacer;
    ok_cancel;
}
