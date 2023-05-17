# fragments

step1. make sure everything is install
step2. npm setup

- install package.json through npm init -y
- install package-lock.json through npm install
  step3. prettier setup
- npm install --save-dev --save-exact prettier
- create .prettierrc
- create .prettierignore (include file you dont want to formate)
- create .vscode folder and add settings.json(to override VSCode setting for formatting)
  step4. ESLint setup
- npm install --save-dev eslint
- npx eslint --init do ok to proceed (problems, common.js, none, no, Node, JavaScript)
- create .eslintrc.js
- update script in package.json file to add ("lint" : "eslint --config .eslintrc.js src/\*_/_.js")
  step5. Structured logging and Pino setup
- create src folder
- npm install --save pino pino-pretty pino-http
- create logger.js in src folder to login information
  step6. Express app setup
- npm install --save express cors helmet compression
- create app.js in src folder for express app
  step7. Express server setup
- npm install --save stoppable
- create server.js in src folder for our server.
- npm run lint
- node src/server.js
  step8. server startup script
- npm install --save-dev nodemon
- update script in package.json to include ( "start": "node src/server.js",
  "dev": "LOG_LEVEL=debug nodemon ./src/server.js --watch src",
  "debug": "LOG_LEVEL=debug nodemon --inspect=0.0.0.0:9229 ./src/server.js --watch src")
- npm start
- npm run dev
- npm run debug
- create launch.json in .vscode folder to setup debugger

update files in git after every step bu using -git status command to check statues for file and use -git add {filename} to add file. Finally to commit use -git commit -m "description".
