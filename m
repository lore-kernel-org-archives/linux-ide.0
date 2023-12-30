Received: from vps.thesusis.net (vps.thesusis.net [34.202.238.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C72BA37
	for <linux-ide@vger.kernel.org>; Sat, 30 Dec 2023 18:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thesusis.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thesusis.net
Received: by vps.thesusis.net (Postfix, from userid 1000)
	id 8EC6D14FB3C; Sat, 30 Dec 2023 13:21:54 -0500 (EST)
From: Phillip Susi <phill@thesusis.net>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org,
	Phillip Susi <phill@thesusis.net>
Subject: [PATCH 1/1] libata: only wake a drive once on system resume
Date: Sat, 30 Dec 2023 13:21:28 -0500
Message-Id: <20231230182128.296675-2-phill@thesusis.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231230182128.296675-1-phill@thesusis.net>
References: <20231225151915.258816-1-phill@thesusis.net>
 <20231230182128.296675-1-phill@thesusis.net>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the event that more than one pass of EH is needed during system resume,
only request the drive be started once.
---
 drivers/ata/libata-core.c | 4 ++--
 drivers/ata/libata-eh.c   | 4 ----
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index d1389ce6943e..ca3ca8107a3e 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5223,7 +5223,7 @@ static void ata_port_request_pm(struct ata_port *ap, pm_message_t mesg,
 	/* on system resume, don't wake PuiS drives */
 	if (mesg.event == PM_EVENT_RESUME)
 		ehi_flags |= ATA_EHI_NOSTART;
-	
+
 	/* Request PM operation to EH */
 	ap->pm_mesg = mesg;
 	ap->pflags |= ATA_PFLAG_PM_PENDING;
@@ -5297,7 +5297,7 @@ static int ata_port_pm_poweroff(struct device *dev)
 static void ata_port_resume(struct ata_port *ap, pm_message_t mesg,
 			    bool async)
 {
-	ata_port_request_pm(ap, mesg, ATA_EH_RESET,
+	ata_port_request_pm(ap, mesg, ATA_EH_RESET | ATA_EH_SET_ACTIVE,
 			    ATA_EHI_NO_AUTOPSY | ATA_EHI_QUIET,
 			    async);
 }
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 120f7d7fb450..f44ce7068a8b 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -711,10 +711,6 @@ void ata_scsi_port_error_handler(struct Scsi_Host *host, struct ata_port *ap)
 			ehc->saved_xfer_mode[devno] = dev->xfer_mode;
 			if (ata_ncq_enabled(dev))
 				ehc->saved_ncq_enabled |= 1 << devno;
-
-			/* If we are resuming, wake up the device */
-			if (ap->pflags & ATA_PFLAG_RESUMING)
-				ehc->i.dev_action[devno] |= ATA_EH_SET_ACTIVE;
 		}
 	}
 
-- 
2.30.2

