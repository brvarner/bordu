import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["projectSelect"]

    initialize () {
        this.index = 0
        this.showSelectedSlide()
    }

    showSelectedSlide() {
        this.projectSelectTargets.forEach((element, index) => {
            element.hidden = index !== this.index
        })
    }
}