From: "Eric D. Mudama" <edmudama@gmail.com>
Subject: Re: [PATCH 1/1] libata: rearrange dmesg info to add full ATA revision
Date: Tue, 30 Jan 2007 23:00:40 -0700
Message-ID: <20070131060040.GA3361@bounceswoosh.org>
References: <20070131021051.GA3403@bounceswoosh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.227]:26417 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932832AbXAaGCN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 31 Jan 2007 01:02:13 -0500
Received: by nz-out-0506.google.com with SMTP id s1so99232nze
        for <linux-ide@vger.kernel.org>; Tue, 30 Jan 2007 22:02:12 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20070131021051.GA3403@bounceswoosh.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org

Per Jeff's suggestion, this patch rearranges the info printed for ATA
drives into dmesg to add the full ATA firmware revision and model
information, while keeping the output to 2 lines.

Signed-off-by: Eric D. Mudama <edmudama@gmail.com>

---

This extra information is helpful for debugging drive-related issues
on ATA drives connected with libata, especially when the user can't
easily run hdparm.

Update: added Tejun's formatting requests, and created the constants
necessary.

Diff is against 2.6.20-rc6 (roughly).  Here's a snippet of my new
dmesg with this patch, showing the full and truncated firmware
revision information:

[   43.747027] scsi2 : ata_piix
[   43.911113] ata3.00: ATA-7: ST3250820AS, 3.AAC   ST325082, max UDMA/133
[   43.911155] ata3.00: 488395055 sectors, multi 16: LBA48 NCQ (depth 0/32)
[   43.919201] ata3.00: configured for UDMA/133
[   43.919241] scsi3 : ata_piix
[   44.084459] ata4.00: ATA-7: Maxtor 6V100E0, VA111910Maxtor 6, max UDMA/133
[   44.084502] ata4.00: 195813072 sectors, multi 16: LBA48 NCQ (depth 0/32)
[   44.096522] ata4.00: configured for UDMA/133
[   44.096638] scsi 2:0:0:0: Direct-Access     ATA      ST3250820AS      3.AA PQ: 0 ANSI: 5
[   44.097521] scsi 3:0:0:0: Direct-Access     ATA      Maxtor 6V100E0   VA11 PQ: 0 ANSI: 5


 drivers/ata/libata-core.c |   52 +++++++++++++++++++++++++++-------------------
 include/linux/ata.h       |    2 +
 2 files changed, 33 insertions(+), 21 deletions(-)


diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index a388a8d..f628dc5 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1607,6 +1607,8 @@ int ata_dev_configure(struct ata_device *dev)
 	const u16 *id = dev->id;
 	unsigned int xfer_mask;
 	char revbuf[7];		/* XYZ-99\0 */
+	char fwrevbuf[ATA_ID_FW_REV_LEN+1];
+	char modelbuf[ATA_ID_PROD_LEN+1];
 	int rc;
 
 	if (!ata_dev_enabled(dev) && ata_msg_info(ap)) {
@@ -1661,6 +1663,16 @@ int ata_dev_configure(struct ata_device *dev)
 
 		dev->n_sectors = ata_id_n_sectors(id);
 
+		/* SCSI only uses 4-char revisions, dump full 8 chars from ATA */
+		ata_id_c_string(dev->id, fwrevbuf, ATA_ID_FW_REV_OFS,
+				sizeof(fwrevbuf));
+
+		ata_id_c_string(dev->id, modelbuf, ATA_ID_PROD_OFS,
+				sizeof(modelbuf));
+
+		if (dev->id[59] & 0x100)
+			dev->multi_count = dev->id[59] & 0xff;
+
 		if (ata_id_has_lba(id)) {
 			const char *lba_desc;
 			char ncq_desc[20];
@@ -1680,13 +1692,16 @@ int ata_dev_configure(struct ata_device *dev)
 			ata_dev_config_ncq(dev, ncq_desc, sizeof(ncq_desc));
 
 			/* print device info to dmesg */
-			if (ata_msg_drv(ap) && print_info)
-				ata_dev_printk(dev, KERN_INFO, "%s, "
-					"max %s, %Lu sectors: %s %s\n",
-					revbuf,
-					ata_mode_string(xfer_mask),
+			if (ata_msg_drv(ap) && print_info) {
+				ata_dev_printk(dev, KERN_INFO,
+					"%s: %s, %s, max %s\n",
+					revbuf, modelbuf, fwrevbuf,
+					ata_mode_string(xfer_mask));
+				ata_dev_printk(dev, KERN_INFO,
+					"%Lu sectors, multi %u: %s %s\n",
 					(unsigned long long)dev->n_sectors,
-					lba_desc, ncq_desc);
+					dev->multi_count, lba_desc, ncq_desc);
+			}
 		} else {
 			/* CHS */
 
@@ -1703,22 +1718,17 @@ int ata_dev_configure(struct ata_device *dev)
 			}
 
 			/* print device info to dmesg */
-			if (ata_msg_drv(ap) && print_info)
-				ata_dev_printk(dev, KERN_INFO, "%s, "
-					"max %s, %Lu sectors: CHS %u/%u/%u\n",
-					revbuf,
-					ata_mode_string(xfer_mask),
-					(unsigned long long)dev->n_sectors,
-					dev->cylinders, dev->heads,
-					dev->sectors);
-		}
-
-		if (dev->id[59] & 0x100) {
-			dev->multi_count = dev->id[59] & 0xff;
-			if (ata_msg_drv(ap) && print_info)
+			if (ata_msg_drv(ap) && print_info) {
 				ata_dev_printk(dev, KERN_INFO,
-					"ata%u: dev %u multi count %u\n",
-					ap->id, dev->devno, dev->multi_count);
+					"%s: %s, %s, max %s\n",
+					revbuf,	modelbuf, fwrevbuf,
+					ata_mode_string(xfer_mask));
+				ata_dev_printk(dev, KERN_INFO, 
+					"%Lu sectors, multi %u, CHS %u/%u/%u\n",
+					(unsigned long long)dev->n_sectors,
+					dev->multi_count, dev->cylinders,
+					dev->heads, dev->sectors);
+			}
 		}
 
 		dev->cdb_len = 16;
diff --git a/include/linux/ata.h b/include/linux/ata.h
index 1df9416..aa9c1fd 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -60,6 +60,8 @@ enum {
 
 	ATA_PCI_CTL_OFS		= 2,
 	ATA_SERNO_LEN		= 20,
+	ATA_ID_PROD_LEN         = 40,
+	ATA_ID_FW_REV_LEN       = 16,
 	ATA_UDMA0		= (1 << 0),
 	ATA_UDMA1		= ATA_UDMA0 | (1 << 1),
 	ATA_UDMA2		= ATA_UDMA1 | (1 << 2),

