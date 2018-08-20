    % IL EST POSSIBLE QU'IL SOIT NECESSAIRE DE
    %FAIRE UN "adtopath" POUR L'EXECUTER
    clear all;
    close all;
    clc;

    load usa.txt;

    Y = usa(:,1); 
    X = usa(:,2:14);
    
    % Preprocess data
    X = normalize(X);
    y = center(Y);
    % Run lasso
    [beta info] = lasso(X, y, 0, true, true);
    % Find best fitting model
    [bestAIC bestIdx] = min(info.AIC);
    best_s = info.s(bestIdx);
    % Plot results
    h1 = figure(1);
    plot(info.s, beta, '.-');
    xlabel('s'), ylabel('\lambda', 'Rotation', 0)
    line([best_s best_s], [-6 14], 'LineStyle', ':', 'Color', [1 0 0]);
    legend('1','2','3','4','5','6',2);
