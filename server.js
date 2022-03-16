const express = require("express");
const app = express();
const { resolve } = require("path");
const stripe = require("stripe")(process.env.secret_key); // https://stripe.com/docs/keys#obtain-api-keys

app.use(express.static("."));
app.use(express.json());

// An endpoint for creating a new subscription
app.post("/subscribe", async (req, res) => {
  // Create or retrieve the Stripe Customer object associated with your user.
  let customer = await stripe.customers.create({
    email: req.body.email,
  });

  // Attach payment method to the customer
  const paymentMethod = await stripe.paymentMethods.attach(
    req.body.paymentMethodId,
    { customer: customer.id }
  );

  // Create subscription for customer
  const subscription = await stripe.subscriptions.create({
    customer: customer.id,
    items: [{ price: req.body.priceID }],
    expand: ["latest_invoice.payment_intent"],
    default_payment_method: paymentMethod.id,
  });

  // Send the client secret of payment intent to the client
  res.send({
    subscription: subscription.id,
    paymentIntent: subscription.latest_invoice.payment_intent.client_secret,
    customer: customer.id,
  });
});
