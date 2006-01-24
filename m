From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 03/12] libata: new ->probe_reset operation
Date: Tue, 24 Jan 2006 17:05:22 +0900
Message-ID: <11380899223211-git-send-email-htejun@gmail.com>
References: <1138089921565-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xproxy.gmail.com ([66.249.82.197]:47552 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030353AbWAXIF3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 24 Jan 2006 03:05:29 -0500
Received: by xproxy.gmail.com with SMTP id s14so770398wxc
        for <linux-ide@vger.kernel.org>; Tue, 24 Jan 2006 00:05:26 -0800 (PST)
In-Reply-To: <1138089921565-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, albertcc@tw.ibm.com
Cc: Tejun Heo <htejun@gmail.com>

Add new ->probe_reset operation to ata_port_operations obsoleting
->phy_reset.  The main difference from ->phy_reset is that the new
operation is not allowed to manipulate libata internals directly.
It's not allowed to configure or disable the port or devices.  It can
only succeed or fail and classify attached devices into passed
@classes.

This change gives more control to higher level and eases sharing reset
methods with EH.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   19 ++++++++++++++++++-
 include/linux/libata.h     |    8 +++++---
 2 files changed, 23 insertions(+), 4 deletions(-)

65ce0d036067942117a705c7293aa544804e47a1
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index e10169d..c70151a 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1532,7 +1532,24 @@ static int ata_bus_probe(struct ata_port
 {
 	unsigned int i, found = 0;
 
-	ap->ops->phy_reset(ap);
+	if (ap->ops->probe_reset) {
+		unsigned int classes[ATA_MAX_DEVICES];
+		int rc;
+
+		ata_port_probe(ap);
+
+		rc = ap->ops->probe_reset(ap, classes);
+		if (rc == 0) {
+			for (i = 0; i < ATA_MAX_DEVICES; i++)
+				ap->device[i].class = classes[i];
+		} else {
+			printk(KERN_ERR "ata%u: probe reset failed, "
+			       "disabling port\n", ap->id);
+			ata_port_disable(ap);
+		}
+	} else
+		ap->ops->phy_reset(ap);
+
 	if (ap->flags & ATA_FLAG_PORT_DISABLED)
 		goto err_out;
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index b33f035..6f36d9a 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -148,9 +148,9 @@ enum {
 	ATA_FLAG_PORT_DISABLED	= (1 << 2), /* port is disabled, ignore it */
 	ATA_FLAG_SATA		= (1 << 3),
 	ATA_FLAG_NO_LEGACY	= (1 << 4), /* no legacy mode check */
-	ATA_FLAG_SRST		= (1 << 5), /* use ATA SRST, not E.D.D. */
+	ATA_FLAG_SRST		= (1 << 5), /* (obsolete) use ATA SRST, not E.D.D. */
 	ATA_FLAG_MMIO		= (1 << 6), /* use MMIO, not PIO */
-	ATA_FLAG_SATA_RESET	= (1 << 7), /* use COMRESET */
+	ATA_FLAG_SATA_RESET	= (1 << 7), /* (obsolete) use COMRESET */
 	ATA_FLAG_PIO_DMA	= (1 << 8), /* PIO cmds via DMA */
 	ATA_FLAG_NOINTR		= (1 << 9), /* FIXME: Remove this once
 					     * proper HSM is in place. */
@@ -422,7 +422,9 @@ struct ata_port_operations {
 	u8   (*check_altstatus)(struct ata_port *ap);
 	void (*dev_select)(struct ata_port *ap, unsigned int device);
 
-	void (*phy_reset) (struct ata_port *ap);
+	void (*phy_reset) (struct ata_port *ap); /* obsolete */
+	int (*probe_reset) (struct ata_port *ap, unsigned int *classes);
+
 	void (*post_set_mode) (struct ata_port *ap);
 
 	int (*check_atapi_dma) (struct ata_queued_cmd *qc);
-- 
1.1.3


