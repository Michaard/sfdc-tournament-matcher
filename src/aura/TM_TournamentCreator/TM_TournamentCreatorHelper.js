({
    init : function(component) {
        sessionStorage.clear();
        component.set("v.stage", "1");
    },

    incrementStage : function(component) {
        let currentStage = Number(component.get("v.stage"));
        let isStageValid = false;

        if (currentStage === 1) {
            this.saveCreatorBaseData(component);
            isStageValid = this.validatePhaseOne(component);
        } else if (currentStage === 2) {
            this.saveCreatorPhaseData(component);
            isStageValid = this.validatePhaseTwo(component);
        } else {
            isStageValid = true;
        }

        if (isStageValid) {
            currentStage++;
            component.set("v.stage", currentStage.toString());
        }
    },

    decrementStage : function(component) {
        let currentStage = Number(component.get("v.stage"));
        if (currentStage === 2) {
            this.saveCreatorPhaseData(component);
        }
        currentStage--;
        component.set("v.stage", currentStage.toString());
    },

    validatePhaseOne : function(component) {
        let tournamentBaseJson = sessionStorage.getItem($A.get("$Label.c.TM_TournamentSessionKey"));
        if (tournamentBaseJson) {
            let tournamentBase = JSON.parse(tournamentBaseJson);
            if (tournamentBase.name && tournamentBase.type && tournamentBase.participants) {
                return this.validateParticipants(component, tournamentBase);
            } else {
                this.showToastAlert(component, "warning", $A.get("$Label.c.Label_Invalid_Data"), $A.get("$Label.c.TM_CreatorBaseErrorMissingField"));
                return false;
            }
        }
    },

    validatePhaseTwo : function(component) {
        let tournamentPhaseJson = sessionStorage.getItem($A.get("$Label.c.TM_TournamentPhaseSessionKey"));
        if (tournamentPhaseJson) {
            let tournamentPhase = JSON.parse(tournamentPhaseJson);
            let allowDraws = tournamentPhase.allowDraws;
            let pointsPerVictory = Number(tournamentPhase.pointsPerVictory);
            let pointsPerLose = Number(tournamentPhase.pointsPerLose);
            let pointsPerDraw = Number(tournamentPhase.pointsPerDraw);
            if (pointsPerVictory >= 0) {
                if ((pointsPerVictory > pointsPerLose) && !(allowDraws && (pointsPerDraw >= pointsPerVictory || pointsPerLose >= pointsPerDraw))) {
                    return true;
                } else {
                    this.showToastAlert(component, "warning", $A.get("$Label.c.Label_Invalid_Data"), $A.get("$Label.c.TM_InvalidPointScore"));
                    return false;
                }
            } else {
                return false;
            }
        }
    },

    validateParticipants : function(component, tournamentBase) {
        if (tournamentBase && tournamentBase.participants) {
            let participants = tournamentBase.participants.split("\n");
            return this.isNumberOfParticipantsValid(component, tournamentBase.type, participants.length);
        } else {
            return false;
        }
    },

    isNumberOfParticipantsValid : function(component, type, numberOfParticipants) {
        let value;
        let errorMessage;
        if (type === $A.get("$Label.c.TM_Label_Cup")) {
            value = (numberOfParticipants >= 2 && numberOfParticipants <= 16 && this.isPowerOfTwo(numberOfParticipants));
            errorMessage = $A.get("$Label.c.TM_InvalidNumberOfParticipantsCup");
        } else if (type === $A.get("$Label.c.TM_Label_League")) {
            value = (numberOfParticipants >= 2 && numberOfParticipants <= 64);
            errorMessage = $A.get("$Label.c.TM_InvalidNumberOfParticipantsLeague");
        } else {
            value = (numberOfParticipants >= 4 && numberOfParticipants <= 64);
            errorMessage = $A.get("$Label.c.TM_InvalidNumberOfParticipantsElse");
        }

        if (!value) {
            this.showToastAlert(component, "warning", $A.get("$Label.c.TM_InvalidNumberOfParticipants"), errorMessage);
        }

        return value;
    },

    isPowerOfTwo : function(n) {
        return n && (n != 0) && !(n & (n - 1));
    },

    saveCreatorBaseData : function(component) {
        let creatorBase = component.find("creatorBase");
        if (creatorBase) {
            creatorBase.save();
        }
    },

    saveCreatorPhaseData : function(component) {
        let creatorPhase = component.find("creatorPhase");
        if (creatorPhase) {
            creatorPhase.save();
        }
    },

    showToastAlert : function(component, variant, title, message) {
        let notifLib = component.find("notifLib");
        if (notifLib) {
            notifLib.showToast({
                "variant": variant,
                "title": title,
                "message": message
            });
        }
    }
})