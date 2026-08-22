package com.stockmate.app

import android.content.Intent
import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp

data class ShoppingItem(val id: Long, val name: String, val done: Boolean = false)

class MainActivity : ComponentActivity() {
    override fun onCreate(state: Bundle?) {
        super.onCreate(state)
        val shared = if (intent.action == Intent.ACTION_PROCESS_TEXT)
            intent.getCharSequenceExtra(Intent.EXTRA_PROCESS_TEXT)?.toString().orEmpty() else ""
        setContent { MaterialTheme { StockMateScreen(shared) } }
    }
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun StockMateScreen(initial: String) {
    var text by remember { mutableStateOf(initial) }
    var next by remember { mutableLongStateOf(1) }
    val list = remember { mutableStateListOf<ShoppingItem>() }
    Scaffold(topBar = { TopAppBar(title = { Text("StockMate 採買清單") }) }) { pad ->
        Column(Modifier.padding(pad).padding(16.dp)) {
            Row {
                OutlinedTextField(text, { text = it }, label = { Text("要買什麼？") }, modifier = Modifier.weight(1f))
                Button(onClick = { list.add(ShoppingItem(next++, text.trim())); text = "" }, enabled = text.isNotBlank()) { Text("加入") }
            }
            LazyColumn { items(list, key = { it.id }) { item ->
                ListItem(headlineContent = { Text(item.name) }, trailingContent = { TextButton(onClick = { list.remove(item) }) { Text("刪除") } })
            } }
        }
    }
}
