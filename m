From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 06/13] libata-hp: prepare for persistent device flags
Date: Tue, 11 Apr 2006 23:06:21 +0900
Message-ID: <11447643811744-git-send-email-htejun@gmail.com>
References: <11447643813451-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.226]:36020 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750835AbWDKOG1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 10:06:27 -0400
Received: by wproxy.gmail.com with SMTP id i11so930347wra
        for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 07:06:27 -0700 (PDT)
In-Reply-To: <11447643813451-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

This patch makes dev->flags persistent, defines ATA_DFLAG_INIT_MASK as
lower 16 bits of device flags and clear them in ata_dev_init().  So,
device flags in bits [0:15] are cleared over hotplugging while flags
from bit 16 upward are maintained.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    2 ++
 include/linux/libata.h     |    3 ++-
 2 files changed, 4 insertions(+), 1 deletions(-)

3a7b8630e4c5cc409562164a941b40bc2b6b8728
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 09e82f9..930f387 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1444,6 +1444,8 @@ err_out_nosup:
  */
 static void ata_dev_init(struct ata_port *ap, struct ata_device *dev)
 {
+	dev->flags &= ~ATA_DFLAG_INIT_MASK;
+
 	memset((void *)dev + ATA_DEVICE_CLEAR_OFFSET, 0,
 	       sizeof(*dev) - ATA_DEVICE_CLEAR_OFFSET);
 	dev->pio_mask = UINT_MAX;
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 809f3b9..33ce8a4 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -128,6 +128,7 @@ enum {
 
 	ATA_DFLAG_PIO		= (1 << 8), /* device currently in PIO mode */
 	ATA_DFLAG_FAILED	= (1 << 9), /* device has failed */
+	ATA_DFLAG_INIT_MASK	= (1 << 16) - 1,
 
 	ATA_DEV_UNKNOWN		= 0,	/* unknown device */
 	ATA_DEV_ATA		= 1,	/* ATA device */
@@ -396,9 +397,9 @@ struct ata_ering {
 
 struct ata_device {
 	unsigned int		devno;		/* 0 or 1 */
+	unsigned long		flags;		/* ATA_DFLAG_xxx */
 	/* fields above n_sectors are not cleared across device init */
 	u64			n_sectors;	/* size of device, if ATA */
-	unsigned long		flags;		/* ATA_DFLAG_xxx */
 	unsigned int		class;		/* ATA_DEV_xxx */
 	u16			*id;		/* IDENTIFY xxx DEVICE data */
 	u8			pio_mode;
-- 
1.2.4


