options missing=0;
title1 'Ames Housing';

proc contents data=ameshousing;
run;

*****************
STYLING
*****************;
title2 'Styling';

*STYLE= option in PROC REPORT statement - Exercise 1;
title3 'STYLE= for header in PROC REPORT statement';
proc report data=ameshousing style(header)=[foreground=green];
	where yr_sold=2010;
	format bldg_type $bldg_type. sale_type $sale_type.;

	column bldg_type sale_type saleprice gr_liv_area;
	define bldg_type / group;
	define sale_type / group;
	define saleprice / mean format=dollar15.2;
	define gr_liv_area / mean format=8.;

	break after bldg_type / summarize;
	rbreak after / summarize;

run;

*STYLE= option in DEFINE statement for header - Exercise 2;
title3 'STYLE= for header in DEFINE statement';
proc report data=ameshousing style(header)=[foreground=green];
	where yr_sold=2010;
	format bldg_type $bldg_type. sale_type $sale_type.;

	column bldg_type sale_type saleprice gr_liv_area;
	define bldg_type / group style(header)=[foreground=black font_size=14pt];
	define sale_type / group;
	define saleprice / mean format=dollar15.2;
	define gr_liv_area / mean format=8.;

	break after bldg_type / summarize;
	rbreak after / summarize;

run;

*STYLE= option in DEFINE for column data - Exercise 3;
title3 'STYLE= for column in DEFINE statement';
proc report data=ameshousing style(header)=[foreground=green];
	where yr_sold=2010;
	format bldg_type $bldg_type. sale_type $sale_type.;

	column bldg_type sale_type saleprice gr_liv_area;
	define bldg_type / group style(header)=[foreground=black font_size=14pt];
	define sale_type / group style(column)=[background=lightyellow];
	define saleprice / mean format=dollar15.2;
	define gr_liv_area / mean format=8.;

	break after bldg_type / summarize;
	rbreak after / summarize;

run;

*STYLE= option in DEFINE statement using a format - Exercise 4;
title3 'Use STYLE= and a format';
proc format;
	value size
		low-500 = 'red'
		500-700 = 'orange'
		700-1000 = 'yellow'
		1000-1500 = 'lightgreen'
		1500-high = 'green';
run;

proc report data=ameshousing style(header)=[foreground=green];
	where yr_sold=2010;
	format bldg_type $bldg_type. sale_type $sale_type.;

	column bldg_type sale_type saleprice gr_liv_area;
	define bldg_type / group style(header)=[foreground=black font_size=14pt];
	define sale_type / group style(column)=[background=lightyellow];
	define saleprice / mean format=dollar15.2;
	define gr_liv_area / mean format=8. style(column)=[background=size.];

	break after bldg_type / summarize;
	rbreak after / summarize;

run;


*add style formatting to summary rows - Exercise 5;
*notice how this overwrites some of the other formatting;
title3 'Summary rows style formatting';
proc report data=ameshousing style(header)=[foreground=green] style(summary)=[font_weight=bold background=lightblue];
	where yr_sold=2010;
	format bldg_type $bldg_type. sale_type $sale_type.;

	column bldg_type sale_type saleprice gr_liv_area;
	define bldg_type / group style(header)=[foreground=black font_size=14pt];
	define sale_type / group style(column)=[background=lightyellow];
	define saleprice / mean format=dollar15.2;
	define gr_liv_area / mean format=8. style(column)=[background=size.];

	break after bldg_type / summarize;
	rbreak after / summarize;

	compute after;
		bldg_type = 'GTotal';
		call define(_row_,'style','style={font_size=14pt}');
	endcomp;
run;

*add style based on another column - Exercise 6;
title3 'Style based on another row';
proc report data=ameshousing style(header)=[foreground=green] style(summary)=[font_weight=bold background=lightblue];
	where yr_sold=2010;
	format bldg_type $bldg_type. sale_type $sale_type.;

	column bldg_type sale_type saleprice gr_liv_area;
	define bldg_type / group style(header)=[foreground=black font_size=14pt];
	define sale_type / group style(column)=[background=lightyellow];
	define saleprice / mean format=dollar15.2;
	define gr_liv_area / mean format=8. style(column)=[background=size.];

	break after bldg_type / summarize;
	rbreak after / summarize;

	compute after;
		bldg_type = 'GTotal';
		call define(_row_,'style','style={font_size=14pt}');
	endcomp;

	compute saleprice;
		if sale_type = 'New' then call define(_col_,'style','style={background=lightpink}');
		*if sale_type = 'New' then call define('saleprice.mean','style','style={background=lightpink}');
		*if put(sale_type,$sale_type.) = 'Home just constructed and sold' then call define(_col_,'style','style={background=lightpink}');
	endcomp;
run;


