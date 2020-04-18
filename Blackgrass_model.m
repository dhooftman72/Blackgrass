% Model runs for blackgrass
function Blackgrass_model
clear all
clc
delete ('Outputs_save.mat')

rotations_to_run = [6:9,36:59,72:83]; %83
run_max =25000;


max_heads = 10000; % = approx 500 plant m2, see Colbach et al. 2007
max_yield = 8.39;
threshold_yield = 1;
yield_rico = -0.0108;
cover_rico_high = 0.0902;
c_point_cover_high = 7.3282;
cover_rico_low = 0.113;
split_line_point = c_point_cover_high./cover_rico_low;
reduction_OSR_spray = 0.88;

% load parameters and the rotation to run
load('distributions.mat')

for rotation_run = 1:1:length(rotations_to_run)
    rotation_type = rotations_to_run(rotation_run);
    display(rotation_type)
    [cyclus, ~,~,~,~,~,~,~,~,prop_cash] = Rotations(rotation_type);
    years(rotation_run) = length(cyclus);
    proportion_cash(rotation_run) = prop_cash;
    max_years = max(years);
    clear cyclus
end

cyclus_lambdas = NaN(10,length(rotations_to_run));
lambda_larger_1 = NaN(4,length(rotations_to_run));


time_to_fulnesses = NaN(10,length(rotations_to_run));
time_to_extinctions = NaN(10,length(rotations_to_run));

total_growth_avg_sb = zeros(length(rotations_to_run),max_years);
total_growth_med_sb = zeros(length(rotations_to_run),max_years);
total_growth_005_sb = zeros(length(rotations_to_run),max_years);
total_growth_095_sb = zeros(length(rotations_to_run),max_years);

total_growth_avg_heads = zeros(length(rotations_to_run),max_years);
total_growth_med_heads = zeros(length(rotations_to_run),max_years);
total_growth_005_heads = zeros(length(rotations_to_run),max_years);
total_growth_095_heads = zeros(length(rotations_to_run),max_years);

total_all_seeds_avg = zeros(length(rotations_to_run),(max_years+1));% NOte one more year
total_all_seeds_med = zeros(length(rotations_to_run),(max_years+1));% NOte one more year
total_all_seeds_005 = zeros(length(rotations_to_run),(max_years+1));% NOte one more year
total_all_seeds_095 = zeros(length(rotations_to_run),(max_years+1));% NOte one more year

total_heads_year_avg = zeros(length(rotations_to_run),max_years);
total_heads_year_med = zeros(length(rotations_to_run),max_years);
total_heads_year_005 = zeros(length(rotations_to_run),max_years);
total_heads_year_095 = zeros(length(rotations_to_run),max_years);


for rotation_run = 1:1:length(rotations_to_run)
    rotation_type = rotations_to_run(rotation_run);
    display(rotation_type)
    
    [cyclus, movement, ploughing, ~,~,...
        ~,~,length_cyclus,years_40,~] = Rotations(rotation_type);   
    
    Half_year_seed_mortality = 0.48;
    One_year_seed_mortality = Half_year_seed_mortality; %0.14;
    
    ss_L1_year = zeros(run_max,(length(cyclus)+1));
    ss_L2_year = zeros(run_max,(length(cyclus)+1));
    all_seeds = zeros(run_max,(length(cyclus)+1));
    growth_rate_sb = zeros(run_max,(length(cyclus)));
    heads_year = zeros(run_max,length(cyclus));
    growth_rate_heads = zeros(run_max,length(cyclus));
    yield = zeros(run_max,length(cyclus));
   cover = zeros(run_max,length(cyclus));
    above_threshold =  zeros(run_max,length(cyclus));

    above_threshold_5 =  zeros(run_max,length(cyclus));
    above_threshold_12 =  zeros(run_max,length(cyclus));
    time_to_fullness =  NaN(run_max,1);
    time_to_extinction = NaN(run_max,1);
    time_to_fullness_40 =  NaN(run_max,1);
    time_to_extinction_40 = NaN(run_max,1);
    cash_crop_prop =  NaN(run_max,1);
    cash_crop_prop_40 =  NaN(run_max,1);
    cash_crop = zeros(length(cyclus),1);

    for i = 1:1:length(cyclus)
        if cyclus(i) ~= 8 && cyclus(i) ~= 10 && cyclus(i) ~= 11 && cyclus(i) ~= 13 && cyclus(i) ~= 14 &&...
                cyclus(i) ~= 15 
            cash_crop(i) = 1;
        end
    end
    total_cash_crops = sum(cash_crop(1:length(cash_crop)));
    total_cash_crops_40 = sum(cash_crop(1:(years_40)));
    clear i

    for run = 1:1:run_max
        if run/100== round(run/100) || run == 1
            clc
            display(rotation_type)
            display(run)
        end
        
        above_threshold_cash = zeros(length(cyclus),1);
        first_time = 0;
        extinct = 0;
        for year = 1:1:length(cyclus)
            if run == 1 % first run is with averages
                seeds_per_head_ratio = seeds_per_head(1,cyclus(year));
                emergence_ratio = Emergence_rate(1,cyclus(year));
                seed_bank_start_5cm = start_seedbank_5cm(1,cyclus(1));
                seed_bank_start_20cm=  start_seedbank_20cm(1,cyclus(1));
                Heads_per_emergence = Heads_per_Emergence(1,cyclus(year));
            else
                seeds_per_head_ratio = -1;
                emergence_ratio = -1;
                Heads_per_emergence = -1;
                seed_bank_start_5cm = -1;
                seed_bank_start_20cm = -1;
                
                while seeds_per_head_ratio <0 || emergence_ratio <0 || Heads_per_emergence <0 ||...
                        seed_bank_start_5cm <0 || seed_bank_start_20cm <0 || emergence_ratio >1
                    seeds_per_head_ratio =  seeds_per_head(1,cyclus(year)) + randn.*((seeds_per_head(3,cyclus(year))));
                    emergence_ratio = Emergence_rate(1,cyclus(year)) + randn.*((Emergence_rate(3,cyclus(year))));
                    Heads_per_emergence = Heads_per_Emergence(1,cyclus(year)) + randn.*((Heads_per_Emergence(3,cyclus(year))));
                    seed_bank_start_5cm = start_seedbank_5cm(1,cyclus(1)) + randn.*((start_seedbank_5cm(3,cyclus(1))));
                    seed_bank_start_20cm =  start_seedbank_20cm(1,cyclus(1)) + randn.*((start_seedbank_20cm(3,cyclus(1))));                    
                end
                
                
            end
            
            %% The main model
            % the year starts with emergence
            if year == 1
                ss_L1 = seed_bank_start_5cm;
                ss_L2 =  seed_bank_start_20cm;
                ss_L1_year(run,year) = ss_L1;
                ss_L2_year(run,year) = ss_L2;
                all_seeds(run,year) = ss_L1 + ss_L2;
%                 growth_rate_sb(run,1:start_length+1) = 1;
%                 growth_rate_heads(run,1:start_length+1) = 1;
            end
            %Period 1: seeds produced per seeds
            emergence_plants = emergence_ratio.*ss_L1;
            
             % spraying on OSR
            if cyclus(year) == 2
            emergence_plants = emergence_plants.* (1-reduction_OSR_spray);
            end
            heads_produced = (emergence_plants).*Heads_per_emergence;
            if heads_produced < 0
                heads_produced = 0;
            end
            
            
            % density dependece
            if heads_produced > 0
            if year > 1
                fullness = heads_produced./max_heads;
                if fullness >= 1
                    %  fullness = 1;
                    %heads_produced = max_heads;
                     if first_time == 0
                        time_to_fullness(run) = year;
                        if year <=years_40
                            time_to_fullness_40(run) = year;
                        end
                    end
                    first_time = 1;
                end
                heads_produced = max_heads.* (1-(exp(-fullness)));
            end
            end
            
            % managment refime on fallows, assuming full control
            if cyclus(year) == 8 || cyclus(year) == 10 || cyclus(year) == 11 || cyclus(year) ==13 || cyclus(year) ==14 || cyclus(year) ==15
                seeds_per_head_ratio = 0;
            end
            
            seeds_produced = heads_produced.*seeds_per_head_ratio;
            if seeds_produced < 0 %#ok<*BDSCI>
                seeds_produced = 0;
            end
            
            % Period 1  seed bank mortality
            ss_L1a = (ss_L1- (emergence_plants)).*One_year_seed_mortality;
            ss_L2a =  ss_L2.*One_year_seed_mortality;
            if ss_L1a < 0
                ss_L1a = 0;
            end
            if ss_L2a <0
                ss_L2a = 0;
            end
                       
            ss_L1b = (seeds_produced.*ploughing(year+1)).*movement(1,year+1);
            ss_L2b = (seeds_produced.*ploughing(year+1)).*movement(2,year+1);
            
            %Period 2: movement and incorperation
            ss_L1= (((movement(1,year+1).*ss_L1a) + ((movement(3,year+1).* ss_L2a)))) + ss_L1b;% +...
                %(seeds_produced.*ploughing(year+1)); % emergence is imidiate, so no mortality of seeds entering the sb
            ss_L2= (((movement(4,year+1).*ss_L2a)+ ((movement(2,year+1).* ss_L1a)))) + ss_L2b;
            
            if ss_L1 < 0
                ss_L1 = 0;
            end
            if ss_L2 <0
                ss_L2 = 0;
            end
            clear  ss_L1a
            clear  ss_L1b
            clear  ss_L2a
            clear  ss_L2b
            
            % store outputs
            ss_L1_year(run,year+1) = ss_L1;
            ss_L2_year(run,year+1) = ss_L2;
            all_seeds(run,year+1) = ss_L1 + ss_L2;
            heads_year(run,year) = heads_produced;
            
            if year >10
            if year >10 & all_seeds(run,((year-2):(year+1))) <= 0.0001 & extinct == 0 %
                time_to_extinction(run) = year;
                if year <=years_40
                    time_to_extinction_40(run) = year;
                end
                extinct = 1;
            end
            end
            
            % calculate growth rates
                growth_rate_sb(run,year) = all_seeds(run,year+1)./all_seeds(run,1);
                growth_rate_heads(run,year) = heads_year(run,year)./heads_year(run,1);
            
            
            
            % yield losses
            yield(run,year) = max_yield + (yield_rico*heads_produced); % this to make a graph of average yield as % of full yield
            if yield(run,year) <0
                yield(run,year) = 0;
            end
            if yield(run,year) < max_yield-threshold_yield % calcuate from here the % of runs that are above a threshold
                above_threshold(run,year) = 1;
                if cash_crop(year) == 1
                    above_threshold_cash(year) = 1;
                end
            end
             yield(run,year) =  yield(run,year)./max_yield;
             if cash_crop(year) ~= 1
                 yield(run,year) = NaN;
             end
             
             % cover calculation
             if heads_produced <split_line_point
                cover(run,year) = cover_rico_low.*heads_produced;
             else
                cover(run,year) = (cover_rico_high.*heads_produced) + c_point_cover_high; 
             end
             cover(run,year) = cover(run,year)./100;
             if cash_crop(year) ~= 1
                 cover(run,year) = NaN;
             end
             if cover(run,year) > 1
                 cover(run,year) = 1;
             end
             
            if emergence_plants >5
                above_threshold_5(run,year) = 1;
            end
            if emergence_plants >12
                above_threshold_12(run,year) = 1;
            end
            clear heads_produced
            clear seeds_produced
            clear ss_L1a
            clear ss_L2a
            
            %%
        end % End of per year cyclus
        clear year
        % OUTPUT per run
        if first_time == 1;
            cyclus_lambda(run) = (growth_rate_sb(run,((time_to_fullness(run)))))^(1/((time_to_fullness(run)))); %#ok<*AGROW,*SAGROW>
            cyclus_lambda_max(run) = (max(growth_rate_sb(run,:)))^(1/((time_to_fullness(run))));
        else
            cyclus_lambda(run) = (growth_rate_sb(run,length(cyclus)))^(1/((length(cyclus))));
            cyclus_lambda_max(run) = (max(growth_rate_sb(run,((length(cyclus)-length_cyclus):length(cyclus)))))^(1/(length(cyclus)));
        end
        if first_time == 1 && time_to_fullness(run) < (years_40)
            cyclus_lambda_40(run) = (growth_rate_sb(run,((time_to_fullness(run)))))^(1/((time_to_fullness(run))));
            cyclus_lambda_max_40(run) = (growth_rate_sb(run,years_40))^(1/((time_to_fullness(run))));
        else
            cyclus_lambda_40(run) = (growth_rate_sb(run,(40)))^(1/40);
            cyclus_lambda_max_40(run) = (growth_rate_sb(run,years_40)) ^(1/((years_40)));
        end
        
        % cash crops % threshold
        if total_cash_crops > 0
        cash_crop_prop(run) = (sum(above_threshold_cash(1:length(above_threshold_cash)))) ./total_cash_crops;
        else
            cash_crop_prop(run) = NaN;
        end
        if total_cash_crops_40 > 0
        cash_crop_prop_40(run) = (sum(above_threshold_cash(1:(years_40))))./total_cash_crops_40;
        else 
            cash_crop_prop_40(run) = NaN;
        end
        clear above_threshold_cash
    end % End of runs
    
    %% OUTPUT PER ROTATION RUN
    % calculate chance on Lamda >= 1
    cyclus_lambda_per = cyclus_lambda(cyclus_lambda >=1);
    lambda_larger_1(1,rotation_run) = length(cyclus_lambda_per)./run_max;
    clear  cyclus_lambda_per
    cyclus_lambda_per = cyclus_lambda(cyclus_lambda_max >=1);
    lambda_larger_1(2,rotation_run) = length(cyclus_lambda_per)./run_max;
    clear  cyclus_lambda_per
    cyclus_lambda_per = cyclus_lambda(cyclus_lambda_40 >=1);
    lambda_larger_1(3,rotation_run) = length(cyclus_lambda_per)./run_max;
    clear  cyclus_lambda_per
    cyclus_lambda_per = cyclus_lambda(cyclus_lambda_max_40 >=1);
    lambda_larger_1(4,rotation_run) = length(cyclus_lambda_per)./run_max;
    clear  cyclus_lambda_per
    
    %collate data among runs
    cyclus_lambdas(1,rotation_run) = mean(cyclus_lambda_max,2); % one number
    cyclus_lambdas(2,rotation_run) = median(cyclus_lambda_max,2); % one number
    cyclus_lambdas(3,rotation_run) = prctile(cyclus_lambda_max,5,2); %one number
    cyclus_lambdas(4,rotation_run) = prctile(cyclus_lambda_max,95,2);% one number
    cyclus_lambdas(5,rotation_run) = mean( cyclus_lambda_max_40,2); % one number
    cyclus_lambdas(6,rotation_run) = median(cyclus_lambda_max_40,2); % one number
    cyclus_lambdas(7,rotation_run) = prctile(cyclus_lambda_max_40,5,2); %one number
    cyclus_lambdas(8,rotation_run) = prctile(cyclus_lambda_max_40,95,2);% one number
    cyclus_lambdas(9,rotation_run) = mean( cyclus_lambda_40,2); % one number
    cyclus_lambdas(10,rotation_run) = median(cyclus_lambda_40,2); % one number
    cyclus_lambdas(11,rotation_run) = prctile(cyclus_lambda_40,5,2); %one number
    cyclus_lambdas(12,rotation_run) = prctile(cyclus_lambda_40,95,2);% one number
    cyclus_lambdas(13,rotation_run) = mean(cyclus_lambda,2); % one number
    cyclus_lambdas(14,rotation_run) = median(cyclus_lambda,2); % one number
    cyclus_lambdas(15,rotation_run) = years_40;
    
    clear cyclus_lambda_max
    clear cyclus_lambda_max_40
    clear cyclus_lambda
    clear cyclus_lambda_40
    clear years_40
    
    time_to_fullness(isnan(time_to_fullness)==1) = [];
    time_to_extinction(isnan(time_to_extinction)==1)=[];
    percentage_fulness = length(time_to_fullness)./run_max;
    percentage_extinction = length(time_to_extinction)./run_max;
    time_to_fullness_40(isnan(time_to_fullness_40)==1) = [];
    time_to_extinction_40(isnan(time_to_extinction_40)==1)=[];
    percentage_fulness_40 = length(time_to_fullness_40)./run_max;
    percentage_extinction_40 = length(time_to_extinction_40)./run_max;
    
    if isempty(time_to_fullness) ~= 1
        time_to_fulnesses(1,rotation_run) = mean(time_to_fullness); % one number
        time_to_fulnesses(2,rotation_run) = median(time_to_fullness);% one number
        time_to_fulnesses(3,rotation_run) = prctile(time_to_fullness,5); % one number
        time_to_fulnesses(4,rotation_run) = prctile(time_to_fullness,95); % one number
        time_to_fulnesses(5,rotation_run) =  percentage_fulness;
    end
    clear time_to_fullness
    clear percentage_fulness
    
    if isempty(time_to_fullness_40) ~= 1
        time_to_fulnesses(6,rotation_run) = mean(time_to_fullness_40); % one number
        time_to_fulnesses(7,rotation_run) = median(time_to_fullness_40);% one number
        time_to_fulnesses(8,rotation_run) = prctile(time_to_fullness_40,5); % one number
        time_to_fulnesses(9,rotation_run) = prctile(time_to_fullness_40,95); % one number
        time_to_fulnesses(10,rotation_run) =  percentage_fulness_40;
    end
    clear time_to_fullness_40
    clear percentage_fulness_40
    
    if isempty(time_to_extinction) ~=1
        time_to_extinctions(1,rotation_run) = mean(time_to_extinction); % one number
        time_to_extinctions(2,rotation_run) = median(time_to_extinction);% one number
        time_to_extinctions(3,rotation_run) = prctile(time_to_extinction,5); % one number
        time_to_extinctions(4,rotation_run) = prctile(time_to_extinction,95); % one number
        time_to_extinctions(5,rotation_run) =  percentage_extinction;
    end
    clear time_to_extinction
    clear percentage_extinction
    
    if isempty(time_to_extinction_40) ~=1
        time_to_extinctions(6,rotation_run) = mean(time_to_extinction_40); % one number
        time_to_extinctions(7,rotation_run) = median(time_to_extinction_40);% one number
        time_to_extinctions(8,rotation_run) = prctile(time_to_extinction_40,5); % one number
        time_to_extinctions(9,rotation_run) = prctile(time_to_extinction_40,95); % one number
        time_to_extinctions(10,rotation_run) =  percentage_extinction_40;
    end
    clear time_to_extinction_40
    clear percentage_extinction_40
    if isempty(cash_crop_prop) ~=1
        cash_crops_prop(1,rotation_run) = mean(cash_crop_prop); % one number
        cash_crops_prop(2,rotation_run) = median(cash_crop_prop);% one number
       cash_crops_prop(3,rotation_run) = prctile(cash_crop_prop,5); % one number
       cash_crops_prop(4,rotation_run) = prctile(cash_crop_prop,95); % one number
    end
    if isempty(cash_crop_prop_40) ~=1
        cash_crops_prop(5,rotation_run) = mean(cash_crop_prop_40); % one number
        cash_crops_prop(6,rotation_run) = median(cash_crop_prop_40);% one number
       cash_crops_prop(7,rotation_run) = prctile(cash_crop_prop_40,5); % one number
       cash_crops_prop(8,rotation_run) = prctile(cash_crop_prop_40,95); % one number
    end
    clear cash_crop_prop
    clear cash_crop_prop_40
    
    lengte = size(growth_rate_sb,2)+1;
    % total growth sb
    total_growth_avg_sb_a = mean(growth_rate_sb,1); % array
    total_growth_med_sb_a = median(growth_rate_sb,1);% array
    total_growth_005_sb_a = prctile(growth_rate_sb,5,1); %array
    total_growth_095_sb_a = prctile(growth_rate_sb,95,1); %array
    
    total_growth_avg_sb_a(lengte:max_years) = NaN;
    total_growth_med_sb_a(lengte:max_years) = NaN;
    total_growth_005_sb_a(lengte:max_years) = NaN;
    total_growth_095_sb_a(lengte:max_years) = NaN;
    
    total_growth_avg_sb(rotation_run,:) = total_growth_avg_sb_a;
    total_growth_med_sb(rotation_run,:) = total_growth_med_sb_a;
    total_growth_005_sb(rotation_run,:) = total_growth_005_sb_a;
    total_growth_095_sb(rotation_run,:) = total_growth_095_sb_a;
    
    clear total_growth_avg_sb_a
    clear total_growth_med_sb_a
    clear total_growth_005_sb_a
    clear total_growth_095_sb_a
    
    % total growth heads
    total_growth_avg_heads_a = mean(growth_rate_heads,1); % array
    total_growth_med_heads_a = median(growth_rate_heads,1);% array
    total_growth_005_heads_a = prctile(growth_rate_heads,5,1); %array
    total_growth_095_heads_a = prctile(growth_rate_heads,95,1); %array
    
    total_growth_avg_heads_a(lengte:max_years) = NaN;
    total_growth_med_heads_a(lengte:max_years) = NaN;
    total_growth_005_heads_a(lengte:max_years) = NaN;
    total_growth_095_heads_a(lengte:max_years) = NaN;
    
    total_growth_avg_heads(rotation_run,:) = total_growth_avg_heads_a;
    total_growth_med_heads(rotation_run,:) = total_growth_med_heads_a;
    total_growth_005_heads(rotation_run,:) = total_growth_005_heads_a;
    total_growth_095_heads(rotation_run,:) = total_growth_095_heads_a;
    
    clear total_growth_avg_heads_a
    clear total_growth_med_heads_a
    clear total_growth_005_heads_a
    clear total_growth_095_heads_a
    
    % total heads per year
    total_heads_year_avg_a = mean(heads_year,1); % array
    total_heads_year_med_a = median(heads_year,1);% array
    total_heads_year_005_a = prctile(heads_year,5,1); %array
    total_heads_year_095_a = prctile(heads_year,95,1); %array
    
    total_heads_year_avg_a(lengte:max_years) = NaN;
    total_heads_year_med_a(lengte:max_years) = NaN;
    total_heads_year_005_a(lengte:max_years) = NaN;
    total_heads_year_095_a(lengte:max_years) = NaN;
    
    total_heads_year_avg(rotation_run,:) = total_heads_year_avg_a; % array
    total_heads_year_med(rotation_run,:) =total_heads_year_med_a;% array
    total_heads_year_005(rotation_run,:) = total_heads_year_005_a; %array
    total_heads_year_095(rotation_run,:) = total_heads_year_095_a; %array
    
    clear total_heads_year_avg_a
    clear total_heads_year_med_a
    clear total_heads_year_005_a
    clear total_heads_year_095_a
    
    % yield per year
    total_yield_avg_a = mean(yield,1); % array
    total_yield_med_a = median(yield,1);% array
    total_yield_005_a = prctile(yield,5,1); %array
    total_yield_095_a = prctile(yield,95,1); %array
    
    total_yield_avg_a(lengte:max_years) = NaN;
    total_yield_med_a(lengte:max_years) = NaN;
    total_yield_005_a(lengte:max_years) = NaN;
    total_yield_095_a(lengte:max_years) = NaN;
    
    total_yield_avg(rotation_run,:) = total_yield_avg_a; % array
    total_yield_med(rotation_run,:) =total_yield_med_a;% array
    total_yield_005(rotation_run,:) =  total_yield_005_a; %array
    total_yield_095(rotation_run,:) = total_yield_095_a; %array
    
    % cover per year
        total_cover_avg_a = mean(cover,1); % array
    total_cover_med_a = median(cover,1);% array
    total_cover_005_a = prctile(cover,5,1); %array
    total_cover_095_a = prctile(cover,95,1); %array
    
    total_cover_avg_a(lengte:max_years) = NaN;
    total_cover_med_a(lengte:max_years) = NaN;
    total_cover_005_a(lengte:max_years) = NaN;
    total_cover_095_a(lengte:max_years) = NaN;
    
    total_cover_avg(rotation_run,:) = total_cover_avg_a; % array
    total_cover_med(rotation_run,:) =total_cover_med_a;% array
    total_cover_005(rotation_run,:) =  total_cover_005_a; %array
    total_cover_095(rotation_run,:) = total_cover_095_a; %array
    
    above_threshold_yield_a = (sum(above_threshold,1))./run_max;
    above_threshold_yield_5_a = (sum(above_threshold_5,1))./run_max;
    above_threshold_yield_12_a = (sum(above_threshold_12,1))./run_max;
    
    above_threshold_yield_a(lengte:max_years) = NaN;
    above_threshold_yield_5_a(lengte:max_years) = NaN;
    above_threshold_yield_12_a(lengte:max_years) = NaN;
    
    above_threshold_yield(rotation_run,:) = above_threshold_yield_a;
    above_threshold_yield_5(rotation_run,:) =  above_threshold_yield_5_a;
    above_threshold_yield_12(rotation_run,:) = above_threshold_yield_12_a;
    
    clear above_threshold_yield_a
    clear above_threshold_yield_5_a
    clear above_threshold_yield_12_a   
    clear total_yield_avg_a
    clear total_yield_med_a
    clear total_yield_005_a
    clear total_yield_095_a

    
    % total seeds per year
    lengte = lengte + 1;
    total_all_seeds_avg_a = mean(all_seeds,1); %% array NOTE one more year!!!
    total_all_seeds_med_a = median(all_seeds,1);% array
    total_all_seeds_005_a = prctile(all_seeds,5,1); %array
    total_all_seeds_095_a = prctile(all_seeds,95,1); %array
    
    total_all_seeds_avg_a(lengte:(max_years+1)) = NaN;
    total_all_seeds_med_a(lengte:(max_years+1)) = NaN;
    total_all_seeds_005_a(lengte:(max_years+1)) = NaN;
    total_all_seeds_095_a(lengte:(max_years+1)) = NaN;
    
    total_all_seeds_avg(rotation_run,:) = total_all_seeds_avg_a; % array NOTE one more year!!!
    total_all_seeds_med(rotation_run,:) = total_all_seeds_med_a;% array
    total_all_seeds_005(rotation_run,:) = total_all_seeds_005_a; %array
    total_all_seeds_095(rotation_run,:) = total_all_seeds_095_a; %array
    
    clear lengte
    clear  total_all_seeds_avg_a
    clear total_all_seeds_med_a
    clear total_all_seeds_005_a
    clear total_all_seeds_095_a
    
    clear growth_rate_sb
    clear growth_rate_heads
    clear cyclus_lambda
    clear all_seeds
    clear heads_year
    clear yield
    clear cover
    clear above_threshold
    clear above_threshold_12
  clear above_threshold_5
  clear total_cash_crops
  clear total_cash_crops_40
  
  clear cyclus
  clear movement
  clear ploughing
  clear start_length
  clear length_cyclus
  clear run
  
  clear Heads_per_emergence
  clear emergence_ratio
  clear extinct
  clear first_time
  clear fullness
  clear seeds_per_head_ratio
  clear ss_L1
  clear ss_L1_year
  clear ss_L2_year
  clear ss_L2
  clear Half_year_seed_mortality
  clear One_year_seed_mortality  
  clear emergence_plants
  
  save('Otputs_save')
end

Input_Emergence_rate = Emergence_rate; %#ok<*NASGU>
Input_Heads_per_Emergence = Heads_per_Emergence;
Input_seed_to_head_rate = seed_to_head_rate;
Input_seeds_per_head = seeds_per_head;
Input_start_seedbank_20cm = start_seedbank_20cm;
Input_start_seedbank_5cm = start_seedbank_5cm;
Main_lambda_larger_1 = lambda_larger_1;
Main_cyclus_lambdas = cyclus_lambdas;
Main_time_to_extinctions = time_to_extinctions;
Main_cash_crops_prop = cash_crops_prop;
Main_total_all_seeds_avg = total_all_seeds_avg;
Main_above_threshold_yield = above_threshold_yield;
Main_total_yield_avg = total_yield_avg;
Main_total_cover_avg = total_cover_avg;

%Calcuate 10y crop yield loss perspective
for y = 1:size(Main_total_yield_avg,1)
       for x= 1:1:30
            avg_10_a =  (Main_total_yield_avg(y,x:(x+9)))
            avg_10_a(isnan(avg_10_a) == 1) = [];
            avg_10_b(x) = mean(avg_10_a);
            if isempty(avg_10_b) == 1
                avg_10_b(x) = NaN;
            end
       end    
   avg_10(y) = 1- (mean(avg_10_b));
end
 avg_crop_prop_10y =  avg_10';
 clear avg_10
 clear avg_10_a
 clear avg_10_b
 clear x
 clear y
 
 for y = 1:size(Main_total_cover_avg,1)
       for x= 1:1:30
            avg_10_a =  (Main_total_cover_avg(y,x:(x+9)));
            avg_10_a(isnan(avg_10_a) == 1) = [];
            avg_10_b(x) = mean(avg_10_a);
            if isempty(avg_10_b) == 1
                avg_10_b(x) = NaN;
            end
       end    
   avg_10(y) = mean(avg_10_b);
end
 avg_cover_prop_10y =  avg_10';
 clear avg_10
 clear avg_10_a
 clear avg_10_b
 clear x
 clear y

clear cash_crops_prop
clear time_to_extinctions
clear lambda_larger_1
clear total_all_seeds_avg
clear cyclus_lambdas
clear above_threshold_yield
clear total_yield_avg
clear total_cover_avg

clear start_seedbank_20cm
clear start_seedbank_5cm
clear seeds_per_head
clear seed_to_head_rate
clear Heads_per_Emergence
clear Emergence_rate
clear Based_on_runs

clear max_heads
clear max_years
clear max_yield
clear rotation_run
clear run_max
clear seed_bank_start_20cm
clear seed_bank_start_5cm
clear threshold_yield
clear rotation_type
clear years
clear yield_rico
clear cover_rico_high
clear c_point_cover_high
clear cover_rico_low
clear split_line_point

save('Outputs_save')
end