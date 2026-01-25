# Galaxy BBS Project

A Java Servlet/JSP based Bulletin Board System (Reddit Clone).

## 🚀 Deployment Status

**Can this be deployed to Vercel?**  
❌ **No.** Vercel is designed for frontend frameworks (Next.js, React) and Serverless functions (Node.js, Python, Go). It does not support Java Servlet Containers (Tomcat) or persistent file-based databases (H2) out of the box.

**Where should I deploy it?**  
✅ **Railway**, **Render**, or **Fly.io**. These platforms support Docker containers, which is the best way to deploy this Java application.

---

## 🛠 How to Deploy (Recommended: Railway/Render)

This project includes a `Dockerfile` that automates the build and deployment process.

### Option 1: Deploy with Docker (Railway/Render)

1.  **Push this code to GitHub**.
2.  **Sign up** for [Railway](https://railway.app/) or [Render](https://render.com/).
3.  **Create a New Service** and select your GitHub repository.
4.  The platform will detect the `Dockerfile` and build your application automatically.

### Database Note for Cloud Deployment
By default, this app uses an **embedded H2 database** stored inside the container. 
*   **Warning**: On most cloud platforms, if the app restarts, **all data will be lost** because the container's file system is ephemeral.
*   **Production Solution**: Use a managed database (MySQL or PostgreSQL).
    1.  Provision a MySQL database (Railway/Render often provide this).
    2.  Set the following **Environment Variables** in your deployment settings:
        *   `DB_URL`: `jdbc:mysql://<your-db-host>:<port>/<db-name>`
        *   `DB_USER`: `<your-db-username>`
        *   `DB_PASSWORD`: `<your-db-password>`

---

## 💻 Running Locally

### Prerequisites
*   Java JDK 17+
*   Apache Tomcat 10+

### Steps
1.  **Compile**: Run `compile.bat` (Windows).
2.  **Setup Database**: Run `setup_db.bat` (Windows) to initialize the H2 database.
3.  **Start Server**: Ensure Tomcat is running and the project folder (`galaxy_test`) is in `webapps`.
4.  **Access**: Open `http://localhost:8080/galaxy_test` in your browser.

## 📂 Project Structure
*   `src/`: Java source code (Models, DAOs, Servlets).
*   `WEB-INF/views/`: JSP files (Frontend templates).
*   `assets/`: CSS, JS, and Images.
*   `docs/`: Database schema and documentation.
