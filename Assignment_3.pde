
int screen = 0;
int selectedDifficulty = 0;
char targetLetter = 'a';
String message = "";
int timeLimit = 30;
int startTime = 0;
int timeLeft = 30;
int score = 0;
int finalLPM = 0;

void setup() {
  size(600, 400);
  textAlign(CENTER);
}

void draw() {
  background(30, 30, 45);

  
  if (screen == 0) {
    fill(255);
    textSize(30);
    text("TYPING SPEED TEST", 300, 80);

    textSize(18);
    text("Choose your mode", 300, 130);

    // Easy button
    fill(40, 170, 90);
    rect(100, 155, 160, 65);

    // Medium button
    fill(220, 150, 40);
    rect(340, 155, 160, 65);

    // Hard button
    fill(200, 60, 60);
    rect(100, 245, 160, 65);

    // Endless button
    fill(80, 100, 220);
    rect(340, 245, 160, 65);

    // Speed Test button
    fill(0, 150, 180);
    rect(220, 325, 160, 50);

    fill(255);
    textSize(20);
    text("EASY", 180, 195);
    text("MEDIUM", 420, 195);
    text("HARD", 180, 285);
    text("ENDLESS", 420, 285);

    textSize(18);
    text("SPEED TEST", 300, 355);

  } else if (screen == 1) {

   
    if (selectedDifficulty != 4) {
      timeLeft = timeLimit - (millis() - startTime) / 1000;

      if (timeLeft <= 0) {
        timeLeft = 0;
        message = "Time is up!";
        calculateLPM();
        screen = 2;
      }
    }

    
    if (screen == 1) {
      fill(255);
      textSize(30);
      text("TYPING CHALLENGE", 300, 45);

      textSize(20);

      if (selectedDifficulty == 1) {
        text("Difficulty: Easy", 300, 80);
      } else if (selectedDifficulty == 2) {
        text("Difficulty: Medium", 300, 80);
      } else if (selectedDifficulty == 3) {
        text("Difficulty: Hard", 300, 80);
      } else if (selectedDifficulty == 4) {
        text("Mode: Endless", 300, 80);
      } else if (selectedDifficulty == 5) {
        text("Mode: Speed Test", 300, 80);
      }

      
      if (selectedDifficulty != 4) {
        textSize(22);
        text("Time: " + timeLeft, 300, 120);
      }

      textSize(22);
      text("Score: " + score, 300, 155);

      textSize(24);
      text("Type this letter", 300, 205);

      textSize(90);
      text(targetLetter, 300, 290);

      textSize(22);
      text(message, 300, 350);
    }

  
  } else if (screen == 2) {
    fill(255, 80, 80);
    textSize(40);
    text("GAME OVER", 300, 85);

    fill(255);
    textSize(22);
    text(message, 300, 130);

    textSize(26);
    text("Final Score: " + score, 300, 185);

    
    if (selectedDifficulty == 5) {
      textSize(22);
      text("Typing speed: " + finalLPM + " LPM", 300, 225);
    }

    textSize(18);
    text("Press R to return to menu", 300, 285);
  }
}

void mousePressed() {
  
  if (screen != 0) {
    return;
  }

  
  if (mouseX >= 100 && mouseX <= 260 &&
      mouseY >= 155 && mouseY <= 220) {
    selectedDifficulty = 1;
    startGame();
    println("Easy selected");

  
  } else if (mouseX >= 340 && mouseX <= 500 &&
             mouseY >= 155 && mouseY <= 220) {
    selectedDifficulty = 2;
    startGame();
    println("Medium selected");

 
  } else if (mouseX >= 100 && mouseX <= 260 &&
             mouseY >= 245 && mouseY <= 310) {
    selectedDifficulty = 3;
    startGame();
    println("Hard selected");

  
  } else if (mouseX >= 340 && mouseX <= 500 &&
             mouseY >= 245 && mouseY <= 310) {
    selectedDifficulty = 4;
    startGame();
    println("Endless selected");

  
  } else if (mouseX >= 220 && mouseX <= 380 &&
             mouseY >= 325 && mouseY <= 375) {
    selectedDifficulty = 5;
    startGame();
    println("Speed Test selected");
  }
}

void startGame() {
  score = 0;
  timeLeft = timeLimit;
  startTime = millis();
  finalLPM = 0;
  message = "";

  chooseLetter();
  screen = 1;
}

void chooseLetter() {
  if (selectedDifficulty == 1) {
    targetLetter = char(int(random(2)) + int('a'));

  } else if (selectedDifficulty == 2) {
    targetLetter = char(int(random(4)) + int('a'));

  } else if (selectedDifficulty == 3) {
    targetLetter = char(int(random(6)) + int('a'));

  } else if (selectedDifficulty == 4 ||
             selectedDifficulty == 5) {
    targetLetter = char(int(random(26)) + int('a'));
  }
}

void calculateLPM() {
  int elapsedSeconds = (millis() - startTime) / 1000;

  if (elapsedSeconds > 0) {
    finalLPM = score * 60 / elapsedSeconds;
  } else {
    finalLPM = 0;
  }
}

void keyPressed() {
  
  if (screen == 2 && (key == 'r' || key == 'R')) {
    screen = 0;
    selectedDifficulty = 0;
    targetLetter = 'a';
    message = "";
    score = 0;
    timeLeft = timeLimit;
    finalLPM = 0;
    return;
  }

  
  if (screen != 1) {
    return;
  }

  
  if (key == targetLetter) {
    message = "Great work!";
    score++;
    chooseLetter();

  } else {
    message = "Wrong letter!";

    if (selectedDifficulty == 5) {
      calculateLPM();
    }

    screen = 2;
  }
}
