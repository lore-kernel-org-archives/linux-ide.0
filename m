From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 03/11] libata-eh: add per-dev ata_ering
Date: Thu, 11 May 2006 22:21:27 +0900
Message-ID: <11473536873222-git-send-email-htejun@gmail.com>
References: <11473536873966-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0102.google.com ([66.249.82.206]:45348 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751699AbWEKNVd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 09:21:33 -0400
Received: by wx-out-0102.google.com with SMTP id t5so1388wxc
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 06:21:32 -0700 (PDT)
In-Reply-To: <11473536873966-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

EH is gonna record errors per-dev.  Define per-dev ata_ering.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    1 +
 include/linux/libata.h     |    4 ++++
 2 files changed, 5 insertions(+), 0 deletions(-)

17d6991533312fcce8cb213ddabd164af7e9f88e
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index a05be86..afb7796 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -4871,6 +4871,7 @@ static void ata_host_init(struct ata_por
 		dev->pio_mask = UINT_MAX;
 		dev->mwdma_mask = UINT_MAX;
 		dev->udma_mask = UINT_MAX;
+		ata_ering_init(&dev->ering, ATA_DEV_ERING_SIZE);
 	}
 
 #ifdef ATA_IRQ_TRAP
diff --git a/include/linux/libata.h b/include/linux/libata.h
index ad16d6b..1a4df14 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -135,6 +135,8 @@ enum {
 	ATA_DEV_ATAPI_UNSUP	= 4,	/* ATAPI device (unsupported) */
 	ATA_DEV_NONE		= 5,	/* no device */
 
+	ATA_DEV_ERING_SIZE	= 32,	/* record 32 recent errors */
+
 	/* struct ata_port flags */
 	ATA_FLAG_SLAVE_POSS	= (1 << 0), /* host supports slave dev */
 					    /* (doesn't imply presence) */
@@ -417,6 +419,8 @@ struct ata_device {
 	u16			cylinders;	/* Number of cylinders */
 	u16			heads;		/* Number of heads */
 	u16			sectors;	/* Number of sectors per track */
+
+	DEFINE_ATA_ERING	(ering, ATA_DEV_ERING_SIZE);
 };
 
 struct ata_port {
-- 
1.2.4


