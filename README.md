# Monster Shop Extensions - Bulk Discount


## Instructions

* Fork this repository or use your existing project.
* Clone your fork if you have forked.
* When you are finished, push your code to your fork. (if you have forked)

## Bulk Discount

#### General Goals

Merchants add bulk discount rates for all of their inventory. These apply automatically in the shopping cart, and adjust the order_items price upon checkout.

#### Completion Criteria

1. Merchants need full CRUD functionality on bulk discounts, and will be accessed a link on the merchant's dashboard.
1. You will implement a percentage based discount:
   - 5% discount on 20 or more items
1. A merchant can have multiple bulk discounts in the system.
1. When a user adds enough value or quantity of a single item to their cart, the bulk discount will automatically show up on the cart page.
1. A bulk discount from one merchant will only affect items from that merchant in the cart.
1. A bulk discount will only apply to items which exceed the minimum quantity specified in the bulk discount. (eg, a 5% off 5 items or more does not activate if a user is buying 1 quantity of 5 different items; if they raise the quantity of one item to 5, then the bulk discount is only applied to that one item, not all of the others as well)
1. When there is a conflict between two discounts, the greater of the two will be applied.

#### Mod 2 Learning Goals reflected:
- Database relationships and migrations
- Advanced ActiveRecord
- Software Testing



---

# Additional Extensions

##  Users have multiple addresses

#### General Goal

Users will have more than one address associated with their profile. Each address will have a nickname like "home" or "work". Users will choose an address when checking out.

#### Completion Criteria

1. When a user registers they will still provide an address, this will become their first address entry in the database and nicknamed "home".
1. Users need full CRUD ability for addresses from their Profile page.
1. An address cannot be deleted or changed if it's been used in a "shipped" order.
1. When a user checks out on the cart show page, they will have the ability to choose one of their addresses where they'd like the order shipped.
1. If a user deletes all of their addresses, they cannot check out and see an error telling them they need to add an address first. This should link to a page where they add an address.
1. If an order is still pending, the user can change to which address they want their items shipped.

#### Implementation Guidelines

1. Existing tests should still pass. Since you will need to make major changes to your database schema, you will probably break **many** tests. It's recommended that you focus on the completion criteria described above before going back and refactoring your code so that your existing tests still work.
1. Every order show page should display the chosen shipping address.
1. Statistics related to city/state should still work as before.

---

## Merchant To-Do List

#### General Goals

Merchant dashboards will display a to-do list of tasks that need their attention.

#### Completion Criteria

1. Merchants should be shown a list of items which are using a placeholder image and encouraged to find an appropriate image instead; each item is a link to that item's edit form.
1. Merchants should see a statistic about unfulfilled items and the revenue impact. eg, "You have 5 unfulfilled orders worth $752.86"
1. Next to each order on their dashboard, Merchants should see a warning if an item quantity on that order exceeds their current inventory count.
1. If several orders exist for an item, and their summed quantity exceeds the Merchant's inventory for that item, a warning message is shown.

#### Implementation Guidelines

1. Make sure you are testing for all happy path and sad path scenarios.

#### Mod 2 Learning Goals reflected:

- MVC and Rails development
- Database relationships and migrations
- ActiveRecord
- Software Testing

# Rubric

| | **Feature Completeness**                                                                                                   | **Rails** | **ActiveRecord** | **Testing and Debugging**                                                                                                                                                                                               |
| --- | ---------------------------------------------------------------------------------------------------------------------------| --- | --- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **4: Exceptional**  | One or more additional extension features complete.                                                                        | Students implement strategies not discussed in class to effectively organize code and adhere to MVC. | Highly effective and efficient use of ActiveRecord beyond what we've taught in class. Even `.each` calls will not cause additional database lookups. | Very clear Test Driven Development. Test files are extremely well organized and nested. Students utilize `before :each` blocks. 100% coverage for features and models                                                   |
| **3: Passing** | Bulk discount feature 100% complete, including most sad paths and edge cases                                               | Students use the principles of MVC to effectively organize code. Students can defend any of their design decisions. | ActiveRecord is used in a clear and effective way to read/write data using no Ruby to process data. | 100% coverage for models. 98% coverage for features. Tests are well written and meaningful. All preexisting tests still pass. TDD Process is clear throughout commits. Sad paths and edge cases are covered in testing. |
| **2: Passing with Concerns** | One of the completion criteria for Coupon Codes feature is not complete or fails to handle a big sad path or edge case     | Students utilize MVC to organize code, but cannot defend some of their design decisions. Or some functionality is not limited to the appropriately authorized users. | Ruby is used to process data that could use ActiveRecord instead. | Feature test coverage between 90% and 98%, or model test coverage below 100%, or tests are not meaningfully written or have an unclear objective. Missing sad path or edge case testing.                                |
| **1: Failing** | More than one of the completion criteria for Coupon Code feature is not complete or fails to handle a sad path or edge case| Students do not effectively organize code using MVC. Or students do not authorize users. | Ruby is used to process data more often than ActiveRecord | Below 90% coverage for either features or models. TDD was not used.                                                                                                                                                     | 


# Monster Shop - Turing Back End Engineering, Module 2, Group Project
#### Heroku Link
https://monster-shop-dreamteam.herokuapp.com/

#### Contributors
[Jordan Williams](https://github.com/iEv0lv3)

[David Atkins](https://github.com/d-atkins)

[Kathleen Carroll](https://github.com/kathleen-carroll)

[Raymond Nguyen](https://github.com/itemniner)

### Overview:
Monster Shop is fictitious  e-commerce website where users are able to browse items from various shops, add them to their cart, and make orders.

Monster Shop is made up of merchants and items. Merchants have many items, and items belong to merchants. Items can be ordered and reviewed by users. CRUD functionality for merchants, items, and orders is determined by user role: visitor, regular user, merchant employee, and administrator.

Monster Shop is built in Rails and uses ActiveRecord to store and query data.

### Schema Design
![schema](https://i.imgur.com/srezwoS.png)

### Getting Started
1. Fork this repository
2. Clone down your forked repository
3. From your repository's root directory, run:
`bundle install`
4. Set up the database
`rake db:{drop,create,migrate,seed}`

### Merchants
![merchant index](https://i.imgur.com/oqeYGrW.png)
![merchant show](https://i.imgur.com/d6o4TeS.png)
Merchants are stores that carry items.
- index shows all merchants
- show page shows information for a single merchant
- can be activated/deactivated by administrator

### Items
![item index](https://i.imgur.com/XCwIUx1.png)
![item show](https://i.imgur.com/gI0oCxe.png)
Items belong to merchants, and can be added to the cart.
- items can be deactivated by merchant employees and admins
  - deactivated items will not show up in the items index
- items have inventory which limit how many a user can add to the cart
- users can leave reviews for items
  ```
  <section class = "review-stats">
    <%if @item.reviews.empty? %>
      <h3>This item has not yet been reviewed.</h3>
    <% else %>
      <section class = "top-three-reviews">
        <h2>Top 3 Reviews</h2>
        <% @item.sorted_reviews(3, :desc).each do |review| %>
          <h3><%= "#{review.rating}-#{review.title}" %></h3>
        <% end %>
      </section>
      <section class = "bottom-three-reviews">
        <h2>Bottom 3 Reviews</h2>
        <% @item.sorted_reviews(3, :asc).each do |review| %>
          <h3><%= "#{review.rating}-#{review.title}" %></h3>
        <% end %>
      </section>
    </section>
  ```
- top/bottom 5 popular items are displayed in items index using the following AR query:
  ```
  def self.popular(limit, order)
      left_outer_joins(:item_orders)
        .group(:id)
        .order("COALESCE(SUM(quantity), 0) #{order}, items.id")
        .limit(limit)
    end
  ```

### Users
Visitor - this type of user is anonymously browsing our site and is not logged in. Permissions for visitors:
  - access to merchants and items with ability to add items to cart.  Visitor must log in to checkout.
  - can not access any pages outside of merchant and item shopping sites
  - no profile information

Regular User - this user is registered and logged in to the application while performing their work; can place items in a cart and create an order. Permissions for regular user:
  - same access as visitor
  - can edit profile information, can update password information, can place orders and cancel orders
  ```
  def update
    @user = current_user
    if @user.update(user_params) && @user.pw_check_not_empty(params)
      flash[:success] = 'Password updated'
      redirect_to '/profile'
    elsif @user.pw_check_empty(params)
      flash[:error] = "Password can't be blank"
      redirect_to '/profile/edit/pw'
    else
      flash[:error] = @user.errors.full_messages.to_sentence
      redirect_to '/profile/edit/pw'
    end
  end
  ```

Merchant Employee - this user works for a merchant. They can fulfill orders on behalf of their merchant. They also have the same permissions as a regular user (adding items to a cart and checking out). Permissions for merchant employees:
  - Merchants can fulfill orders
    - pending orders are shown on the merchant dashboard:
    ```
     <% @merchant.pending_orders.each do |order| %>
      <tr id="item-<%= order.id %>">
        <td><p>Order#<%= link_to order.id, "#{path}#{order.id}" %> </p></td>
        <td><p><%= order.created_at.to_formatted_s(:long) %></p></td>
        <td><p><%= order.item_orders.by_merchant(@merchant.id).item_count %></p></td>
        <td><p><%= number_to_currency(order.item_orders.by_merchant(@merchant.id).total) %></p></td>
      </tr>
    <% end %>
    <%= "No orders have been placed." if @merchant.pending_orders.nil? %>
    ```
  - Add, edit, delete, and update items
  - Update merchant store information
  - Place orders

Admin User - a registered user who has "superuser" access to all areas of the application; user is logged in to perform their work
  - Access to all merchants and ability to disable or enable
  - Access user information
  - Cannot place orders
  - See all orders, ship and cancel orders

  ![admin control](https://slack-imgs.com/?c=1&o1=ro&url=https%3A%2F%2Fmedia.giphy.com%2Fmedia%2FQuCiMbc7FWAy2bxWUO%2Fgiphy.gif)


### Orders
Orders can be made by regular users and merchant users when items are added to the cart.
Visitors can add items to the cart but must log in to make an order.

Orders have four possible statuses:
- pending: default status
- packaged: all merchants have fulfilled all items on the order
- shipped: admin has approved shipping of order
- canceled: user cancels a pending or packaged order

Orders are made up of item orders
- an item order is a single item and its quantity in an order
- class methods for item orders:
  ```
  def self.by_merchant(id)
      self
        .all
        .joins(:item)
        .where("items.merchant_id = #{id}")
    end
    def self.total
      sum("item_orders.quantity * item_orders.price")
    end
    def self.item_count
      sum(:quantity)
    end
  ```
