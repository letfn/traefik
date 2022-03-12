package build

import (
	"github.com/defn/boot/project"
	"github.com/defn/boot/devcontainer"
)

#TraefikContext: {
	project.#Project
	devcontainer.#DevContainer
}

traefikContext: #TraefikContext & {
	codeowners: ["@jojomomojo", "@amanibhavam"]
}
