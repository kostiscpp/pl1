import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;
import java.util.Queue;
import java.util.LinkedList;
import java.util.ArrayList;
public class Moves {
    static class coord {
        int x, y;
        coord(int x, int y) {
            this.x = x;
            this.y = y;
        }
    }
    public static void main(String[] args) {
        try (Scanner scanner = new Scanner(new File(args[0]))) {
            if (!scanner.hasNextInt()) {
                System.out.println("Error reading file");
                return;
            }
            int N = scanner.nextInt();
            int[][] grid = new int[N][N];
            int[][] distance = new int[N][N];
            for (int i = 0; i < N; i++) {
                for (int j = 0; j < N; j++) {
                    grid[i][j] = scanner.nextInt();
                    distance[i][j] = -1;
                }
            }
            Queue <coord> q = new LinkedList<>();
            coord[] moves = {new coord(0, 1), new coord(-1, 0), new coord(1, 0), new coord(0, -1), new coord(1, 1), new coord(-1, -1), new coord(1, -1), new coord(-1, 1)};
            coord[][] prev = new coord[N][N];
            q.add(new coord(0, 0));
            distance[0][0] = 0;
            prev[0][0] = new coord(-1, -1);
            while(!q.isEmpty()) {
                coord c = q.poll();
                for (coord m : moves) {
                    int x = c.x + m.x;
                    int y = c.y + m.y;
                    if (x >= 0 && x < N && y >= 0 && y < N && grid[x][y] < grid[c.x][c.y] && distance[x][y] == -1) {
                        distance[x][y] = distance[c.x][c.y] + 1;
                        q.add(new coord(x, y));
                        prev[x][y] = c;
                    }
                }
            }
            if (distance[N-1][N-1] == -1) {
                System.out.println("IMPOSSIBLE");
            } else {
                coord c = new coord(N-1, N-1);
                ArrayList<String> path = new ArrayList<>();
                String dir = "";
                while (c.x != 0 || c.y != 0) {
                        switch (c.y - prev[c.x][c.y].y) {
                            case -1:
                                dir = "W";
                                break;
                            case 1:
                                dir = "E";
                                break;
                        }
                        switch (c.x - prev[c.x][c.y].x) {
                            case -1:
                                dir = "N" + dir;
                                break;
                            case 1:
                                dir = "S" + dir;
                                break;
                        }
                        c = prev[c.x][c.y];
                        path.add(0, dir);
                        dir = "";
                }
                System.out.println(path);
            }
        } catch (FileNotFoundException e) {
            System.out.println("Error opening file");
        }
    }
}
