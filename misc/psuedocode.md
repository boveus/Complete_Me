#put psuedocode here

current.node.key["p"].key["i"].key["z"]

node objects to contain a hash that points to the next node based on the alphabet letter

current_node.key["p"].key["i"].key["z"]

create the hash as you add words to the list

instance variable called next

next is equal to a hash of up to 26 letters than point to next nodes

if the tree travels through P, I, and Z to get suggested words, we don't need to store the entire word in the final linked list of words.

For example, if we append P, I, and Z to some string as the tree travels down to select words, we can save Piz as a string and prepend it on the words.

string + za = pizza, string + e = pize, string + zeria = pizzeria

the logic for this when adding words would be something like.  If a node exists for the first letter of a word, skip it and move on to the second letter without creating a new hash pointer.  If it doesn't exist, then create a hash pointer for the first few letter combinations (IE, P I Z or D E N)  
