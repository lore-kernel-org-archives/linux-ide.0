From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 4/7] libata: kill ata_dev_reread_id()
Date: Wed, 15 Feb 2006 18:24:09 +0900
Message-ID: <11399954491502-git-send-email-htejun@gmail.com>
References: <11399954493467-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.206]:5406 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1945905AbWBOJYN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Feb 2006 04:24:13 -0500
Received: by zproxy.gmail.com with SMTP id i11so1475859nzh
        for <linux-ide@vger.kernel.org>; Wed, 15 Feb 2006 01:24:12 -0800 (PST)
In-Reply-To: <11399954493467-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Kill now-unused ata_dev_reread_id().

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   42 ------------------------------------------
 1 files changed, 0 insertions(+), 42 deletions(-)

4436e50d21e0dcfaa26f54dc798b9d23c4d71d11
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 6de78d1..0119e15 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -61,7 +61,6 @@
 
 #include "libata.h"
 
-static void ata_dev_reread_id(struct ata_port *ap, struct ata_device *dev);
 static unsigned int ata_dev_init_params(struct ata_port *ap,
 					struct ata_device *dev);
 static void ata_set_mode(struct ata_port *ap);
@@ -2545,47 +2544,6 @@ static void ata_dev_set_xfermode(struct 
 }
 
 /**
- *	ata_dev_reread_id - Reread the device identify device info
- *	@ap: port where the device is
- *	@dev: device to reread the identify device info
- *
- *	LOCKING:
- */
-
-static void ata_dev_reread_id(struct ata_port *ap, struct ata_device *dev)
-{
-	struct ata_taskfile tf;
-
-	ata_tf_init(ap, &tf, dev->devno);
-
-	if (dev->class == ATA_DEV_ATA) {
-		tf.command = ATA_CMD_ID_ATA;
-		DPRINTK("do ATA identify\n");
-	} else {
-		tf.command = ATA_CMD_ID_ATAPI;
-		DPRINTK("do ATAPI identify\n");
-	}
-
-	tf.flags |= ATA_TFLAG_DEVICE;
-	tf.protocol = ATA_PROT_PIO;
-
-	if (ata_exec_internal(ap, dev, &tf, DMA_FROM_DEVICE,
-			      dev->id, sizeof(dev->id[0]) * ATA_ID_WORDS))
-		goto err_out;
-
-	swap_buf_le16(dev->id, ATA_ID_WORDS);
-
-	ata_dump_id(dev->id);
-
-	DPRINTK("EXIT\n");
-
-	return;
-err_out:
-	printk(KERN_ERR "ata%u: failed to reread ID, disabled\n", ap->id);
-	ata_port_disable(ap);
-}
-
-/**
  *	ata_dev_init_params - Issue INIT DEV PARAMS command
  *	@ap: Port associated with device @dev
  *	@dev: Device to which command will be sent
-- 
1.1.5


