From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 5/7] libata: implement ata_down_xfermask_limit()
Date: Sun, 2 Apr 2006 17:54:46 +0900
Message-ID: <11439680864033-git-send-email-htejun@gmail.com>
References: <11439680863256-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.207]:47513 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932183AbWDBIyz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Apr 2006 04:54:55 -0400
Received: by zproxy.gmail.com with SMTP id o37so1438211nzf
        for <linux-ide@vger.kernel.org>; Sun, 02 Apr 2006 00:54:55 -0800 (PST)
In-Reply-To: <11439680863256-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Implement ata_down_xfermask_limit().  This function manipulates
@dev->pio/mwdma/udma_mask such that the next lower transfer mode is
selected.  This will be used to improve ata_bus_probe() failure
handling and later by EH.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   52 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 52 insertions(+), 0 deletions(-)

be65a1d4949d11d333866d10f79e6ef2165dd3cb
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index dfa2b36..42a3147 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -65,6 +65,8 @@ static unsigned int ata_dev_init_params(
 					struct ata_device *dev,
 					u16 heads,
 					u16 sectors);
+static int ata_down_xfermask_limit(struct ata_port *ap, struct ata_device *dev,
+				   int force_pio0);
 static int ata_down_sata_spd_limit(struct ata_port *ap);
 static int ata_set_mode(struct ata_port *ap, struct ata_device **r_failed_dev);
 static unsigned int ata_dev_set_xfermode(struct ata_port *ap,
@@ -1859,6 +1861,56 @@ int ata_timing_compute(struct ata_device
 	return 0;
 }
 
+/**
+ *	ata_down_xfermask_limit - adjust dev xfer masks downward
+ *	@ap: Port associated with device @dev
+ *	@dev: Device to adjust xfer masks
+ *	@force_pio0: Force PIO0
+ *
+ *	Adjust xfer masks of @dev downward.  Note that this function
+ *	does not apply the change.  Invoking ata_set_mode() afterwards
+ *	will apply the limit.
+ *
+ *	LOCKING:
+ *	Inherited from caller.
+ *
+ *	RETURNS:
+ *	0 on success, negative errno on failure
+ */
+static int ata_down_xfermask_limit(struct ata_port *ap, struct ata_device *dev,
+				   int force_pio0)
+{
+	unsigned long xfer_mask;
+	int highbit;
+
+	xfer_mask = ata_pack_xfermask(dev->pio_mask, dev->mwdma_mask,
+				      dev->udma_mask);
+
+	if (!xfer_mask)
+		goto fail;
+	/* don't gear down to MWDMA from UDMA, go directly to PIO */
+	if (xfer_mask & ATA_MASK_UDMA)
+		xfer_mask &= ~ATA_MASK_MWDMA;
+
+	highbit = fls(xfer_mask) - 1;
+	xfer_mask &= ~(1 << highbit);
+	if (force_pio0)
+		xfer_mask &= 1 << ATA_SHIFT_PIO;
+	if (!xfer_mask)
+		goto fail;
+
+	ata_unpack_xfermask(xfer_mask, &dev->pio_mask, &dev->mwdma_mask,
+			    &dev->udma_mask);
+
+	printk(KERN_WARNING "ata%u: dev %u limiting speed to %s\n",
+	       ap->id, dev->devno, ata_mode_string(xfer_mask));
+
+	return 0;
+
+ fail:
+	return -EINVAL;
+}
+
 static int ata_dev_set_mode(struct ata_port *ap, struct ata_device *dev)
 {
 	unsigned int err_mask;
-- 
1.2.4


