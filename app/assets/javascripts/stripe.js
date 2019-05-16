window.onload = function() {
  var stripe = new Stripe(window.stripeApiKey);

  function registerElements(elements) {
    var example = document.querySelector('.stripe');

    var form = example.querySelector('form');
    var resetButton = example.querySelector('a.reset');
    var error = form.querySelector('.error');
    var errorMessage = error.querySelector('.message');

    function enableInputs() {
      Array.prototype.forEach.call(
        form.querySelectorAll(
          "input[type='text'], input[type='email'], input[type='tel']"
        ),
        function(input) {
          input.removeAttribute('disabled');``
        }
      );
    }

    function disableInputs() {
      Array.prototype.forEach.call(
        form.querySelectorAll(
          "input[type='text'], input[type='email'], input[type='tel']"
        ),
        function(input) {
          input.setAttribute('disabled', 'true');
        }
      );
    }

    function triggerBrowserValidation() {
      // The only way to trigger HTML5 form validation UI is to fake a user submit
      // event.
      var submit = document.createElement('input');
      submit.type = 'submit';
      submit.style.display = 'none';
      form.appendChild(submit);
      submit.click();
      submit.remove();
    }

    // Listen for errors from each Element, and show error messages in the UI.
    var savedErrors = {};
    elements.forEach(function(element, idx) {
      element.on('change', function(event) {
        if (event.error) {
          error.classList.add('visible');
          savedErrors[idx] = event.error.message;
          errorMessage.innerText = event.error.message;
        } else {
          savedErrors[idx] = null;

          // Loop over the saved errors and find the first one, if any.
          var nextError = Object.keys(savedErrors)
            .sort()
            .reduce(function(maybeFoundError, key) {
              return maybeFoundError || savedErrors[key];
            }, null);

          if (nextError) {
            // Now that they've fixed the current error, show another one.
            errorMessage.innerText = nextError;
          } else {
            // The user fixed the last error; no more errors.
            error.classList.remove('visible');
          }
        }
      });
    });

    // Listen on the form's 'submit' handler...
    form.addEventListener('submit', function(e) {
      e.preventDefault();

      // Trigger HTML5 validation UI on the form if any of the inputs fail
      // validation.
      var plainInputsValid = true;
      Array.prototype.forEach.call(form.querySelectorAll('input'), function(
        input
      ) {
        if (input.checkValidity && !input.checkValidity()) {
          plainInputsValid = false;
          return;
        }
      });
      if (!plainInputsValid) {
        triggerBrowserValidation();
        return;
      }

      // Show a loading screen...
      example.classList.add('submitting');

      // Disable all inputs.
      disableInputs();

      // Use Stripe.js to create a token. We only need to pass in one Element
      // from the Element group in order to create a token. We can also pass
      // in the additional customer data we collected in our form.

      var options = {
        name: document.getElementById('stripe-name').value,
        address_line1: document.getElementById('stripe-address').value,
        address_city: document.getElementById('stripe-city').value,
        address_state: document.getElementById('stripe-state').value,
        address_zip: document.getElementById('stripe-zip').value
      };

      stripe.createToken(elements[0], options).then(function(result) {
        fetch('/projects/' + window.projectId + '/donations/stripe_charge', {
          method: 'POST',
          body: JSON.stringify({ token: result.token.id }),
          headers: {'content-type': 'application/json'},
        })
          .then(function(response) {
            example.classList.remove('submitting');
            if (response.ok) {
              example.classList.add('submitted');
              location.href = 'App://diddonate'
            } else {
              alert('Could not charge card. Please contact an administrator.')
            }
          });
      });
    });

    resetButton.addEventListener('click', function(e) {
      e.preventDefault();
      // Resetting the form (instead of setting the value to `''` for each input)
      // helps us clear webkit autofill styles.
      form.reset();

      // Clear each Element.
      elements.forEach(function(element) {
        element.clear();
      });

      // Reset error state as well.
      error.classList.remove('visible');

      // Resetting the form does not un-disable inputs, so we need to do it separately:
      enableInputs();
      example.classList.remove('submitted');
    });
  }

  var elements = stripe.elements({
    fonts: [
      {
        cssSrc: "https://rsms.me/inter/inter-ui.css"
      }
    ],
    // Stripe's examples are localized to specific languages, but if
    // you wish to have Elements automatically detect your user's locale,
    // use `locale: 'auto'` instead.
    locale: window.__exampleLocale
  });

  /**
   * Card Element
   */
  var card = elements.create("card", {
    hidePostalCode: true,
    style: {
      base: {
        color: "#32325D",
        fontWeight: 500,
        fontFamily: "Inter UI, Open Sans, Segoe UI, sans-serif",
        fontSize: "16px",
        fontSmoothing: "antialiased",

        "::placeholder": {
          color: "#CFD7DF"
        }
      },
      invalid: {
        color: "#E25950"
      }
    }
  });

  card.mount("#stripe-card");

  registerElements([card]);
};
