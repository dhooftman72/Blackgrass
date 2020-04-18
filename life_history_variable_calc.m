% calculate seeds per emergence per year per treatment
% calcuated by 1) draw plot, 2) random draw emergence, 3) random draw
% heads, 4 random dras seeds
clear all
load('Blackgrass_data.mat')
delete('seeds_per_emergence.mat')
delete('distributions.mat')
Combine_plots_Heads
Combine_plots_Emergence

run_max = 10000;
range = 100;
% !!!!! In need of data!!!
Invert_plough = 0.285;% OSR following Gruber et al 2005 Table 4, T1 average of two cultivars
Non_invert_plough = 0.143;% OSR following Gruber et al 2005 Table 4, T3 average of two cultivars
no_plough = 0.0115; % OSR following Gruber et al 2005 Table 4, T4 average of two cultivars
avg_seed_bank = 544.7;
avg_seed_bank_low = 577.5;
One_year_seed_mortality = 0.14;
Half_year_seed_mortality = 0.48;

% Non_invert_plough
X_11_c = 0.7;
X_12_c = 0.3;
X_21_c = 0.12;
X_22_c = 0.88;
%
% Invert plough
X_11_p = 0.02;
X_12_p = 0.98;
X_21_p = 0.29;
X_22_p = 0.71;

All_5cm = reshape(Seed_bank_2013_5cm,1,(length(Seed_bank_2013_5cm)).*4);
All_20cm = reshape(Seed_bank_2013_20cm,1,(length(Seed_bank_2013_20cm)).*4);

start_seedbank_5cm(1,1:19) = poissfit(All_5cm);
start_seedbank_5cm(2,1:19) = mean(All_5cm);
start_seedbank_5cm(3,1:19) = std(All_5cm);
start_seedbank_20cm(1,1:19) = poissfit(All_20cm);
start_seedbank_20cm(2,1:19) = mean(All_20cm);
start_seedbank_20cm(3,1:19) = std(All_20cm);

for x= 1:1:19
    heads_y1 = 0;
    heads_y2 = 0;
    if x == 1
        emer = emergence_A1;
        emer_2 = emergence_A2;% x = 2
        emer_3 = emergence_A3; % x = 3
        heads = heads_A1;
        heads_2 = heads_A2; % x = 2
        heads_3 = heads_A3;  %x = 3
        seeds = Seeds_head_A;
        seed_bank = Seed_bank_2013_5cm (1,:);
        seed_bank_low = Seed_bank_2013_20cm (1,:);
        sb = 1;
        plough_incorperation_y2 = Non_invert_plough;
        plough_incorperation_y3 = Non_invert_plough;
        X_11_y2 = X_11_c;
        X_12_y2 = X_12_c;
        X_21_y2 = X_21_c;
        X_22_y2 = X_22_c;
        
        X_11_y3 = X_11_c;
        X_12_y3 = X_12_c;
        X_21_y3 = X_21_c;
        X_22_y3 = X_22_c;
    elseif x == 2
        emer = emergence_A2;
        heads = heads_A2;
        seeds = Seeds_head_A;
        sb = 1;
    elseif x == 3
        emer = emergence_A3;
        heads = heads_A3;
        seeds = Seeds_head_A;
    elseif x == 4
        emer = emergence_B1;
        emer_2 = emergence_B2; % x = 5
        emer_3 = emergence_B3; % x = 6
        heads = heads_B1;
        heads_2 = heads_B2;% x = 5
        heads_3 = heads_B3; % x = 6
        seeds = Seeds_head_B;
        seed_bank = Seed_bank_2013_5cm (2,:);
        seed_bank_low = Seed_bank_2013_20cm (2,:);
        sb = 2;
        plough_incorperation_y2 = Invert_plough;
        plough_incorperation_y3 = Non_invert_plough;
        X_11_y2 = X_11_p;
        X_12_y2 = X_12_p;
        X_21_y2 = X_21_p;
        X_22_y2 = X_22_p;
        X_11_y3 = X_11_c;
        X_12_y3 = X_12_c;
        X_21_y3 = X_21_c;
        X_22_y3 = X_22_c;
    elseif x == 5
        emer = emergence_B2;
        heads = heads_B2;
        seeds = Seeds_head_B;
    elseif x == 6
        emer = emergence_B3;
        heads = heads_B3;
        seeds = Seeds_head_B;
    elseif x == 7
        emer = emergence_C1; 
        emer_2 = emergence_C2; % x = 8
        emer_3 = emergence_C3; % x = 9
        heads = heads_C1;
        heads_2 = heads_C2; % x = 8
        heads_3 = heads_C3; % x = 9
        seeds = Seeds_head_C;
        seed_bank = Seed_bank_2013_5cm (3,:);
        seed_bank_low = Seed_bank_2013_20cm (3,:);
        sb =3;
        plough_incorperation_y2 = no_plough;
        plough_incorperation_y3 = Non_invert_plough;
        X_11_y2 = 1;
        X_12_y2 = 0;
        X_21_y2 = 0;
        X_22_y2 = 1;
        X_11_y3 = X_11_c;
        X_12_y3 = X_12_c;
        X_21_y3 = X_21_c;
        X_22_y3 = X_22_c;
    elseif x == 8
        emer = emergence_C2;
        heads = heads_C2;
        seeds = Seeds_head_C;
    elseif x == 9
        emer = emergence_C3;
        heads = heads_C3;
        seeds = Seeds_head_C;
    elseif x == 10
        emer = emergence_D1;
        emer_2 = emergence_D2; % x = 11
        emer_3 = emergence_D3; % x = 12
        heads = heads_D1;
        heads_2 = heads_D2; % x = 11
        heads_3 = heads_D3; % x =12
        seeds = Seeds_head_D;
        seed_bank = Seed_bank_2013_5cm (4,:);
        seed_bank_low = Seed_bank_2013_20cm (4,:);
        sb = 4;
        plough_incorperation_y2 = no_plough;
        plough_incorperation_y3 = Non_invert_plough;
        X_11_y2 = 1;
        X_12_y2 = 0;
        X_21_y2 = 0;
        X_22_y2 = 1;
        X_11_y3 = X_11_c;
        X_12_y3 = X_12_c;
        X_21_y3 = X_21_c;
        X_22_y3 = X_22_c;
    elseif x == 11
        emer = emergence_D2;
        heads = heads_D2;
        seeds = Seeds_head_D;
    elseif x == 12
        emer = emergence_D3;
        heads = heads_D3;
        seeds = Seeds_head_D;
    elseif x == 13
        emer = emergence_E1;
        emer_2 = emergence_E2; % x=14
        emer_3 = emergence_E3; % x = 15
        heads = heads_E1;
        heads_2 = heads_E2; % x=14
        heads_3 = heads_E3; % x =15
        seeds = Seeds_head_E;
        seed_bank = Seed_bank_2013_5cm (5,:);
        seed_bank_low = Seed_bank_2013_20cm (5,:);
        sb = 5;
        plough_incorperation_y2 = no_plough;
        plough_incorperation_y3 = no_plough;
        X_11_y2 = 1;
        X_12_y2 = 0;
        X_21_y2 = 0;
        X_22_y2 = 1;
        X_11_y3 = 1;
        X_12_y3 = 0;
        X_21_y3 = 0;
        X_22_y3 = 1;
    elseif x == 14
        emer = emergence_E2;
        heads = heads_E2;
        seeds = Seeds_head_E;
    elseif x == 15
        emer = emergence_E3;
        heads = heads_E3;
        seeds = Seeds_head_E;
    elseif x == 16
        emer = emergence_A1;
        emer_2 = emergence_A2;
        emer_3 = emergence_A3_plus;
        heads = heads_A1;
        heads_2 = zeros(4,20); %heads_A2
        heads_3 = heads_A3_plus;
        seeds = Seeds_head_A;
        seeds_y3 = Seeds_head_A_plus;
        seed_bank = Seed_bank_2013_5cm (1,:);
        seed_bank_low = Seed_bank_2013_20cm (1,:);
        sb = 1;
        plough_incorperation_y2 = Non_invert_plough;
        plough_incorperation_y3 = no_plough;
        X_11_y2 = X_11_c;
        X_12_y2 = X_12_c;
        X_21_y2 = X_21_c;
        X_22_y2 = X_22_c;
        
        X_11_y3 = 1;
        X_12_y3 = 0;
        X_21_y3 = 0;
        X_22_y3 = 1;
    elseif x == 17
        emer = emergence_B1;
        emer_2 = emergence_B2;
        emer_3 = emergence_B3_plus;
        heads = heads_B1;
        heads_2 = heads_B2;
        heads_3 = heads_B3_plus;
        seeds = Seeds_head_B;
        seeds_y3 = Seeds_head_B_plus;
        seed_bank = Seed_bank_2013_5cm (2,:);
        seed_bank_low = Seed_bank_2013_20cm (2,:);
        sb = 2;
        plough_incorperation_y2 = Invert_plough;
        plough_incorperation_y3 = no_plough;
        X_11_y2 = X_11_p;
        X_12_y2 = X_12_p;
        X_21_y2 = X_21_p;
        X_22_y2 = X_22_p;
        X_11_y3 = 1;
        X_12_y3 = 0;
        X_21_y3 = 0;
        X_22_y3 = 1;
    elseif x == 18
        emer = emergence_C1;
        emer_2 = emergence_C2;
        emer_3 = emergence_C3_plus;
        heads = heads_C1;
        heads_2 = heads_C2;
        heads_3 = heads_C3_plus;
        seeds = Seeds_head_C;
        seeds_y3 = Seeds_head_C_plus;
        seed_bank = Seed_bank_2013_5cm (3,:);
        seed_bank_low = Seed_bank_2013_20cm (3,:);
        sb =3;
        plough_incorperation_y2 = no_plough;
        plough_incorperation_y3 = no_plough;
        X_11_y2 = 1;
        X_12_y2 = 0;
        X_21_y2 = 0;
        X_22_y2 = 1;
        X_11_y3 = 1;
        X_12_y3 = 0;
        X_21_y3 = 0;
        X_22_y3 = 1;
        
    elseif x == 19
        emer = emergence_D1;
        emer_2 = emergence_D2;
        emer_3 = emergence_D3_plus;
        heads = heads_D1;
        heads_2 = heads_D2;
        heads_3 = heads_D3_plus;
        seeds = Seeds_head_D;
        seeds_y3 = Seeds_head_D_plus;
        seed_bank = Seed_bank_2013_5cm (4,:);
        seed_bank_low = Seed_bank_2013_20cm (4,:);
        sb = 4;
        plough_incorperation_y2 = no_plough;
        plough_incorperation_y3 = no_plough;
        X_11_y2 = 1;
        X_12_y2 = 0;
        X_21_y2 = 0;
        X_22_y2 = 1;
        X_11_y3 = 1;
        X_12_y3 = 0;
        X_21_y3 = 0;
        X_22_y3 = 1;
    end
    
    seed_per_emergence = zeros(run_max,1);
    if x== 1 || x == 4 || x== 7 || x == 10 || x == 13 || x >15
        for run = 1:1:run_max
            
            if run/1000 == round(run/1000) || run == 1
                clc
                display(x)
                display(run)
            end
            valid = 0;
            while valid == 0
                % draw plot
                series_heads = randi(2)-1;
                series_heads_2 = randi(2)-1;
                series_heads_3 = randi(2)-1;
                series_emer = randi(2)-1;
                series_emer_2 =  randi(2)-1;
                series_emer_3 =  randi(2)-1;
                plot = randi(4);
                quadrat_heads = randi(10)+ (10*series_heads);
                quadrat_heads_2 = randi(10)+ (10*series_heads_2);
                quadrat_heads_3 = randi(10)+ (10*series_heads_3);
                quadrat_emer = randi(10) + (10*series_emer);
                quadrat_emer_2 = randi(10) + (10*series_emer_2);
                quadrat_emer_3 = randi(10) + (10*series_emer_3);
                if isnan(heads(plot,quadrat_heads))~= 1 &&  isnan(emer(plot,quadrat_emer))~= 1 &&...
                        isnan(emer_2(plot,quadrat_emer_2))~= 1 && isnan(heads_2(plot,quadrat_heads_2))~= 1 &&...
                        isnan(heads_3(plot,quadrat_heads_3))~= 1 && isnan(emer_3(plot,quadrat_emer_3))~= 1
                    valid = 1;
                end
            end
            seedhead = randi(10);
            seedhead_2 = randi(10);
            nr_seeds(run) = heads(plot,quadrat_heads).* seeds(plot,seedhead);
            nr_seeds_2 = heads_2(plot,quadrat_heads_2).* seeds(plot,seedhead_2);
            number_seeds(run) = seeds(plot,seedhead);
            if x> 15
                number_seeds_y3(run) = seeds_y3(plot,seedhead);
            end
            
            
            
            heads_y1(run) = heads(plot,quadrat_heads);
            emergence_y1(run) = emer(plot,quadrat_emer);
            % seed_bank_all(run) = seed_bank(plot);
            seed_bank_all(run) = avg_seed_bank;
            
            % calculation emergence rate year 2
            %             ss_y1_y2_L1a = (seed_bank(plot)-emer(plot,quadrat_emer)).*One_year_seed_mortality;
            %             ss_y1_y2_L2a =  seed_bank_low(plot).* Half_year_seed_mortality;
            
            ss_y1_y2_L1a = (avg_seed_bank-emer(plot,quadrat_emer)).*Half_year_seed_mortality;
            ss_y1_y2_L2a =  avg_seed_bank_low.* Half_year_seed_mortality;
            
            
            if ss_y1_y2_L1a < 0
                ss_y1_y2_L1a = 0;
            end
            ss_y1_y2_L1a = ss_y1_y2_L1a +  ((nr_seeds(run).*plough_incorperation_y2));
            ss_y1_y2_L1= ((X_11_y2.*ss_y1_y2_L1a) + (X_21_y2.* ss_y1_y2_L2a));
            ss_y1_y2_L2= (X_22_y2.*ss_y1_y2_L2a)+ (X_12_y2.*ss_y1_y2_L1a);
            emergence_y2(run) = emer_2(plot,quadrat_emer_2);
            heads_y2(run) = heads_2(plot,quadrat_heads_2);
            ss_y1_y2_L1_all(run) = ss_y1_y2_L1;
            
            % calculation emergence rate year 3
            ss_y2_y3_L1a = (ss_y1_y2_L1 - emer_2(plot,quadrat_emer_2)).*Half_year_seed_mortality;
            if ss_y2_y3_L1a < 0
                ss_y2_y3_L1a = 0;
            end
            ss_y2_y3_L2a = ss_y1_y2_L2.* Half_year_seed_mortality;
            ss_y2_y3_L1= ((X_11_y3.*ss_y2_y3_L1a) + (X_21_y3.* ss_y2_y3_L2a)) +  ((nr_seeds_2.*plough_incorperation_y3));
            ss_y2_y3_L2= (X_22_y3.*ss_y2_y3_L2a)+ (X_12_y3.*ss_y2_y3_L1a);
            emergence_y3(run) = emer_3(plot,quadrat_emer_3);
            heads_y3(run) = heads_3(plot,quadrat_heads_3);
            ss_y2_y3_L1_all(run) = ss_y2_y3_L1;
            
            %             if x== 7 && run == 100
            %             emergence_rat
            %             emergence_rat_y2
            %             emergence_rat_y3
            %             c
            %             end
        end

    
    %     seed_per_clean = seed_per_emergence;
    %     seed_per_clean(isinf(seed_per_clean)==1) = NaN;
    %     a=find(isnan(seed_per_clean)==1);
    %     seed_per_clean(a) = []; %#ok<*FNDSB>
    %
    %     nr_seed_per_clean = number_seeds;
    %     nr_seed_per_clean(isinf(nr_seed_per_clean)==1) = NaN;
    %     a=find(isnan(nr_seed_per_clean)==1);
    %     nr_seed_per_clean(a) = []; %#ok<*FNDSB>
    
        count = 0;
        for i = 1:range:run_max
            count = count + 1;
            emergence_rat(count) = sum(emergence_y1(i:(i+(range-1))))./sum( seed_bank_all(i:(i+(range-1))));
            heads_rat(count) =  sum(heads_y1(i:(i+(range-1))))./sum( seed_bank_all(i:(i+(range-1))));
            heads_rat_y2(count) =  sum(heads_y2(i:(i+(range-1))))./sum(ss_y1_y2_L1_all(i:(i+(range-1))));
            head_to_head_y2(count) = sum(heads_y2(i:(i+(range-1))))./sum(heads_y1(i:(i+(range-1))));
            emergence_rat_y2(count) = sum(emergence_y2(i:(i+(range-1))))./sum(ss_y1_y2_L1_all(i:(i+(range-1))));
            heads_rat_y3(count) =  sum(heads_y3(i:(i+(range-1))))./sum(ss_y2_y3_L1_all(i:(i+(range-1))));
            head_to_head_y3(count) = sum(heads_y3(i:(i+(range-1))))./sum(heads_y2(i:(i+(range-1))));
            emergence_rat_y3(count) = sum(emergence_y3(i:(i+(range-1))))./sum(ss_y2_y3_L1_all(i:(i+(range-1))));
            head_per_emer(count) =  sum(heads_y1(i:(i+(range-1))))./sum(emergence_y1(i:(i+(range-1))));
            head_per_emer_y2(count) =  sum(heads_y2(i:(i+(range-1))))./sum(emergence_y2(i:(i+(range-1))));
            head_per_emer_y3(count) =  sum(heads_y3(i:(i+(range-1))))./sum(emergence_y3(i:(i+(range-1))));
        end
        
        
        heads_rat(isinf(heads_rat)==1) = NaN; %#ok<*SAGROW>
        heads_rat(isnan(heads_rat)==1) = [];
        heads_rat_y2(isinf(heads_rat_y2)==1) = NaN; %#ok<*SAGROW>
        heads_rat_y2(isnan(heads_rat_y2)==1) = [];
        heads_rat_y3(isinf(heads_rat_y3)==1) = NaN; %#ok<*SAGROW>
        heads_rat_y3(isnan(heads_rat_y3)==1) = [];
        head_to_head_y2(isinf(head_to_head_y2)==1) = NaN; %#ok<*SAGROW>
        head_to_head_y2(isnan(head_to_head_y2)==1) = [];
        head_to_head_y3(isinf(head_to_head_y3)==1) = NaN; %#ok<*SAGROW>
        head_to_head_y3(isnan(head_to_head_y3)==1) = [];
        emergence_rat(isinf(emergence_rat)==1) = NaN; %#ok<*SAGROW>
        emergence_rat(isnan(emergence_rat)==1) = [];
        emergence_rat_y2(isinf(emergence_rat_y2)==1) = NaN; %#ok<*SAGROW>
        emergence_rat_y2(isnan(emergence_rat_y2)==1) = [];
        emergence_rat_y3(isinf(emergence_rat_y3)==1) = NaN; %#ok<*SAGROW>
        emergence_rat_y3(isnan(emergence_rat_y3)==1) = [];
        head_per_emer(isinf(head_per_emer)==1) = NaN; %#ok<*SAGROW>
        head_per_emer(isnan(head_per_emer)==1) = [];
        head_per_emer_y2(isinf(head_per_emer_y2)==1) = NaN; %#ok<*SAGROW>
        head_per_emer_y2(isnan(head_per_emer_y2)==1) = [];
        head_per_emer_y3(isinf( head_per_emer_y3)==1) = NaN; %#ok<*SAGROW>
        head_per_emer_y3(isnan( head_per_emer_y3)==1) = [];
        
        if x <=15
            seed_to_head_rate(1,x) = poissfit(heads_rat);
            seed_to_head_rate(2,x) =  mean(heads_rat);
            seed_to_head_rate(3,x) = std(heads_rat);
            seed_to_head_rate(1,x+1) = poissfit(heads_rat_y2);
            seed_to_head_rate(2,x+1) =  mean(heads_rat_y2);
            seed_to_head_rate(3,x+1) =  std(heads_rat_y2);
            seed_to_head_rate(1,x+2) = poissfit(heads_rat_y3);
            seed_to_head_rate(2,x+2) =  mean(heads_rat_y3);
            seed_to_head_rate(3,x+2) = std(heads_rat_y3);
            %         head_to_head_rate(1,x) = NaN;
            %         head_to_head_rate(2,x) = NaN;
            %         head_to_head_rate(3,x) = NaN;
            %         head_to_head_rate(1,x+2) = poissfit(head_to_head_y3);
            %         head_to_head_rate(2,x+2) = mean(head_to_head_y3);
            %         head_to_head_rate(3,x+2) = std(head_to_head_y3);
            Emergence_rate(1,x) = poissfit(emergence_rat);
            Emergence_rate(2,x) =  mean(emergence_rat);
            Emergence_rate(3,x) = std(emergence_rat);
            Emergence_rate(1,x+1) = poissfit(emergence_rat_y2);
            Emergence_rate(2,x+1) =  mean(emergence_rat_y2);
            Emergence_rate(3,x+1) = std(emergence_rat_y2);
            Emergence_rate(1,x+2) = poissfit(emergence_rat_y3);
            Emergence_rate(2,x+2) =  mean(emergence_rat_y3);
            Emergence_rate(3,x+2) = std(emergence_rat_y3);
            Heads_per_Emergence(1,x) = poissfit(head_per_emer);
            Heads_per_Emergence(2,x) = mean(head_per_emer);
            Heads_per_Emergence(3,x) = std(head_per_emer);
            Heads_per_Emergence(1,x+1) = poissfit(head_per_emer_y2);
            Heads_per_Emergence(2,x+1) = mean(head_per_emer_y2);
            Heads_per_Emergence(3,x+1) = std(head_per_emer_y2);
            Heads_per_Emergence(1,x+2) = poissfit(head_per_emer_y3);
            Heads_per_Emergence(2,x+2) = mean(head_per_emer_y3);
            Heads_per_Emergence(3,x+2) = std(head_per_emer_y3);
            seeds_per_head(1,x) =  poissfit(number_seeds);
            seeds_per_head(2,x) = mean(number_seeds);
            seeds_per_head(3,x) = std(number_seeds);
            seeds_per_head(1,x+1) =  poissfit(number_seeds);
            seeds_per_head(2,x+1) = mean(number_seeds);
            seeds_per_head(3,x+1) = std(number_seeds);
            seeds_per_head(1,x+2) =  poissfit(number_seeds);
            seeds_per_head(2,x+2) = mean(number_seeds);
            seeds_per_head(3,x+2) = std(number_seeds);
            
        else
            seed_to_head_rate(1,x) = poissfit(heads_rat_y3);
            seed_to_head_rate(2,x) =  mean(heads_rat_y3);
            seed_to_head_rate(3,x) = std(heads_rat_y3);
            Emergence_rate(1,x) = poissfit(emergence_rat_y3);
            Emergence_rate(2,x) =  mean(emergence_rat_y3);
            Emergence_rate(3,x) = std(emergence_rat_y3);
            Heads_per_Emergence(1,x) = poissfit(head_per_emer_y3);
            Heads_per_Emergence(2,x) = mean(head_per_emer_y3);
            Heads_per_Emergence(3,x) = std(head_per_emer_y3);
            seeds_per_head(1,x) =  poissfit( number_seeds_y3);
            seeds_per_head(2,x) = mean( number_seeds_y3);
            seeds_per_head(3,x) = std( number_seeds_y3);
            
        end
        
    end
    Heads_per_Emergence(isnan(Heads_per_Emergence)==1) = 0;
    
    % correct OSR failure
    if x== 1
        Heads_per_Emergence(1,2) = Heads_per_Emergence(1,x);
        Heads_per_Emergence(2,2) = Heads_per_Emergence(2,x);
        Heads_per_Emergence(3,2) = Heads_per_Emergence(3,x);
    end
    
    % calculate seeds per run
    %     seeds_per_head(1,x) =  poissfit(number_seeds);
    %     seeds_per_head(2,x) = mean(number_seeds);
    %     seeds_per_head(3,x) = std(number_seeds);
    
    
    
    clear emergence_rat
    clear emergence_rat_y2
    clear emergence_rat_y3
    clear head_to_head_y2
    clear head_to_head_y3
    clear heads_y1
    clear heads_y2
    clear heads_y3
    clear seed_bank_all
    clear ss_y1_y2_L1_all
    clear ss_y2_y3_L1_all);
    
end
Based_om_runs = run_max;

clear seed_per_emergence
clear seed_per_clean
%save('seeds_per_emergence', '-regexp','^seed_per','^nr_seed_per')
save('distributions', '-regexp', '^seed_to_','^Emergence', '^start_seedbank','^Heads_per_Eme','seeds_per_head','Based_om_runs')
clear all
load('distributions.mat')