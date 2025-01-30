### Summary: Include screen shots or a video of your app highlighting its features

#### Happy Path
https://github.com/user-attachments/assets/6d798773-b3ec-45ad-bf82-da740423aae9

#### Refresh Recipes
https://github.com/user-attachments/assets/efb9775b-674f-451a-8c23-bc01bbf8047e

#### Recipes fail to load or error when loading
![Simulator Screenshot - iPhone 16 Pro - 2025-01-29 at 07 46 49](https://github.com/user-attachments/assets/1a28ea0f-f8fd-433e-8ebf-7f3ce270d568)

#### Loading state for images
![Simulator Screenshot - iPhone 16 Pro - 2025-01-29 at 07 46 00](https://github.com/user-attachments/assets/541eba2c-f6f7-4b81-810f-8ef869358132)

#### Failure state for images
![Simulator Screenshot - iPhone 16 Pro - 2025-01-29 at 07 45 44](https://github.com/user-attachments/assets/350d7798-7c5d-4e2e-b853-637ad007f0eb)


### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?

I prioritized testability and failure cases. Testability and subsequently actually testing said feature provides a baseline level of confidence that something will behave as expected when users interact with it. Also as a user, it can be incredibly annoying when something doesn't work as anticipated and there is not a means to recovery. This can detract from the overall user experience and ultimately cause users to leave. I believe it's important to provide not only a great happy path but also pay attention and implement sad and recovery paths.

### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?

~4-5 hours. My time was allocated between laying out groundwork for being able to test and build against previews without actually hitting the network, ensuring that the base features worked as intended and covering error cases.

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?

Rather than spending too much time designing the UI, I focused more on what happens when things go wrong from the user perspective and ensuring failures were recoverable. I also ensured that dependencies could be injected into the view models to enhance testability rather than opting for speed of delivery. 

In terms of design, I opted to work only with the large image which could be a problem for users on a slower connection. Some work could be done to utilize the smaller image on a poor connection to potentially enhance the experience.

Additionally, I opted not to support iOS 16 as it is lacking some SwiftUI APIs that helps simplify some views. These APIs could be replaced with alternate solutions though if this were a strict requirement.

An additional improvement would be to handle decoding failures when only one or a few of the elements don't adhere to the contract and display some recipes rather than no recipes.

### Weakest Part of the Project: What do you think is the weakest part of your project?

The weakest part of the project is probably the ui design or error logging. I do believe the underlying logic is built in a way that would easily be extended to support more specific and interesting designs though. Errors are currently communicated via print statements which are not ideal for a production application and should be replaced with a logger so more interesting analysis can be done off client when errors arise.

The caching is also somewhat rudimentary and could be more sophisticated. A current possibility is that files will be left over until they are cleaned up by the system since they are in the caches directory. A better approach would be to clear files out on a regular cadence. 

### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered

