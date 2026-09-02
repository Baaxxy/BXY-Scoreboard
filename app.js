QBScoreboard = {}

const jobIcons = {
  police: "fa-shield-halved",
  ambulance: "fa-suitcase-medical",
};

const STATE_CLASSES = "state-open state-locked state-busy";
const isPreviewMode = /(^|\/)index\.html$/i.test(window.location.pathname);

window.addEventListener("message", (event) => {
  switch (event.data.action) {
    case "open":
      Open(event.data);
      break;
    case "close":
      Close();
      break;
    case "setup":
      Setup(event.data);
      break;
  }
});

const setBeamState = (beam, state, iconClass) => {
  if (!beam || !beam.length) return;
  beam.removeClass(STATE_CLASSES).addClass(state);
  beam.find(".info-beam-status").html(`<i class="fa-solid ${iconClass}"></i>`);
};

const normalizeJobs = (items) => {
  if (!items) return [];
  return items.map((item) => {
    if (Array.isArray(item)) return item;
    return [item.name, item.label || item.name];
  });
};

const normalizeActions = (items) => {
  if (!items) return [];
  return items.map((item) => {
    if (Array.isArray(item)) return item;
    return [item.name, item.label || item.name];
  });
};

const Open = (data) => {
  $(".scoreboard-block").css("display", "flex");

  $.each(data.IllegalActions || [], (i, category) => {
    const beam = $(".scoreboard-info").find('[data-type="' + (category.name || category[0]) + '"]');

    if (category.busy) {
      setBeamState(beam, "state-busy", "fa-clock fa-lg");
    } else if ((data.currentCops || 0) >= (category.minimumPolice || 0)) {
      setBeamState(beam, "state-open", "fa-lock-open fa-lg");
    } else {
      setBeamState(beam, "state-locked", "fa-lock fa-lg");
    }
  });

  $.each(data.availableJobs || {}, (job, Jcount) => {
    const beam = $(".scoreboard-info").find('[data-type="job-' + job + '"]');

    if (Jcount > 0) {
      setBeamState(beam, "state-open", "fa-check");
    } else {
      setBeamState(beam, "state-locked", "fa-xmark");
    }
  });

  if ($("#summary-players").length) {
    $("#summary-players").html(data.players || 0);
  }

  if ($("#total-players").length) {
    $("#total-players").html(data.players || 0);
  }
};

const Close = () => {
  $(".scoreboard-block").css("display", "none");
};

const Setup = (data) => {
  const jobs = normalizeJobs(data.availableJobs);
  const actions = normalizeActions(data.creminalJobs || data.IllegalActions || []);

  let scoreboardHtml = "";

  scoreboardHtml += `
    <div class="scoreboard-summary">
      <div class="summary-chip single-player-chip">
        <span class="summary-label">Players</span>
        <strong class="summary-value" id="summary-players">0</strong>
      </div>
    </div>
  `;

  if (actions.length) {
    scoreboardHtml += `<div class="scoreboard-section-title">Operations</div>`;
    $.each(actions, (index, value) => {
      const type = value[0] || value.name;
      const label = value[1] || value.label || type;
      const icon = type === "CitizenKidnap" || type === "PoliceKidnap"
        ? '<i class="fa-solid fa-user-secret beam-icon"></i>'
        : '<i class="fa-solid fa-burst beam-icon"></i>';

      scoreboardHtml += `
        <div class="scoreboard-info-beam" data-type="${type}">
          <div class="info-beam-title">${icon}<p>${label}</p></div>
          <div class="info-beam-status"></div>
        </div>
      `;
    });
  }

  if (jobs.length) {
    scoreboardHtml += `<div class="scoreboard-section-title">Departments</div>`;
    $.each(jobs, (index, value) => {
      const type = value[0] || value.name;
      const label = value[1] || value.label || type;
      const icon = jobIcons[type]
        ? `<i class="fa-solid ${jobIcons[type]} beam-icon"></i>`
        : '<i class="fa-solid fa-users beam-icon"></i>';

      scoreboardHtml += `
        <div class="scoreboard-info-beam" data-type="job-${type}">
          <div class="info-beam-title">${icon}<p>${label}</p></div>
          <div class="info-beam-status"></div>
        </div>
      `;
    });
  }

  $(".scoreboard-info").html(scoreboardHtml);
};

if (isPreviewMode) {
  Setup({
    availableJobs: [
      ["police", "Police"],
      ["ambulance", "Medic"],
    ],
  });

  Open({
    currentCops: 8,
    availableJobs: {
      police: 3,
      ambulance: 2,
    },
    players: 24,
  });
} else {
  Close();
}
