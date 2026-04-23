import { Controller } from "@hotwired/stimulus" //Controllerクラスを継承

export default class extends Controller { //新しいクラスの作成
  connect() { //ライフサイクルメソッド(コントローラーが初めて接続された時、自動的に一度だけ実行)
    this.element.textContent = "Hello World!" //指定してHTML要素を書き換える
  }
}
