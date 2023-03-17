const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();
const db = admin.firestore();

exports.mpesaCallback = functions.https.onRequest(async (req, res) => {
  const callbackMetadata = req.body;
  const responseCode = callbackMetadata.Body.stkCallback.ResultCode;
  const checkoutRequestId = callbackMetadata.Body.stkCallback.CheckoutRequestID;

  if (responseCode === 0) {
    const transactionDetails =
      callbackMetadata.Body.stkCallback.CallbackMetadata.Item;
    var transactionDate, phoneNumber, amount, mpesaReceiptNumber;

    await transactionDetails.forEach((entry) => {
      switch (entry.Name) {
        case "MpesaReceiptNumber":
          mpesaReceiptNumber = entry.Value;
          break;
        case "Amount":
          amount = entry.Value;
          break;
        case "PhoneNumber":
          phoneNumber = entry.Value;
          break;
        case "TransactionDate":
          transactionDate = entry.Value;
          break;
        default:
          break;
      }
    });

    const transactionDet = {
      transactionDate: transactionDate,
      phoneNumber: phoneNumber,
      amount: amount,
      mpesaReceiptNumber: mpesaReceiptNumber,
    };

    const matchingCheckoutID = admin
      .firestore()
      .collection("mobileTransactions")
      .where("name", "==", checkoutRequestId);
    const queryResults = await matchingCheckoutID.get();

    if (!queryResults.empty) {
      const documentMatchingID = queryResults.docs[0];
      await documentMatchingID.ref.set(transactionDet, { merge: true });
    } else {
      const lostTransactionRef = db
        .collection("lost_transactions")
        .doc(checkoutRequestId);
      await lostTransactionRef.set(transactionDet);
    }

    return res.status(200).send("Callback received successfully.");
  } else {
    console.log("Failed transaction.");
  }

  res.json({ result: "Payment response received" });
});
