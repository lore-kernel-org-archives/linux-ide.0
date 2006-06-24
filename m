From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 01/15] libata: move ata_eh_clear_action() upward
Date: Sat, 24 Jun 2006 20:30:18 +0900
Message-ID: <1151148618863-git-send-email-htejun@gmail.com>
References: <11511486183271-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.198]:19846 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1752220AbWFXLaI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 24 Jun 2006 07:30:08 -0400
Received: by nz-out-0102.google.com with SMTP id o37so445543nzf
        for <linux-ide@vger.kernel.org>; Sat, 24 Jun 2006 04:30:08 -0700 (PDT)
In-Reply-To: <11511486183271-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, lkml@rtr.ca, axboe@suse.de, forrest.zhao@intel.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Move ata_eh_clear_action() upward.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-eh.c |   50 +++++++++++++++++++++++-----------------------
 1 files changed, 25 insertions(+), 25 deletions(-)

5437c8195e49efeb2eed0aea79f5749e6c4a9521
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index 8233859..126be36 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -93,6 +93,31 @@ static int ata_ering_map(struct ata_erin
 	return rc;
 }
 
+static void ata_eh_clear_action(struct ata_device *dev,
+				struct ata_eh_info *ehi, unsigned int action)
+{
+	int i;
+
+	if (!dev) {
+		ehi->action &= ~action;
+		for (i = 0; i < ATA_MAX_DEVICES; i++)
+			ehi->dev_action[i] &= ~action;
+	} else {
+		/* doesn't make sense for port-wide EH actions */
+		WARN_ON(!(action & ATA_EH_PERDEV_MASK));
+
+		/* break ehi->action into ehi->dev_action */
+		if (ehi->action & action) {
+			for (i = 0; i < ATA_MAX_DEVICES; i++)
+				ehi->dev_action[i] |= ehi->action & action;
+			ehi->action &= ~action;
+		}
+
+		/* turn off the specified per-dev action */
+		ehi->dev_action[dev->devno] &= ~action;
+	}
+}
+
 /**
  *	ata_scsi_timed_out - SCSI layer time out callback
  *	@cmd: timed out SCSI command
@@ -705,31 +730,6 @@ static void ata_eh_detach_dev(struct ata
 	spin_unlock_irqrestore(ap->lock, flags);
 }
 
-static void ata_eh_clear_action(struct ata_device *dev,
-				struct ata_eh_info *ehi, unsigned int action)
-{
-	int i;
-
-	if (!dev) {
-		ehi->action &= ~action;
-		for (i = 0; i < ATA_MAX_DEVICES; i++)
-			ehi->dev_action[i] &= ~action;
-	} else {
-		/* doesn't make sense for port-wide EH actions */
-		WARN_ON(!(action & ATA_EH_PERDEV_MASK));
-
-		/* break ehi->action into ehi->dev_action */
-		if (ehi->action & action) {
-			for (i = 0; i < ATA_MAX_DEVICES; i++)
-				ehi->dev_action[i] |= ehi->action & action;
-			ehi->action &= ~action;
-		}
-
-		/* turn off the specified per-dev action */
-		ehi->dev_action[dev->devno] &= ~action;
-	}
-}
-
 /**
  *	ata_eh_about_to_do - about to perform eh_action
  *	@ap: target ATA port
-- 
1.3.2


