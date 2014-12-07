var express = require('express');
var path = require('path');
var fs = require('fs');
var app = express();

global.appRoot = path.resolve(__dirname);

app.get('/meals', function(req, res) {
  res.type('application/json');
  var obj = JSON.parse(fs.readFileSync(appRoot + '/resources/json data/meals.json', 'utf8'));
  res.json(obj);
});

app.get('/restauraunts', function(req, res) {
	res.type('application/json');
	var obj = JSON.parse(fs.readFileSync(approot + '/resources/json data/restauraunts.json', 'utf8'));
	res.json(obj);
});

app.get('/restaurauntmealtimes', function(req, res) {
	res.type('application/json');
	var obj = JSON.parse(fs.readFileSync(appRoot + '/resources/json data/restaurauntmealtimes.json', 'utf8'));
	res.json(obj);
});

app.get('/kitchens', function(req, res) {
	res.type('application/json');
	var obj = JSON.parse(fs.readFileSync(appRoot + '/resources/json data/kitchens.json'));
	res.json(obj);
});

app.listen(3000);