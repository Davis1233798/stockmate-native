import express from "express";
import { z } from "zod";
import { ItemStore } from "./domain.js";

const app=express(); const store=new ItemStore();
app.use(express.json({limit:"1mb"}));
const user=(req: express.Request)=>req.header("x-user-id") || "local-user";
app.get("/health",(_req,res)=>res.json({ok:true}));
app.get("/v1/items",(req,res)=>res.json(store.list(user(req))));
app.post("/v1/items",(req,res)=>{const parsed=z.object({name:z.string().min(1).max(100),quantity:z.number().int().positive().default(1),storeId:z.string().optional()}).safeParse(req.body);if(!parsed.success)return res.status(400).json(parsed.error);return res.status(201).json(store.add({userId:user(req),...parsed.data}));});
app.delete("/v1/items/:id",(req,res)=>res.sendStatus(store.remove(user(req),req.params.id)?204:404));
app.post("/v1/receipts/reconcile",(req,res)=>{const p=z.object({productNames:z.array(z.string())}).safeParse(req.body);if(!p.success)return res.status(400).json(p.error);return res.json({completed:store.completeByReceipt(user(req),p.data.productNames)});});
app.post("/webhooks/:provider",(req,res)=>{console.info("webhook",req.params.provider);res.sendStatus(202);});
app.listen(Number(process.env.PORT||8080),()=>console.log(`StockMate API :${process.env.PORT||8080}`));
