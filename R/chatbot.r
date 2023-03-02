# chatbot (rule-based)
# ordering pizza


topping <- c("Cheese", "Pepporoni", "Meat Lover", "Hawaiian", "Supreme")
crust <- c("Thin", "Thick")
size <- c("Small", "Medium", "Large")
appe <- c("Garlic Bread", "Chicken Wings")
drinks <- c("Coke", "Sprite", "Water")

order_pizza <- function() {
    print("What would you like to order?")
    print(paste(seq_along(topping), topping))
    get_topping <- as.numeric(readline())

    print("Which crust style would you like?")
    print(paste(seq_along(crust), crust))
    get_crust <- as.numeric(readline())

    print("Which size?")
    print(paste(seq_along(size), size))
    get_size <- as.numeric(readline())

    return(paste(size[get_size], crust[get_crust], topping[get_topping]))
}

order_appe <- function() {
    print("What kind of appetizer?")
    print(paste(seq_along(appe), appe))
    get_index <- as.numeric(readline())

    return(appe[get_index])
}

order_drink <- function() {
    print("What kind of drinks?")
    print(paste(seq_along(drinks), drinks))
    get_index <- as.numeric(readline())

    return(drinks[get_index])
}


# Main

order_list <- c()

print("Welcome to our pizza shop")
name <- readline("What's your name? ")
print(paste("Hi,", name))
pizza <- order_pizza()
order_list <- append(order_list, pizza)

while (TRUE) {
    print("Anything else?")
    print("1 Pizza  2 Appetizer  3 Drinks  4 Nothing else")
    get_else <- as.numeric(readline())
    if (get_else == 1) {
        get_pizza <- order_pizza()
        order_list <- append(order_list, get_pizza)
    } else if (get_else == 2) {
        get_appe <- order_appe()
        order_list <- append(order_list, get_appe)
    } else if (get_else == 3) {
        get_drink <- order_drink()
        order_list <- append(order_list, get_drink)
    } else {
        order_df <- data.frame(table(order_list))
        names(order_df) <- c("Menu", "Amount")
        print(paste(name, "orders", nrow(order_df), "items"))
        print(order_df)
        break()
    }
}
