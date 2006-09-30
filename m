From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 5/6] ata_piix: apply device detection via polling IDENTIFY
Date: Sat, 30 Sep 2006 15:46:50 +0900
Message-ID: <1159598810227-git-send-email-htejun@gmail.com>
References: <11595988092938-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.185]:42834 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751093AbWI3GrF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 30 Sep 2006 02:47:05 -0400
Received: by nf-out-0910.google.com with SMTP id o25so1150186nfa
        for <linux-ide@vger.kernel.org>; Fri, 29 Sep 2006 23:47:05 -0700 (PDT)
In-Reply-To: <11595988092938-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: nabiki@teleline.es, kaos@ocs.com.au, stevenm@umd.edu, jfs@keytradebank.com, 0602@eq.cz, jgarzik@pobox.com, akpm@osdl.org, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

PATA PIIX uses reset signature + TF r/w test for device presence
detection, which doesn't always work.  It sometimes reports phantom
device which results in IDENTIFY timeouts.

SATA PIIX uses some combination of PCS + reset signature + TF r/w test
for device presence detection.  No combination satifies all and for
some controllers, there doesn't seem to be any combination which
works reliably.

This patch makes both PATA and SATA piix's use reset signature + TF
r/w + polling IDENTIFY for device detection.  This is what the old
libata (before irq-pio and new EH) did and what IDE does.

This patch also removes now obsolete PIIX_FLAG_IGNORE_PCS, force_pcs
and related code.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ata_piix.c |  104 +++---------------------------------------------
 1 files changed, 6 insertions(+), 98 deletions(-)

diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index cdb99dc..a92c798 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -101,13 +101,13 @@ enum {
 	ICH5_PCS		= 0x92,	/* port control and status */
 	PIIX_SCC		= 0x0A, /* sub-class code register */
 
-	PIIX_FLAG_IGNORE_PCS	= (1 << 25), /* ignore PCS present bits */
 	PIIX_FLAG_SCR		= (1 << 26), /* SCR available */
 	PIIX_FLAG_AHCI		= (1 << 27), /* AHCI possible */
 	PIIX_FLAG_CHECKINTR	= (1 << 28), /* make sure PCI INTx enabled */
 
-	PIIX_PATA_FLAGS		= ATA_FLAG_SLAVE_POSS,
-	PIIX_SATA_FLAGS		= ATA_FLAG_SATA | PIIX_FLAG_CHECKINTR,
+	PIIX_PATA_FLAGS		= ATA_FLAG_SLAVE_POSS | ATA_FLAG_DETECT_POLLING,
+	PIIX_SATA_FLAGS		= ATA_FLAG_SATA | PIIX_FLAG_CHECKINTR |
+				  ATA_FLAG_DETECT_POLLING,
 
 	/* combined mode.  if set, PATA is channel 0.
 	 * if clear, PATA is channel 1.
@@ -505,7 +505,7 @@ static struct ata_port_info piix_port_in
 	/* ich5_sata: 5 */
 	{
 		.sht		= &piix_sht,
-		.flags		= PIIX_SATA_FLAGS | PIIX_FLAG_IGNORE_PCS,
+		.flags		= PIIX_SATA_FLAGS,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f,	/* udma0-6 */
@@ -515,7 +515,7 @@ static struct ata_port_info piix_port_in
 	/* i6300esb_sata: 6 */
 	{
 		.sht		= &piix_sht,
-		.flags		= PIIX_SATA_FLAGS | PIIX_FLAG_IGNORE_PCS,
+		.flags		= PIIX_SATA_FLAGS,
 		.pio_mask	= 0x1f,	/* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f,	/* udma0-6 */
@@ -589,11 +589,6 @@ MODULE_LICENSE("GPL");
 MODULE_DEVICE_TABLE(pci, piix_pci_tbl);
 MODULE_VERSION(DRV_VERSION);
 
-static int force_pcs = 0;
-module_param(force_pcs, int, 0444);
-MODULE_PARM_DESC(force_pcs, "force honoring or ignoring PCS to work around "
-		 "device mis-detection (0=default, 1=ignore PCS, 2=honor PCS)");
-
 /**
  *	piix_pata_cbl_detect - Probe host controller cable detect info
  *	@ap: Port for which cable detect info is desired
@@ -682,84 +677,9 @@ static void ich_pata_error_handler(struc
 			   ata_std_postreset);
 }
 
-/**
- *	piix_sata_present_mask - determine present mask for SATA host controller
- *	@ap: Target port
- *
- *	Reads SATA PCI device's PCI config register Port Configuration
- *	and Status (PCS) to determine port and device availability.
- *
- *	LOCKING:
- *	None (inherited from caller).
- *
- *	RETURNS:
- *	determined present_mask
- */
-static unsigned int piix_sata_present_mask(struct ata_port *ap)
-{
-	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
-	struct piix_host_priv *hpriv = ap->host->private_data;
-	const unsigned int *map = hpriv->map;
-	int base = 2 * ap->port_no;
-	unsigned int present_mask = 0;
-	int port, i;
-	u16 pcs;
-
-	pci_read_config_word(pdev, ICH5_PCS, &pcs);
-	DPRINTK("ata%u: ENTER, pcs=0x%x base=%d\n", ap->id, pcs, base);
-
-	for (i = 0; i < 2; i++) {
-		port = map[base + i];
-		if (port < 0)
-			continue;
-		if ((ap->flags & PIIX_FLAG_IGNORE_PCS) ||
-		    (pcs & 1 << (hpriv->map_db->present_shift + port)))
-			present_mask |= 1 << i;
-	}
-
-	DPRINTK("ata%u: LEAVE, pcs=0x%x present_mask=0x%x\n",
-		ap->id, pcs, present_mask);
-
-	return present_mask;
-}
-
-/**
- *	piix_sata_softreset - reset SATA host port via ATA SRST
- *	@ap: port to reset
- *	@classes: resulting classes of attached devices
- *
- *	Reset SATA host port via ATA SRST.  On controllers with
- *	reliable PCS present bits, the bits are used to determine
- *	device presence.
- *
- *	LOCKING:
- *	Kernel thread context (may sleep)
- *
- *	RETURNS:
- *	0 on success, -errno otherwise.
- */
-static int piix_sata_softreset(struct ata_port *ap, unsigned int *classes)
-{
-	unsigned int present_mask;
-	int i, rc;
-
-	present_mask = piix_sata_present_mask(ap);
-
-	rc = ata_std_softreset(ap, classes);
-	if (rc)
-		return rc;
-
-	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		if (!(present_mask & (1 << i)))
-			classes[i] = ATA_DEV_NONE;
-	}
-
-	return 0;
-}
-
 static void piix_sata_error_handler(struct ata_port *ap)
 {
-	ata_bmdma_drive_eh(ap, ata_std_prereset, piix_sata_softreset, NULL,
+	ata_bmdma_drive_eh(ap, ata_std_prereset, ata_std_softreset, NULL,
 			   ata_std_postreset);
 }
 
@@ -1074,18 +994,6 @@ static void __devinit piix_init_pcs(stru
 		pci_write_config_word(pdev, ICH5_PCS, new_pcs);
 		msleep(150);
 	}
-
-	if (force_pcs == 1) {
-		dev_printk(KERN_INFO, &pdev->dev,
-			   "force ignoring PCS (0x%x)\n", new_pcs);
-		pinfo[0].flags |= PIIX_FLAG_IGNORE_PCS;
-		pinfo[1].flags |= PIIX_FLAG_IGNORE_PCS;
-	} else if (force_pcs == 2) {
-		dev_printk(KERN_INFO, &pdev->dev,
-			   "force honoring PCS (0x%x)\n", new_pcs);
-		pinfo[0].flags &= ~PIIX_FLAG_IGNORE_PCS;
-		pinfo[1].flags &= ~PIIX_FLAG_IGNORE_PCS;
-	}
 }
 
 static void __devinit piix_init_sata_map(struct pci_dev *pdev,
-- 
1.4.2.1


