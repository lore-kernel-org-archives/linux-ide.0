From: Manuel Lauss <manuel.lauss@gmail.com>
Subject: [RFC PATCH] ata: ahci: find eSATA ports and flag them as removable
Date: Fri, 25 Sep 2015 13:05:01 +0200
Message-ID: <1443179101-9870-1-git-send-email-manuel.lauss@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:35787 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753897AbbIYLFI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 25 Sep 2015 07:05:08 -0400
Received: by wicge5 with SMTP id ge5so15600588wic.0
        for <linux-ide@vger.kernel.org>; Fri, 25 Sep 2015 04:05:06 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linux-IDE <linux-ide@vger.kernel.org>
Cc: Manuel Lauss <manuel.lauss@gmail.com>

If the AHCI ports' HPCP or ESP bits are set, the port
should be considered external (e.g. eSATA) and is marked
as removable.  Userspace tools like udisks then treat it
like an usb drive.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
--
This is a crude hack, but works fine on my laptop. If I plug something in
on the eSATA port, KDE pops up a windows asking me what to do with the
new drive(s), just like it does for any random usb stick.

I didn't know how else to communicate to userspace that the drive is
removable other than adding it to the removable-bit-test of ATA IDENTIFY data.

 drivers/ata/ahci.h        | 2 ++
 drivers/ata/libahci.c     | 6 ++++++
 drivers/ata/libata-scsi.c | 7 +++++--
 include/linux/libata.h    | 1 +
 4 files changed, 14 insertions(+), 2 deletions(-)

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
index d256a66..209c3c6 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -1469,6 +1469,7 @@ static int ahci_hardreset(struct ata_link *link, unsigned int *class,
 static void ahci_postreset(struct ata_link *link, unsigned int *class)
 {
 	struct ata_port *ap = link->ap;
+	struct ahci_host_priv *hpriv = ap->host->private_data;
 	void __iomem *port_mmio = ahci_port_base(ap);
 	u32 new_tmp, tmp;
 
@@ -1484,6 +1485,11 @@ static void ahci_postreset(struct ata_link *link, unsigned int *class)
 		writel(new_tmp, port_mmio + PORT_CMD);
 		readl(port_mmio + PORT_CMD); /* flush */
 	}
+
+	/* mark esata ports */
+	if ((tmp & PORT_CMD_HPCP) ||
+	    ((tmp & PORT_CMD_ESP) && (hpriv->cap & HOST_CAP_SXS)))
+		ap->pflags |= ATA_PFLAG_EXTERNAL;
 }
 
 static unsigned int ahci_fill_sg(struct ata_queued_cmd *qc, void *cmd_tbl)
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

