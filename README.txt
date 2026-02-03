AIUC ↔ AIVSS Crosswalk Website (offline)

How to open:
1) Open index.html in a browser.
   - If your browser blocks local scripts, run a local server:
     python3 -m http.server 8000
     Then open http://localhost:8000/website/index.html

What you can do:
- Switch between Controls & Evidence vs Requirements
- Filter by AIVSS Core Risk, ASI ID (optional), Principle, Confidence
- Search across all fields
- Click a row to see full details and rationale
- Export filtered CSV

Files:
- index.html, styles.css, app.js: UI
- site_data.js: embedded data (no external dependencies)
