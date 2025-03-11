import express, { Request, Response } from 'express';

const app = express();

app.get('/', (req: Request, res: Response) => {
  res.send('Hello World');
});

app.get('/test', (req: Request, res: Response) =>{
  res.json({message: "Test Json"}).status(200);
})

app.listen(3000, () => {
  console.log('Server is running on http://localhost:3000');
});
