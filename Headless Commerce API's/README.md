# Headless Commerce API's

This folder is associated with the following video where I go through the full life cycle of a cart to order using the Salesforce B2B & B2C2C (DTC) Commerce Cloud API's. 
If you want the full list of available API, you can go [here](https://developer.salesforce.com/docs/atlas.en-us.chatterapi.meta/chatterapi/connect_resources_commerce.htm).

[Video Link](https://youtu.be/fqJ0FyMTs04)

## How to start?

Before you get going on the following API you'll want to setup the basics of your postman instance which will allow you to authenticate with the community user you plan to use. Once you have that you can use the following steps below to begin making API calls in the sequence mentioned. 

## Cart to Order API Flow
![Cart to Order Lifecycle Diagram](https://github.com/shane-saltbox/Salesforce-Mojo/blob/main/Headless%20Commerce%20API's/Commerce-API.jpeg)

1. Create Cart https://developer.salesforce.com/docs/atlas.en-us.chatterapi.meta/chatterapi/connect_resources_commerce_webstore_carts.htm
2. Create Cart Items https://developer.salesforce.com/docs/atlas.en-us.chatterapi.meta/chatterapi/connect_resources_commerce_webstore_cart_items.htm
3. Start Store Checkout https://developer.salesforce.com/docs/atlas.en-us.chatterapi.meta/chatterapi/connect_resources_commerce_webstore_checkouts_start_checkout.htm
4. Check Checkout Status https://developer.salesforce.com/docs/atlas.en-us.chatterapi.meta/chatterapi/connect_resources_commerce_webstore_checkouts.htm
5. Update Checkout Details https://developer.salesforce.com/docs/atlas.en-us.chatterapi.meta/chatterapi/connect_resources_commerce_webstore_checkouts.htm
5. Tokenize CC Payment https://developer.salesforce.com/docs/atlas.en-us.chatterapi.meta/chatterapi/connect_resources_commerce_webstore_token.htm
6. Authorize Payment https://developer.salesforce.com/docs/atlas.en-us.chatterapi.meta/chatterapi/connect_resources_commerce_webstore_checkouts_payments.htm
7. Place Order https://developer.salesforce.com/docs/atlas.en-us.chatterapi.meta/chatterapi/connect_resources_commerce_webstore_checkouts_place_order.htm