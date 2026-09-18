import os

from flask import Flask
import pymysql

app = Flask(__name__)


def get_db_connection():
    return pymysql.connect(
        host=os.environ["DB_HOST"],
        port=int(os.environ.get("DB_PORT", "3306")),
        user=os.environ["DB_USER"],
        password=os.environ["DB_PASSWORD"],
        database=os.environ["DB_NAME"],
        connect_timeout=5,
    )


@app.route("/")
def index():
    try:
        connection = get_db_connection()

        with connection.cursor() as cursor:
            cursor.execute("SELECT VERSION()")
            mysql_version = cursor.fetchone()[0]

        connection.close()

        return f"""
        <!DOCTYPE html>
        <html lang="ru">
        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Final Project</title>
            <style>
                body {{
                    margin: 0;
                    min-height: 100vh;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    background: #111827;
                    color: #ffffff;
                    font-family: Arial, sans-serif;
                }}

                .card {{
                    max-width: 650px;
                    padding: 40px;
                    border-radius: 16px;
                    background: #1f2937;
                    box-shadow: 0 10px 40px rgba(0,0,0,0.35);
                }}

                h1 {{
                    margin-top: 0;
                }}

                .status {{
                    color: #22c55e;
                    font-weight: bold;
                }}

                .info {{
                    margin-top: 25px;
                    padding: 20px;
                    background: #111827;
                    border-radius: 10px;
                }}

                code {{
                    color: #93c5fd;
                }}
            </style>
        </head>
        <body>
            <div class="card">
                <h1>Final Project</h1>

                <p class="status">● Приложение работает</p>

                <p>
                    Веб-приложение запущено в Docker
                    на виртуальной машине Yandex Cloud.
                </p>

                <div class="info">
                    <p><strong>Database:</strong> <code>{os.environ["DB_NAME"]}</code></p>
                    <p><strong>MySQL:</strong> <code>подключение успешно</code></p>
                    <p><strong>MySQL version:</strong> <code>{mysql_version}</code></p>
                </div>
            </div>
        </body>
        </html>
        """

    except Exception as error:
        return f"""
        <h1>Application is running</h1>
        <p>Ошибка подключения к MySQL:</p>
        <pre>{error}</pre>
        """, 500


@app.route("/health")
def health():
    return {"status": "ok"}


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000)
