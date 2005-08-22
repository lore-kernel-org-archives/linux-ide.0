From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH libata:upstream] sil: apply M15W quirk selectively
Date: Mon, 22 Aug 2005 20:46:39 +0900
Message-ID: <20050822114639.GA26607@htj.dyndns.org>
References: <1121894035.4885.15.camel@drevil.aslab.com> <20050728141242.GA10010@htj.dyndns.org> <4308D3D0.50504@pobox.com> <4308E7F4.3000509@gmail.com> <4308EDB5.6060102@pobox.com> <4308F5CD.7060001@gmail.com> <58cb370e05082203194cf1f424@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zeus1.kernel.org ([204.152.191.4]:57990 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751319AbVHVWMR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Aug 2005 18:12:17 -0400
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.194])
	by zeus1.kernel.org (8.13.1/8.13.1) with ESMTP id j7MBlvZs005878
	for <linux-ide@vger.kernel.org>; Mon, 22 Aug 2005 04:47:57 -0700
Received: by wproxy.gmail.com with SMTP id i2so984368wra
        for <linux-ide@vger.kernel.org>; Mon, 22 Aug 2005 04:46:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <58cb370e05082203194cf1f424@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Michael Madore <Michael.Madore@aslab.com>, linux-ide@vger.kernel.org, albertcc@tw.ibm.com

 Hello, Jeff & Bartlomiej & all.

> What about fixing 3114 for a start? :-)

 Yeap, why not?  Here it is.
--

 This patch adds chipset mask to sil_blacklist such that quirks can be
applied selectively depending on chipset.  And add sil_3112_m15w
chipset which is identical to sil_3112 except that mod15write quirk is
applied.  As we don't know which PCI IDs are affected yet, I've
changed all 3112's to sil_3112_m15w.  Later when we know which PCI IDs
are affected, we can just change them to sil_3112 later.


Signed-off-by: Tejun Heo <htejun@gmail.com>


diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
--- a/drivers/scsi/sata_sil.c
+++ b/drivers/scsi/sata_sil.c
@@ -41,8 +41,10 @@
 #define DRV_VERSION	"0.9"
 
 enum {
-	sil_3112		= 0,
-	sil_3114		= 1,
+	sil_3112_m15w		= (1 << 0),
+	sil_3112		= (1 << 1),
+	sil_3114		= (1 << 2),
+	sil_all			= 0xffffffff,
 
 	SIL_FIFO_R0		= 0x40,
 	SIL_FIFO_W0		= 0x41,
@@ -76,38 +78,39 @@ static void sil_scr_write (struct ata_po
 static void sil_post_set_mode (struct ata_port *ap);
 
 static struct pci_device_id sil_pci_tbl[] = {
-	{ 0x1095, 0x3112, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112 },
-	{ 0x1095, 0x0240, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112 },
-	{ 0x1095, 0x3512, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112 },
+	{ 0x1095, 0x3112, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112_m15w },
+	{ 0x1095, 0x0240, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112_m15w },
+	{ 0x1095, 0x3512, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112_m15w },
 	{ 0x1095, 0x3114, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3114 },
-	{ 0x1002, 0x436e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112 },
-	{ 0x1002, 0x4379, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112 },
-	{ 0x1002, 0x437a, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112 },
+	{ 0x1002, 0x436e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112_m15w },
+	{ 0x1002, 0x4379, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112_m15w },
+	{ 0x1002, 0x437a, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sil_3112_m15w },
 	{ }	/* terminate list */
 };
 
 
 /* TODO firmware versions should be added - eric */
-static const struct sil_drivelist {
-	const char * product;
+static const struct sil_blacklist {
+	int chipmask;
+	const char * drive;
 	unsigned int quirk;
 } sil_blacklist [] = {
-	{ "ST320012AS",		SIL_QUIRK_MOD15WRITE },
-	{ "ST330013AS",		SIL_QUIRK_MOD15WRITE },
-	{ "ST340017AS",		SIL_QUIRK_MOD15WRITE },
-	{ "ST360015AS",		SIL_QUIRK_MOD15WRITE },
-	{ "ST380013AS",		SIL_QUIRK_MOD15WRITE },
-	{ "ST380023AS",		SIL_QUIRK_MOD15WRITE },
-	{ "ST3120023AS",	SIL_QUIRK_MOD15WRITE },
-	{ "ST3160023AS",	SIL_QUIRK_MOD15WRITE },
-	{ "ST3120026AS",	SIL_QUIRK_MOD15WRITE },
-	{ "ST3200822AS",	SIL_QUIRK_MOD15WRITE },
-	{ "ST340014ASL",	SIL_QUIRK_MOD15WRITE },
-	{ "ST360014ASL",	SIL_QUIRK_MOD15WRITE },
-	{ "ST380011ASL",	SIL_QUIRK_MOD15WRITE },
-	{ "ST3120022ASL",	SIL_QUIRK_MOD15WRITE },
-	{ "ST3160021ASL",	SIL_QUIRK_MOD15WRITE },
-	{ "Maxtor 4D060H3",	SIL_QUIRK_UDMA5MAX },
+	{ sil_3112_m15w, "ST320012AS",		SIL_QUIRK_MOD15WRITE },
+	{ sil_3112_m15w, "ST330013AS",		SIL_QUIRK_MOD15WRITE },
+	{ sil_3112_m15w, "ST340017AS",		SIL_QUIRK_MOD15WRITE },
+	{ sil_3112_m15w, "ST360015AS",		SIL_QUIRK_MOD15WRITE },
+	{ sil_3112_m15w, "ST380013AS",		SIL_QUIRK_MOD15WRITE },
+	{ sil_3112_m15w, "ST380023AS",		SIL_QUIRK_MOD15WRITE },
+	{ sil_3112_m15w, "ST3120023AS",		SIL_QUIRK_MOD15WRITE },
+	{ sil_3112_m15w, "ST3160023AS",		SIL_QUIRK_MOD15WRITE },
+	{ sil_3112_m15w, "ST3120026AS",		SIL_QUIRK_MOD15WRITE },
+	{ sil_3112_m15w, "ST3200822AS",		SIL_QUIRK_MOD15WRITE },
+	{ sil_3112_m15w, "ST340014ASL",		SIL_QUIRK_MOD15WRITE },
+	{ sil_3112_m15w, "ST360014ASL",		SIL_QUIRK_MOD15WRITE },
+	{ sil_3112_m15w, "ST380011ASL",		SIL_QUIRK_MOD15WRITE },
+	{ sil_3112_m15w, "ST3120022ASL",	SIL_QUIRK_MOD15WRITE },
+	{ sil_3112_m15w, "ST3160021ASL",	SIL_QUIRK_MOD15WRITE },
+	{ sil_all,	 "Maxtor 4D060H3",	SIL_QUIRK_UDMA5MAX },
 	{ }
 };
 
@@ -165,7 +168,16 @@ static struct ata_port_operations sil_op
 };
 
 static struct ata_port_info sil_port_info[] = {
-	/* sil_3112 */
+	/* sil_3112_m15w, keep it sync'd w/ sil_3112 */
+	{
+		.sht		= &sil_sht,
+		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
+				  ATA_FLAG_SRST | ATA_FLAG_MMIO,
+		.pio_mask	= 0x1f,			/* pio0-4 */
+		.mwdma_mask	= 0x07,			/* mwdma0-2 */
+		.udma_mask	= 0x3f,			/* udma0-5 */
+		.port_ops	= &sil_ops,
+	}, /* sil_3112 */
 	{
 		.sht		= &sil_sht,
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
@@ -309,6 +321,7 @@ static void sil_scr_write (struct ata_po
  */
 static void sil_dev_config(struct ata_port *ap, struct ata_device *dev)
 {
+	int chip = (int)ap->host_set->private_data;
 	unsigned int n, quirks = 0;
 	unsigned char model_num[40];
 	const char *s;
@@ -323,9 +336,10 @@ static void sil_dev_config(struct ata_po
 	while ((len > 0) && (s[len - 1] == ' '))
 		len--;
 
-	for (n = 0; sil_blacklist[n].product; n++)
-		if (!memcmp(sil_blacklist[n].product, s,
-			    strlen(sil_blacklist[n].product))) {
+	for (n = 0; sil_blacklist[n].drive; n++)
+		if ((sil_blacklist[n].chipmask & chip) &&
+		    !memcmp(sil_blacklist[n].drive, s,
+			    strlen(sil_blacklist[n].drive))) {
 			quirks = sil_blacklist[n].quirk;
 			break;
 		}
@@ -403,6 +417,7 @@ static int sil_init_one (struct pci_dev 
        	probe_ent->irq = pdev->irq;
        	probe_ent->irq_flags = SA_SHIRQ;
 	probe_ent->host_flags = sil_port_info[ent->driver_data].host_flags;
+	probe_ent->private_data = (void *)ent->driver_data;
 
 	mmio_base = ioremap(pci_resource_start(pdev, 5),
 		            pci_resource_len(pdev, 5));
