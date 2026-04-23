import { Application } from "@hotwired/stimulus"

const application = Application.start() //Stimulusアプリを起動

// Configure Stimulus development experience(開発時の体験を調整する設定)
application.debug = false // デバッグモードを無効化
window.Stimulus   = application //起動したStimulusをブラウザのどこからでも触れるようにする

export { application }
