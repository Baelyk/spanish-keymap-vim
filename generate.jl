### A Pluto.jl notebook ###
# v0.19.13

using Markdown
using InteractiveUtils

# ╔═╡ cf2c37dd-8ee1-4db8-8985-7060199fa2b0
using Dates

# ╔═╡ ccc70728-dcac-11ed-151f-59634d8bf535
english = raw"1234567890-=qwertyuiop[]\asdfghjkl;'zxcvbnm,./~!@#$%^&*()_+QWERTYUIOP{}|ASDFGHJKL:\"ZXCVBNM<>?`"

# ╔═╡ 5410f4ba-3b0e-4462-a32a-a26a75cda42e
spanish = raw"1234567890'¡qwertyuiop`+çasdfghjklñ´zxcvbnm,.-ª!\"·$%&/()=?¿QWERTYUIOP^*ÇASDFGHJKLÑ¨ZXCVBNM;:_º"

# ╔═╡ 04f57aa8-ae41-480d-81dd-2e9e4793e79a
keymap = collect(zip(english, spanish))

# ╔═╡ fa3ae890-1bbe-46c1-9bbf-facd42f75f10
Dates.today()

# ╔═╡ 6fcc5988-5daa-4eb1-a245-cbab5761daa5
function create_keymap_file(keymap)
	isdiacritic(c) = c ∈ ['\'', '"']
	needsescaping(c) = c ∈ ['\\', '#', '"']
	
	keymapline(pair) = if isdiacritic(pair[1])
		keymapline(("$(pair[1])$(pair[1])", pair[2]))
	elseif needsescaping(pair[1][1])
		"\\$(pair[1])\t$(pair[2])"
	else
		"$(pair[1])\t$(pair[2])"
	end
	
	# Differences in the keys themselves
	keys = map(keymapline, 
		filter(pair -> pair[1] != pair[2], 
			keymap))
	# Accenting keys
	accenting = Iterators.flatten(map(x -> map(
		# Convert to keymap file format
		pair -> keymapline(("$(x[1])$(pair[1])", pair[2])), 
		zip(collect(x[2]), collect(x[3]))), 
		# Lower and uppercase
		Iterators.flatten(map(x -> [lowercase.(x), uppercase.(x)], 
			[('\'', "aeiou", "áéíóú"), ('"', "aeiou", "äëïöü")]
		))))
	# Alt Gr + Keys
	altgrs = map(pair -> "<A-$(pair[1])>\t$(pair[2])", 
		[collect(zip("1234567890", "|@#~½¬{}[]"))..., ('-', "\\\\")])
	
	return "\" Spanish (ES) keyboard layout emulator when using English Qwerty
\" Maintainer: George Ekman b43lyk@gmail.com
\" Last Changed: $(Dates.today())

let b:keymap_name = \"ES\"

loadkeymap
\" Key remaps
$(join(keys, "\n"))
\" Diacritics
$(join(accenting, "\n"))
\" Alt Gr keys
$(join(altgrs, "\n"))"
end

# ╔═╡ 515e84fe-2f6e-44a6-a35c-1fa48ac10e45
print(create_keymap_file(keymap))

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
Dates = "ade2ca70-3891-5945-98fb-dc099432e06a"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.8.5"
manifest_format = "2.0"
project_hash = "d7cd76e304b32b583eb96a7ac19153dc0f2d1730"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"
"""

# ╔═╡ Cell order:
# ╠═ccc70728-dcac-11ed-151f-59634d8bf535
# ╠═5410f4ba-3b0e-4462-a32a-a26a75cda42e
# ╠═04f57aa8-ae41-480d-81dd-2e9e4793e79a
# ╠═cf2c37dd-8ee1-4db8-8985-7060199fa2b0
# ╠═fa3ae890-1bbe-46c1-9bbf-facd42f75f10
# ╠═6fcc5988-5daa-4eb1-a245-cbab5761daa5
# ╠═515e84fe-2f6e-44a6-a35c-1fa48ac10e45
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
