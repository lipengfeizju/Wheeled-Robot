% snake��һ��n*2�����飬��ͷ��β����snakeÿ�����������
% snakeLength��ʾ�ߵĳ���
% directNow��ʾ��ǰ��ͷ�ķ���0-3�ֱ������������
% bean����������
% mapLength��mapWidth�����ͼ�ĳ��Ϳ�
% pathΪ·����¼
% directHistΪ�����¼��0Ϊ�ϣ�1Ϊ�£�2Ϊ��3Ϊ��
% movetoΪ����ָ��С���ķ���0Ϊ��1Ϊǰ��2Ϊ��
function [map,snake,snakeLength,path,direction,moveto,index] = eatbean2(map,mapLength,mapWidth,snake,snakeLength,bean,path,direction,moveto,index)

    UP = 0; DOWN = 1; LEFT = 2; RIGHT = 3;
    X = 1; Y = 2;
    
    directNow = direction(index,1);
    sideFlag = 0;
    sideNum = 0;
    indexBegin = index;
    
    while snake(1,X)~=bean(1,X) || snake(1,Y)~=bean(1,Y)
        if sideFlag==0 || sideFlag==2    % �����û����
            % �����γԶ�������
            if sideFlag==0 && sideNum>=2    % ���sideFlag==0˵������ֱ��ת��sideNum>=2��֤���������Σ���ͷһ���ڽ����ϣ�
                if snake(1,X) == bean(1,X) && snake(1,Y) < bean(1,Y) && (directNow == RIGHT || directNow == LEFT)    % �����ͷ�ڶ������·����ҷ���������
                    eatFlag = 1;
                    for i = snake(1,Y)+1:mapWidth-1
                        if map(mapWidth+1-i,snake(1,X))==1
                            eatFlag = 0;
                        end
                    end
                    if eatFlag    % ���ǰ·��û���ߵ����嵲·
                        directNow = UP;
                    end
                end
                if snake(1,X) == bean(1,X) && snake(1,Y) > bean(1,Y) && (directNow == RIGHT || directNow == LEFT)    % �����ͷ�ڶ������Ϸ����ҷ���������
                    eatFlag = 1;
                    for i = 2:snake(1,Y)-1
                        if map(mapWidth+1-i,snake(1,X))==1
                            eatFlag = 0;
                        end
                    end
                    if eatFlag    % ���ǰ·��û���ߵ����嵲·
                        directNow = DOWN;
                    end
                end
                if snake(1,Y) == bean(1,Y) && snake(1,X) < bean(1,X) && (directNow == UP || directNow == DOWN)    % �����ͷ�ڶ������󷽣��ҷ���������
                    eatFlag = 1;
                    for i = snake(1,X)+1:mapLength-1
                        if map(mapWidth+1-snake(1,Y),i)==1
                            eatFlag = 0;
                        end
                    end
                    if eatFlag    % ���ǰ·��û���ߵ����嵲·
                        directNow = RIGHT;
                    end
                end
                if snake(1,Y) == bean(1,Y) && snake(1,X) > bean(1,X) && (directNow == UP || directNow == DOWN)    % �����ͷ�ڶ������ҷ����ҷ���������
                    eatFlag = 1;
                    for i = 2:snake(1,X)-1
                        if map(mapWidth+1-snake(1,Y),i)==1
                            eatFlag = 0;
                        end
                    end
                    if eatFlag    % ���ǰ·��û���ߵ����嵲·
                        directNow = LEFT;
                    end
                end
            end
            
            % �����ο��ߵ�����
            sideFlag = 0;
            switch directNow
                case UP    % ����
                    if snake(1,Y)==mapWidth    % ����Ѿ������ϱ߽磨��������ϵ��
                        sideFlag = 1;
                        sideNum = sideNum + 1;
                    else
                        map(mapWidth + 1 - snake(snakeLength,Y),snake(snakeLength,X)) = 0;    %������һ��
                        for i=snakeLength+1:-1:2
                            snake(i,:) = snake(i-1,:);    % ����ȫ����ǰ��һ��
                        end
                        snake(1,Y) = snake(1,Y) + 1;    % ��ͷ������һ��
                        map(mapWidth + 1 - snake(1,Y),snake(1,X)) = 1;    % ��ͼ�ϼ�¼�¸�
                        index = index + 1;
                        path(index,:) = snake(1,:);    % ��¼��ͷ�ƶ��켣
                        direction(index,1) = directNow;    % ��¼����仯
                    end
                case DOWN    % ����
                    if snake(1,Y)==1    % ����Ѿ������±߽磨��������ϵ��
                        sideFlag = 1;
                        sideNum = sideNum + 1;
                    else
                        map(mapWidth + 1 - snake(snakeLength,Y),snake(snakeLength,X)) = 0;    %������һ��
                        for i=snakeLength+1:-1:2
                            snake(i,:) = snake(i-1,:);    % ����ȫ����ǰ��һ��
                        end
                        snake(1,Y) = snake(1,Y) - 1;    % ��ͷ������һ��
                        map(mapWidth + 1 - snake(1,Y),snake(1,X)) = 1;    % ��ͼ�ϼ�¼�¸�
                        index = index + 1;
                        path(index,:) = snake(1,:);    % ��¼��ͷ�ƶ��켣
                        direction(index,1) = directNow;    % ��¼����仯
                    end
                case LEFT    % ����
                    if snake(1,X)==1    % ����Ѿ�������߽磨��������ϵ��
                        sideFlag = 1;
                        sideNum = sideNum + 1;
                    else
                        map(mapWidth + 1 - snake(snakeLength,Y),snake(snakeLength,X)) = 0;    %������һ��
                        for i=snakeLength+1:-1:2
                            snake(i,:) = snake(i-1,:);    % ����ȫ����ǰ��һ��
                        end
                        snake(1,X) = snake(1,X) - 1;    % ��ͷ������һ��
                        map(mapWidth + 1 - snake(1,Y),snake(1,X)) = 1;    % ��ͼ�ϼ�¼�¸�
                        index = index + 1;
                        path(index,:) = snake(1,:);    % ��¼��ͷ�ƶ��켣
                        direction(index,1) = directNow;    % ��¼����仯
                    end
                case RIGHT    % ����
                    if snake(1,X)==mapLength    % ����Ѿ������ұ߽磨��������ϵ��
                        sideFlag = 1;
                        sideNum = sideNum + 1;
                    else
                        map(mapWidth + 1 - snake(snakeLength,Y),snake(snakeLength,X)) = 0;    %������һ��
                        for i=snakeLength+1:-1:2
                            snake(i,:) = snake(i-1,:);    % ����ȫ����ǰ��һ��
                        end
                        snake(1,X) = snake(1,X) + 1;    % ��ͷ������һ��
                        map(mapWidth + 1 - snake(1,Y),snake(1,X)) = 1;    % ��ͼ�ϼ�¼�¸�
                        index = index + 1;
                        path(index,:) = snake(1,:);    % ��¼��ͷ�ƶ��켣
                        direction(index,1) = directNow;    % ��¼����仯
                    end
            end
        else    % if sideFlag
            % ���ײǽת�������
            switch directNow
                case UP    % ����
                    if snake(1,X)>mapLength/2 && snake(1,X)>1 && map(mapWidth+1-snake(1,Y),snake(1,X)-1)==0    % �ߴ����������ң�������߲�������
                        directNow = LEFT;    % ��Ϊ����
                    else if snake(1,X)<mapLength && map(mapWidth+1-snake(1,Y),snake(1,X)+1)==0    % ���ұ߲�������
                        directNow = RIGHT;    % ��Ϊ����
                        else
                        directNow = LEFT;
                        end
                    end
                case DOWN    % ����
                    if snake(1,X)>mapLength/2 && snake(1,X)>1 && map(mapWidth+1-snake(1,Y),snake(1,X)-1)==0    % �ߴ����������ң�������߲�������
                        directNow = LEFT;    % ��Ϊ����
                    else if snake(1,X)<mapLength && map(mapWidth+1-snake(1,Y),snake(1,X)+1)==0    % ���ұ߲�������
                        directNow = RIGHT;    % ��Ϊ����
                        else
                        directNow = LEFT;
                        end
                    end
                case LEFT    % ����
                    if snake(1,Y)>mapWidth/2 && snake(1,Y)>1 && map(mapWidth+1-snake(1,Y)+1,snake(1,X))==0    % �ߴ����������ϣ������±߲�������
                        directNow = DOWN;    % ��Ϊ����
                    else if snake(1,Y)<mapWidth && map(mapWidth+1-snake(1,Y)-1,snake(1,X))==0    % ���ϱ߲�������
                        directNow = UP;    % ��Ϊ����
                        else
                        directNow = DOWN;
                        end
                    end
                case RIGHT    % ����
                    if snake(1,Y)>mapWidth/2 && snake(1,Y)>1 && map(mapWidth+1-snake(1,Y)+1,snake(1,X))==0    % �ߴ����������ϣ������±߲�������
                        directNow = DOWN;    % ��Ϊ����
                    else if snake(1,Y)<mapWidth && map(mapWidth+1-snake(1,Y)-1,snake(1,X))==0    % ���ϱ߲�������
                        directNow = UP;    % ��Ϊ����
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
    
    % ��direction�����߷���moveto����Ϊ0����ǰΪ1�����Ϊ2
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