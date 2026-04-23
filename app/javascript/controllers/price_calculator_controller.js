import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  // 画面上の要素（ターゲット）を定義
  static get targets() {
    return [ "price", "quantity", "unit", "result", "unitLabel" ]
  }

  // 入力があった時に実行される関数
  calculate() {
    const price = parseFloat(this.priceTarget.value) //金額入力値を取得し、計算ができるように浮動小数点に変換
    const quantity = parseFloat(this.quantityTarget.value) //分量入力値を数値に変換
    const unit = this.unitTarget.value //単位を取得


    // 単位ラベルの更新
    if (this.hasUnitLabelTarget) {
      const label = (unit === "piece") ? "1piece" : `100${unit}`
      this.unitLabelTarget.textContent = label
    }

    if (price > 0 && quantity > 0) {
      // 単位が "piece(個)" なら 1個あたり、それ以外(ml/g)なら 100あたりの単価
      const base = (unit === "piece") ? 1 : 100
      const unitPrice = (price / quantity) * base
      
      // 結果を表示（小数点第1位まで）
      this.resultTarget.textContent = `¥${unitPrice.toFixed(1)}`
    } else {
      this.resultTarget.textContent = "¥0"
    }
  }
}
