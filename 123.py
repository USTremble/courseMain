from werkzeug.security import generate_password_hash, check_password_hash

pas = "admin"
hashed = generate_password_hash(pas)
print(hashed)