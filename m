From: "Eric D. Mudama" <edmudama@gmail.com>
Subject: [PATCH 1/1] libata: rearrange dmesg info to add full ATA revision
Date: Tue, 30 Jan 2007 19:10:51 -0700
Message-ID: <20070131021051.GA3403@bounceswoosh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.239]:36304 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932510AbXAaDDM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Jan 2007 22:03:12 -0500
Received: by nz-out-0506.google.com with SMTP id s1so65711nze
        for <linux-ide@vger.kernel.org>; Tue, 30 Jan 2007 19:03:12 -0800 (PST)
Received: from edmudama by localhost.localdomain with local (Exim 4.63)
	(envelope-from <edmudama@lithium.foomancer.com>)
	id 1HC5jF-0001RW-98
	for linux-ide@vger.kernel.org; Tue, 30 Jan 2007 20:01:45 -0700
Content-Disposition: inline
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

Diff is against 2.6.20-rc6 (roughly).

Here's a snippet of my new dmesg with this patch, showing the full and
truncated firmware revision information:

[   44.559351] ata3: SATA max UDMA/133 cmd 0xB400 ctl 0xB802 bmdma 0xC400 irq 19
[   44.559407] ata4: SATA max UDMA/133 cmd 0xBC00 ctl 0xC002 bmdma 0xC408 irq 19
[   44.559450] scsi2 : ata_piix
[   44.723970] ata3.00: ATA-7: ST3250820AS, 3.AAC, max UDMA/133
[   44.724012] ata3.00: 488395055 sectors, multi 16: LBA48 NCQ (depth 0/32)
[   44.732057] ata3.00: configured for UDMA/133
[   44.732099] scsi3 : ata_piix
[   44.897435] ata4.00: ATA-7: Maxtor 6V100E0, VA111910, max UDMA/133
[   44.897476] ata4.00: 195813072 sectors, multi 16: LBA48 NCQ (depth 0/32)
[   44.909506] ata4.00: configured for UDMA/133
[   44.909618] scsi 2:0:0:0: Direct-Access     ATA      ST3250820AS      3.AA PQ: 0 ANSI: 5
[   44.910500] scsi 3:0:0:0: Direct-Access     ATA      Maxtor 6V100E0   VA11 PQ: 0 ANSI: 5


 libata-core.c |   46 ++++++++++++++++++++++++++++++----------------
 1 file changed, 30 insertions(+), 16 deletions(-)


diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index a388a8d..b8f7223 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1607,6 +1607,8 @@ int ata_dev_configure(struct ata_device *dev)
 	const u16 *id = dev->id;
 	unsigned int xfer_mask;
 	char revbuf[7];		/* XYZ-99\0 */
+	char fwrevbuf[9];
+	char modelbuf[41];
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
@@ -1680,13 +1692,18 @@ int ata_dev_configure(struct ata_device *dev)
 			ata_dev_config_ncq(dev, ncq_desc, sizeof(ncq_desc));
 
 			/* print device info to dmesg */
-			if (ata_msg_drv(ap) && print_info)
-				ata_dev_printk(dev, KERN_INFO, "%s, "
-					"max %s, %Lu sectors: %s %s\n",
+			if (ata_msg_drv(ap) && print_info) {
+				ata_dev_printk(dev, KERN_INFO,
+					"%s: %s, %s, max %s\n",
 					revbuf,
-					ata_mode_string(xfer_mask),
+					modelbuf, fwrevbuf,
+					ata_mode_string(xfer_mask));
+				ata_dev_printk(dev, KERN_INFO,
+					"%Lu sectors, multi %u: %s %s\n",
 					(unsigned long long)dev->n_sectors,
+					dev->multi_count,
 					lba_desc, ncq_desc);
+			}
 		} else {
 			/* CHS */
 
@@ -1703,22 +1720,19 @@ int ata_dev_configure(struct ata_device *dev)
 			}
 
 			/* print device info to dmesg */
-			if (ata_msg_drv(ap) && print_info)
-				ata_dev_printk(dev, KERN_INFO, "%s, "
-					"max %s, %Lu sectors: CHS %u/%u/%u\n",
+			if (ata_msg_drv(ap) && print_info) {
+				ata_dev_printk(dev, KERN_INFO,
+					"%s: %s, %s, max %s\n",
 					revbuf,
-					ata_mode_string(xfer_mask),
+					modelbuf, fwrevbuf,
+					ata_mode_string(xfer_mask));
+				ata_dev_printk(dev, KERN_INFO, 
+					"%Lu sectors, multi %u, CHS %u/%u/%u\n",
 					(unsigned long long)dev->n_sectors,
+					dev->multi_count,
 					dev->cylinders, dev->heads,
 					dev->sectors);
-		}
-
-		if (dev->id[59] & 0x100) {
-			dev->multi_count = dev->id[59] & 0xff;
-			if (ata_msg_drv(ap) && print_info)
-				ata_dev_printk(dev, KERN_INFO,
-					"ata%u: dev %u multi count %u\n",
-					ap->id, dev->devno, dev->multi_count);
+			}
 		}
 
 		dev->cdb_len = 16;

