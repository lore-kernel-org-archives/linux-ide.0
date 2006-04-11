From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 04/13] libata-hp: make some fields of ata_device persistent
Date: Tue, 11 Apr 2006 23:06:21 +0900
Message-ID: <1144764381944-git-send-email-htejun@gmail.com>
References: <11447643813451-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.226]:36020 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750824AbWDKOGY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 10:06:24 -0400
Received: by wproxy.gmail.com with SMTP id i11so930347wra
        for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 07:06:24 -0700 (PDT)
In-Reply-To: <11447643813451-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Lifetimes of some fields span over device plugging/unplugging.  This
patch moves such persistent fields to the top of ata_device and
separate them with ATA_DEVICE_CLEAR_OFFSET.  Fields above the offset
are initialized once during host initializatino while all other fields
are cleared before hotplugging.  Currently only dev->devno is
persistent.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    2 +-
 include/linux/libata.h     |    5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

9160b11ebb15ef4f9501a1aba807ed221ef713ed
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 1378b6f..3406f3d 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1446,7 +1446,6 @@ static void ata_dev_init(struct ata_port
 {
 	memset((void *)dev + ATA_DEVICE_CLEAR_OFFSET, 0,
 	       sizeof(*dev) - ATA_DEVICE_CLEAR_OFFSET);
-	dev->devno = dev - ap->device;
 	dev->pio_mask = UINT_MAX;
 	dev->mwdma_mask = UINT_MAX;
 	dev->udma_mask = UINT_MAX;
@@ -4885,6 +4884,7 @@ static void ata_host_init(struct ata_por
 
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
 		struct ata_device *dev = &ap->device[i];
+		dev->devno = i;
 		ata_dev_init(ap, dev);
 	}
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index e86d63c..809f3b9 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -395,10 +395,11 @@ struct ata_ering {
 	struct ata_ering_entry	name_entries[size];
 
 struct ata_device {
+	unsigned int		devno;		/* 0 or 1 */
+	/* fields above n_sectors are not cleared across device init */
 	u64			n_sectors;	/* size of device, if ATA */
 	unsigned long		flags;		/* ATA_DFLAG_xxx */
 	unsigned int		class;		/* ATA_DEV_xxx */
-	unsigned int		devno;		/* 0 or 1 */
 	u16			*id;		/* IDENTIFY xxx DEVICE data */
 	u8			pio_mode;
 	u8			dma_mode;
@@ -423,6 +424,8 @@ struct ata_device {
 	DEFINE_ATA_ERING	(ering, ATA_DEV_ERING_SIZE);
 };
 
+#define ATA_DEVICE_CLEAR_OFFSET		offsetof(struct ata_device, n_sectors)
+
 struct ata_port {
 	struct Scsi_Host	*host;	/* our co-allocated scsi host */
 	const struct ata_port_operations *ops;
-- 
1.2.4


