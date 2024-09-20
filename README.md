# golang-joke-cli

This repository is to learn how to use tview

## depenedency install

```shell=
go get github.com/rivo/tview@master
```

## setup main function
```go
package main

import (
	"log"

	"github.com/rivo/tview"
)

var (
	app *tview.Application
  textView *tview.TextView
)
func getAndDrawJoke() {
  // fetch chuck norris joke from the web
  // update our ui with the joke
  textView.Clear()
}
func main() {
	app = tview.NewApplication()
	textView = tview.NewTextView().SetDynamicColors(true).SetWrap(true).
		SetWordWrap(true).
		SetTextAlign(tview.AlignCenter).
		SetText("Hello world from Tview")

	if err := app.SetRoot(textView, true).Run(); err != nil {
		log.Fatal(err)
	}
}
```

## 新增 取得笑話邏輯
```golang
func getAndDrawJoke() {
	// fetch chuck norris joke from the web
	result, err := http.Get("https://api.chucknorris.io/jokes/random?category=science")
	if err != nil {
		log.Fatal(err)
	}
	payloadBytes, err := io.ReadAll(result.Body)
	if err != nil {
		log.Fatal(err)
	}
	payload := &Payload{}
	err = json.Unmarshal(payloadBytes, payload)
	if err != nil {
		log.Fatal(err)
	}
	defer result.Body.Close()
	// update our ui with the joke
	textView.Clear()
	fmt.Fprint(textView, payload.Value)
	timeStr := fmt.Sprintf("\n\n[gray]%s", time.Now().Format(time.RFC1123))
	fmt.Fprintln(textView, timeStr)
}
func refreshJoke() {
	tick := time.NewTicker(time.Second * 10)
	for {
		select {
		case <-tick.C:
			getAndDrawJoke()
			app.Draw()
		}
	}

}
```
## 更新　main flow
```golang
app = tview.NewApplication()
	textView = tview.NewTextView().
		SetDynamicColors(true).
		SetWrap(true).
		SetWordWrap(true).
		SetTextAlign(tview.AlignCenter).
		SetTextColor(tcell.ColorLime)
	getAndDrawJoke()
	go refreshJoke()
	if err := app.SetRoot(textView, true).Run(); err != nil {
		log.Fatal(err)
	}
```