From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 09/16] libata: kill ata_dev_reread_id()
Date: Fri, 27 Jan 2006 00:39:11 +0900
Message-ID: <11382899513529-git-send-email-htejun@gmail.com>
References: <1138289951261-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.199]:806 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964776AbWAZQLX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Jan 2006 11:11:23 -0500
Received: by zproxy.gmail.com with SMTP id 34so381300nzf
        for <linux-ide@vger.kernel.org>; Thu, 26 Jan 2006 08:11:22 -0800 (PST)
In-Reply-To: <1138289951261-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk
Cc: Tejun Heo <htejun@gmail.com>

Kill now-unused ata_dev_reread_id().

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   42 ------------------------------------------
 1 files changed, 0 insertions(+), 42 deletions(-)

8afcb5146c2019c84595beebcdb68335570a754d
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 9575ce0..d1cec73 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -61,7 +61,6 @@
 
 #include "libata.h"
 
-static void ata_dev_reread_id(struct ata_port *ap, struct ata_device *dev);
 static unsigned int ata_dev_init_params(struct ata_port *ap,
 					struct ata_device *dev);
 static void ata_set_mode(struct ata_port *ap);
@@ -2867,47 +2866,6 @@ static void ata_dev_set_xfermode(struct 
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
-			      dev->id, sizeof(dev->id)))
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
1.1.3


