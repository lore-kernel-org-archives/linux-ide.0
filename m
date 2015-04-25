From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: [PATCH v2 1/2] libata: Add helper to determine when PHY events should be ignored
Date: Sat, 25 Apr 2015 19:52:36 +0200
Message-ID: <1429984357-2223-2-git-send-email-gabriele.mzt@gmail.com>
References: <1429984357-2223-1-git-send-email-gabriele.mzt@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1429984357-2223-1-git-send-email-gabriele.mzt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tj@kernel.org
Cc: stripathi@apm.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Gabriele Mazzotta <gabriele.mzt@gmail.com>
List-Id: linux-ide@vger.kernel.org

This is a preparation commit that will allow to add other criteria
according to which PHY events should be dropped.

Signed-off-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
---
 drivers/ata/libahci.c     |  3 +--
 drivers/ata/libata-core.c | 19 +++++++++++++++++++
 include/linux/libata.h    |  1 +
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 61a9c07..287c4ba 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -1707,8 +1707,7 @@ static void ahci_handle_port_interrupt(struct ata_port *ap,
 	if (unlikely(resetting))
 		status &= ~PORT_IRQ_BAD_PMP;
 
-	/* if LPM is enabled, PHYRDY doesn't mean anything */
-	if (ap->link.lpm_policy > ATA_LPM_MAX_POWER) {
+	if (sata_lpm_ignore_phy_events(&ap->link)) {
 		status &= ~PORT_IRQ_PHYRDY;
 		ahci_scr_write(&ap->link, SCR_ERROR, SERR_PHYRDY_CHG);
 	}
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index f6cb1f1..12adcf7 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6752,6 +6752,25 @@ u32 ata_wait_register(struct ata_port *ap, void __iomem *reg, u32 mask, u32 val,
 	return tmp;
 }
 
+/**
+ *	sata_lpm_ignore_phy_events - test if PHY event should be ignored
+ *	@link: Link receiving the event
+ *
+ *	Test whether the received PHY event has to be ignored or not.
+ *
+ *	LOCKING:
+ *	None:
+ *
+ *	RETURNS:
+ *	True if the event has to be ignored.
+ */
+bool sata_lpm_ignore_phy_events(struct ata_link *link)
+{
+	/* if LPM is enabled, PHYRDY doesn't mean anything */
+	return !!(link->lpm_policy > ATA_LPM_MAX_POWER);
+}
+EXPORT_SYMBOL_GPL(sata_lpm_ignore_phy_events);
+
 /*
  * Dummy port_ops
  */
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 8dad4a3..6138d87 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1201,6 +1201,7 @@ extern struct ata_device *ata_dev_pair(struct ata_device *adev);
 extern int ata_do_set_mode(struct ata_link *link, struct ata_device **r_failed_dev);
 extern void ata_scsi_port_error_handler(struct Scsi_Host *host, struct ata_port *ap);
 extern void ata_scsi_cmd_error_handler(struct Scsi_Host *host, struct ata_port *ap, struct list_head *eh_q);
+extern bool sata_lpm_ignore_phy_events(struct ata_link *link);
 
 extern int ata_cable_40wire(struct ata_port *ap);
 extern int ata_cable_80wire(struct ata_port *ap);
-- 
2.1.4
