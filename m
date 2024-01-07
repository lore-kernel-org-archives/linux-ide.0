Received: from vps.thesusis.net (vps.thesusis.net [34.202.238.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6833713FE5
	for <linux-ide@vger.kernel.org>; Sun,  7 Jan 2024 18:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thesusis.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thesusis.net
Received: by vps.thesusis.net (Postfix, from userid 1000)
	id A7F55152323; Sun,  7 Jan 2024 13:03:01 -0500 (EST)
From: Phillip Susi <phill@thesusis.net>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Phillip Susi <phill@thesusis.net>
Subject: [PATCH 2/3] libata: only wake a drive once on system resume
Date: Sun,  7 Jan 2024 13:02:57 -0500
Message-Id: <20240107180258.360886-3-phill@thesusis.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240107180258.360886-1-phill@thesusis.net>
References: <87msthdo11.fsf@vps.thesusis.net>
 <20240107180258.360886-1-phill@thesusis.net>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the event that more than one pass of EH is needed during system resume,
only request the drive be started once ( if the first time worked ).
---
 drivers/ata/libata-core.c | 9 +++++----
 drivers/ata/libata-eh.c   | 8 +++-----
 drivers/ata/libata.h      | 2 +-
 3 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 6c5269de4bf2..ef6a2349a6f8 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2080,7 +2080,7 @@ static bool ata_dev_power_is_active(struct ata_device *dev)
  *	LOCKING:
  *	Kernel thread context (may sleep).
  */
-void ata_dev_power_set_active(struct ata_device *dev)
+unsigned int ata_dev_power_set_active(struct ata_device *dev)
 {
 	struct ata_taskfile tf;
 	unsigned int err_mask;
@@ -2090,14 +2090,14 @@ void ata_dev_power_set_active(struct ata_device *dev)
 	 * if supported by the device.
 	 */
 	if (!ata_dev_power_init_tf(dev, &tf, true))
-		return;
+		return AC_ERR_OK;
 
 	/*
 	 * Check the device power state & condition and force a spinup with
 	 * VERIFY command only if the drive is not already ACTIVE or IDLE.
 	 */
 	if (ata_dev_power_is_active(dev))
-		return;
+		return AC_ERR_OK;
 
 	ata_dev_notice(dev, "Entering active power mode\n");
 
@@ -2105,6 +2105,7 @@ void ata_dev_power_set_active(struct ata_device *dev)
 	if (err_mask)
 		ata_dev_err(dev, "VERIFY failed (err_mask=0x%x)\n",
 			    err_mask);
+	return err_mask;
 }
 
 /**
@@ -5277,7 +5278,7 @@ static int ata_port_pm_poweroff(struct device *dev)
 static void ata_port_resume(struct ata_port *ap, pm_message_t mesg,
 			    bool async)
 {
-	ata_port_request_pm(ap, mesg, ATA_EH_RESET,
+	ata_port_request_pm(ap, mesg, ATA_EH_RESET | ATA_EH_SET_ACTIVE,
 			    ATA_EHI_NO_AUTOPSY | ATA_EHI_QUIET,
 			    async);
 }
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index b0d6e69c4a5b..799a1b8bc384 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -710,10 +710,6 @@ void ata_scsi_port_error_handler(struct Scsi_Host *host, struct ata_port *ap)
 			ehc->saved_xfer_mode[devno] = dev->xfer_mode;
 			if (ata_ncq_enabled(dev))
 				ehc->saved_ncq_enabled |= 1 << devno;
-
-			/* If we are resuming, wake up the device */
-			if (ap->pflags & ATA_PFLAG_RESUMING)
-				ehc->i.dev_action[devno] |= ATA_EH_SET_ACTIVE;
 		}
 	}
 
@@ -3853,7 +3849,9 @@ int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
 		 */
 		ata_for_each_dev(dev, link, ENABLED) {
 			if (ehc->i.dev_action[dev->devno] & ATA_EH_SET_ACTIVE) {
-				ata_dev_power_set_active(dev);
+				unsigned int err_mask = ata_dev_power_set_active(dev);
+				if (err_mask)
+					link->eh_info.dev_action[dev->devno] |= ATA_EH_SET_ACTIVE;
 				ata_eh_done(link, dev, ATA_EH_SET_ACTIVE);
 			}
 		}
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 5c685bb1939e..43ad1ef9b63a 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -65,7 +65,7 @@ extern int ata_dev_configure(struct ata_device *dev);
 extern bool ata_dev_power_init_tf(struct ata_device *dev,
 				  struct ata_taskfile *tf, bool set_active);
 extern void ata_dev_power_set_standby(struct ata_device *dev);
-extern void ata_dev_power_set_active(struct ata_device *dev);
+extern unsigned int ata_dev_power_set_active(struct ata_device *dev);
 extern int sata_down_spd_limit(struct ata_link *link, u32 spd_limit);
 extern int ata_down_xfermask_limit(struct ata_device *dev, unsigned int sel);
 extern unsigned int ata_dev_set_feature(struct ata_device *dev,
-- 
2.30.2

