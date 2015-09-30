From: Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH v2] ata: ahci: find eSATA ports and flag them as removable
Date: Wed, 30 Sep 2015 21:10:25 +0200
Message-ID: <1443640225-11860-1-git-send-email-manuel.lauss@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:38689 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932872AbbI3TKc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 Sep 2015 15:10:32 -0400
Received: by wiclk2 with SMTP id lk2so76279990wic.1
        for <linux-ide@vger.kernel.org>; Wed, 30 Sep 2015 12:10:31 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Manuel Lauss <manuel.lauss@gmail.com>

If the AHCI ports' HPCP or ESP bits are set, the port
should be considered external (e.g. eSATA) and is marked
as removable.  Userspace tools like udisks then treat it
like an usb drive.

With this patch applied, when I plug a drive into the esata port,
KDE pops up a window asking what to do with the drives(s), just
like it does for any random USB stick.

Removability is indicated to the upper layers by way of the
SCSI RMB bit, as I haven't found another way to signal
userspace to treat a sata disk like any usb stick.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
 drivers/ata/ahci.h        | 2 ++
 drivers/ata/libahci.c     | 7 +++++++
 drivers/ata/libata-scsi.c | 7 +++++--
 include/linux/libata.h    | 1 +
 4 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 5b8e8a0..45586c1 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -181,6 +181,8 @@ enum {
 	PORT_CMD_ALPE		= (1 << 26), /* Aggressive Link PM enable */
 	PORT_CMD_ATAPI		= (1 << 24), /* Device is ATAPI */
 	PORT_CMD_FBSCP		= (1 << 22), /* FBS Capable Port */
+	PORT_CMD_ESP		= (1 << 21), /* External Sata Port */
+	PORT_CMD_HPCP		= (1 << 18), /* HotPlug Capable Port */
 	PORT_CMD_PMP		= (1 << 17), /* PMP attached */
 	PORT_CMD_LIST_ON	= (1 << 15), /* cmd list DMA engine running */
 	PORT_CMD_FIS_ON		= (1 << 14), /* FIS DMA engine running */
diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index d256a66..2fa551a 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -1117,6 +1117,7 @@ static void ahci_port_init(struct device *dev, struct ata_port *ap,
 			   int port_no, void __iomem *mmio,
 			   void __iomem *port_mmio)
 {
+	struct ahci_host_priv *hpriv = ap->host->private_data;
 	const char *emsg = NULL;
 	int rc;
 	u32 tmp;
@@ -1138,6 +1139,12 @@ static void ahci_port_init(struct device *dev, struct ata_port *ap,
 		writel(tmp, port_mmio + PORT_IRQ_STAT);
 
 	writel(1 << port_no, mmio + HOST_IRQ_STAT);
+
+	/* mark esata ports */
+	tmp = readl(port_mmio + PORT_CMD);
+	if ((tmp & PORT_CMD_HPCP) ||
+	    ((tmp & PORT_CMD_ESP) && (hpriv->cap & HOST_CAP_SXS)))
+		ap->pflags |= ATA_PFLAG_EXTERNAL;
 }
 
 void ahci_init_controller(struct ata_host *host)
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 0d7f0da..183a57b 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2015,8 +2015,11 @@ static unsigned int ata_scsiop_inq_std(struct ata_scsi_args *args, u8 *rbuf)
 
 	VPRINTK("ENTER\n");
 
-	/* set scsi removable (RMB) bit per ata bit */
-	if (ata_id_removable(args->id))
+	/* set scsi removable (RMB) bit per ata bit, or if the
+	 * AHCI port says it's external (Hotplug-capable, eSATA).
+	 */
+	if (ata_id_removable(args->id) ||
+	    (args->dev->link->ap->pflags & ATA_PFLAG_EXTERNAL))
 		hdr[1] |= (1 << 7);
 
 	if (args->dev->class == ATA_DEV_ZAC) {
diff --git a/include/linux/libata.h b/include/linux/libata.h
index c9cfbcd..83577f8 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -254,6 +254,7 @@ enum {
 
 	ATA_PFLAG_PIO32		= (1 << 20),  /* 32bit PIO */
 	ATA_PFLAG_PIO32CHANGE	= (1 << 21),  /* 32bit PIO can be turned on/off */
+	ATA_PFLAG_EXTERNAL	= (1 << 22),  /* eSATA/external port */
 
 	/* struct ata_queued_cmd flags */
 	ATA_QCFLAG_ACTIVE	= (1 << 0), /* cmd not yet ack'd to scsi lyer */
-- 
2.5.3

