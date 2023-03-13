const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

const firestore = admin.firestore();

exports.mpesaCallback = functions.https.onRequest(async (req, res) => {
  const transactionDetailss = req.body.Body.stkCallback;
  console.log("Received payload data", transactionDetailss);
  const responseCode = transactionDetailss.ResultCode;
  const checkOutRequestID = transactionDetailss.CheckoutRequestID;

  if (responseCode === 0) {
    const transactionDetails = transactionDetailss.CallbackMetadata.Item;
    console.log("Payment details: ", transactionDetails);

    var transCode;
    var phonePaidFrom;
    var amount;
    var transactionDate;

    await transactionDetails.forEach((entry) => {
      switch (entry.Name) {
        case "MpesaReceiptNumber":
          transCode = entry.Value;
          break;
        case "PhoneNumber":
          phonePaidFrom = entry.Value;
          break;
        case "Amount":
          amount = entry.Value;
          break;
        case "TransactionDate":
          transactionDate = entry.Value;
          break;
        default:
          break;
      }
    });
     
    const entryDetails = {
        
    }

    // Save payment details to Firestore
    await firestore.collection("payments").doc(checkOutRequestID).set({
      transCode,
      phonePaidFrom,
      amount,
      transactionDate,
    });

    console.log(
      `Payment details saved for checkoutRequestID: ${checkOutRequestID}`
    );
  }

  res.status(200).send("OK");
});
