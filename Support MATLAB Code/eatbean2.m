% snake是一个n*2的数组，从头至尾储存snake每截身体的坐标
% snakeLength表示蛇的长度
% directNow表示当前蛇头的方向，0-3分别代表上下左右
% bean代表豆的坐标
% mapLength和mapWidth代表地图的长和宽
% path为路径记录
% directHist为方向记录，0为上，1为下，2为左，3为右
% moveto为最终指引小车的方向，0为左，1为前，2为右
function [map,snake,snakeLength,path,direction,moveto,index] = eatbean2(map,mapLength,mapWidth,snake,snakeLength,bean,path,direction,moveto,index)

    UP = 0; DOWN = 1; LEFT = 2; RIGHT = 3;
    X = 1; Y = 2;
    
    directNow = direction(index,1);
    sideFlag = 0;
    sideNum = 0;
    indexBegin = index;
    
    while snake(1,X)~=bean(1,X) || snake(1,Y)~=bean(1,Y)
        if sideFlag==0 || sideFlag==2    % 如果还没靠边
            % 解决如何吃豆的问题
            if sideFlag==0 && sideNum>=2    % 如果sideFlag==0说明可以直接转，sideNum>=2保证已碰边两次（蛇头一定在角落上）
                if snake(1,X) == bean(1,X) && snake(1,Y) < bean(1,Y) && (directNow == RIGHT || directNow == LEFT)    % 如果蛇头在豆的正下方，且方向不是向下
                    eatFlag = 1;
                    for i = snake(1,Y)+1:mapWidth-1
                        if map(mapWidth+1-i,snake(1,X))==1
                            eatFlag = 0;
                        end
                    end
                    if eatFlag    % 如果前路上没有蛇的身体挡路
                        directNow = UP;
                    end
                end
                if snake(1,X) == bean(1,X) && snake(1,Y) > bean(1,Y) && (directNow == RIGHT || directNow == LEFT)    % 如果蛇头在豆的正上方，且方向不是向上
                    eatFlag = 1;
                    for i = 2:snake(1,Y)-1
                        if map(mapWidth+1-i,snake(1,X))==1
                            eatFlag = 0;
                        end
                    end
                    if eatFlag    % 如果前路上没有蛇的身体挡路
                        directNow = DOWN;
                    end
                end
                if snake(1,Y) == bean(1,Y) && snake(1,X) < bean(1,X) && (directNow == UP || directNow == DOWN)    % 如果蛇头在豆的正左方，且方向不是向左
                    eatFlag = 1;
                    for i = snake(1,X)+1:mapLength-1
                        if map(mapWidth+1-snake(1,Y),i)==1
                            eatFlag = 0;
                        end
                    end
                    if eatFlag    % 如果前路上没有蛇的身体挡路
                        directNow = RIGHT;
                    end
                end
                if snake(1,Y) == bean(1,Y) && snake(1,X) > bean(1,X) && (directNow == UP || directNow == DOWN)    % 如果蛇头在豆的正右方，且方向不是向右
                    eatFlag = 1;
                    for i = 2:snake(1,X)-1
                        if map(mapWidth+1-snake(1,Y),i)==1
                            eatFlag = 0;
                        end
                    end
                    if eatFlag    % 如果前路上没有蛇的身体挡路
                        directNow = LEFT;
                    end
                end
            end
            
            % 解决如何靠边的问题
            sideFlag = 0;
            switch directNow
                case UP    % 向上
                    if snake(1,Y)==mapWidth    % 如果已经到达上边界（常规坐标系）
                        sideFlag = 1;
                        sideNum = sideNum + 1;
                    else
                        map(mapWidth + 1 - snake(snakeLength,Y),snake(snakeLength,X)) = 0;    %清空最后一格
                        for i=snakeLength+1:-1:2
                            snake(i,:) = snake(i-1,:);    % 蛇身全部向前移一格
                        end
                        snake(1,Y) = snake(1,Y) + 1;    % 蛇头向上移一格
                        map(mapWidth + 1 - snake(1,Y),snake(1,X)) = 1;    % 地图上记录新格
                        index = index + 1;
                        path(index,:) = snake(1,:);    % 记录蛇头移动轨迹
                        direction(index,1) = directNow;    % 记录方向变化
                    end
                case DOWN    % 向下
                    if snake(1,Y)==1    % 如果已经到达下边界（常规坐标系）
                        sideFlag = 1;
                        sideNum = sideNum + 1;
                    else
                        map(mapWidth + 1 - snake(snakeLength,Y),snake(snakeLength,X)) = 0;    %清空最后一格
                        for i=snakeLength+1:-1:2
                            snake(i,:) = snake(i-1,:);    % 蛇身全部向前移一格
                        end
                        snake(1,Y) = snake(1,Y) - 1;    % 蛇头向下移一格
                        map(mapWidth + 1 - snake(1,Y),snake(1,X)) = 1;    % 地图上记录新格
                        index = index + 1;
                        path(index,:) = snake(1,:);    % 记录蛇头移动轨迹
                        direction(index,1) = directNow;    % 记录方向变化
                    end
                case LEFT    % 向左
                    if snake(1,X)==1    % 如果已经到达左边界（常规坐标系）
                        sideFlag = 1;
                        sideNum = sideNum + 1;
                    else
                        map(mapWidth + 1 - snake(snakeLength,Y),snake(snakeLength,X)) = 0;    %清空最后一格
                        for i=snakeLength+1:-1:2
                            snake(i,:) = snake(i-1,:);    % 蛇身全部向前移一格
                        end
                        snake(1,X) = snake(1,X) - 1;    % 蛇头向左移一格
                        map(mapWidth + 1 - snake(1,Y),snake(1,X)) = 1;    % 地图上记录新格
                        index = index + 1;
                        path(index,:) = snake(1,:);    % 记录蛇头移动轨迹
                        direction(index,1) = directNow;    % 记录方向变化
                    end
                case RIGHT    % 向右
                    if snake(1,X)==mapLength    % 如果已经到达右边界（常规坐标系）
                        sideFlag = 1;
                        sideNum = sideNum + 1;
                    else
                        map(mapWidth + 1 - snake(snakeLength,Y),snake(snakeLength,X)) = 0;    %清空最后一格
                        for i=snakeLength+1:-1:2
                            snake(i,:) = snake(i-1,:);    % 蛇身全部向前移一格
                        end
                        snake(1,X) = snake(1,X) + 1;    % 蛇头向右移一格
                        map(mapWidth + 1 - snake(1,Y),snake(1,X)) = 1;    % 地图上记录新格
                        index = index + 1;
                        path(index,:) = snake(1,:);    % 记录蛇头移动轨迹
                        direction(index,1) = directNow;    % 记录方向变化
                    end
            end
        else    % if sideFlag
            % 解决撞墙转弯的问题
            switch directNow
                case UP    % 向上
                    if snake(1,X)>mapLength/2 && snake(1,X)>1 && map(mapWidth+1-snake(1,Y),snake(1,X)-1)==0    % 蛇处于中轴以右，且其左边不是蛇身
                        directNow = LEFT;    % 改为向左
                    else if snake(1,X)<mapLength && map(mapWidth+1-snake(1,Y),snake(1,X)+1)==0    % 蛇右边不是蛇身
                        directNow = RIGHT;    % 改为向右
                        else
                        directNow = LEFT;
                        end
                    end
                case DOWN    % 向下
                    if snake(1,X)>mapLength/2 && snake(1,X)>1 && map(mapWidth+1-snake(1,Y),snake(1,X)-1)==0    % 蛇处于中轴以右，且其左边不是蛇身
                        directNow = LEFT;    % 改为向左
                    else if snake(1,X)<mapLength && map(mapWidth+1-snake(1,Y),snake(1,X)+1)==0    % 蛇右边不是蛇身
                        directNow = RIGHT;    % 改为向右
                        else
                        directNow = LEFT;
                        end
                    end
                case LEFT    % 向左
                    if snake(1,Y)>mapWidth/2 && snake(1,Y)>1 && map(mapWidth+1-snake(1,Y)+1,snake(1,X))==0    % 蛇处于中轴以上，且其下边不是蛇身
                        directNow = DOWN;    % 改为向下
                    else if snake(1,Y)<mapWidth && map(mapWidth+1-snake(1,Y)-1,snake(1,X))==0    % 蛇上边不是蛇身
                        directNow = UP;    % 改为向上
                        else
                        directNow = DOWN;
                        end
                    end
                case RIGHT    % 向右
                    if snake(1,Y)>mapWidth/2 && snake(1,Y)>1 && map(mapWidth+1-snake(1,Y)+1,snake(1,X))==0    % 蛇处于中轴以上，且其下边不是蛇身
                        directNow = DOWN;    % 改为向下
                    else if snake(1,Y)<mapWidth && map(mapWidth+1-snake(1,Y)-1,snake(1,X))==0    % 蛇上边不是蛇身
                        directNow = UP;    % 改为向上
                        else
                        directNow = DOWN;
                        end
                    end
            end
            sideFlag = 2;
        end    % if ~sideFlag
    end    % while snake(1,:)~=bean(1,:)
    
    snakeLength = snakeLength + 1;
    map(mapWidth + 1 - snake(snakeLength,Y),snake(snakeLength,X)) = 1;
    
    % 由direction决定走法，moveto向左为0，向前为1，向后为2
    for i=indexBegin:index-1
        switch direction(i,1)
            case 0
                switch direction(i+1,1)
                    case 0
                        moveto(i,1) = 1;
                    case 2
                        moveto(i,1) = 0;
                    case 3
                        moveto(i,1) = 2;
                end
            case 1
                switch direction(i+1,1)
                    case 1
                        moveto(i,1) = 1;
                    case 2
                        moveto(i,1) = 2;
                    case 3
                        moveto(i,1) = 0;
                end
            case 2
                switch direction(i+1,1)
                    case 0
                        moveto(i,1) = 2;
                    case 1
                        moveto(i,1) = 0;
                    case 2
                        moveto(i,1) = 1;
                end
            case 3
                switch direction(i+1,1)
                    case 0
                        moveto(i,1) = 0;
                    case 1
                        moveto(i,1) = 2;
                    case 3
                        moveto(i,1) = 1;
                end
        end
    end
end