From: Tejun Heo <htejun@gmail.com>
Subject: [RESEND][PATCH] ata_piix: fix ghost device probing by honoring PCS present bits
Date: Sun, 20 Aug 2006 17:56:38 +0900
Message-ID: <20060820085638.GM6371@htj.dyndns.org>
References: <20060810052347.GC6371@htj.dyndns.org> <44E7841B.6050004@pobox.com> <20060820062745.GL6371@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.181]:11636 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751678AbWHTI4o (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 20 Aug 2006 04:56:44 -0400
Received: by py-out-1112.google.com with SMTP id n25so1913219pyg
        for <linux-ide@vger.kernel.org>; Sun, 20 Aug 2006 01:56:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20060820062745.GL6371@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Move out PCS handling from piix_sata_prereset() into
piix_sata_present_mask() and use it from newly implemented
piix_sata_softreset().  Class codes for devices which are indicated to
be absent by PCS are cleared to ATA_DEV_NONE.  This fixes ghost device
problem reported on ICH6 and 7.

This patch moves PCS handling from prereset to softreset, which makes
two behavior changes.

* perform softreset even when PCS indicates no device
* PCS handling is repeated before retrying softresets due to reset
  failures.

Both behavior changes are intended and more consistent with how other
drivers behave.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---

Sorry, I forgot save after before diffing and the previous patch
contained debug printks.

diff --git a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
index 5e8afc8..01b3530 100644
--- a/drivers/scsi/ata_piix.c
+++ b/drivers/scsi/ata_piix.c
@@ -531,27 +531,25 @@ static void piix_pata_error_handler(stru
 }
 
 /**
- *	piix_sata_prereset - prereset for SATA host controller
+ *	piix_sata_present_mask - determine present mask for SATA host controller
  *	@ap: Target port
  *
- *	Reads and configures SATA PCI device's PCI config register
- *	Port Configuration and Status (PCS) to determine port and
- *	device availability.  Return -ENODEV to skip reset if no
- *	device is present.
+ *	Reads SATA PCI device's PCI config register Port Configuration
+ *	and Status (PCS) to determine port and device availability.
  *
  *	LOCKING:
  *	None (inherited from caller).
  *
  *	RETURNS:
- *	0 if device is present, -ENODEV otherwise.
+ *	determined present_mask
  */
-static int piix_sata_prereset(struct ata_port *ap)
+static unsigned int piix_sata_present_mask(struct ata_port *ap)
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
 	struct piix_host_priv *hpriv = ap->host_set->private_data;
 	const unsigned int *map = hpriv->map;
 	int base = 2 * ap->hard_port_no;
-	unsigned int present = 0;
+	unsigned int present_mask = 0;
 	int port, i;
 	u16 pcs;
 
@@ -564,24 +562,52 @@ static int piix_sata_prereset(struct ata
 			continue;
 		if ((ap->flags & PIIX_FLAG_IGNORE_PCS) ||
 		    (pcs & 1 << (hpriv->map_db->present_shift + port)))
-			present = 1;
+			present_mask |= 1 << i;
 	}
 
-	DPRINTK("ata%u: LEAVE, pcs=0x%x present=0x%x\n",
-		ap->id, pcs, present);
+	DPRINTK("ata%u: LEAVE, pcs=0x%x present_mask=0x%x\n",
+		ap->id, pcs, present_mask);
 
-	if (!present) {
-		ata_port_printk(ap, KERN_INFO, "SATA port has no device.\n");
-		ap->eh_context.i.action &= ~ATA_EH_RESET_MASK;
-		return 0;
+	return present_mask;
+}
+
+/**
+ *	piix_sata_softreset - reset SATA host port via ATA SRST
+ *	@ap: port to reset
+ *	@classes: resulting classes of attached devices
+ *
+ *	Reset SATA host port via ATA SRST.  On controllers with
+ *	reliable PCS present bits, the bits are used to determine
+ *	device presence.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep)
+ *
+ *	RETURNS:
+ *	0 on success, -errno otherwise.
+ */
+static int piix_sata_softreset(struct ata_port *ap, unsigned int *classes)
+{
+	unsigned int present_mask;
+	int i, rc;
+
+	present_mask = piix_sata_present_mask(ap);
+
+	rc = ata_std_softreset(ap, classes);
+	if (rc)
+		return rc;
+
+	for (i = 0; i < ATA_MAX_DEVICES; i++) {
+		if (!(present_mask & (1 << i)))
+			classes[i] = ATA_DEV_NONE;
 	}
 
-	return ata_std_prereset(ap);
+	return 0;
 }
 
 static void piix_sata_error_handler(struct ata_port *ap)
 {
-	ata_bmdma_drive_eh(ap, piix_sata_prereset, ata_std_softreset, NULL,
+	ata_bmdma_drive_eh(ap, ata_std_prereset, piix_sata_softreset, NULL,
 			   ata_std_postreset);
 }
 
