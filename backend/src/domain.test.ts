import test from "node:test"; import assert from "node:assert/strict"; import {ItemStore} from "./domain.js";
test("receipt completes exact normalized item",()=>{const s=new ItemStore();const i=s.add({userId:"u",name:"鮮 奶",quantity:1});assert.equal(s.completeByReceipt("u",["鮮奶"])[0].id,i.id);});
