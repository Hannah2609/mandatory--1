# Graph database design

- This graph database design represents a company system where users can have multiple roles, vehicles, and own items. 
- Each entity is represented as a vertex (node), and relationships are represented as edges.

## Graph Structure

- Users can have multiple phones (HasPhone)
- Users can have multiple addresses (HasAddress)
- Users can have multiple roles (HasRole)
- Users can have multiple vehicles (HasVehicle)
- Users can own multiple items (OwnsItem)
- Items can have multiple images (HasImage)



## Vertex Collections

### Users Vertex
{
    "user_pk": "user1",
    "user_name": "A",
    "user_last_name": "Aa",
    "user_email": "a@example.com",
    "user_password": "password1",
    "user_created_at": 1702483200,
    "user_deleted_at": 0,
    "user_blocked_at": 0,
    "user_updated_at": 0,
    "user_verified_at": 1702483200,
    "user_verification_key": "verification_uuid"
}

# Roles Vertex
{
    "role_pk": "role1",
    "role_name": "admin"
}

### Vehicles Vertex
{
    "vehicle_pk": "vehicle1",
    "vehicle_name": "Bicycle"
}

### Items Vertex
{
    "item_pk": "item1",
    "item_title": "Pizza",
    "item_price": 12.99,
    "item_created_at": 1702483200,
    "item_deleted_at": 0,
    "item_blocked_at": 0,
    "item_updated_at": 0
}




## Edge Collections

### HasPhone Edge
{
    "_from": "users/user1",
    "_to": "phones/phone1",
    "phone_number": "+4512345678"
}

### HasAddress Edge
{
    "_from": "users/user1",
    "_to": "addresses/addr1",
    "address_line": "Street 1, City A",
    "postal_code": "1000",
    "primary_address": false
} 

### HasRole Edge
{
    "_from": "users/user1",
    "_to": "roles/role1"
}

### HasVehicle Edge
{
    "_from": "users/user1",
    "_to": "vehicles/vehicle1"
}

### OwnsItem Edge
{
    "_from": "users/user1",
    "_to": "items/item1"
}

### HasImage Edge
{
    "_from": "items/item1",
    "_to": "images/img1",
    "image_path": "dish_1.jpg",
    "image_order": 0
}

