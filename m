From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 03/13] libata-hp: implement ata_dev_init()
Date: Tue, 11 Apr 2006 23:06:21 +0900
Message-ID: <11447643811565-git-send-email-htejun@gmail.com>
References: <11447643813451-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.204]:29188 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750822AbWDKOGX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 10:06:23 -0400
Received: by zproxy.gmail.com with SMTP id o37so1100680nzf
        for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 07:06:23 -0700 (PDT)
In-Reply-To: <11447643813451-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Move initialization of struct ata_device into ata_dev_init() in
preparation for hotplug.  This patch calls ata_dev_init() from
ata_host_init() and thus makes no functional difference.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   28 ++++++++++++++++++++++------
 1 files changed, 22 insertions(+), 6 deletions(-)

442eed97d84e43eb0860e19398c508c4a02c2860
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index d49d4c7..1378b6f 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1433,6 +1433,27 @@ err_out_nosup:
 }
 
 /**
+ *	ata_dev_init - Initialize an ata_device structure
+ *	@ap: ATA port device to initialize is attached to
+ *	@dev: Device structure to initialize
+ *
+ *	Initialize @dev in preparation for probing.
+ *
+ *	LOCKING:
+ *	Inherited from caller.
+ */
+static void ata_dev_init(struct ata_port *ap, struct ata_device *dev)
+{
+	memset((void *)dev + ATA_DEVICE_CLEAR_OFFSET, 0,
+	       sizeof(*dev) - ATA_DEVICE_CLEAR_OFFSET);
+	dev->devno = dev - ap->device;
+	dev->pio_mask = UINT_MAX;
+	dev->mwdma_mask = UINT_MAX;
+	dev->udma_mask = UINT_MAX;
+	ata_ering_init(&dev->ering, ATA_DEV_ERING_SIZE);
+}
+
+/**
  *	ata_bus_probe - Reset and probe ATA bus
  *	@ap: Bus to probe
  *
@@ -4828,7 +4849,6 @@ static void ata_host_remove(struct ata_p
  *	LOCKING:
  *	Inherited from caller.
  */
-
 static void ata_host_init(struct ata_port *ap, struct Scsi_Host *host,
 			  struct ata_host_set *host_set,
 			  const struct ata_probe_ent *ent, unsigned int port_no)
@@ -4865,11 +4885,7 @@ static void ata_host_init(struct ata_por
 
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
 		struct ata_device *dev = &ap->device[i];
-		dev->devno = i;
-		dev->pio_mask = UINT_MAX;
-		dev->mwdma_mask = UINT_MAX;
-		dev->udma_mask = UINT_MAX;
-		ata_ering_init(&dev->ering, ATA_DEV_ERING_SIZE);
+		ata_dev_init(ap, dev);
 	}
 
 #ifdef ATA_IRQ_TRAP
-- 
1.2.4


