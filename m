From: shaohua.li@intel.com
Subject: [patch v2 3/3] SATA: enable non-queueable flush flag
Date: Wed, 04 May 2011 16:17:28 +0800
Message-ID: <20110504082115.488846050@sli10-conroe.sh.intel.com>
References: <20110504081725.946950281@sli10-conroe.sh.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=sata-add-nonqueueable.patch
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Cc: jaxboe@fusionio.com, htejun@gmail.com, jgarzik@pobox.com, hch@infradead.org, djwong@us.ibm.com, Shaohua Li <shaohua.li@intel.com>
List-Id: linux-ide@vger.kernel.org

Enable non-queueable flush flag for SATA.

Signed-off-by: Shaohua Li <shaohua.li@intel.com>
---
 drivers/ata/libata-scsi.c |    2 ++
 1 file changed, 2 insertions(+)

Index: linux/drivers/ata/libata-scsi.c
===================================================================
--- linux.orig/drivers/ata/libata-scsi.c	2011-05-04 14:20:41.000000000 +0800
+++ linux/drivers/ata/libata-scsi.c	2011-05-04 14:28:28.000000000 +0800
@@ -3424,7 +3424,9 @@ void ata_scsi_scan_host(struct ata_port
 			sdev = __scsi_add_device(ap->scsi_host, channel, id, 0,
 						 NULL);
 			if (!IS_ERR(sdev)) {
+				struct request_queue *q = sdev->request_queue;
 				dev->sdev = sdev;
+				blk_set_queue_flush_queueable(q, false);
 				scsi_device_put(sdev);
 			} else {
 				dev->sdev = NULL;
