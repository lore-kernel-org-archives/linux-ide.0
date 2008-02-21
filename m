From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: automatically use DMADIR if drive/bridge requires
 it
Date: Thu, 21 Feb 2008 13:25:50 +0900
Message-ID: <47BCFD4E.4070100@gmail.com>
References: <47B9D64C.3000705@rtr.ca> <47B9F05A.1060207@rtr.ca> <47BC6100.9020906@pobox.com> <47BC7727.1090508@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.190]:30778 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754384AbYBUEZ6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 20 Feb 2008 23:25:58 -0500
Received: by rv-out-0910.google.com with SMTP id k20so2118861rvb.1
        for <linux-ide@vger.kernel.org>; Wed, 20 Feb 2008 20:25:57 -0800 (PST)
In-Reply-To: <47BC7727.1090508@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, Albert Lee <albertcc@tw.ibm.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@redhat.com>

Back in 2.6.17-rc2, a libata module parameter was added for atapi_dmadir.

That's nice, but most SATA devices which need it will tell us about it
in their IDENTIFY PACKET response, as bit-15 of word-62 of the
returned data (as per ATA7, ATA8 specifications).

So for those which specify it, we should automatically use the DMADIR bit.
Otherwise, disc writing will fail by default on many SATA-ATAPI drives.

This patch adds ATA_DFLAG_DMADIR and make ata_dev_configure() set it
if atapi_dmadir is set or identify data indicates DMADIR is necessary.
atapi_xlat() is converted to check ATA_DFLAG_DMADIR before setting
DMADIR.

Original patch is from Mark Lord.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Mark Lord <mlord@pobox.com>
---
I don't have a bridge which sets DMADIR but so only checked atapi_dmadir
parameter.  Thanks.

 drivers/ata/libata-core.c |   11 +++++++++--
 drivers/ata/libata-scsi.c |    3 ++-
 include/linux/ata.h       |    5 +++++
 include/linux/libata.h    |    1 +
 4 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 3011919..d38f113 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2200,6 +2200,7 @@ int ata_dev_configure(struct ata_device *dev)
 	else if (dev->class == ATA_DEV_ATAPI) {
 		const char *cdb_intr_string = "";
 		const char *atapi_an_string = "";
+		const char *dma_dir_string = "";
 		u32 sntf;
 
 		rc = atapi_cdb_len(id);
@@ -2240,13 +2241,19 @@ int ata_dev_configure(struct ata_device *dev)
 			cdb_intr_string = ", CDB intr";
 		}
 
+		if (atapi_dmadir || atapi_id_dmadir(dev->id)) {
+			dev->flags |= ATA_DFLAG_DMADIR;
+			dma_dir_string = ", DMADIR";
+		}
+
 		/* print device info to dmesg */
 		if (ata_msg_drv(ap) && print_info)
 			ata_dev_printk(dev, KERN_INFO,
-				       "ATAPI: %s, %s, max %s%s%s\n",
+				       "ATAPI: %s, %s, max %s%s%s%s\n",
 				       modelbuf, fwrevbuf,
 				       ata_mode_string(xfer_mask),
-				       cdb_intr_string, atapi_an_string);
+				       cdb_intr_string, atapi_an_string,
+				       dma_dir_string);
 	}
 
 	/* determine max_sectors */
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index c02c490..f50b96b 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2543,7 +2543,8 @@ static unsigned int atapi_xlat(struct ata_queued_cmd *qc)
 		qc->tf.protocol = ATAPI_PROT_DMA;
 		qc->tf.feature |= ATAPI_PKT_DMA;
 
-		if (atapi_dmadir && (scmd->sc_data_direction != DMA_TO_DEVICE))
+		if ((dev->flags & ATA_DFLAG_DMADIR) &&
+		    (scmd->sc_data_direction != DMA_TO_DEVICE))
 			/* some SATA bridges need us to indicate data xfer direction */
 			qc->tf.feature |= ATAPI_DMADIR;
 	}
diff --git a/include/linux/ata.h b/include/linux/ata.h
index 78bbaca..1c622e2 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -659,6 +659,11 @@ static inline int atapi_command_packet_set(const u16 *dev_id)
 	return (dev_id[0] >> 8) & 0x1f;
 }
 
+static inline int atapi_id_dmadir(const u16 *dev_id)
+{
+	return ata_id_major_version(dev_id) >= 7 && (dev_id[62] & 0x8000);
+}
+
 static inline int is_multi_taskfile(struct ata_taskfile *tf)
 {
 	return (tf->command == ATA_CMD_READ_MULTI) ||
diff --git a/include/linux/libata.h b/include/linux/libata.h
index bc5a8d0..b942e90 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -138,6 +138,7 @@ enum {
 	ATA_DFLAG_AN		= (1 << 7), /* AN configured */
 	ATA_DFLAG_HIPM		= (1 << 8), /* device supports HIPM */
 	ATA_DFLAG_DIPM		= (1 << 9), /* device supports DIPM */
+	ATA_DFLAG_DMADIR	= (1 << 10), /* device requires DMADIR */
 	ATA_DFLAG_CFG_MASK	= (1 << 12) - 1,
 
 	ATA_DFLAG_PIO		= (1 << 12), /* device limited to PIO mode */
