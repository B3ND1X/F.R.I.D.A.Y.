<p align="center">
  <img src="https://raw.githubusercontent.com/B3ND1X/F.R.I.D.A.Y./refs/heads/main/favicon.ico" width="200" />
</p>

## F.R.I.D.A.Y - Functional Responsive Intelligent Digital Assistant for You ##

The F.R.I.D.A.Y. repository is an open-source project that provides a Functional Responsive Intelligent Digital Assistant for You. It is designed to serve as a personal assistant, integrating various APIs to make your linux box smarter with the power of ai, automation and voice interaction. 

Functional Responsive Intelligent Digital Assistant for You
A hybrid AI-powered assistant for Linux with privacy, speed, and real utility.

⸻

What is F.R.I.D.A.Y.?

F.R.I.D.A.Y. is a personal AI assistant for Linux built from the ground up to be privacy-first, modular, and capable of running on low-power devices like old PCs and Raspberry Pi. It’s designed to bridge the gap between cloud-based language models and real-world, local system control.

Built in just 2 weeks as a passion project, F.R.I.D.A.Y. combines voice interaction, real-time system automation, and intelligent command execution — without sacrificing your control or privacy.

⸻

Key Features
	•	Voice Commands
Natural language voice interaction using microphone input and audio feedback.
	•	Groq-powered NLP
Fast, cost-free cloud inference using Groq for language understanding and intent parsing.
	•	Windsurf AI (local)
Local code generation and execution using Windsurf, enabling system control, shell commands, and file manipulation.
	•	Modular Architecture
Decoupled cloud + local processing — cloud LLMs handle language, while local scripts handle real-time execution and device control.
	•	Google Integration
Send emails, read your calendar, and access user-specific data securely.
	•	YouTube Music & Smart Home Control
Manage media and connected devices directly through voice.
	•	Low-resource Compatible
Works on older machines — no GPU or local LLM needed. Can run on Raspberry Pi and similar devices.
	•	Privacy-First
Only language parsing touches the cloud. All execution and sensitive data handling remains local.

⸻

Why It’s Different

Unlike typical AI assistants tied to Big Tech, F.R.I.D.A.Y. gives you real ownership, customization, and offline power. It’s designed for hackers, makers, and privacy advocates who want a voice assistant that actually works — without spying on them or eating system resources.

⸻

Planned/Optional Add-ons
	•	Offline fallback mode (minimal keyword + STT)
	•	GUI configuration panel
	•	Home Assistant or MQTT integration
	•	Custom trigger phrases and wakeword engine

⸻


🛠️ Technical Overview of F.R.I.D.A.Y.

F.R.I.D.A.Y. (Functional Responsive Intelligent Digital Assistant for You) is a privacy-focused, modular AI assistant designed for Linux systems, optimized for low-resource devices. It seamlessly integrates cloud-based NLP with local execution to provide a responsive and secure user experience.

🔧 Architecture & Components
	•	Voice Interaction: Utilizes microphone input for voice commands, enabling hands-free operation.
	•	Natural Language Processing (NLP): Employs Groq AI for fast, cloud-based intent recognition, allowing natural language understanding without the need for local LLMs.
	•	Local Code Generation: Leverages Windsurf AI to generate and execute shell scripts locally, facilitating real-time system control and automation.
	•	Modular Design: Features a decoupled architecture separating cloud-based language parsing from local command execution, enhancing flexibility and maintainability.

🔐 Privacy & Efficiency
	•	Privacy-First Approach: Only the NLP component interacts with the cloud; all sensitive operations, including email and calendar access, are handled locally.
	•	Resource Optimization: Designed to run efficiently on low-power hardware such as Raspberry Pi or legacy PCs, eliminating the need for high-end servers.

🧩 Extensibility
	•	Custom Triggers: Supports user-defined triggers via scripts like windsurf_trigger.sh, allowing personalized automation workflows.
	•	Smart Device Control: Capable of managing smart home devices, integrating seamlessly with existing ecosystems.
	•	Google Account Integration: Connects to Google services for sending emails and accessing calendar events, providing user-specific information.

⸻



🚀 Installation

Follow these steps to install F.R.I.D.A.Y. on your Linux system:
1. Download Release File

Download the latest release: https://github.com/B3ND1X/F.R.I.D.A.Y./releases
and unzip the file. 

2. Ensure You Have Your Google Credentials

Before proceeding, you'll need a credentials.json file from your Google Cloud Console:

    Visit Google Cloud Console

    Create a new project (or select an existing one)

    Enable Gmail API and Google Calendar API

    Create OAuth 2.0 Client ID for "Desktop App"

    Download the JSON and rename it to credentials.json

    Place it in the root directory of this project

3. Run the Installer Script

Run the following command as root (using sudo) to install all required dependencies:
sudo chmod +x install.sh 

sudo ./install.sh


This script will:

    Check for system requirements

    Install Node.js, npm, and system tools

    Install required npm packages (e.g., Express, Axios, Google APIs)

    Prompt for your API keys (Groq, Weather, News, TMDB, Spotify)

    Set up permissions and configuration

4. Launch the Assistant

After installation, you can start the assistant with:

./start.sh start| stop | debug


or 

 ./run.sh

*as non sudo user**

Then visit http://localhost:3000 in your browser to begin using F.R.I.D.A.Y.

*For best results use chrome, other browsers like brave or firefox seem to either block the mic or STT* 

### 🗣️🎙️ **VOICE COMMANDS:** ###
## All voice commands require a wake word to trigger. The assistant starts listening when you say "Hey Friday." ##
---

# Voice Assistant Commands

This document lists all available voice commands for the personal assistant system.

## 🔊 Volume Control
| Command | Description |
|---------|-------------|
| "Set/Turn/Adjust/Put/Change volume to [0-100]" | Set volume to specific level |
| "Volume at/to [0-100]" | Set volume to specific level |
| "Mute" / "Shut up" / "Silence it" / "Kill the sound" / "Turn off sound" | Mute sound |
| "Unmute" / "Sound on" / "Turn on sound" / "Restore sound" | Unmute sound |
| "Increase/Raise volume" / "Turn up" / "Volume up" | Increase volume |
| "Make it louder" / "Crank it up" / "Boost" | Increase volume |
| "Increase/Raise volume by [number]" | Increase by specific amount |
| "Decrease/Lower volume" / "Turn down" / "Volume down" | Decrease volume |
| "Make it quieter" / "Drop the sound" | Decrease volume |
| "Decrease/Lower volume by [number]" | Decrease by specific amount |
| "Maximum/Max volume" / "Full volume" / "Turn all the way up" | Set volume to maximum |
| "Minimum/Min volume" / "Zero volume" / "Turn all the way down" / "Mute all" | Set volume to minimum |

## 💡 Light Control
| Command | Description |
|---------|-------------|
| "Turn on/off [room] lights" / "Switch on/off [room] lights" | Control room lighting |
| "[Room] lights on/off" | Control room lighting |
| "Dim [room] lights to [0-100]" / "Lower the [room] lights" | Reduce brightness |
| "Make [room] darker" | Reduce brightness |
| "Undim [room] lights" / "Brighten [room] lights" | Increase brightness |
| "Increase brightness in [room]" / "Make [room] brighter" | Increase brightness |
| "Set [room] lights to warm/cool" / "Make [room] warm/cool" | Adjust light temperature |
| "Warm white" / "Cool white" | Set light temperature |
| "Change/Set light color to [color]" | Change light color |
| "Set [room] lights to [color]" | Change specific room light color |
| "Set brightness to [0-100]%" | Adjust brightness level |

## 🌙 Mood Setting
| Command | Description |
|---------|-------------|
| "Set the mood" / "Sex mode" | Activate romantic lighting and music |
| "Make it romantic" / "Turn on romance mode" | Set romantic ambiance |
| "Romantic mode" / "Get things ready" | Prepare romantic setting |
| "Time to get freaky" | Activate intimate mode |
| "Dim the lights and play something sexy" | Set mood lighting with music |
| "Turn on the vibe" / "Start the mood lighting" | Activate mood lighting |

## 🎵 Music Control
| Command | Description |
|---------|-------------|
| "Play [song/artist]" / "Start playing [song/artist]" | Play specific music |
| "Begin music [song/artist]" / "Play music [song/artist]" | Play specific music |
| "Start song [song/artist]" / "Begin song [song/artist]" | Play specific music |
| "Turn on music [song/artist]" | Play specific music |
| "Play the song/track [song/artist]" | Play specific music |
| "Pause" / "Pause music" / "Stop playing" / "Halt music" | Pause music playback |
| "Pause the song/track" / "Stop the music" / "Hold the song" | Pause music playback |
| "Skip" / "Next" / "Next track" / "Next song" | Play next song |
| "Skip track/song" / "Go to the next song/track" | Play next song |
| "Stop" / "Stop music" / "Stop playback" / "End music" | Stop music entirely |
| "Stop the song/track" / "Halt the music" | Stop music entirely |
| "Resume" / "Resume music" / "Continue playing/music" | Resume paused music |
| "Unpause" / "Unpause music" / "Resume the song" | Resume paused music |
| "Continue the track" / "Unpause the song/track" | Resume paused music |

## ⏰ Timers & Reminders
| Command | Description |
|---------|-------------|
| "Set/Start/Begin a timer for [time]" | Create a countdown timer |
| "Set timer for [time]" / "Start timer for [time]" | Create a countdown timer |
| "Begin timer for [time]" / "Set a countdown for [time]" | Create a countdown timer |
| "Set/Start/Begin an alarm for [time]" | Set an alarm |
| "Set alarm for [time]" / "Wake me up at [time]" | Set an alarm |
| "Remind me in [number] [seconds/minutes/hours] to [task]" | Create a timed reminder |
| "Remind me at [time] [am/pm] to [task]" | Create a time-specific reminder |
| "Remind me to [task]" / "Set/Make me a reminder to [task]" | Create a general reminder |
| "What are my reminders" / "Do I have any reminders" | List active reminders |
| "Show/List my reminders" / "What reminders do I have" | List active reminders |
| "Check my reminders" / "Tell me my reminders" | List active reminders |
| "Delete/Clear/Remove my reminders" / "Cancel all reminders" | Remove all reminders |
| "Delete all reminders" / "Wipe all reminders" | Remove all reminders |

## 📝 Notes
| Command | Description |
|---------|-------------|
| "Make/Create/Take a note [content]" | Create a new note |
| "Write down/Write a note [content]" | Create a new note |
| "Add a note [content]" | Create a new note |
| "What are my notes" / "Read me my notes" | Display saved notes |
| "Show me my notes" / "List my notes" | Display saved notes |  
| "Tell me my notes" / "Give me my notes" | Display saved notes |
| "Clear/Delete/Remove/Erase notes" | Delete all notes |
| "Wipe all my notes" | Delete all notes |

## 🌦️ Weather Information
| Command | Description |
|---------|-------------|
| "Weather" / "Temp" / "Temperature" | Current weather conditions |
| "What's the weather" / "How's the weather" | Current weather conditions |
| "Tell me the weather" / "Current temperature" | Current weather conditions |
| "Current weather" | Current weather conditions |
| "Forecast" / "Weather forecast" | Weather forecast |
| "Tomorrow's weather" / "Weather for tomorrow" | Weather forecast |
| "What's the forecast" / "What's the weather like tomorrow" | Weather forecast |
| "Tell me the forecast" | Weather forecast |

## 🔍 Web & Information
| Command | Description |
|---------|-------------|
| "Search [query]" / "Look up [query]" | Search the web |
| "Find [query]" / "Look for [query]" | Search the web |
| "Google [query]" / "Search for [query]" | Search the web |
| "Searching [query]" / "Find information about [query]" | Search the web |
| "News" / "Headlines" / "Latest news" | Get latest news |
| "What's happening" / "What's the news" | Get latest news |
| "Give/Show/Tell me the news" | Get latest news |
| "Current events" | Get latest news |
| "What's my IP" / "What is my IP" / "IP address" | Display IP address |
| "Time" | Show current time |
| "New movies" / "Latest movies" / "Recent movies" / "Top movies" | Show movie information |
| "Score" / "Game" / "Match" / "Team" / "Sports" | Get sports information |
| "NBA" / "NFL" / "MLB" / "NHL" / "Premier League" | Get sports league information |
| "Football" / "Basketball" / "Baseball" / "Hockey" | Get specific sport information |

## 💻 System Operations
| Command | Description |
|---------|-------------|
| "Update system" / "System update" / "Run update" | System updates |
| "Check for updates" / "Install updates" / "Fetch updates" | System updates |
| "Get updates" / "Update everything" / "Refresh packages" | System updates |
| "Look for updates" | System updates |
| "Upgrade system" / "Run upgrade" / "Full upgrade" | System upgrades |
| "Upgrade packages" / "Install upgrades" / "Perform upgrade" | System upgrades |
| "Do upgrade" / "System full upgrade" / "Upgrade everything" | System upgrades |
| "Dist upgrade" / "Distribution upgrade" / "Upgrade distribution" | Distribution upgrade |
| "Advanced upgrade" | Distribution upgrade |
| "Autoremove" / "Remove unused packages" | Clean unused packages |
| "Clean/Delete unused packages" / "Get rid of unused packages" | Clean unused packages |
| "Remove extra packages" / "Free up space" | Clean unused packages |
| "Clean packages" / "Apt clean" / "Package cache clean" | Clean package cache |
| "Clear package/cache" / "Clean apt" / "Clean package manager" | Clean package cache |
| "Remove cached packages" | Clean package cache |
| "Take/Capture a screenshot" / "Screenshot" | Capture screen |
| "Shutdown" / "Shut down" / "Power off" / "Turn off" | Power off system |
| "Reboot" / "Restart" / "Reboot system" / "Restart system" | Restart system |
| "Lock screen" / "Go to sleep" / "Lock the screen" / "Sleep mode" | Lock the system |
| "Switch to dark mode" / "Enable dark mode" / "Toggle dark mode" | Activate dark mode |
| "Turn on dark mode" / "Go dark" / "Dark mode on" | Activate dark mode |
| "Activate dark mode" | Activate dark mode |
| "Switch to light mode" / "Enable light mode" / "Toggle light mode" | Activate light mode |
| "Turn on light mode" / "Go light" / "Light mode on" | Activate light mode |
| "Activate light mode" | Activate light mode |

## 🔕 Do Not Disturb
| Command | Description |
|---------|-------------|
| "Do not disturb" / "DND" / "Silent mode" | Toggle DND mode |
| "Focus mode" / "Away mode" / "Mute notifications" | Toggle DND mode |
| "Disable notifications" / "Turn off notifications" | Disable notifications |
| "Turn on focus" / "Enable focus mode" | Enable focus mode |
| "Do not disturb on" / "Enable do not disturb" | Enable DND |
| "DND on" / "Turn on DND" / "Activate DND" | Enable DND |
| "Silent mode on" / "Enable silent mode" | Enable silent mode |
| "Focus mode on" / "Turn on focus mode" | Enable focus mode |
| "Away mode on" / "Enable away mode" | Enable away mode |
| "Start DND" / "Start focus" | Start DND/focus mode |
| "Do not disturb off" / "Disable do not disturb" | Disable DND |
| "DND off" / "Turn off DND" / "Deactivate DND" | Disable DND |
| "Silent mode off" / "Disable silent mode" | Disable silent mode |
| "Focus mode off" / "Turn off focus mode" | Disable focus mode |
| "Away mode off" / "Disable away mode" | Disable away mode |
| "Stop DND" / "Stop focus" | Stop DND/focus mode |

## 📂 File Operations
| Command | Description |
|---------|-------------|
| "Create a file [name]" / "Create file [name]" | Create a new file |
| "Create a dir [name]" / "Create dir [name]" | Create a new directory |
| "Delete a file [name]" / "Delete file [name]" | Remove a file |
| "Delete a dir [name]" / "Delete dir [name]" | Remove a directory |
| "Find a file [name]" / "Find file [name]" | Locate files |
| "Copy a file [source] to [destination]" | Copy files |
| "Copy file [source] to [destination]" | Copy files |
| "Open a file [path]" / "Open file [path]" | Open a file |
| "Open a dir [path]" / "Open dir [path]" | Open a directory |

## 📱 Applications & Services
| Command | Description |
|---------|-------------|
| "Launch [app name]" / "Open [app name]" | Start applications |
| "Cascade [prompt]" / "Windsurf [prompt]" | Use AI services |
| "Let's have a chat" / "Start chat mode" | Engage conversation mode |
| "Stop chat mode" / "Goodbye" | End conversation mode |
| "Send an email" / "Compose an email" | Email management |

## 📅 Calendar
| Command | Description |
|---------|-------------|
| "Add event [details]" / "Create event [details]" | Create calendar events |
| "Calendar event [details]" / "Schedule event [details]" | Create calendar events |
| "Make an event [details]" / "New event [details]" | Create calendar events |
| "List events" / "Show my calendar" | View scheduled events |
| "What's on my calendar" / "What events do I have" | View scheduled events |
| "Calendar events" / "Show me events" | View scheduled events |
| "Delete event [details]" / "Remove event [details]" | Remove calendar events |
| "Cancel event [details]" | Remove calendar events |
| "Remove calendar event [details]" / "Delete calendar event [details]" | Remove calendar events |

## 📧 Email
| Command | Description |
|---------|-------------|
| "Send/Compose an email" | Send an email by voice |

## 📊 System Information & Reports
| Command | Description |
|---------|-------------|
| "Report" / "Give me a report" | Get system status |
| "Daily report" / "Status update" | Daily summary information |
| "What's my report" / "How's my day" | Daily summary information |
| "Day summary" / "What's going on today" | Daily summary information |
| "Today's overview" / "Today's report" | Daily summary information |
| "Show me my day" / "How does my day look" | Daily summary information |
| "Good morning/afternoon/evening" | Time-based status report |
| "What's planned today" / "Schedule overview" | View daily schedule |
| "Give me my schedule" / "What's up today" | View daily schedule |

---

*For best results, speak clearly and use the command phrases as shown above.*

### 🤖 **Fallback AI (Groq Integration)**
If a command doesn’t match any of the above, it will be passed to your Groq-based assistant for a smart response or conversation.
---

✅ **All spoken and text responses are auto-handled!**  
NLP integrated so you can just talk to it naturally.


**PLEASE NOTE FOR ALL SYSTEM RELATED COMMANDS REQUIRE A BACKEND SERVER RUNNING LOCALLY**
This would mean stuff like changing volume, rebooting, etc. Anything that needs access to your device or system would need to have a node server backend running local!!


### 🔐 **Privacy and Data**

⸻

Privacy Disclosure

This project includes voice interaction features using the Web Speech API, which enables speech recognition and speech synthesis in supported browsers.

Features Used
	•	Speech Synthesis (TTS): Converts text into spoken voice output using your device’s built-in speech engine.
	•	Speech Recognition (STT): Converts spoken input into text for interaction.

Data Handling and Privacy
	•	No voice data is collected, stored, or transmitted by this application.
	•	Microphone access is only initiated with your explicit permission via your browser.
	•	Speech Synthesis is processed locally on your device using system-provided voices.
	•	Speech Recognition may be processed either locally or by third-party servers, depending on your browser:
	•	In Safari, STT may use Apple servers.
	•	In Chrome, STT typically uses Google’s cloud services.
	•	Some browsers (e.g., WebKitGTK) may support fully local recognition.

Please refer to your browser’s privacy policy for further information on how voice data is handled during speech recognition:
	•	Apple Privacy Policy
	•	Google Privacy Policy

### Groq AI Usage

This project utilizes Groq AI for language processing tasks (e.g., speech-to-text or text analysis).

- **No user data is stored or logged** by this application.
- All communication with Groq services is subject to Groq Inc.'s data handling policies.
- To learn more, please refer to the [Groq Privacy Policy](https://groq.com/privacy-policy).

Note: If you are using a third-party wrapper or API provider that runs on Groq hardware, please review their respective privacy terms as well.

If you are concerned about speech data being transmitted to third parties, we recommend using a browser that supports local speech recognition and or modifying the code to use a local LLM. 

⸻

Here are direct links to the official privacy policies:

Browser Privacy Policies
	•	Apple (Safari on macOS and iOS)
https://www.apple.com/legal/privacy/en-ww/
	•	Google (Chrome, Chromium-based browsers)
https://policies.google.com/privacy
	•	Mozilla Firefox (Note: Firefox does not currently implement the SpeechRecognition API)
https://www.mozilla.org/en-US/privacy/
	•	Microsoft Edge (based on Chromium)
https://privacy.microsoft.com/en-us/privacystatement
 • Groq AI Privacy
https://groq.com/privacy-policy/

### Contribute 

F.R.I.D.A.Y. showcases an ambitious attempt to bring a voice-activated assistant to Linux systems. While the groundwork is laid, further development, detailed documentation, and community involvement would be beneficial to realize its full potential.

For those interested in AI assistants or Linux automation, this project offers a starting point, but be prepared to delve into the code and possibly contribute to its evolution.