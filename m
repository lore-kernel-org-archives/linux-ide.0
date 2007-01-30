From: "Eric D. Mudama" <edmudama@gmail.com>
Subject: [PATCH 1/1] libata: dump full ATA firmware revision to dmesg
Date: Tue, 30 Jan 2007 13:35:34 -0700
Message-ID: <311601c90701301235l3026fa55oa9d6372b20963e39@mail.gmail.com>
References: <311601c90701301221o4cee44cat34547cf8891189ed@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:39300 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751391AbXA3Ufg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Jan 2007 15:35:36 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1643118uga
        for <linux-ide@vger.kernel.org>; Tue, 30 Jan 2007 12:35:35 -0800 (PST)
In-Reply-To: <311601c90701301221o4cee44cat34547cf8891189ed@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

SCSI only supports a 4-character firmware revision string, while ATA
uses 8 characters.  Record this firmware revision string into dmesg.

Signed-off-by: Eric D. Mudama <edmudama@gmail.com>

---

Patch is against 2.6.20-rc6 pull via GIT.  Resubmitting to (hopefully)
fix linewrap and bad formatting of the commit message.

This is useful for drive vendors debugging issues with ATA devices and
libata, since not everyone can easily run hdparm on their systems.

Sample output from my dmesg, showing the truncated firmware revisions:

ata1.00: ATA-7, max UDMA/133, 488395055 sectors: LBA48 NCQ (depth 0/32)
ata1.00: ata1: dev 0 multi count 16
ata1.00: ata1: Firmware Revision: 3.AAC
ata1.00: configured for UDMA/133
ata2.00: ATA-7, max UDMA/133, 195813072 sectors: LBA48 NCQ (depth 0/32)
ata2.00: ata2: dev 0 multi count 16
ata2.00: ata2: Firmware Revision: VA111910
ata2.00: configured for UDMA/133
scsi 0:0:0:0: Direct-Access     ATA      ST3250820AS      3.AA PQ: 0 ANSI: 5
scsi 1:0:0:0: Direct-Access     ATA      Maxtor 6V100E0   VA11 PQ: 0 ANSI: 5


diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index a388a8d..7dc4dad 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1607,6 +1607,7 @@ int ata_dev_configure(struct ata_device *dev)
       const u16 *id = dev->id;
       unsigned int xfer_mask;
       char revbuf[7];         /* XYZ-99\0 */
+       char fwrevbuf[9];
       int rc;

       if (!ata_dev_enabled(dev) && ata_msg_info(ap)) {
@@ -1721,6 +1722,16 @@ int ata_dev_configure(struct ata_device *dev)
                                       ap->id, dev->devno, dev->multi_count);
               }

+               if (ata_msg_drv(ap) && print_info) {
+                       /* SCSI only uses 4-char revisions, dump full
8 chars from ATA */
+                       ata_id_c_string(dev->id, fwrevbuf, ATA_ID_FW_REV_OFS,
+                                       sizeof(fwrevbuf));
+
+                       ata_dev_printk(dev, KERN_INFO,
+                                      "ata%u: Firmware Revision: %s\n",
+                                      ap->id, fwrevbuf);
+               }
+
               dev->cdb_len = 16;
       }
