From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 03/14] libata-eh: add per-dev ata_ering
Date: Tue, 11 Apr 2006 22:48:22 +0900
Message-ID: <11447633022728-git-send-email-htejun@gmail.com>
References: <11447633013561-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.199]:60071 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750932AbWDKNsY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 09:48:24 -0400
Received: by zproxy.gmail.com with SMTP id o37so1096027nzf
        for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 06:48:23 -0700 (PDT)
In-Reply-To: <11447633013561-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

EH is gonna record errors per-dev.  Define per-dev ata_ering.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    1 +
 include/linux/libata.h     |    4 ++++
 2 files changed, 5 insertions(+), 0 deletions(-)

f672946fdd44a66d0dd42b4df146b7e9e3735e49
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index d4c75cb..13954f6 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -4777,6 +4777,7 @@ static void ata_host_init(struct ata_por
 		dev->pio_mask = UINT_MAX;
 		dev->mwdma_mask = UINT_MAX;
 		dev->udma_mask = UINT_MAX;
+		ata_ering_init(&dev->ering, ATA_DEV_ERING_SIZE);
 	}
 
 #ifdef ATA_IRQ_TRAP
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 7a8d77b..9447bd2 100644
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
@@ -414,6 +416,8 @@ struct ata_device {
 	u16			cylinders;	/* Number of cylinders */
 	u16			heads;		/* Number of heads */
 	u16			sectors;	/* Number of sectors per track */
+
+	DEFINE_ATA_ERING	(ering, ATA_DEV_ERING_SIZE);
 };
 
 struct ata_port {
-- 
1.2.4


