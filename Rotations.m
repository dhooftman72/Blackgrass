function [cyclus, movement, ploughing, Grass_2years_return,Flowers_3years_return,...
    number_of_years,start_length,length_cyclus,years_40,prop_cash] = Rotations(rotation_type)

%CORE ROTATIONS
% 1-5 Core rotations A-E
% 5-9 Rotations A-D with direct drilling
%10-11 C & D with alternated direct drilling

% COMBINED ROTATIONS REGULAR
% 12-17 BAU + grass cover (frequency every 1,2,3,4,5,6)
% 18-23 Best agronomy + grass cover (frequency every 1,2,3,4,5,6)
% 24-29 BAU + 3 year flower (frequency every 1,2,3,4,5,6)
% 30-35 Best agronomy + 3 year flower (frequency every 1,2,3,4,5,6)

% DIRECT DRILLING ROTATIOND
% 36-41  BAU + grass cover (frequency every 1,2,3,4,5,6) Direct DRILL
% 42-47 Best agronomy + grass cover (frequency every 1,2,3,4,5,6) Direct DRILL
% 48-53  BAU + 3 year flower (frequency every 1,2,3,4,5,6) Direct DRILL
% 54-59 Best agronomy + 3 year flower (frequency every 1,2,3,4,5,6) Direct DRILL

% DIRECT DRILLING PARTLY
% 60-65 BAU + 1 year grass (frequency every 1,2,3,4,5,6) 
% 66-71  Best agronomy + 1 year grass (frequency every 1,2,3,4,5,6) 
% 72-77 BAU + 1 year grass (frequency every 1,2,3,4,5,6) DIRECT DRILL
% 78-83  Best agronomy + 1 year grass (frequency every 1,2,3,4,5,6) DIRECT DRILL

%% DATA

% Non_invert_plough
X_11_c = 0.7;
X_12_c = 0.3;
X_21_c = 0.12;
X_22_c = 0.88;
movement_c = [X_11_c;X_12_c; X_21_c; X_22_c];
% Invert plough
X_11_p = 0.02;
X_12_p = 0.98;
X_21_p = 0.29;
X_22_p = 0.71;
movement_p = [X_11_p;X_12_p; X_21_p; X_22_p];
%No_plough
movement_no = [1;0;0;1];

Invert_plough = 0.285;% OSR following Gruber et al 2005 Table 5, T1 
Non_invert_plough = 0.143;% OSR following Gruber et al 2005 Table 5, T3 
no_plough = 0.0115; % OSR following Gruber et al 2005 Table 5, 

Rot_A_start = [1,2,3]; % to start or after another rotation type
Rot_A_after = [2,3]; % as within the same rotation cyclus [OSR_WW]
Rot_A_start_move = [movement_c,movement_c,movement_c];
Rot_A_after_move = [movement_c,movement_c];
Rot_A_start_incorp = [Non_invert_plough,Non_invert_plough,Non_invert_plough];
Rot_A_after_incorp = [Non_invert_plough,Non_invert_plough];

Rot_A_start_plus = [1,2,16]; % to start or after another rotation type
Rot_A_after_plus = [2,16]; % as within the same rotation cyclus [OSR_WWdrill]
Rot_A_start_move_plus = [movement_c,movement_c,movement_no];
Rot_A_after_move_plus = [movement_c,movement_no];
Rot_A_start_incorp_plus = [Non_invert_plough,Non_invert_plough,no_plough];
Rot_A_after_incorp_plus = [Non_invert_plough,no_plough];



Rot_B_start = [4,5,6]; % to start or after another rotation type
Rot_B_after = [5,6]; % as within the same rotation cyclus [Beans-WW]

Rot_B_start_move = [movement_c,movement_p,movement_c];
Rot_B_after_move = [movement_p,movement_c];
Rot_B_start_incorp = [Non_invert_plough,Invert_plough,Non_invert_plough];
Rot_B_after_incorp = [Invert_plough,Non_invert_plough];

Rot_B_start_plus = [4,5,17]; % to start or after another rotation type
Rot_B_after_plus = [5,17]; % as within the same rotation cyclus
Rot_B_start_move_plus = [movement_c,movement_p,movement_no];
Rot_B_after_move_plus = [movement_p,movement_no];
Rot_B_start_incorp_plus = [Non_invert_plough,Invert_plough,no_plough];
Rot_B_after_incorp_plus = [Invert_plough,no_plough];


Rot_C_start = [7,8,9]; % to start or after another rotation type
Rot_C_after = [8,9]; % as within the same rotation cyclus [Grass-WW]
Rot_C_start_move = [movement_c,movement_no,movement_c];
Rot_C_after_move = [movement_no,movement_c];
Rot_C_start_incorp = [Non_invert_plough,no_plough,Non_invert_plough];
Rot_C_after_incorp = [no_plough,Non_invert_plough];

Rot_C_start_plus = [7,8,18]; % to start or after another rotation type
Rot_C_after_plus = [8,18]; % as within the same rotation cyclus [Grass-WWdrill]
Rot_C_start_move_plus = [movement_c,movement_no,movement_c];
Rot_C_after_move_plus = [movement_no,movement_no]; % NOTE: No movement
Rot_C_start_incorp_plus = [Non_invert_plough,no_plough,Non_invert_plough];
Rot_C_after_incorp_plus = [no_plough,no_plough]; % NOTE: No plough


Rot_D_start = [10,11,12]; % 3-years cylcus ALSO within the same rotation cyclus,
%Rot_D_after = [10,11]; %#ok<*NASGU> % if following and being followed by Non-Invert WW !!!!!!!!!!!!!!!!!
Rot_D_start_move = [movement_no,movement_no,movement_c];
%Rot_D_after_move = [movement_no,movement_no];
Rot_D_start_incorp = [no_plough,no_plough,Non_invert_plough];
%Rot_D_after_incorp = [no_plough,no_plough];

Rot_D_start_plus = [10,11,19]; % 3-years cylcus ALSO within the same rotation cyclus,
%Rot_D_after_plus = [10,19]; %#ok<*NASGU> % if following and being followed by Non-Invert WW !!!!!!!!!!!!!!!!!
Rot_D_start_move_plus = [movement_no,movement_no,movement_no];
%Rot_D_after_move_plus = [movement_no,movement_no]; % NOTE: No movement
Rot_D_start_incorp_plus = [no_plough,no_plough,no_plough];
%Rot_D_after_incorp_plus = [no_plough,no_plough]; % NOTE: No plough


Rot_E_start = [13,14,15]; % to start or after another rotation type
Rot_E_after = 15; %1-year cyclus within the same rotation
Rot_E_after_other = [13,14,15,12]; % with an added WW, "borrowed from 2-years grass")
Rot_E_start_move = [movement_no,movement_no,movement_no];
Rot_E_after_move = [movement_no];
Rot_E_after_other_move =[movement_no,movement_no,movement_no,movement_c];
Rot_E_start_incorp = [no_plough,no_plough,no_plough];
Rot_E_after_incorp = [no_plough];
Rot_E_after_other_incorp = [no_plough,no_plough,no_plough,Non_invert_plough];
Rot_E_after_other_plus = [13,14,15,19]; % with an added WW with drilling, "borrowed from 2-years grass")
Rot_E_after_other_move_plus = [movement_no,movement_no,movement_no,movement_no];
Rot_E_after_other_incorp_plus = [no_plough,no_plough,no_plough,no_plough];

number_of_years = 250;

%% SINGLE ROTATIONS
if rotation_type == 1
    length_cyclus = 2;
    start_length = 6;
    cyclus = [Rot_A_start]; %#ok<*NBRAK>
    movement =[Rot_A_start_move];
    ploughing = [Rot_A_start_incorp];
    for i = 1:ceil(number_of_years/length_cyclus)
        cyclus = [cyclus,Rot_A_after]; %#ok<*AGROW>
        movement = [movement, Rot_A_after_move];
        ploughing = [ploughing, Rot_A_after_incorp];
    end
    %last movement&ploughing
    movement = [movement,movement_c];
    ploughing = [ploughing, Non_invert_plough];
    Grass_2years_return = nan;
    Flowers_3years_return = nan;
    years_40 = 1 + (ceil(40/length_cyclus)).*length_cyclus;
elseif rotation_type == 2
    length_cyclus = 2;
    start_length = 6;
    cyclus = [Rot_B_start];
    movement =[Rot_B_start_move];
    ploughing = [Rot_B_start_incorp];
    for i = 1:ceil(number_of_years/length_cyclus)
        cyclus = [cyclus,Rot_B_after];
        movement = [movement, Rot_B_after_move];
        ploughing = [ploughing, Rot_B_after_incorp];
    end
    %last movement&ploughing
    movement = [movement,movement_c];
     ploughing = [ploughing, Non_invert_plough];
    Grass_2years_return = nan;
    Flowers_3years_return = nan;
    years_40 = 1 + (ceil(40/length_cyclus)).*length_cyclus;
elseif rotation_type == 3
    length_cyclus = 2;
    start_length = 6;
    cyclus = [Rot_C_start];
    movement =[Rot_C_start_move];
    ploughing = [Rot_C_start_incorp];
    for i = 1:ceil(number_of_years/length_cyclus)
        cyclus = [cyclus,Rot_C_after];
        movement = [movement, Rot_C_after_move];
        ploughing = [ploughing, Rot_C_after_incorp];
    end
    %last movement&ploughing
    movement = [movement,movement_c];
    ploughing = [ploughing, Non_invert_plough];
    Grass_2years_return = nan;
    Flowers_3years_return = nan;
    years_40 = 1 + (ceil(40/length_cyclus)).*length_cyclus;
elseif rotation_type == 4
    length_cyclus = 3;
    start_length = 6;
    cyclus = [Rot_D_start];
    movement =[Rot_D_start_move];
    ploughing = [Rot_D_start_incorp];
    for i = 1:ceil(number_of_years/length_cyclus)
        cyclus = [cyclus,Rot_D_start]; %!!!! %#ok<*AGROW>
        movement = [movement, Rot_D_start_move];
        ploughing = [ploughing, Rot_D_start_incorp];
    end
    %last movement&ploughing
    movement = [movement,movement_c];
    ploughing = [ploughing, Non_invert_plough];
    Grass_2years_return = 1;
    Flowers_3years_return = nan;
    years_40 = (ceil(40/length_cyclus)).*length_cyclus;
elseif rotation_type == 5
    length_cyclus = 1;
    start_length = 6;
    cyclus = [Rot_E_start];
    movement =[Rot_E_start_move];
    ploughing = [Rot_E_start_incorp];
    for i = 1:ceil(number_of_years/length_cyclus)
        cyclus = [cyclus,Rot_E_after];
        movement = [movement, Rot_E_after_move];
        ploughing = [ploughing, Rot_E_after_incorp];
    end
    %last movement&ploughing
    movement = [movement,movement_no];
    ploughing = [ploughing, no_plough];
    Grass_2years_return = nan;
    Flowers_3years_return = 1;
    years_40 = 2 + (ceil(40/length_cyclus)).*length_cyclus;
elseif rotation_type == 6 % BAU with drilling in y3
    length_cyclus = 2;
    start_length = 6;
    cyclus = [Rot_A_start_plus]; %#ok<*NBRAK>
    movement =[Rot_A_start_move_plus];
    ploughing = [Rot_A_start_incorp_plus];
    for i = 1:ceil(number_of_years/length_cyclus)
        cyclus = [cyclus,Rot_A_after_plus]; %#ok<*AGROW>
        movement = [movement, Rot_A_after_move_plus];
        ploughing = [ploughing, Rot_A_after_incorp_plus];
    end
    %last movement&ploughing
    movement = [movement,movement_no];
    ploughing = [ploughing, no_plough];
    Grass_2years_return = nan;
    Flowers_3years_return = nan;
    years_40 = 1 + (ceil(40/length_cyclus)).*length_cyclus;
elseif rotation_type == 7 % Best agronomy with drilling in y3
    length_cyclus = 2;
    start_length = 6;
    cyclus = [Rot_B_start_plus];
    movement =[Rot_B_start_move_plus];
    ploughing = [Rot_B_start_incorp_plus];
    for i = 1:ceil(number_of_years/length_cyclus)
        cyclus = [cyclus,Rot_B_after_plus];
        movement = [movement, Rot_B_after_move_plus];
        ploughing = [ploughing, Rot_B_after_incorp_plus];
    end
    %last movement&ploughing
    movement = [movement,movement_no];
     ploughing = [ploughing, no_plough];
    Grass_2years_return = nan;
    Flowers_3years_return = nan;
    years_40 = 1 + (ceil(40/length_cyclus)).*length_cyclus;
elseif rotation_type == 8 % One year fallow with drilling in y3
    length_cyclus = 2;
    start_length = 6;
    cyclus = [Rot_C_start_plus];
    movement =[Rot_C_start_move_plus];
    ploughing = [Rot_C_start_incorp_plus];
    for i = 1:ceil(number_of_years/length_cyclus)
        cyclus = [cyclus,Rot_C_after_plus];
        movement = [movement, Rot_C_after_move_plus];
        ploughing = [ploughing, Rot_C_after_incorp_plus];
    end
    %last movement&ploughing
    movement = [movement,movement_no];
    ploughing = [ploughing, no_plough];
    Grass_2years_return = nan;
    Flowers_3years_return = nan;
    years_40 = 1 + (ceil(40/length_cyclus)).*length_cyclus;
elseif rotation_type == 9 % two year fallow with drilling in y3
    length_cyclus = 3;
    start_length = 6;
    cyclus = [Rot_D_start_plus];
    movement =[Rot_D_start_move_plus];
    ploughing = [Rot_D_start_incorp_plus];
    for i = 1:ceil(number_of_years/length_cyclus)
        cyclus = [cyclus,Rot_D_start_plus]; %!!!! %#ok<*AGROW>
        movement = [movement, Rot_D_start_move_plus];
        ploughing = [ploughing, Rot_D_start_incorp_plus];
    end
    %last movement&ploughing
    movement = [movement,movement_no];
    ploughing = [ploughing, no_plough];
    Grass_2years_return = 1;
    Flowers_3years_return = nan;    
    years_40 = (ceil(40/length_cyclus)).*length_cyclus;
elseif rotation_type == 10 % One year fallow with drilling in y3 alternated
    length_cyclus = 2;
    start_length = 6;
    cyclus = [Rot_C_start_plus];
    movement =[Rot_C_start_move_plus];
    ploughing = [Rot_C_start_incorp_plus];
    for i = 1:ceil(number_of_years/length_cyclus)
        cyclus = [cyclus,Rot_C_after,Rot_C_after_plus];
        movement = [movement, Rot_C_after_move,Rot_C_after_move_plus];
        ploughing = [ploughing,Rot_C_after_incorp,Rot_C_after_incorp_plus];
    end
    %last movement&ploughing
    movement = [movement,movement_no];
    ploughing = [ploughing, no_plough];
    Grass_2years_return = nan;
   Flowers_3years_return = nan;
   years_40 = 1 + (ceil(40/length_cyclus)).*length_cyclus;
elseif rotation_type == 11 % two year fallow with drilling in y3 alternated
    length_cyclus = 3;
    start_length = 6;
    cyclus = [Rot_D_start_plus];
    movement =[Rot_D_start_move_plus];
    ploughing = [Rot_D_start_incorp_plus];
    for i = 1:ceil(number_of_years/length_cyclus)
        cyclus = [cyclus,Rot_D_start,Rot_D_start_plus]; %!!!! %#ok<*AGROW>
        movement = [movement, Rot_D_start_move,Rot_D_start_move_plus];
        ploughing = [ploughing, Rot_D_start_incorp,Rot_D_start_incorp_plus];
    end
    %last movement&ploughing
    movement = [movement,movement_no];
    ploughing = [ploughing, no_plough];
    Grass_2years_return = 1;
    Flowers_3years_return = nan;   
years_40 =  (ceil(40/length_cyclus)).*length_cyclus;
%% COMBINED ROTATIONS REGULAR
elseif rotation_type == 12 % BAU with grass cover in between at different intervals
    %main_rotation_interval = 1;
      length_cyclus = 3+2;
    start_length = 6;
    cyclus = [Rot_D_start];
    movement =[Rot_D_start_move];
    ploughing = [Rot_D_start_incorp];
    for i = 1:ceil(number_of_years/length_cyclus)
        cyclus = [cyclus,Rot_A_after,Rot_D_start];  % [Grass-Grass-WW]-[OSR-WW]-[Grass-Grass-ww]
        movement = [movement,Rot_A_after_move, Rot_D_start_move];
        ploughing = [ploughing,Rot_A_after_incorp, Rot_D_start_incorp];
    end
    %last movement&ploughing
    movement = [movement,movement_c];
    ploughing = [ploughing, Non_invert_plough];
    Grass_2years_return = 3;
    Flowers_3years_return = NaN;
    years_40 = (ceil(40/length_cyclus)).*length_cyclus;
elseif rotation_type == 13 % BAU with grass cover in between at different intervals
    %main_rotation_interval = 2;
    length_cyclus = 3+2+2;
    start_length = 6;
    cyclus = [Rot_D_start];
    movement =[Rot_D_start_move];
    ploughing = [Rot_D_start_incorp];
    for i = 1:ceil(number_of_years/length_cyclus)
        cyclus = [cyclus,Rot_A_after, Rot_A_after, Rot_D_start];
        movement = [movement, Rot_A_after_move, Rot_A_after_move, Rot_D_start_move];
        ploughing = [ploughing, Rot_A_after_incorp, Rot_A_after_incorp, Rot_D_start_incorp];
    end
    %last movement&ploughing
    movement = [movement,movement_c];
    ploughing = [ploughing, Non_invert_plough];
    Grass_2years_return = 5;
    Flowers_3years_return = NaN;
     years_40 = (ceil(40/length_cyclus)).*length_cyclus;
elseif rotation_type == 14 % BAU with grass cover in between at different intervals
    %main_rotation_interval = 3;
    length_cyclus = 3+2+2+2;
     start_length = 6;
    cyclus = [Rot_D_start];
    movement =[Rot_D_start_move];
    ploughing = [Rot_D_start_incorp];
    for i = 1:ceil(number_of_years/length_cyclus)
        cyclus = [cyclus,Rot_A_after,Rot_A_after,Rot_A_after, Rot_D_start];
        movement = [movement, Rot_A_after_move, Rot_A_after_move, Rot_A_after_move, Rot_D_start_move];
        ploughing = [ploughing, Rot_A_after_incorp,Rot_A_after_incorp,Rot_A_after_incorp, Rot_D_start_incorp];
    end
    %last movement&ploughing
    movement = [movement,movement_c];
    ploughing = [ploughing, Non_invert_plough];
    Grass_2years_return = 7;
    Flowers_3years_return = NaN;
     years_40 = (ceil(40/length_cyclus)).*length_cyclus;
 elseif rotation_type == 15 % BAU with grass cover in between at different intervals
    %main_rotation_interval = 4;
    length_cyclus = 3+2+2+2+2;
     start_length = 6;
    cyclus = [Rot_D_start];
    movement =[Rot_D_start_move];
    ploughing = [Rot_D_start_incorp];
    for i = 1:ceil(number_of_years/length_cyclus)
        cyclus = [cyclus,Rot_A_after,Rot_A_after,Rot_A_after,Rot_A_after, Rot_D_start];
        movement = [movement, Rot_A_after_move,Rot_A_after_move, Rot_A_after_move, Rot_A_after_move, Rot_D_start_move];
        ploughing = [ploughing, Rot_A_after_incorp,Rot_A_after_incorp, Rot_A_after_incorp,Rot_A_after_incorp, Rot_D_start_incorp];
    end
    %last movement&ploughing
    movement = [movement,movement_c];
    ploughing = [ploughing, Non_invert_plough];
    Grass_2years_return = 9;
    Flowers_3years_return = NaN;
     years_40 = (ceil(40/length_cyclus)).*length_cyclus;
elseif rotation_type == 16 % BAU with grass cover in between at different intervals
    %main_rotation_interval = 5;
    length_cyclus = 3+2+2+2+2+2;
     start_length = 6;
    cyclus = [Rot_D_start];
    movement =[Rot_D_start_move];
    ploughing = [Rot_D_start_incorp];
    for i = 1:ceil(number_of_years/length_cyclus)
        cyclus = [cyclus,Rot_A_after,Rot_A_after,Rot_A_after,Rot_A_after,Rot_A_after, Rot_D_start];
        movement = [movement, Rot_A_after_move,Rot_A_after_move, Rot_A_after_move,Rot_A_after_move, Rot_A_after_move, Rot_D_start_move];
        ploughing = [ploughing, Rot_A_after_incorp,Rot_A_after_incorp,Rot_A_after_incorp,Rot_A_after_incorp,Rot_A_after_incorp, Rot_D_start_incorp];
    end
    %last movement&ploughing
    movement = [movement,movement_c];
    ploughing = [ploughing, Non_invert_plough];
    Grass_2years_return = 11;
    Flowers_3years_return = NaN;
     years_40 = (ceil(40/length_cyclus)).*length_cyclus;
elseif rotation_type == 17 % BAU with grass cover in between at different intervals
    %main_rotation_interval = 6;
    length_cyclus = 3+2+2+2+2+2+2;
     start_length = 6;
    cyclus = [Rot_D_start];
    movement =[Rot_D_start_move];
    ploughing = [Rot_D_start_incorp];
    for i = 1:ceil(number_of_years/length_cyclus)
        cyclus = [cyclus,Rot_A_after,Rot_A_after,Rot_A_after,Rot_A_after,Rot_A_after,Rot_A_after, Rot_D_start];
        movement = [movement, Rot_A_after_move,Rot_A_after_move, Rot_A_after_move,Rot_A_after_move,Rot_A_after_move, Rot_A_after_move, Rot_D_start_move];
        ploughing = [ploughing, Rot_A_after_incorp,Rot_A_after_incorp,Rot_A_after_incorp,Rot_A_after_incorp,Rot_A_after_incorp,Rot_A_after_incorp, Rot_D_start_incorp];
    end
    %last movement&ploughing
    movement = [movement,movement_c];
    ploughing = [ploughing, Non_invert_plough];
    Grass_2years_return = 13;
    Flowers_3years_return = NaN;
     years_40 = (ceil(40/length_cyclus)).*length_cyclus;
elseif rotation_type == 18 % Best agronomy with grass cover in between at different intervals
    %main_rotation_interval = 1;
      length_cyclus = 5;
    start_length = 6;
    cyclus = [Rot_D_start];
    movement =[Rot_D_start_move];
    ploughing = [Rot_D_start_incorp];
    for i = 1:ceil(number_of_years/length_cyclus)
         cyclus = [cyclus,Rot_B_after,Rot_D_start]; % [Grass-Grass-WW]-[Beans-WW]-[Grass-Grass-WW]
        movement = [movement, Rot_B_after_move, Rot_D_start_move];
        ploughing = [ploughing, Rot_B_after_incorp, Rot_D_start_incorp];
    end
    %last movement&ploughing
    movement = [movement,movement_p];
    ploughing = [ploughing, Invert_plough];
    Grass_2years_return = 3;
    Flowers_3years_return = NaN;
     years_40 = (ceil(40/length_cyclus)).*length_cyclus;
elseif rotation_type == 19 % Best agronomy with grass cover in between at different intervals
    %main_rotation_interval = 2;
    length_cyclus = 7;
    start_length = 6;
    cyclus = [Rot_B_start];
    movement =[Rot_B_start_move];
    ploughing = [Rot_B_start_incorp];
    for i = 1:ceil(number_of_years/length_cyclus)
        cyclus = [cyclus,Rot_B_after,Rot_B_after, Rot_D_start]; % Grass-Grass-WW-Beans-WW-Beans-WW-Grass-Grass-WW
        movement = [movement, Rot_B_after_move, Rot_B_after_move, Rot_D_start_move];
        ploughing = [ploughing, Rot_B_after_incorp,Rot_B_after_incorp, Rot_D_start_incorp];
    end
    %last movement&ploughing
    movement = [movement,movement_p];
    ploughing = [ploughing, Invert_plough];
    Grass_2years_return = 5;
    Flowers_3years_return = NaN;
     years_40 = (ceil(40/length_cyclus)).*length_cyclus;
elseif rotation_type == 20 % Best agronomy with grass cover in between at different intervals
    %main_rotation_interval = 3;
    length_cyclus = 9;
     start_length = 6;
    cyclus = [Rot_D_start];
    movement =[Rot_D_start_move];
    ploughing = [Rot_D_start_incorp];
    for i = 1:ceil(number_of_years/length_cyclus)
        cyclus = [cyclus,Rot_B_after,Rot_B_after,Rot_B_after, Rot_D_start];
        movement = [movement, Rot_B_after_move, Rot_B_after_move, Rot_B_after_move, Rot_D_start_move];
        ploughing = [ploughing, Rot_B_after_incorp,Rot_B_after_incorp,Rot_B_after_incorp, Rot_D_start_incorp];
    end
    %last movement&ploughing
    movement = [movement,movement_p];
    ploughing = [ploughing, Invert_plough];
    Grass_2years_return = 7;
    Flowers_3years_return = NaN;
     years_40 = (ceil(40/length_cyclus)).*length_cyclus;
 elseif rotation_type == 21 % Best agronomy with grass cover in between at different intervals
    %main_rotation_interval = 4;
    length_cyclus = 11;
     start_length = 6;
    cyclus = [Rot_D_start];
    movement =[Rot_D_start_move];
    ploughing = [Rot_D_start_incorp];
    for i = 1:ceil(number_of_years/length_cyclus)
        cyclus = [cyclus,Rot_B_after,Rot_B_after,Rot_B_after,Rot_B_after, Rot_D_start];
        movement = [movement, Rot_B_after_move,Rot_B_after_move, Rot_B_after_move, Rot_B_after_move, Rot_D_start_move];
        ploughing = [ploughing, Rot_B_after_incorp,Rot_B_after_incorp, Rot_B_after_incorp,Rot_B_after_incorp, Rot_D_start_incorp];
    end
    %last movement&ploughing
    movement = [movement,movement_p];
    ploughing = [ploughing, Invert_plough];
    Grass_2years_return = 9;
    Flowers_3years_return = NaN;
     years_40 = (ceil(40/length_cyclus)).*length_cyclus;
elseif rotation_type == 22 % Best agronomy with grass cover in between at different intervals
    %main_rotation_interval = 5;
    length_cyclus = 13;
     start_length = 6;
    cyclus = [Rot_D_start];
    movement =[Rot_D_start_move];
    ploughing = [Rot_D_start_incorp];
    for i = 1:ceil(number_of_years/length_cyclus)
        cyclus = [cyclus,Rot_B_after,Rot_B_after,Rot_B_after,Rot_B_after,Rot_B_after, Rot_D_start];
        movement = [movement, Rot_B_after_move,Rot_B_after_move, Rot_B_after_move,Rot_B_after_move, Rot_B_after_move, Rot_D_start_move];
        ploughing = [ploughing, Rot_B_after_incorp,Rot_B_after_incorp,Rot_B_after_incorp,Rot_B_after_incorp,Rot_B_after_incorp, Rot_D_start_incorp];
    end
    %last movement&ploughing
    movement = [movement,movement_p];
    ploughing = [ploughing, Invert_plough];
    Grass_2years_return = 11;
    Flowers_3years_return = NaN;  
     years_40 = (ceil(40/length_cyclus)).*length_cyclus;
elseif rotation_type == 23 % Best agronomy with grass cover in between at different intervals
    %main_rotation_interval = 6;
    length_cyclus = 15;
     start_length = 6;
    cyclus = [Rot_D_start];
    movement =[Rot_D_start_move];
    ploughing = [Rot_D_start_incorp];
    for i = 1:ceil(number_of_years/length_cyclus)
        cyclus = [cyclus,Rot_B_after,Rot_B_after,Rot_B_after,Rot_B_after,Rot_B_after,Rot_B_after, Rot_D_start];
        movement = [movement, Rot_B_after_move,Rot_B_after_move,Rot_B_after_move, Rot_B_after_move,Rot_B_after_move, Rot_B_after_move, Rot_D_start_move];
        ploughing = [ploughing, Rot_B_after_incorp,Rot_B_after_incorp,Rot_B_after_incorp,Rot_B_after_incorp,Rot_B_after_incorp,Rot_B_after_incorp, Rot_D_start_incorp];
    end
    %last movement&ploughing
    movement = [movement,movement_p];
    ploughing = [ploughing, Invert_plough];
    Grass_2years_return = 13;
    Flowers_3years_return = NaN;   
     years_40 = (ceil(40/length_cyclus)).*length_cyclus;
elseif rotation_type == 24 % BAU with three year flower mix in between at different intervals
    %main_rotation_interval = 1;
    length_cyclus = 6;
    start_length = 6;
    cyclus = [Rot_E_after_other];
    movement =[Rot_E_after_other_move];
    ploughing = [Rot_E_after_other_incorp];
    for i = 1:ceil(number_of_years/length_cyclus)
        cyclus = [cyclus,Rot_A_after,Rot_E_after_other]; % [Flower-Flower-Flower-WW]-[OSR-WW]-[Flower-Flower-Flower-WW]
        movement = [movement,Rot_A_after_move, Rot_E_after_other_move];
        ploughing = [ploughing,Rot_A_after_incorp, Rot_E_after_other_incorp];
    end
    %last movement&ploughing
    movement = [movement,movement_c];
    ploughing = [ploughing, Non_invert_plough];
    Grass_2years_return = NaN;
    Flowers_3years_return = 4;
     years_40 = (ceil(40/length_cyclus)).*length_cyclus;
elseif rotation_type == 25 % BAU with three year flower mix in between at different intervals
    %main_rotation_interval = 2;
    length_cyclus = 8;
    start_length = 6;
    cyclus = [Rot_E_after_other];
    movement =[Rot_E_after_other_move];
    ploughing = [Rot_E_after_other_incorp];
    for i = 1:ceil(number_of_years/length_cyclus)
        cyclus = [cyclus,Rot_A_after,Rot_A_after, Rot_E_after_other];  % [Flower-Flower-Flower-WW]-[OSR-WW]-[OSR-WW]-[Flower-Flower-Flower-WW]
        movement = [movement,Rot_A_after_move,Rot_A_after_move, Rot_E_after_other_move];
        ploughing = [ploughing,Rot_A_after_incorp,Rot_A_after_incorp, Rot_E_after_other_incorp];
    end
    %last movement&ploughing
    movement = [movement,movement_c];
    ploughing = [ploughing, Non_invert_plough];
    Grass_2years_return = NaN;
    Flowers_3years_return = 6;
    years_40 = (ceil(40/length_cyclus)).*length_cyclus;
elseif rotation_type == 26 % BAU with three year flower mix in between at different intervals
    %main_rotation_interval = 3;
    length_cyclus = 10;
    start_length = 6;
    cyclus = [Rot_E_after_other];
    movement =[Rot_E_after_other_move];
    ploughing = [Rot_E_after_other_incorp];
    for i = 1:ceil(number_of_years/length_cyclus)
        cyclus = [cyclus,Rot_A_after,Rot_A_after,Rot_A_after, Rot_E_after_other];
        movement = [movement,Rot_A_after_move,Rot_A_after_move,Rot_A_after_move, Rot_E_after_other_move];
        ploughing = [ploughing,Rot_A_after_incorp,Rot_A_after_incorp,Rot_A_after_incorp, Rot_E_after_other_incorp];
    end
    %last movement&ploughing
    movement = [movement,movement_c];
    ploughing = [ploughing, Non_invert_plough];
    Grass_2years_return = NaN;
    Flowers_3years_return = 8;
    years_40 = (ceil(40/length_cyclus)).*length_cyclus;
 elseif rotation_type == 27 % BAU with three year flower mix in between at different intervals
    %main_rotation_interval = 4;
    length_cyclus = 12;
    start_length = 6;
    cyclus = [Rot_E_after_other];
    movement =[Rot_E_after_other_move];
    ploughing = [Rot_E_after_other_incorp];
    for i = 1:ceil(number_of_years/length_cyclus)
        cyclus = [cyclus,Rot_A_after,Rot_A_after,Rot_A_after,Rot_A_after, Rot_E_after_other];
        movement = [movement,Rot_A_after_move,Rot_A_after_move,Rot_A_after_move, Rot_A_after_move,Rot_E_after_other_move];
        ploughing = [ploughing,Rot_A_after_incorp,Rot_A_after_incorp,Rot_A_after_incorp,Rot_A_after_incorp, Rot_E_after_other_incorp];
    end
    %last movement&ploughing
    movement = [movement,movement_c];
    ploughing = [ploughing, Non_invert_plough];
    Grass_2years_return = NaN;
    Flowers_3years_return = 10;
    years_40 = (ceil(40/length_cyclus)).*length_cyclus;
elseif rotation_type == 28 % BAU with three year flower mix in between at different intervals
    %main_rotation_interval = 5;
    length_cyclus = 14;
    start_length = 6;
    cyclus = [Rot_E_after_other];
    movement =[Rot_E_after_other_move];
    ploughing = [Rot_E_after_other_incorp];
    for i = 1:ceil(number_of_years/length_cyclus)
        cyclus = [cyclus,Rot_A_after,Rot_A_after,Rot_A_after,Rot_A_after,Rot_A_after, Rot_E_after_other];
        movement = [movement,Rot_A_after_move,Rot_A_after_move,Rot_A_after_move,Rot_A_after_move, Rot_A_after_move,Rot_E_after_other_move];
        ploughing = [ploughing,Rot_A_after_incorp,Rot_A_after_incorp,Rot_A_after_incorp,Rot_A_after_incorp,Rot_A_after_incorp, Rot_E_after_other_incorp];
    end
    %last movement&ploughing
    movement = [movement,movement_c];
    ploughing = [ploughing, Non_invert_plough];
    Grass_2years_return = NaN;
    Flowers_3years_return = 12;    
    years_40 = (ceil(40/length_cyclus)).*length_cyclus;
 elseif rotation_type == 29 % BAU with three year flower mix in between at different intervals
    %main_rotation_interval = 6;
    length_cyclus = 16;
    start_length = 6;
    cyclus = [Rot_E_after_other];
    movement =[Rot_E_after_other_move];
    ploughing = [Rot_E_after_other_incorp];
    for i = 1:ceil(number_of_years/length_cyclus)
        cyclus = [cyclus,Rot_A_after,Rot_A_after,Rot_A_after,Rot_A_after,Rot_A_after,Rot_A_after, Rot_E_after_other];
        movement = [movement,Rot_A_after_move,Rot_A_after_move,Rot_A_after_move,Rot_A_after_move,Rot_A_after_move, Rot_A_after_move,Rot_E_after_other_move];
        ploughing = [ploughing,Rot_A_after_incorp,Rot_A_after_incorp,Rot_A_after_incorp,Rot_A_after_incorp,Rot_A_after_incorp,Rot_A_after_incorp, Rot_E_after_other_incorp];
    end
    %last movement&ploughing
     movement = [movement,movement_c];
    ploughing = [ploughing, Non_invert_plough];
    Grass_2years_return = NaN;
    Flowers_3years_return = 14;       
    years_40 = (ceil(40/length_cyclus)).*length_cyclus;
    
elseif rotation_type == 30 % Best agronomy with three year flower mix in between at different intervals
    %main_rotation_interval = 1;
    length_cyclus = 6;
    start_length = 6;
    cyclus = [Rot_E_after_other];
    movement =[Rot_E_after_other_move];
    ploughing = [Rot_E_after_other_incorp];
    for i = 1:ceil(number_of_years/length_cyclus)
        cyclus = [cyclus,Rot_B_after,Rot_E_after_other];% [Flower-Flower-Flower-WW]-[Beans-WW]-[Flower-Flower-Flower-WW]
        movement = [movement,Rot_B_after_move, Rot_E_after_other_move];
        ploughing = [ploughing,Rot_B_after_incorp, Rot_E_after_other_incorp];
    end
    %last movement&ploughing
    movement = [movement,movement_p];
    ploughing = [ploughing, Invert_plough];
    Grass_2years_return = NaN;
    Flowers_3years_return = 4;
    years_40 = (ceil(40/length_cyclus)).*length_cyclus;
elseif rotation_type == 31 % Best agronomy with three year flower mix in between at different intervals
    %main_rotation_interval = 2;
    length_cyclus = 8;
    start_length = 6;
    cyclus = [Rot_E_after_other];
    movement =[Rot_E_after_other_move];
    ploughing = [Rot_E_after_other_incorp];
    for i = 1:ceil(number_of_years/length_cyclus)
        cyclus = [cyclus,Rot_B_after,Rot_B_after, Rot_E_after_other];% [Flower-Flower-Flower-WW]-[Beans-WW]-[Beans-WW]-[Flower-Flower-Flower-WW]
        movement = [movement,Rot_B_after_move,Rot_B_after_move, Rot_E_after_other_move];
        ploughing = [ploughing,Rot_B_after_incorp,Rot_B_after_incorp, Rot_E_after_other_incorp];
    end
    %last movement&ploughing
    movement = [movement,movement_p];
    ploughing = [ploughing, Invert_plough];
    Grass_2years_return = NaN;
    Flowers_3years_return = 6;
    years_40 = (ceil(40/length_cyclus)).*length_cyclus;
elseif rotation_type == 32 % Best agronomy with three year flower mix in between at different intervals
    %main_rotation_interval = 3;
    length_cyclus = 10;
    start_length = 6;
    cyclus = [Rot_E_after_other];
    movement =[Rot_E_after_other_move];
    ploughing = [Rot_E_after_other_incorp];
    for i = 1:ceil(number_of_years/length_cyclus)
        cyclus = [cyclus,Rot_B_after,Rot_B_after,Rot_B_after, Rot_E_after_other];
        movement = [movement,Rot_B_after_move,Rot_B_after_move,Rot_B_after_move, Rot_E_after_other_move];
        ploughing = [ploughing,Rot_B_after_incorp,Rot_B_after_incorp,Rot_B_after_incorp, Rot_E_after_other_incorp];
    end
    %last movement&ploughing
    movement = [movement,movement_p];
    ploughing = [ploughing, Invert_plough];
    Grass_2years_return = NaN;
    Flowers_3years_return = 8;
    years_40 = (ceil(40/length_cyclus)).*length_cyclus;
 elseif rotation_type == 33 % Best agronomy with three year flower mix in between at different intervals
    %main_rotation_interval = 4;
    length_cyclus = 12;
    start_length = 6;
    cyclus = [Rot_E_after_other];
    movement =[Rot_E_after_other_move];
    ploughing = [Rot_E_after_other_incorp];
    for i = 1:ceil(number_of_years/length_cyclus)
        cyclus = [cyclus,Rot_B_after,Rot_B_after,Rot_B_after,Rot_B_after, Rot_E_after_other];
        movement = [movement,Rot_B_after_move,Rot_B_after_move,Rot_B_after_move, Rot_B_after_move,Rot_E_after_other_move];
        ploughing = [ploughing,Rot_B_after_incorp,Rot_B_after_incorp,Rot_B_after_incorp,Rot_B_after_incorp, Rot_E_after_other_incorp];
    end
    %last movement&ploughing
    movement = [movement,movement_p];
    ploughing = [ploughing, Invert_plough];
    Grass_2years_return = NaN;
    Flowers_3years_return = 10;
    years_40 = (ceil(40/length_cyclus)).*length_cyclus;
elseif rotation_type == 34 % Best agronomy with three year flower mix in between at different intervals
    %main_rotation_interval = 5;
    length_cyclus = 14;
    start_length = 6;
    cyclus = [Rot_E_after_other];
    movement =[Rot_E_after_other_move];
    ploughing = [Rot_E_after_other_incorp];
    for i = 1:ceil(number_of_years/length_cyclus)
        cyclus = [cyclus,Rot_B_after,Rot_B_after,Rot_B_after,Rot_B_after,Rot_B_after, Rot_E_after_other];
        movement = [movement,Rot_B_after_move,Rot_B_after_move,Rot_B_after_move,Rot_B_after_move, Rot_B_after_move,Rot_E_after_other_move];
        ploughing = [ploughing,Rot_B_after_incorp,Rot_B_after_incorp,Rot_B_after_incorp,Rot_B_after_incorp,Rot_B_after_incorp, Rot_E_after_other_incorp];
    end
    %last movement&ploughing
    movement = [movement,movement_p];
    ploughing = [ploughing, Invert_plough];
    Grass_2years_return = NaN;
    Flowers_3years_return = 12;  
    years_40 = (ceil(40/length_cyclus)).*length_cyclus;
elseif rotation_type == 35 % Best agronomy with three year flower mix in between at different intervals
    %main_rotation_interval = 6;
    length_cyclus = 16;
    start_length = 6;
    cyclus = [Rot_E_after_other];
    movement =[Rot_E_after_other_move];
    ploughing = [Rot_E_after_other_incorp];
    for i = 1:ceil(number_of_years/length_cyclus)
        cyclus = [cyclus,Rot_B_after,Rot_B_after,Rot_B_after,Rot_B_after,Rot_B_after,Rot_B_after, Rot_E_after_other];
        movement = [movement,Rot_B_after_move,Rot_B_after_move,Rot_B_after_move,Rot_B_after_move,Rot_B_after_move, Rot_B_after_move,Rot_E_after_other_move];
        ploughing = [ploughing,Rot_B_after_incorp,Rot_B_after_incorp,Rot_B_after_incorp,Rot_B_after_incorp,Rot_B_after_incorp,Rot_B_after_incorp, Rot_E_after_other_incorp];
    end
    %last movement&ploughing
    movement = [movement,movement_p];
    ploughing = [ploughing, Invert_plough];
    Grass_2years_return = NaN;
    Flowers_3years_return = 14;    
    years_40 = (ceil(40/length_cyclus)).*length_cyclus;
    
 %% Rotations with direct Drilling    
 
 % 2 years fallow
elseif rotation_type == 36 % BAU with WW drilling with grass cover in between at different intervals
    %main_rotation_interval = 1;
      length_cyclus = 5;
    start_length = 6;
    cyclus = [Rot_D_start_plus];
    movement =[Rot_D_start_move_plus];
    ploughing = [Rot_D_start_incorp_plus];
    for i = 1:ceil(number_of_years/length_cyclus)
        cyclus = [cyclus,Rot_A_after_plus,Rot_D_start_plus];  % [Grass-Grass-WWdrill]-[OSR-WWdrill]-[Grass-Grass-WWdrill]
        movement = [movement,Rot_A_after_move_plus, Rot_D_start_move_plus];
        ploughing = [ploughing,Rot_A_after_incorp_plus, Rot_D_start_incorp_plus];
    end
    %last movement&ploughing
    movement = [movement,movement_c]; % for OSR
    ploughing = [ploughing, Non_invert_plough]; % for OSR
    Grass_2years_return = 3;
    Flowers_3years_return = NaN;
    years_40 = (ceil(40/length_cyclus)).*length_cyclus;
elseif rotation_type == 37 %BAU with WW drilling with grass cover in between at different intervals
    %main_rotation_interval = 2;
    length_cyclus = 7;
    start_length = 6;
    cyclus = [Rot_D_start_plus];
    movement =[Rot_D_start_move_plus];
    ploughing = [Rot_D_start_incorp_plus];
    for i = 1:ceil(number_of_years/length_cyclus)
        cyclus = [cyclus,Rot_A_after_plus, Rot_A_after_plus, Rot_D_start_plus];
        movement = [movement, Rot_A_after_move_plus, Rot_A_after_move_plus, Rot_D_start_move_plus];
        ploughing = [ploughing, Rot_A_after_incorp_plus, Rot_A_after_incorp_plus, Rot_D_start_incorp_plus];
    end
    %last movement&ploughing
    movement = [movement,movement_c];
    ploughing = [ploughing, Non_invert_plough];
    Grass_2years_return = 5;
    Flowers_3years_return = NaN;
    years_40 = (ceil(40/length_cyclus)).*length_cyclus;
elseif rotation_type == 38 % BAU with WW drilling with grass cover in between at different intervals
    %main_rotation_interval = 3;
    length_cyclus = 9;
     start_length = 6;
    cyclus = [Rot_D_start_plus];
    movement =[Rot_D_start_move_plus];
    ploughing = [Rot_D_start_incorp_plus];
    for i = 1:ceil(number_of_years/length_cyclus)
        cyclus = [cyclus,Rot_A_after_plus,Rot_A_after_plus,Rot_A_after_plus,...
            Rot_D_start_plus];
        movement = [movement, Rot_A_after_move_plus, Rot_A_after_move_plus, Rot_A_after_move_plus,...
            Rot_D_start_move_plus];
        ploughing = [ploughing, Rot_A_after_incorp_plus,Rot_A_after_incorp_plus,Rot_A_after_incorp_plus,...
            Rot_D_start_incorp_plus];
    end
    %last movement&ploughing
    movement = [movement,movement_c];
    ploughing = [ploughing, Non_invert_plough];
    Grass_2years_return = 7;
    Flowers_3years_return = NaN;
    years_40 = (ceil(40/length_cyclus)).*length_cyclus;
 elseif rotation_type == 39 % BAU with WW drilling with grass cover in between at different intervals
    %main_rotation_interval = 4;
    length_cyclus = 11;
     start_length = 6;
    cyclus = [Rot_D_start_plus];
    movement =[Rot_D_start_move_plus];
    ploughing = [Rot_D_start_incorp_plus];
    for i = 1:ceil(number_of_years/length_cyclus)
        cyclus = [cyclus,Rot_A_after_plus,Rot_A_after_plus,Rot_A_after_plus,...
            Rot_A_after_plus, Rot_D_start_plus];
        movement = [movement, Rot_A_after_move_plus,Rot_A_after_move_plus, Rot_A_after_move_plus,...
            Rot_A_after_move_plus, Rot_D_start_move_plus];
        ploughing = [ploughing, Rot_A_after_incorp_plus,Rot_A_after_incorp_plus, Rot_A_after_incorp_plus,...
            Rot_A_after_incorp_plus, Rot_D_start_incorp_plus];
    end
    %last movement&ploughing
    movement = [movement,movement_c];
    ploughing = [ploughing, Non_invert_plough];
    Grass_2years_return = 9;
    Flowers_3years_return = NaN;
    years_40 = (ceil(40/length_cyclus)).*length_cyclus;
elseif rotation_type == 40 % BAU with WW drilling with grass cover in between at different intervals
    %main_rotation_interval = 5;
    length_cyclus = 13;
     start_length = 6;
    cyclus = [Rot_D_start];
    movement =[Rot_D_start_move];
    ploughing = [Rot_D_start_incorp];
    for i = 1:ceil(number_of_years/length_cyclus)
        cyclus = [cyclus,Rot_A_after_plus,Rot_A_after_plus,Rot_A_after_plus,...
            Rot_A_after_plus,Rot_A_after_plus, Rot_D_start_plus];
        movement = [movement, Rot_A_after_move_plus,Rot_A_after_move_plus, Rot_A_after_move_plus,...
            Rot_A_after_move_plus, Rot_A_after_move_plus, Rot_D_start_move_plus];
        ploughing = [ploughing, Rot_A_after_incorp_plus,Rot_A_after_incorp_plus,Rot_A_after_incorp_plus,...
            Rot_A_after_incorp_plus,Rot_A_after_incorp_plus, Rot_D_start_incorp_plus];
    end
    %last movement&ploughing
    movement = [movement,movement_c];
    ploughing = [ploughing, Non_invert_plough];
    Grass_2years_return = 11;
    Flowers_3years_return = NaN;
    years_40 = (ceil(40/length_cyclus)).*length_cyclus;
elseif rotation_type == 41 % BAU with WW drilling with grass cover in between at different intervals
    %main_rotation_interval = 6;
    length_cyclus = 15;
     start_length = 6;
    cyclus = [Rot_D_start];
    movement =[Rot_D_start_move];
    ploughing = [Rot_D_start_incorp];
    for i = 1:ceil(number_of_years/length_cyclus)
        cyclus = [cyclus,Rot_A_after_plus,Rot_A_after_plus,...
            Rot_A_after_plus,Rot_A_after_plus,Rot_A_after_plus,Rot_A_after_plus, Rot_D_start_plus];
        movement = [movement, Rot_A_after_move_plus,Rot_A_after_move_plus, Rot_A_after_move_plus,...
            Rot_A_after_move_plus,Rot_A_after_move_plus, Rot_A_after_move_plus, Rot_D_start_move_plus];
        ploughing = [ploughing, Rot_A_after_incorp_plus,Rot_A_after_incorp_plus,Rot_A_after_incorp_plus,...
            Rot_A_after_incorp_plus,Rot_A_after_incorp_plus,Rot_A_after_incorp_plus, Rot_D_start_incorp_plus];
    end
    %last movement&ploughing
    movement = [movement,movement_c];
    ploughing = [ploughing, Non_invert_plough];
    Grass_2years_return = 13;
    Flowers_3years_return = NaN;
    years_40 = (ceil(40/length_cyclus)).*length_cyclus;
elseif rotation_type == 42 % Best agronomy with WW drilling with grass cover in between at different intervals
    %main_rotation_interval = 1;
      length_cyclus = 5;
    start_length = 6;
    cyclus = [Rot_D_start_plus];
    movement =[Rot_D_start_move_plus];
    ploughing = [Rot_D_start_incorp_plus];
    for i = 1:ceil(number_of_years/length_cyclus)
         cyclus = [cyclus,Rot_B_after_plus,Rot_D_start_plus]; % [Grass-Grass-WW]-[Beans-WW]-[Grass-Grass-WW]
        movement = [movement, Rot_B_after_move_plus, Rot_D_start_move_plus];
        ploughing = [ploughing, Rot_B_after_incorp_plus, Rot_D_start_incorp_plus];
    end
    %last movement&ploughing
    movement = [movement,movement_c];
    ploughing = [ploughing, Non_invert_plough];
    Grass_2years_return = 3;
    Flowers_3years_return = NaN;
    years_40 = (ceil(40/length_cyclus)).*length_cyclus;
elseif rotation_type == 43 % Best agronomy with WW drilling with grass cover in between at different intervals
    %main_rotation_interval = 2;
    length_cyclus = 7;
    start_length = 6;
    cyclus = [Rot_B_start];
    movement =[Rot_B_start_move];
    ploughing = [Rot_B_start_incorp];
    for i = 1:ceil(number_of_years/length_cyclus)
        cyclus = [cyclus,Rot_B_after_plus,Rot_B_after_plus, Rot_D_start_plus]; % Grass-Grass-WW-Beans-WW-Beans-WW-Grass-Grass-WW
        movement = [movement, Rot_B_after_move_plus, Rot_B_after_move_plus, Rot_D_start_move_plus];
        ploughing = [ploughing, Rot_B_after_incorp_plus,Rot_B_after_incorp_plus, Rot_D_start_incorp_plus];
    end
    %last movement&ploughing
    movement = [movement,movement_c];
    ploughing = [ploughing, Non_invert_plough];
    Grass_2years_return = 5;
    years_40 = (ceil(40/length_cyclus)).*length_cyclus;
    Flowers_3years_return = NaN;
elseif rotation_type == 44 % Best agronomy with WW drilling with grass cover in between at different intervals
    %main_rotation_interval = 3;
    length_cyclus = 9;
     start_length = 6;
    cyclus = [Rot_D_start_plus];
    movement =[Rot_D_start_move_plus];
    ploughing = [Rot_D_start_incorp_plus];
    for i = 1:ceil(number_of_years/length_cyclus)
        cyclus = [cyclus,Rot_B_after_plus,Rot_B_after_plus,Rot_B_after_plus,...
            Rot_D_start_plus];
        movement = [movement, Rot_B_after_move_plus, Rot_B_after_move_plus, Rot_B_after_move_plus,...
            Rot_D_start_move_plus];
        ploughing = [ploughing, Rot_B_after_incorp_plus,Rot_B_after_incorp_plus,Rot_B_after_incorp_plus,...
            Rot_D_start_incorp_plus];
    end
    %last movement&ploughing
    movement = [movement,movement_c];
    ploughing = [ploughing, Non_invert_plough];
    Grass_2years_return = 7;
    Flowers_3years_return = NaN;
    years_40 = (ceil(40/length_cyclus)).*length_cyclus;
 elseif rotation_type == 45 % Best agronomy with WW drilling with grass cover in between at different intervals
    %main_rotation_interval = 4;
    length_cyclus = 11;
     start_length = 6;
    cyclus = [Rot_D_start_plus];
    movement =[Rot_D_start_move_plus];
    ploughing = [Rot_D_start_incorp_plus];
    for i = 1:ceil(number_of_years/length_cyclus)
        cyclus = [cyclus,Rot_B_after_plus,Rot_B_after_plus,Rot_B_after_plus,...
            Rot_B_after_plus, Rot_D_start_plus];
        movement = [movement, Rot_B_after_move_plus,Rot_B_after_move_plus, Rot_B_after_move_plus,...
            Rot_B_after_move_plus, Rot_D_start_move_plus];
        ploughing = [ploughing, Rot_B_after_incorp_plus,Rot_B_after_incorp_plus, Rot_B_after_incorp_plus,...
            Rot_B_after_incorp_plus, Rot_D_start_incorp_plus];
    end
    %last movement&ploughing
    movement = [movement,movement_c];
    ploughing = [ploughing, Non_invert_plough];
    Grass_2years_return = 9;
    Flowers_3years_return = NaN;
    years_40 = (ceil(40/length_cyclus)).*length_cyclus;
elseif rotation_type == 46 % Best agronomy wwith WW drilling ith grass cover in between at different intervals
    %main_rotation_interval = 5;
    length_cyclus = 13;
     start_length = 6;
    cyclus = [Rot_D_start_plus];
    movement =[Rot_D_start_move_plus];
    ploughing = [Rot_D_start_incorp_plus];
    for i = 1:ceil(number_of_years/length_cyclus)
        cyclus = [cyclus,Rot_B_after_plus,Rot_B_after_plus,Rot_B_after_plus,...
            Rot_B_after_plus,Rot_B_after_plus, Rot_D_start_plus];
        movement = [movement, Rot_B_after_move_plus,Rot_B_after_move_plus, Rot_B_after_move_plus,...
            Rot_B_after_move_plus, Rot_B_after_move_plus, Rot_D_start_move_plus];
        ploughing = [ploughing, Rot_B_after_incorp_plus,Rot_B_after_incorp_plus,Rot_B_after_incorp_plus,...
            Rot_B_after_incorp_plus,Rot_B_after_incorp_plus, Rot_D_start_incorp_plus];
    end
    %last movement&ploughing
    movement = [movement,movement_c];
    ploughing = [ploughing, Non_invert_plough];
    Grass_2years_return = 11;
    Flowers_3years_return = NaN;  
    years_40 = (ceil(40/length_cyclus)).*length_cyclus;
elseif rotation_type == 47 % Best agronomy with WW drilling with grass cover in between at different intervals
    %main_rotation_interval = 6;
    length_cyclus = 15;
     start_length = 6;
    cyclus = [Rot_D_start_plus];
    movement =[Rot_D_start_move_plus];
    ploughing = [Rot_D_start_incorp_plus];
    for i = 1:ceil(number_of_years/length_cyclus)
        cyclus = [cyclus,Rot_B_after_plus,Rot_B_after_plus,Rot_B_after_plus,...
            Rot_B_after_plus,Rot_B_after_plus,Rot_B_after_plus, Rot_D_start_plus];
        movement = [movement, Rot_B_after_move_plus,Rot_B_after_move_plus,Rot_B_after_move_plus,...
            Rot_B_after_move_plus,Rot_B_after_move_plus, Rot_B_after_move_plus, Rot_D_start_move_plus];
        ploughing = [ploughing, Rot_B_after_incorp_plus,Rot_B_after_incorp_plus,Rot_B_after_incorp_plus,...
            Rot_B_after_incorp_plus,Rot_B_after_incorp_plus,Rot_B_after_incorp_plus, Rot_D_start_incorp_plus];
    end
    %last movement&ploughing
    movement = [movement,movement_c];
    ploughing = [ploughing, Non_invert_plough];
    Grass_2years_return = 13;
    Flowers_3years_return = NaN;   
    years_40 = (ceil(40/length_cyclus)).*length_cyclus;
% Three year flower mix    
elseif rotation_type == 48 % BAU with WW drilling with three year flower mix in between at different intervals
    %main_rotation_interval = 1;
    length_cyclus = 6;
    start_length = 6;
    cyclus = [Rot_E_after_other_plus];
    movement =[Rot_E_after_other_move_plus];
    ploughing = [Rot_E_after_other_incorp_plus];
    for i = 1:ceil(number_of_years/length_cyclus)
        cyclus = [cyclus,Rot_A_after_plus,Rot_E_after_other_plus]; % [Flower-Flower-Flower-WWdrill]-[OSR-WWdrill]-[Flower-Flower-Flower-WWdrill]
        movement = [movement,Rot_A_after_move_plus, Rot_E_after_other_move_plus];
        ploughing = [ploughing,Rot_A_after_incorp_plus, Rot_E_after_other_incorp_plus];
    end
    %last movement&ploughing
    movement = [movement,movement_c];
    ploughing = [ploughing, Non_invert_plough];
    Grass_2years_return = NaN;
    Flowers_3years_return = 4;
    years_40 = (ceil(40/length_cyclus)).*length_cyclus;
elseif rotation_type == 49 % BAU with WW drilling with three year flower mix in between at different intervals
    %main_rotation_interval = 2;
    length_cyclus = 8;
    start_length = 6;
    cyclus = [Rot_E_after_other_plus];
    movement =[Rot_E_after_other_move_plus];
    ploughing = [Rot_E_after_other_incorp_plus];
    for i = 1:ceil(number_of_years/length_cyclus)
        cyclus = [cyclus,Rot_A_after_plus,Rot_A_after_plus, Rot_E_after_other_plus];  % [Flower-Flower-Flower-WWdrill]-[OSR-WWdrill]-[OSR-WWdrill]-[Flower-Flower-Flower-WWdrill]
        movement = [movement,Rot_A_after_move_plus,Rot_A_after_move_plus, Rot_E_after_other_move_plus];
        ploughing = [ploughing,Rot_A_after_incorp_plus,Rot_A_after_incorp_plus, Rot_E_after_other_incorp_plus];
    end
    %last movement&ploughing
    movement = [movement,movement_c];
    ploughing = [ploughing, Non_invert_plough];
    Grass_2years_return = NaN;
    Flowers_3years_return = 6;
    years_40 = (ceil(40/length_cyclus)).*length_cyclus;
elseif rotation_type == 50 % BAU with WW drilling with three year flower mix in between at different intervals
    %main_rotation_interval = 3;
    length_cyclus = 10;
    start_length = 6;
    cyclus = [Rot_E_after_other_plus];
    movement =[Rot_E_after_other_move_plus];
    ploughing = [Rot_E_after_other_incorp_plus];
    for i = 1:ceil(number_of_years/length_cyclus)
        cyclus = [cyclus,Rot_A_after_plus,Rot_A_after_plus,Rot_A_after_plus,...
            Rot_E_after_other_plus];
        movement = [movement,Rot_A_after_move_plus,Rot_A_after_move_plus,Rot_A_after_move_plus,...
            Rot_E_after_other_move_plus];
        ploughing = [ploughing,Rot_A_after_incorp_plus,Rot_A_after_incorp_plus,Rot_A_after_incorp_plus,...
            Rot_E_after_other_incorp_plus];
    end
    %last movement&ploughing
    movement = [movement,movement_c];
    ploughing = [ploughing, Non_invert_plough];
    Grass_2years_return = NaN;
    Flowers_3years_return = 8;
    years_40 = (ceil(40/length_cyclus)).*length_cyclus;
 elseif rotation_type == 51 % BAU with WW drilling with three year flower mix in between at different intervals
    %main_rotation_interval = 4;
    length_cyclus = 12;
    start_length = 6;
    cyclus = [Rot_E_after_other_plus];
    movement =[Rot_E_after_other_move_plus];
    ploughing = [Rot_E_after_other_incorp_plus];
    for i = 1:ceil(number_of_years/length_cyclus)
        cyclus = [cyclus,Rot_A_after_plus,Rot_A_after_plus,Rot_A_after_plus,...
            Rot_A_after_plus, Rot_E_after_other_plus];
        movement = [movement,Rot_A_after_move_plus,Rot_A_after_move_plus,Rot_A_after_move_plus,...
            Rot_A_after_move_plus,Rot_E_after_other_move_plus];
        ploughing = [ploughing,Rot_A_after_incorp_plus,Rot_A_after_incorp_plus,Rot_A_after_incorp_plus,...
            Rot_A_after_incorp_plus, Rot_E_after_other_incorp_plus];
    end
    %last movement&ploughing
    movement = [movement,movement_c];
    ploughing = [ploughing, Non_invert_plough];
    Grass_2years_return = NaN;
    Flowers_3years_return = 10;
    years_40 = (ceil(40/length_cyclus)).*length_cyclus;
elseif rotation_type == 52 % BAU with WW drilling with three year flower mix in between at different intervals
    %main_rotation_interval = 5;
    length_cyclus = 14;
    start_length = 6;
    cyclus = [Rot_E_after_other_plus];
    movement =[Rot_E_after_other_move_plus];
    ploughing = [Rot_E_after_other_incorp_plus];
    for i = 1:ceil(number_of_years/length_cyclus)
        cyclus = [cyclus,Rot_A_after_plus,Rot_A_after_plus,Rot_A_after_plus,...
            Rot_A_after_plus,Rot_A_after_plus, Rot_E_after_other_plus];
        movement = [movement,Rot_A_after_move_plus,Rot_A_after_move_plus,Rot_A_after_move_plus,...
            Rot_A_after_move_plus, Rot_A_after_move_plus,Rot_E_after_other_move_plus];
        ploughing = [ploughing,Rot_A_after_incorp_plus,Rot_A_after_incorp_plus,Rot_A_after_incorp_plus,...
            Rot_A_after_incorp_plus,Rot_A_after_incorp_plus, Rot_E_after_other_incorp_plus];
    end
    %last movement&ploughing
    movement = [movement,movement_c];
    ploughing = [ploughing, Non_invert_plough];
    Grass_2years_return = NaN;
    Flowers_3years_return = 12;    
    years_40 = (ceil(40/length_cyclus)).*length_cyclus;
 elseif rotation_type == 53 % BAU with WW drilling with three year flower mix in between at different intervals
    %main_rotation_interval = 6;
    length_cyclus = 16;
    start_length = 6;
    cyclus = [Rot_E_after_other_plus];
    movement =[Rot_E_after_other_move_plus];
    ploughing = [Rot_E_after_other_incorp_plus];
    for i = 1:ceil(number_of_years/length_cyclus)
        cyclus = [cyclus,Rot_A_after_plus,Rot_A_after_plus,Rot_A_after_plus,...
            Rot_A_after_plus,Rot_A_after_plus,Rot_A_after_plus, Rot_E_after_other_plus];
        movement = [movement,Rot_A_after_move_plus,Rot_A_after_move_plus,Rot_A_after_move_plus,...
            Rot_A_after_move_plus,Rot_A_after_move_plus, Rot_A_after_move_plus,Rot_E_after_other_move_plus];
        ploughing = [ploughing,Rot_A_after_incorp_plus,Rot_A_after_incorp_plus,Rot_A_after_incorp_plus,...
            Rot_A_after_incorp_plus,Rot_A_after_incorp_plus,Rot_A_after_incorp_plus, Rot_E_after_other_incorp_plus];
    end
    %last movement&ploughing
    movement = [movement,movement_c];
    ploughing = [ploughing, Non_invert_plough];
    Grass_2years_return = NaN;
    Flowers_3years_return = 14;    
    years_40 = (ceil(40/length_cyclus)).*length_cyclus;
elseif rotation_type == 54 % Best agronomy with WW drilling with three year flower mix in between at different intervals
    %main_rotation_interval = 1;
    length_cyclus = 6;
    start_length = 6;
    cyclus = [Rot_E_after_other_plus];
    movement =[Rot_E_after_other_move_plus];
    ploughing = [Rot_E_after_other_incorp_plus];
    for i = 1:ceil(number_of_years/length_cyclus)
        cyclus = [cyclus,Rot_B_after_plus,Rot_E_after_other_plus];% [Flower-Flower-Flower-WWdtill]-[Beans-WWdrill]-[Flower-Flower-Flower-WWdrill]
        movement = [movement,Rot_B_after_move_plus, Rot_E_after_other_move_plus];
        ploughing = [ploughing,Rot_B_after_incorp_plus, Rot_E_after_other_incorp_plus];
    end
    %last movement&ploughing
    movement = [movement,movement_p];
    ploughing = [ploughing, Invert_plough];
    Grass_2years_return = NaN;
    Flowers_3years_return = 4;
    years_40 = (ceil(40/length_cyclus)).*length_cyclus;
elseif rotation_type == 55 % Best agronomy with WW drilling with three year flower mix in between at different intervals
    %main_rotation_interval = 2;
    length_cyclus = 8;
    start_length = 6;
    cyclus = [Rot_E_after_other_plus];
    movement =[Rot_E_after_other_move_plus];
    ploughing = [Rot_E_after_other_incorp_plus];
    for i = 1:ceil(number_of_years/length_cyclus)
        cyclus = [cyclus,Rot_B_after_plus,Rot_B_after_plus, Rot_E_after_other_plus];% [Flower-Flower-Flower-WW]-[Beans-WWdrill]-[Beans-WWdrill]-[Flower-Flower-Flower-WW]
        movement = [movement,Rot_B_after_move_plus,Rot_B_after_move_plus, Rot_E_after_other_move_plus];
        ploughing = [ploughing,Rot_B_after_incorp_plus,Rot_B_after_incorp_plus, Rot_E_after_other_incorp_plus];
    end
    %last movement&ploughing
    movement = [movement,movement_p];
    ploughing = [ploughing, Invert_plough];
    Grass_2years_return = NaN;
    Flowers_3years_return = 6;
    years_40 = (ceil(40/length_cyclus)).*length_cyclus;
elseif rotation_type == 56 % Best agronomy with WW drilling with three year flower mix in between at different intervals
    %main_rotation_interval = 3;
    length_cyclus = 10;
    start_length = 6;
    cyclus = [Rot_E_after_other_plus];
    movement =[Rot_E_after_other_move_plus];
    ploughing = [Rot_E_after_other_incorp_plus];
    for i = 1:ceil(number_of_years/length_cyclus)
        cyclus = [cyclus,Rot_B_after_plus,Rot_B_after_plus,Rot_B_after_plus,...
            Rot_E_after_other_plus];
        movement = [movement,Rot_B_after_move_plus,Rot_B_after_move_plus,Rot_B_after_move_plus,...
            Rot_E_after_other_move_plus];
        ploughing = [ploughing,Rot_B_after_incorp_plus,Rot_B_after_incorp_plus,Rot_B_after_incorp_plus,...
            Rot_E_after_other_incorp_plus];
    end
    %last movement&ploughing
    movement = [movement,movement_p];
    ploughing = [ploughing, Invert_plough];
    Grass_2years_return = NaN;
    Flowers_3years_return = 8;
    years_40 = (ceil(40/length_cyclus)).*length_cyclus;
 elseif rotation_type == 57 % Best agronomy with WW drilling with three year flower mix in between at different intervals
    %main_rotation_interval = 4;
    length_cyclus = 12;
    start_length = 6;
    cyclus = [Rot_E_after_other_plus];
    movement =[Rot_E_after_other_move_plus];
    ploughing = [Rot_E_after_other_incorp_plus];
    for i = 1:ceil(number_of_years/length_cyclus)
        cyclus = [cyclus,Rot_B_after_plus,Rot_B_after_plus,Rot_B_after_plus,...
            Rot_B_after_plus, Rot_E_after_other_plus];
        movement = [movement,Rot_B_after_move_plus,Rot_B_after_move_plus,Rot_B_after_move_plus,...
            Rot_B_after_move_plus,Rot_E_after_other_move_plus];
        ploughing = [ploughing,Rot_B_after_incorp_plus,Rot_B_after_incorp_plus,Rot_B_after_incorp_plus,...
            Rot_B_after_incorp_plus, Rot_E_after_other_incorp_plus];
    end
    %last movement&ploughing
    movement = [movement,movement_p];
    ploughing = [ploughing, Invert_plough];
    Grass_2years_return = NaN;
    Flowers_3years_return = 10;
    years_40 = (ceil(40/length_cyclus)).*length_cyclus;
elseif rotation_type == 58 % Best agronomy with WW drilling with three year flower mix in between at different intervals
    %main_rotation_interval = 5;
    length_cyclus = 14;
    start_length = 6;
    cyclus = [Rot_E_after_other_plus];
    movement =[Rot_E_after_other_move_plus];
    ploughing = [Rot_E_after_other_incorp_plus];
    for i = 1:ceil(number_of_years/length_cyclus)
        cyclus = [cyclus,Rot_B_after_plus,Rot_B_after_plus,Rot_B_after_plus,...
            Rot_B_after_plus,Rot_B_after_plus, Rot_E_after_other_plus];
        movement = [movement,Rot_B_after_move_plus,Rot_B_after_move_plus,Rot_B_after_move_plus,...
            Rot_B_after_move_plus, Rot_B_after_move_plus,Rot_E_after_other_move_plus];
        ploughing = [ploughing,Rot_B_after_incorp_plus,Rot_B_after_incorp_plus,Rot_B_after_incorp_plus,...
            Rot_B_after_incorp_plus,Rot_B_after_incorp_plus, Rot_E_after_other_incorp_plus];
    end
    %last movement&ploughing
    movement = [movement,movement_p];
    ploughing = [ploughing, Invert_plough];
    Grass_2years_return = NaN;
    Flowers_3years_return = 12;  
    years_40 = (ceil(40/length_cyclus)).*length_cyclus;
elseif rotation_type == 59 % Best agronomy with WW drilling with three year flower mix in between at different intervals
    %main_rotation_interval = 6;
    length_cyclus = 16;
    start_length = 6;
    cyclus = [Rot_E_after_other_plus];
    movement =[Rot_E_after_other_move_plus];
    ploughing = [Rot_E_after_other_incorp_plus];
    for i = 1:ceil(number_of_years/length_cyclus)
        cyclus = [cyclus,Rot_B_after_plus,Rot_B_after_plus,Rot_B_after_plus,...
            Rot_B_after_plus,Rot_B_after_plus,Rot_B_after_plus, Rot_E_after_other_plus];
        movement = [movement,Rot_B_after_move_plus,Rot_B_after_move_plus,Rot_B_after_move_plus,...
            Rot_B_after_move_plus,Rot_B_after_move_plus, Rot_B_after_move_plus,Rot_E_after_other_move_plus];
        ploughing = [ploughing,Rot_B_after_incorp_plus,Rot_B_after_incorp_plus,Rot_B_after_incorp_plus,...
            Rot_B_after_incorp_plus,Rot_B_after_incorp_plus,Rot_B_after_incorp_plus, Rot_E_after_other_incorp_plus];
    end
    %last movement&ploughing
    movement = [movement,movement_p];
    ploughing = [ploughing, Invert_plough];
    Grass_2years_return = NaN;
    Flowers_3years_return = 14;  
    years_40 = (ceil(40/length_cyclus)).*length_cyclus;
      
elseif rotation_type == 60 % BAU with 1-year grass cover in between at different intervals
    %main_rotation_interval = 1;
      length_cyclus = 5;
    start_length = 6;
    cyclus = [Rot_C_start];
    movement =[Rot_C_start_move];
    ploughing = [Rot_C_start_incorp];
    for i = 1:ceil(number_of_years/length_cyclus)
        cyclus = [cyclus,Rot_A_after,Rot_C_after];  % [Grass-WW]-[OSR-WW]-[Grass WW]
        movement = [movement,Rot_A_after_move, Rot_C_after_move];
        ploughing = [ploughing,Rot_A_after_incorp, Rot_C_after_incorp];
    end
    %last movement&ploughing
    movement = [movement,movement_c];
    ploughing = [ploughing, Non_invert_plough];
    Grass_2years_return = 3;
    Flowers_3years_return = NaN;
    years_40 = 1 + (ceil(40/length_cyclus)).*length_cyclus;
elseif rotation_type == 61 % BAU with 1-year grass cover in between at different intervals
    %main_rotation_interval = 2;
    length_cyclus = 7;
    start_length = 6;
    cyclus = [Rot_C_start];
    movement =[Rot_C_start_move];
    ploughing = [Rot_C_start_incorp];
    for i = 1:ceil(number_of_years/length_cyclus)
        cyclus = [cyclus,Rot_A_after, Rot_A_after, Rot_C_after];
        movement = [movement, Rot_A_after_move, Rot_A_after_move, Rot_C_after_move];
        ploughing = [ploughing, Rot_A_after_incorp, Rot_A_after_incorp, Rot_C_after_incorp];
    end
    %last movement&ploughing
    movement = [movement,movement_c];
    ploughing = [ploughing, Non_invert_plough];
    Grass_2years_return = 5;
    Flowers_3years_return = NaN;
    years_40 = 1 + (ceil(40/length_cyclus)).*length_cyclus;
elseif rotation_type == 62 % BAU with 1-year grass cover in between at different intervals
    %main_rotation_interval = 3;
    length_cyclus = 9;
     start_length = 6;
    cyclus = [Rot_C_start];
    movement =[Rot_C_start_move];
    ploughing = [Rot_C_start_incorp];
    for i = 1:ceil(number_of_years/length_cyclus)
        cyclus = [cyclus,Rot_A_after,Rot_A_after,Rot_A_after, Rot_C_after];
        movement = [movement, Rot_A_after_move, Rot_A_after_move, Rot_A_after_move, Rot_C_after_move];
        ploughing = [ploughing, Rot_A_after_incorp,Rot_A_after_incorp,Rot_A_after_incorp, Rot_C_after_incorp];
    end
    %last movement&ploughing
    movement = [movement,movement_c];
    ploughing = [ploughing, Non_invert_plough];
    Grass_2years_return = 7;
    Flowers_3years_return = NaN;
    years_40 = 1 + (ceil(40/length_cyclus)).*length_cyclus;
 elseif rotation_type == 63 % BAU with 1-year grass cover in between at different intervals
    %main_rotation_interval = 4;
    length_cyclus = 11;
     start_length = 6;
    cyclus = [Rot_C_start];
    movement =[Rot_C_start_move];
    ploughing = [Rot_C_start_incorp];
    for i = 1:ceil(number_of_years/length_cyclus)
        cyclus = [cyclus,Rot_A_after,Rot_A_after,Rot_A_after,Rot_A_after, Rot_C_after];
        movement = [movement, Rot_A_after_move,Rot_A_after_move, Rot_A_after_move, Rot_A_after_move, Rot_C_after_move];
        ploughing = [ploughing, Rot_A_after_incorp,Rot_A_after_incorp, Rot_A_after_incorp,Rot_A_after_incorp, Rot_C_after_incorp];
    end
    %last movement&ploughing
    movement = [movement,movement_c];
    ploughing = [ploughing, Non_invert_plough];
    Grass_2years_return = 9;
    Flowers_3years_return = NaN;
    years_40 = 1 + (ceil(40/length_cyclus)).*length_cyclus;
elseif rotation_type == 64 % BAU with 1-year grass cover in between at different intervals
    %main_rotation_interval = 5;
    length_cyclus = 13;
     start_length = 6;
    cyclus = [Rot_C_start];
    movement =[Rot_C_start_move];
    ploughing = [Rot_C_start_incorp];
    for i = 1:ceil(number_of_years/length_cyclus)
        cyclus = [cyclus,Rot_A_after,Rot_A_after,Rot_A_after,Rot_A_after,Rot_A_after, Rot_C_after];
        movement = [movement, Rot_A_after_move,Rot_A_after_move, Rot_A_after_move,Rot_A_after_move, Rot_A_after_move, Rot_C_after_move];
        ploughing = [ploughing, Rot_A_after_incorp,Rot_A_after_incorp,Rot_A_after_incorp,Rot_A_after_incorp,Rot_A_after_incorp, Rot_C_after_incorp];
    end
    %last movement&ploughing
    movement = [movement,movement_c];
    ploughing = [ploughing, Non_invert_plough];
    Grass_2years_return = 11;
    Flowers_3years_return = NaN;
    years_40 = 1 + (ceil(40/length_cyclus)).*length_cyclus;
elseif rotation_type == 65 % BAU with 1-year grass cover in between at different intervals
    %main_rotation_interval = 6;
    length_cyclus = 13;
     start_length = 6;
    cyclus = [Rot_C_start];
    movement =[Rot_C_start_move];
    ploughing = [Rot_C_start_incorp];
    for i = 1:ceil(number_of_years/length_cyclus)
        cyclus = [cyclus,Rot_A_after,Rot_A_after,Rot_A_after,Rot_A_after,Rot_A_after,Rot_A_after, Rot_C_after];
        movement = [movement, Rot_A_after_move,Rot_A_after_move, Rot_A_after_move,Rot_A_after_move,Rot_A_after_move, Rot_A_after_move, Rot_C_after_move];
        ploughing = [ploughing, Rot_A_after_incorp,Rot_A_after_incorp,Rot_A_after_incorp,Rot_A_after_incorp,Rot_A_after_incorp,Rot_A_after_incorp, Rot_C_after_incorp];
    end
    %last movement&ploughing
    movement = [movement,movement_c];
    ploughing = [ploughing, Non_invert_plough];
    Grass_2years_return = 13;
     Flowers_3years_return = NaN;
     years_40 = 1 + (ceil(40/length_cyclus)).*length_cyclus;
elseif rotation_type == 66 % Best agronomy with 1-year grass cover in between at different intervals
    %main_rotation_interval = 1;
      length_cyclus = 5;
    start_length = 6;
    cyclus = [Rot_C_start];
    movement =[Rot_C_start_move];
    ploughing = [Rot_C_start_incorp];
    for i = 1:ceil(number_of_years/length_cyclus)
        cyclus = [cyclus,Rot_B_after,Rot_C_after];  % [Grass-WW]-[Beans-WW]-[Grass WW]
        movement = [movement,Rot_B_after_move, Rot_C_after_move];
        ploughing = [ploughing,Rot_B_after_incorp, Rot_C_after_incorp];
    end
    %last movement&ploughing
    movement = [movement,movement_c];
    ploughing = [ploughing, Non_invert_plough];
    Grass_2years_return = 3;
    Flowers_3years_return = NaN;
    years_40 = 1 + (ceil(40/length_cyclus)).*length_cyclus;
elseif rotation_type == 67 % Best agronomy with 1-year grass cover in between at different intervals
    %main_rotation_interval = 2;
    length_cyclus = 7;
    start_length = 6;
    cyclus = [Rot_C_start];
    movement =[Rot_C_start_move];
    ploughing = [Rot_C_start_incorp];
    for i = 1:ceil(number_of_years/length_cyclus)
        cyclus = [cyclus,Rot_B_after, Rot_B_after, Rot_C_after];
        movement = [movement, Rot_B_after_move, Rot_B_after_move, Rot_C_after_move];
        ploughing = [ploughing, Rot_B_after_incorp, Rot_B_after_incorp, Rot_C_after_incorp];
    end
    %last movement&ploughing
    movement = [movement,movement_c];
    ploughing = [ploughing, Non_invert_plough];
    Grass_2years_return = 5;
    Flowers_3years_return = NaN;
    years_40 = 1 + (ceil(40/length_cyclus)).*length_cyclus;
elseif rotation_type == 68 % Best agronomy with 1-year grass cover in between at different intervals
    %main_rotation_interval = 3;
    length_cyclus = 9;
     start_length = 6;
    cyclus = [Rot_C_start];
    movement =[Rot_C_start_move];
    ploughing = [Rot_C_start_incorp];
    for i = 1:ceil(number_of_years/length_cyclus)
        cyclus = [cyclus,Rot_B_after,Rot_B_after,Rot_B_after, Rot_C_after];
        movement = [movement, Rot_B_after_move, Rot_B_after_move, Rot_B_after_move, Rot_C_after_move];
        ploughing = [ploughing, Rot_B_after_incorp,Rot_B_after_incorp,Rot_B_after_incorp, Rot_C_after_incorp];
    end
    %last movement&ploughing
    movement = [movement,movement_c];
    ploughing = [ploughing, Non_invert_plough];
    Grass_2years_return = 7;
    Flowers_3years_return = NaN;
    years_40 = 1 + (ceil(40/length_cyclus)).*length_cyclus;
 elseif rotation_type == 69 % Best agronomy with 1-year grass cover in between at different intervals
    %main_rotation_interval = 4;
    length_cyclus = 11;
     start_length = 6;
    cyclus = [Rot_C_start];
    movement =[Rot_C_start_move];
    ploughing = [Rot_C_start_incorp];
    for i = 1:ceil(number_of_years/length_cyclus)
        cyclus = [cyclus,Rot_B_after,Rot_B_after,Rot_B_after,Rot_B_after, Rot_C_after];
        movement = [movement, Rot_B_after_move,Rot_B_after_move, Rot_B_after_move, Rot_B_after_move, Rot_C_after_move];
        ploughing = [ploughing, Rot_B_after_incorp,Rot_B_after_incorp, Rot_B_after_incorp,Rot_B_after_incorp, Rot_C_after_incorp];
    end
    %last movement&ploughing
    movement = [movement,movement_c];
    ploughing = [ploughing, Non_invert_plough];
    Grass_2years_return = 9;
    Flowers_3years_return = NaN;
    years_40 = 1 + (ceil(40/length_cyclus)).*length_cyclus;
elseif rotation_type == 70 % Best agronomy with 1-year grass cover in between at different intervals
    %main_rotation_interval = 5;
    length_cyclus = 13;
     start_length = 6;
    cyclus = [Rot_C_start];
    movement =[Rot_C_start_move];
    ploughing = [Rot_C_start_incorp];
    for i = 1:ceil(number_of_years/length_cyclus)
        cyclus = [cyclus,Rot_B_after,Rot_B_after,Rot_B_after,Rot_B_after,Rot_B_after, Rot_C_after];
        movement = [movement, Rot_B_after_move,Rot_B_after_move, Rot_B_after_move,Rot_B_after_move, Rot_B_after_move, Rot_C_after_move];
        ploughing = [ploughing, Rot_B_after_incorp,Rot_B_after_incorp,Rot_B_after_incorp,Rot_B_after_incorp,Rot_B_after_incorp, Rot_C_after_incorp];
    end
    %last movement&ploughing
    movement = [movement,movement_c];
    ploughing = [ploughing, Non_invert_plough];
    Grass_2years_return = 11;
    Flowers_3years_return = NaN;   
    years_40 = 1 + (ceil(40/length_cyclus)).*length_cyclus;
elseif rotation_type == 71 % BAU with 1-year grass cover in between at different intervals
    %main_rotation_interval = 6;
    length_cyclus = 13;
     start_length = 6;
    cyclus = [Rot_C_start];
    movement =[Rot_C_start_move];
    ploughing = [Rot_C_start_incorp];
    for i = 1:ceil(number_of_years/length_cyclus)
        cyclus = [cyclus,Rot_B_after,Rot_B_after,Rot_B_after,Rot_B_after,Rot_B_after,Rot_B_after, Rot_C_after];
        movement = [movement, Rot_B_after_move,Rot_B_after_move, Rot_B_after_move,Rot_B_after_move,Rot_B_after_move, Rot_B_after_move, Rot_C_after_move];
        ploughing = [ploughing, Rot_B_after_incorp,Rot_B_after_incorp,Rot_B_after_incorp,Rot_B_after_incorp,Rot_B_after_incorp,Rot_B_after_incorp, Rot_C_after_incorp];
    end
    %last movement&ploughing
    movement = [movement,movement_c];
    ploughing = [ploughing, Non_invert_plough];
    Grass_2years_return = 13;       
 Flowers_3years_return = NaN;
 years_40 = 1 + (ceil(40/length_cyclus)).*length_cyclus;
elseif rotation_type == 72 % BAU with WW drilling with 1-ygrass cover in between at different intervals
    %main_rotation_interval = 1;
      length_cyclus = 5;
    start_length = 6;
    cyclus = [Rot_C_start_plus];
    movement =[Rot_C_start_move_plus];
    ploughing = [Rot_C_start_incorp_plus];
    for i = 1:ceil(number_of_years/length_cyclus)
        cyclus = [cyclus,Rot_A_after_plus,Rot_C_after_plus];  %[Grass-WWdrill]-[OSR-WWdrill]-[Grass WWdrill] 
        movement = [movement,Rot_A_after_move_plus, Rot_C_after_move_plus];
        ploughing = [ploughing,Rot_A_after_incorp_plus, Rot_C_after_incorp_plus];
    end
    %last movement&ploughing
    movement = [movement,movement_c]; % for OSR
    ploughing = [ploughing, Non_invert_plough]; % for OSR
    Grass_2years_return = 3;
    Flowers_3years_return = NaN;
    years_40 = 1 + (ceil(40/length_cyclus)).*length_cyclus;
elseif rotation_type == 73 %BAU with WW drilling with 1-ygrass cover in between at different intervals
    %main_rotation_interval = 2;
    length_cyclus = 7;
    start_length = 6;
    cyclus = [Rot_C_start_plus];
    movement =[Rot_C_start_move_plus];
    ploughing = [Rot_C_start_incorp_plus];
    for i = 1:ceil(number_of_years/length_cyclus)
        cyclus = [cyclus,Rot_A_after_plus, Rot_A_after_plus, Rot_C_after_plus];
        movement = [movement, Rot_A_after_move_plus, Rot_A_after_move_plus, Rot_C_after_move_plus];
        ploughing = [ploughing, Rot_A_after_incorp_plus, Rot_A_after_incorp_plus, Rot_C_after_incorp_plus];
    end
    %last movement&ploughing
    movement = [movement,movement_c];
    ploughing = [ploughing, Non_invert_plough];
    Grass_2years_return = 5;
    Flowers_3years_return = NaN;
    years_40 = 1 + (ceil(40/length_cyclus)).*length_cyclus;
elseif rotation_type == 74 % BAU with WW drilling with 1-ygrass cover in between at different intervals
    %main_rotation_interval = 3;
    length_cyclus = 9;
     start_length = 6;
    cyclus = [Rot_C_start_plus];
    movement =[Rot_C_start_move_plus];
    ploughing = [Rot_C_start_incorp_plus];
    for i = 1:ceil(number_of_years/length_cyclus)
        cyclus = [cyclus,Rot_A_after_plus,Rot_A_after_plus,Rot_A_after_plus,...
            Rot_C_after_plus];
        movement = [movement, Rot_A_after_move_plus, Rot_A_after_move_plus, Rot_A_after_move_plus,...
            Rot_C_after_move_plus];
        ploughing = [ploughing, Rot_A_after_incorp_plus,Rot_A_after_incorp_plus,Rot_A_after_incorp_plus,...
            Rot_C_after_incorp_plus];
    end
    %last movement&ploughing
    movement = [movement,movement_c];
    ploughing = [ploughing, Non_invert_plough];
    Grass_2years_return = 7;
    Flowers_3years_return = NaN;
    years_40 = 1 + (ceil(40/length_cyclus)).*length_cyclus;
 elseif rotation_type == 75 % BAU with WW drilling w1-ygrass cover in between at different intervals
    %main_rotation_interval = 4;
    length_cyclus = 11;
     start_length = 6;
    cyclus = [Rot_C_start_plus];
    movement =[Rot_C_start_move_plus];
    ploughing = [Rot_C_start_incorp_plus];
    for i = 1:ceil(number_of_years/length_cyclus)
        cyclus = [cyclus,Rot_A_after_plus,Rot_A_after_plus,Rot_A_after_plus,...
            Rot_A_after_plus, Rot_C_after_plus];
        movement = [movement, Rot_A_after_move_plus,Rot_A_after_move_plus, Rot_A_after_move_plus,...
            Rot_A_after_move_plus, Rot_C_after_move_plus];
        ploughing = [ploughing, Rot_A_after_incorp_plus,Rot_A_after_incorp_plus, Rot_A_after_incorp_plus,...
            Rot_A_after_incorp_plus, Rot_C_after_incorp_plus];
    end
    %last movement&ploughing
    movement = [movement,movement_c];
    ploughing = [ploughing, Non_invert_plough];
    Grass_2years_return = 9;
    Flowers_3years_return = NaN;
    years_40 = 1 + (ceil(40/length_cyclus)).*length_cyclus;
elseif rotation_type == 76 % BAU with WW drilling 1-ygrass cover in between at different intervals
    %main_rotation_interval = 5;
    length_cyclus = 13;
     start_length = 6;
    cyclus = [Rot_C_start];
    movement =[Rot_C_start_move];
    ploughing = [Rot_C_start_incorp];
    for i = 1:ceil(number_of_years/length_cyclus)
        cyclus = [cyclus,Rot_A_after_plus,Rot_A_after_plus,Rot_A_after_plus,...
            Rot_A_after_plus,Rot_A_after_plus, Rot_C_after_plus];
        movement = [movement, Rot_A_after_move_plus,Rot_A_after_move_plus, Rot_A_after_move_plus,...
            Rot_A_after_move_plus, Rot_A_after_move_plus, Rot_C_after_move_plus];
        ploughing = [ploughing, Rot_A_after_incorp_plus,Rot_A_after_incorp_plus,Rot_A_after_incorp_plus,...
            Rot_A_after_incorp_plus,Rot_A_after_incorp_plus, Rot_C_after_incorp_plus];
    end
    %last movement&ploughing
    movement = [movement,movement_c];
    ploughing = [ploughing, Non_invert_plough];
    Grass_2years_return = 11;
    Flowers_3years_return = NaN;
    years_40 = 1 + (ceil(40/length_cyclus)).*length_cyclus;
elseif rotation_type == 77 % BAU with WW drilling with 1-ygrass cover in between at different intervals
    %main_rotation_interval = 6;
    length_cyclus = 15;
     start_length = 6;
    cyclus = [Rot_C_start];
    movement =[Rot_C_start_move];
    ploughing = [Rot_C_start_incorp];
    for i = 1:ceil(number_of_years/length_cyclus)
        cyclus = [cyclus,Rot_A_after_plus,Rot_A_after_plus,...
            Rot_A_after_plus,Rot_A_after_plus,Rot_A_after_plus,Rot_A_after_plus, Rot_C_after_plus];
        movement = [movement, Rot_A_after_move_plus,Rot_A_after_move_plus, Rot_A_after_move_plus,...
            Rot_A_after_move_plus,Rot_A_after_move_plus, Rot_A_after_move_plus, Rot_C_after_move_plus];
        ploughing = [ploughing, Rot_A_after_incorp_plus,Rot_A_after_incorp_plus,Rot_A_after_incorp_plus,...
            Rot_A_after_incorp_plus,Rot_A_after_incorp_plus,Rot_A_after_incorp_plus, Rot_C_after_incorp_plus];
    end
    %last movement&ploughing
    movement = [movement,movement_c];
    ploughing = [ploughing, Non_invert_plough];
    Grass_2years_return = 13;
    Flowers_3years_return = NaN;
    years_40 = 1 + (ceil(40/length_cyclus)).*length_cyclus;
    
elseif rotation_type == 78 % Best agronomy with WW drilling with 1-year grass cover in between at different intervals
    %main_rotation_interval = 1;
      length_cyclus = 5;
    start_length = 6;
    cyclus = [Rot_C_start_plus];
    movement =[Rot_C_start_move_plus];
    ploughing = [Rot_C_start_incorp_plus];
    for i = 1:ceil(number_of_years/length_cyclus)
        cyclus = [cyclus,Rot_B_after_plus,Rot_C_after_plus];  %[Grass-WWdrill]-[Beans-WWdrill]-[Grass WWdrill] 
        movement = [movement,Rot_B_after_move_plus, Rot_C_after_move_plus];
        ploughing = [ploughing,Rot_B_after_incorp_plus, Rot_C_after_incorp_plus];
    end
    %last movement&ploughing
    movement = [movement,movement_c]; % for OSR
    ploughing = [ploughing, Non_invert_plough]; % for OSR
    Grass_2years_return = 3;
    Flowers_3years_return = NaN;
    years_40 = 1 + (ceil(40/length_cyclus)).*length_cyclus;
elseif rotation_type == 79 %Best agronomy with WW drilling with 1-year grass cover in between at different intervals
    %main_rotation_interval = 2;
    length_cyclus = 7;
    start_length = 6;
    cyclus = [Rot_C_start_plus];
    movement =[Rot_C_start_move_plus];
    ploughing = [Rot_C_start_incorp_plus];
    for i = 1:ceil(number_of_years/length_cyclus)
        cyclus = [cyclus,Rot_B_after_plus, Rot_B_after_plus, Rot_C_after_plus];
        movement = [movement, Rot_B_after_move_plus, Rot_B_after_move_plus, Rot_C_after_move_plus];
        ploughing = [ploughing, Rot_B_after_incorp_plus, Rot_B_after_incorp_plus, Rot_C_after_incorp_plus];
    end
    %last movement&ploughing
    movement = [movement,movement_c];
    ploughing = [ploughing, Non_invert_plough];
    Grass_2years_return = 5;
    Flowers_3years_return = NaN;
    years_40 = 1 + (ceil(40/length_cyclus)).*length_cyclus;
elseif rotation_type == 80 % Best agronomy with WW drilling with 1-year grass cover in between at different intervals
    %main_rotation_interval = 3;
    length_cyclus = 9;
     start_length = 6;
    cyclus = [Rot_C_start_plus];
    movement =[Rot_C_start_move_plus];
    ploughing = [Rot_C_start_incorp_plus];
    for i = 1:ceil(number_of_years/length_cyclus)
        cyclus = [cyclus,Rot_B_after_plus,Rot_B_after_plus,Rot_B_after_plus,...
            Rot_C_after_plus];
        movement = [movement, Rot_B_after_move_plus, Rot_B_after_move_plus, Rot_B_after_move_plus,...
            Rot_C_after_move_plus];
        ploughing = [ploughing, Rot_B_after_incorp_plus,Rot_B_after_incorp_plus,Rot_B_after_incorp_plus,...
            Rot_C_after_incorp_plus];
    end
    %last movement&ploughing
    movement = [movement,movement_c];
    ploughing = [ploughing, Non_invert_plough];
    Grass_2years_return = 7;
    Flowers_3years_return = NaN;
    years_40 = 1 + (ceil(40/length_cyclus)).*length_cyclus;
 elseif rotation_type == 81 % Best agronomy with WW drilling with 1-year grass cover in between at different intervals
    %main_rotation_interval = 4;
    length_cyclus = 11;
     start_length = 6;
    cyclus = [Rot_C_start_plus];
    movement =[Rot_C_start_move_plus];
    ploughing = [Rot_C_start_incorp_plus];
    for i = 1:ceil(number_of_years/length_cyclus)
        cyclus = [cyclus,Rot_B_after_plus,Rot_B_after_plus,Rot_B_after_plus,...
            Rot_B_after_plus, Rot_C_after_plus];
        movement = [movement, Rot_B_after_move_plus,Rot_B_after_move_plus, Rot_B_after_move_plus,...
            Rot_B_after_move_plus, Rot_C_after_move_plus];
        ploughing = [ploughing, Rot_B_after_incorp_plus,Rot_B_after_incorp_plus, Rot_B_after_incorp_plus,...
            Rot_B_after_incorp_plus, Rot_C_after_incorp_plus];
    end
    %last movement&ploughing
    movement = [movement,movement_c];
    ploughing = [ploughing, Non_invert_plough];
    Grass_2years_return = 9;
    Flowers_3years_return = NaN;
    years_40 = 1 + (ceil(40/length_cyclus)).*length_cyclus;
elseif rotation_type == 82 % Best agronomy with WW drilling with 1-year grass cover in between at different intervals
    %main_rotation_interval = 5;
    length_cyclus = 13;
     start_length = 6;
    cyclus = [Rot_C_start];
    movement =[Rot_C_start_move];
    ploughing = [Rot_C_start_incorp];
    for i = 1:ceil(number_of_years/length_cyclus)
        cyclus = [cyclus,Rot_B_after_plus,Rot_B_after_plus,Rot_B_after_plus,...
            Rot_B_after_plus,Rot_B_after_plus, Rot_C_after_plus];
        movement = [movement, Rot_B_after_move_plus,Rot_B_after_move_plus, Rot_B_after_move_plus,...
            Rot_B_after_move_plus, Rot_B_after_move_plus, Rot_C_after_move_plus];
        ploughing = [ploughing, Rot_B_after_incorp_plus,Rot_B_after_incorp_plus,Rot_B_after_incorp_plus,...
            Rot_B_after_incorp_plus,Rot_B_after_incorp_plus, Rot_C_after_incorp_plus];
    end
    %last movement&ploughing
    movement = [movement,movement_c];
    ploughing = [ploughing, Non_invert_plough];
    Grass_2years_return = 11;
    Flowers_3years_return = NaN;
    years_40 = 1 + (ceil(40/length_cyclus)).*length_cyclus;
elseif rotation_type == 83 % Best agronomy with WW drilling with 1-year grass cover in between at different intervals
    %main_rotation_interval = 6;
    length_cyclus = 15;
     start_length = 6;
    cyclus = [Rot_C_start];
    movement =[Rot_C_start_move];
    ploughing = [Rot_C_start_incorp];
    for i = 1:ceil(number_of_years/length_cyclus)
        cyclus = [cyclus,Rot_B_after_plus,Rot_B_after_plus,...
            Rot_B_after_plus,Rot_B_after_plus,Rot_B_after_plus,Rot_B_after_plus, Rot_C_after_plus];
        movement = [movement, Rot_B_after_move_plus,Rot_B_after_move_plus, Rot_B_after_move_plus,...
            Rot_B_after_move_plus,Rot_B_after_move_plus, Rot_B_after_move_plus, Rot_C_after_move_plus];
        ploughing = [ploughing, Rot_B_after_incorp_plus,Rot_B_after_incorp_plus,Rot_B_after_incorp_plus,...
            Rot_B_after_incorp_plus,Rot_B_after_incorp_plus,Rot_B_after_incorp_plus, Rot_C_after_incorp_plus];
    end
    %last movement&ploughing
    movement = [movement,movement_c];
    ploughing = [ploughing, Non_invert_plough];
    Grass_2years_return = 13;
    Flowers_3years_return = NaN;    
    years_40 = 1 + (ceil(40/length_cyclus)).*length_cyclus;
end

fallows = find(cyclus == 8 | cyclus == 10 | cyclus == 11 | cyclus == 13 | cyclus == 14 | cyclus == 15);
prop_cash = 1 - (length(fallows)./length(cyclus));

end