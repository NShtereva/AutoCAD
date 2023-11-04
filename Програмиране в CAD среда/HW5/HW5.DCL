YINYANG : dialog
{
    label = "Draw the yin-yang symbol";
    : edit_box
    {
	key = "D1";
	label = "Diameter for the big circle:";
	edit_width = 6;
    }
    : edit_box
    {
	key = "D2";
	label = "Diameter for the small circle:";
	edit_width = 6;
    }
    spacer;
    : image_button
    {
      key = "Slide1";
      width = 15.0;
      height = 5.0;
      aspect_ratio = 1;
      color = -2;
    }
    spacer;
    ok_cancel;
}
