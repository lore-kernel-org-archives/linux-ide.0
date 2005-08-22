From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH libata:upstream] sil: apply M15W quirk selectively (take 2)
Date: Tue, 23 Aug 2005 07:27:25 +0900
Message-ID: <20050822222725.GA17359@htj.dyndns.org>
References: <1121894035.4885.15.camel@drevil.aslab.com> <20050728141242.GA10010@htj.dyndns.org> <4308D3D0.50504@pobox.com> <4308E7F4.3000509@gmail.com> <4308EDB5.6060102@pobox.com> <4308F5CD.7060001@gmail.com> <58cb370e05082203194cf1f424@mail.gmail.com> <20050822114639.GA26607@htj.dyndns.org> <430A2959.300@pobox.com> <20050822213912.GA13920@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.205]:64015 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751375AbVHVW1c (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Aug 2005 18:27:32 -0400
Received: by zproxy.gmail.com with SMTP id r28so789838nza
        for <linux-ide@vger.kernel.org>; Mon, 22 Aug 2005 15:27:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20050822213912.GA13920@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Michael Madore <Michael.Madore@aslab.com>, linux-ide@vger.kernel.org, albertcc@tw.ibm.com

 As SII reports that only original 3112's are affected by M15W quirk,
This patch adds SIL_FLAG_MOD15WRITE to selectively apply M15W quirk
depending on chipsets.  As of yet, we don't know exactly which PCI IDs
are for original 3112, so M15W quirk is applied to all except for 3512
and 3124.  Once more info is avaliable, we can change some of these
sil_3112_m15w's to sil_3112.

Signed-off-by: Tejun Heo <htejun@gmail.com>

diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
--- a/drivers/scsi/sata_sil.c
+++ b/drivers/scsi/sata_sil.c
@@ -41,8 +41,11 @@
 #define DRV_VERSION	"0.9"
 
 enum {
+	SIL_FLAG_MOD15WRITE	= (1 << 30),
+
 	sil_3112		= 0,
-	sil_3114		= 1,
+	sil_3112_m15w		= 1,
+	sil_3114		= 2,
 
 	SIL_FIFO_R0		= 0x40,
 	SIL_FIFO_W0		= 0x41,
@@ -76,13 +79,13 @@ static void sil_scr_write (struct ata_po
 static void sil_post_set_mode (struct ata_port *ap);
 
 static struct pci_device_id sil_pci_tbl[] = {
-	{ 0x1095, 0x3112, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112 },
-	{ 0x1095, 0x0240, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112 },
+	{ 0x1095, 0x3112, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112_m15w },
+	{ 0x1095, 0x0240, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112_m15w },
 	{ 0x1095, 0x3512, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112 },
 	{ 0x1095, 0x3114, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3114 },
-	{ 0x1002, 0x436e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112 },
-	{ 0x1002, 0x4379, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112 },
-	{ 0x1002, 0x437a, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112 },
+	{ 0x1002, 0x436e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112_m15w },
+	{ 0x1002, 0x4379, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112_m15w },
+	{ 0x1002, 0x437a, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112_m15w },
 	{ }	/* terminate list */
 };
 
@@ -174,6 +177,16 @@ static struct ata_port_info sil_port_inf
 		.mwdma_mask	= 0x07,			/* mwdma0-2 */
 		.udma_mask	= 0x3f,			/* udma0-5 */
 		.port_ops	= &sil_ops,
+	}, /* sil_3112_15w - keep it sync'd w/ sil_3112 */
+	{
+		.sht		= &sil_sht,
+		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
+				  ATA_FLAG_SRST | ATA_FLAG_MMIO |
+				  SIL_FLAG_MOD15WRITE,
+		.pio_mask	= 0x1f,			/* pio0-4 */
+		.mwdma_mask	= 0x07,			/* mwdma0-2 */
+		.udma_mask	= 0x3f,			/* udma0-5 */
+		.port_ops	= &sil_ops,
 	}, /* sil_3114 */
 	{
 		.sht		= &sil_sht,
@@ -331,7 +344,7 @@ static void sil_dev_config(struct ata_po
 		}
 
 	/* limit requests to 15 sectors */
-	if (quirks & SIL_QUIRK_MOD15WRITE) {
+	if (ap->flags & SIL_FLAG_MOD15WRITE && quirks & SIL_QUIRK_MOD15WRITE) {
 		printk(KERN_INFO "ata%u(%u): applying Seagate errata fix\n",
 		       ap->id, dev->devno);
 		ap->host->max_sectors = 15;
