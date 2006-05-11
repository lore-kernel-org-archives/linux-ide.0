From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 02/14] libata-hp-prep: implement ata_dev_init()
Date: Fri, 12 May 2006 00:11:58 +0900
Message-ID: <11473603181846-git-send-email-htejun@gmail.com>
References: <1147360318920-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.230]:54573 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751845AbWEKPMF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 11:12:05 -0400
Received: by wr-out-0506.google.com with SMTP id i12so387722wra
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 08:12:04 -0700 (PDT)
In-Reply-To: <1147360318920-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Move initialization of struct ata_device into ata_dev_init() in
preparation for hotplug.  This patch calls ata_dev_init() from
ata_host_init() and thus makes no functional difference.

---

 drivers/scsi/libata-core.c |   28 ++++++++++++++++++++++------
 1 files changed, 22 insertions(+), 6 deletions(-)

bf81344569d3ceb459fa55121a0d69d9ed52f10e
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 54240db..d307164 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -5108,6 +5108,27 @@ static void ata_host_remove(struct ata_p
 }
 
 /**
+ *	ata_dev_init - Initialize an ata_device structure
+ *	@dev: Device structure to initialize
+ *
+ *	Initialize @dev in preparation for probing.
+ *
+ *	LOCKING:
+ *	Inherited from caller.
+ */
+void ata_dev_init(struct ata_device *dev)
+{
+	struct ata_port *ap = dev->ap;
+
+	memset((void *)dev, 0, sizeof(*dev));
+	dev->devno = dev - ap->device;
+	dev->pio_mask = UINT_MAX;
+	dev->mwdma_mask = UINT_MAX;
+	dev->udma_mask = UINT_MAX;
+	ata_ering_init(&dev->ering, ATA_DEV_ERING_SIZE);
+}
+
+/**
  *	ata_host_init - Initialize an ata_port structure
  *	@ap: Structure to initialize
  *	@host: associated SCSI mid-layer structure
@@ -5121,7 +5142,6 @@ static void ata_host_remove(struct ata_p
  *	LOCKING:
  *	Inherited from caller.
  */
-
 static void ata_host_init(struct ata_port *ap, struct Scsi_Host *host,
 			  struct ata_host_set *host_set,
 			  const struct ata_probe_ent *ent, unsigned int port_no)
@@ -5163,11 +5183,7 @@ static void ata_host_init(struct ata_por
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
 		struct ata_device *dev = &ap->device[i];
 		dev->ap = ap;
-		dev->devno = i;
-		dev->pio_mask = UINT_MAX;
-		dev->mwdma_mask = UINT_MAX;
-		dev->udma_mask = UINT_MAX;
-		ata_ering_init(&dev->ering, ATA_DEV_ERING_SIZE);
+		ata_dev_init(dev);
 	}
 
 #ifdef ATA_IRQ_TRAP
-- 
1.2.4


