### Summary: Include screen shots or a video of your app highlighting its features

### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?

I prioritized testability and failure cases. Testability and subsequently actually testing said feature provides a baseline level of confidence that something will behave as expected when users interact with it. Also as a user, it can be incredibly annoying when something doesn't work as anticipated and there is not a means to recovery. This can detract from the overall user experience and ultimately cause users to leave. I believe it's important to provide not only a great happy path but also pay attention and implement sad and recovery paths.

### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?

~4-5 hours. My time was allocated between laying out groundwork for being able to test and build against previews without actually hitting the network, ensuring that the base features worked as intended and covering some error cases.

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?

Rather than spending too much time designing the UI, I focused more on what happens when things go wrong from the user perspective and ensuring failures were recoverable. I also ensured that dependencies could be injected into the view models to enhance testability rather than opting for speed of delivery. 

In terms of design, I opted to work only with the large image which could be a problem for users on a slower connection. Some work could be done to utilize the smaller image on a poor connection to potentially enhance the experience.

Additionally, I opted not to support iOS 16 as it is lacking some SwiftUI APIs that helps simplify some views. These APIs could be replaced with alternate solutions though if this were a strict requirement.

### Weakest Part of the Project: What do you think is the weakest part of your project?

The weakest part of the project is probably the ui design or error logging. I do believe the underlying logic is built in a way that would easily be extended to support more specific and interesting designs. Errors are currently communicated via print statements which are not ideal for a production application and should be replaced with a logger so more interesting analysis can be done off client should errors arise.

The caching is also somewhat rudimentary and could be more sophisticated. A current possibility is that files will be left over until they are cleaned up by the system since they are in the caches directory. A better approach would be to clear files out on a regular cadence. 

### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered

