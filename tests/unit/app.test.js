// tests/unit/app.test.js

const request = require('supertest');

const app = require('../../src/app');

describe('app 404 handler',()=>{
    test('access to resources that can no tbe found is denied', ()=>
        request(app).get('/NotFound').expect(404)
    );
})