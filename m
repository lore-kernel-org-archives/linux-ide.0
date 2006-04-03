From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 03/13] libata: add per-dev ata_ering
Date: Mon, 3 Apr 2006 12:44:38 +0900
Message-ID: <11440358783978-git-send-email-htejun@gmail.com>
References: <11440358783861-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.197]:44129 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932165AbWDCDon (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Apr 2006 23:44:43 -0400
Received: by zproxy.gmail.com with SMTP id o37so1665768nzf
        for <linux-ide@vger.kernel.org>; Sun, 02 Apr 2006 20:44:43 -0700 (PDT)
In-Reply-To: <11440358783861-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

EH is gonna record errors per-dev.  Define per-dev ata_ering.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    1 +
 include/linux/libata.h     |    4 ++++
 2 files changed, 5 insertions(+), 0 deletions(-)

ca065c0f8bb2d545dc3abe83101c4d714f72dee9
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index fc9ae17..e6dec59 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -4762,6 +4762,7 @@ static void ata_host_init(struct ata_por
 		dev->pio_mask = UINT_MAX;
 		dev->mwdma_mask = UINT_MAX;
 		dev->udma_mask = UINT_MAX;
+		ata_ering_init(&dev->ering, ATA_DEV_ERING_SIZE);
 	}
 
 #ifdef ATA_IRQ_TRAP
diff --git a/include/linux/libata.h b/include/linux/libata.h
index e4480f2..7eeb023 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -136,6 +136,8 @@ enum {
 	ATA_DEV_ATAPI_UNSUP	= 4,	/* ATAPI device (unsupported) */
 	ATA_DEV_NONE		= 5,	/* no device */
 
+	ATA_DEV_ERING_SIZE	= 32,	/* record 32 recent errors */
+
 	/* struct ata_port flags */
 	ATA_FLAG_SLAVE_POSS	= (1 << 0), /* host supports slave dev */
 					    /* (doesn't imply presence) */
@@ -412,6 +414,8 @@ struct ata_device {
 	u16			cylinders;	/* Number of cylinders */
 	u16			heads;		/* Number of heads */
 	u16			sectors;	/* Number of sectors per track */
+
+	DEFINE_ATA_ERING	(ering, ATA_DEV_ERING_SIZE);
 };
 
 struct ata_port {
-- 
1.2.4


