CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(32) NOT NULL UNIQUE,
    password TEXT NOT NULL,
    role VARCHAR(10) NOT NULL DEFAULT 'player',
    is_blocked BOOLEAN NOT NULL DEFAULT FALSE
);


CREATE TABLE teams (
    team_id SERIAL PRIMARY KEY,
    team_name VARCHAR(32) NOT NULL,
    invite_code VARCHAR(16) NOT NULL
);

CREATE TABLE events (
    event_id SERIAL PRIMARY KEY,
    code VARCHAR(16) NOT NULL,
    name VARCHAR(64) NOT NULL,
    description TEXT NOT NULL,
    type VARCHAR(8) NOT NULL,
    answer VARCHAR(256) NOT NULL,
    file_path TEXT NOT NULL,
    status VARCHAR(8) NOT NULL DEFAULT 'waiting',
    created_by INTEGER NOT NULL,
    FOREIGN KEY (created_by) REFERENCES users(user_id)
);

CREATE TABLE team_members (
    user_id INTEGER NOT NULL,
    team_id INTEGER NOT NULL,
    active BOOLEAN DEFAULT TRUE,
    PRIMARY KEY (user_id, team_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (team_id) REFERENCES teams(team_id)
);

CREATE TABLE event_teams (
    id SERIAL PRIMARY KEY,
    event_id INTEGER NOT NULL,
    team_id INTEGER NOT NULL,
    points INTEGER NOT NULL DEFAULT 0,
    FOREIGN KEY (event_id) REFERENCES events(event_id),
    FOREIGN KEY (team_id) REFERENCES teams(team_id)
);

CREATE TABLE event_submits (
    id SERIAL PRIMARY KEY,
    event_id INTEGER NOT NULL,
    team_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    answer TEXT NOT NULL,
    ts TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT now(),
    FOREIGN KEY (event_id) REFERENCES events(event_id),
    FOREIGN KEY (team_id) REFERENCES teams(team_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE UNIQUE INDEX IF NOT EXISTS teams_name_unique ON teams (team_name);
CREATE UNIQUE INDEX IF NOT EXISTS teams_code_unique ON teams (invite_code);
CREATE UNIQUE INDEX IF NOT EXISTS events_name_unique ON events (name);
CREATE UNIQUE INDEX IF NOT EXISTS events_code_unique ON events (code);
CREATE UNIQUE INDEX IF NOT EXISTS team_members_user_unique ON team_members (user_id);