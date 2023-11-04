RINGS : dialog
{
    label = "Rings";
    : boxed_radio_row
    {
	label = "Type";
	: radio_button
	{
		key = "N";
		label = "Normal";
	}
	: radio_button
	{
		key = "M";
		label = "Massive";
	}
    }
    : image_button
    {
     	key = "SlideType";
      	width = 15.0;
      	height = 10.0;
      	aspect_ratio = 1;
      	color = -2;
    }
    spacer;
    : boxed_radio_row
    {
	label = "Color";
	: radio_button
	{
		key = "G";
		label = "Golden";
	}
	: radio_button
	{
		key = "S";
		label = "Silver";
	}
	: radio_button
	{
		key = "B";
		label = "Black";
	}
    }
    : boxed_radio_row
    {
	label = "Ring width";
	: radio_button
	{
		key = "W2";
		label = "2 mm";
	}
	: radio_button
	{
		key = "W4";
		label = "4 mm";
	}
	: radio_button
	{
		key = "W6";
		label = "6 mm";
	}
	: radio_button
	{
		key = "W8";
		label = "8 mm";
	}
    }
    : row
    {
    	fixed_width = true;
    	: column
    	{
      		width = 24.76;
      		fixed_width = true;
      		spacer;
      		: text {
        	key = "T1";
        	label = "Size:";
        }
        }
	: popup_list
	{
        	key = "Size";
        	list = " \n4 (diameter 14.8 mm)\n5 (diameter 15.6 mm)\n6 (diameter 16.6 mm)\n7 (diameter 17.2 mm)\n8 (diameter 18.1 mm)\n9 (diameter 19.1 mm)\n10 (diameter 19.7 mm)";
        	width = 15;
        	fixed_width = true;
        }
    }
    : row
    {
    	fixed_width = true;
    	: column
    	{
      		width = 24.76;
      		fixed_width = true;
      		spacer;
      		: text {
        	key = "T2";
        	label = "Ring head shape:";
        }
        }
	: popup_list
	{
        	key = "RHS";
        	list = " \nButterfly\nFlower\nHeart\nStar\nSun\nAnchor\nCompass";
        	width = 15;
        	fixed_width = true;
        }
    }
    spacer;
    : image_button
    {
     	key = "SlideRHS";
      	width = 15.0;
      	height = 10.0;
      	aspect_ratio = 1;
      	color = -2;
    }
    spacer;
    ok_cancel;
}
