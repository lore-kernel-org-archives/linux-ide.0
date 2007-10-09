From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/3] libata: add @timeout to ata_exec_internal[_sg]()
Date: Tue, 9 Oct 2007 15:05:44 +0900
Message-ID: <20071009060544.GL12186@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.189]:58454 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751969AbXJIGFv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 9 Oct 2007 02:05:51 -0400
Received: by rv-out-0910.google.com with SMTP id k20so961462rvb
        for <linux-ide@vger.kernel.org>; Mon, 08 Oct 2007 23:05:50 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Add @timeout argument to ata_exec_internal[_sg]().  If 0, default
timeout ata_probe_timeout is used.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
This patchset kills polling PMP register access callbacks ->pmp_read
and ->pmp_write and use standard ata_exec_internal() mechanism.  This
patchset is generated on top of the following six patches.

  http://article.gmane.org/gmane.linux.ide/23464
  http://article.gmane.org/gmane.linux.ide/23465
  http://article.gmane.org/gmane.linux.ide/23466
  http://article.gmane.org/gmane.linux.ide/23467
  http://article.gmane.org/gmane.linux.ide/23468
  http://article.gmane.org/gmane.linux.ide/23469

 drivers/ata/libata-acpi.c |    2 +-
 drivers/ata/libata-core.c |   32 ++++++++++++++++++++------------
 drivers/ata/libata-eh.c   |    4 ++--
 drivers/ata/libata.h      |    5 +++--
 4 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
index 5ebbf16..d9c295c 100644
--- a/drivers/ata/libata-acpi.c
+++ b/drivers/ata/libata-acpi.c
@@ -474,7 +474,7 @@ static int taskfile_load_raw(struct ata_device *dev,
 			       tf.lbal, tf.lbam, tf.lbah, tf.device);
 
 	rtf = tf;
-	err_mask = ata_exec_internal(dev, &rtf, NULL, DMA_NONE, NULL, 0);
+	err_mask = ata_exec_internal(dev, &rtf, NULL, DMA_NONE, NULL, 0, 0);
 	if (err_mask) {
 		ata_dev_printk(dev, KERN_ERR,
 			"ACPI cmd %02x/%02x:%02x:%02x:%02x:%02x:%02x failed "
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 88becd2..f80089e 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -926,7 +926,7 @@ static int ata_read_native_max_address(struct ata_device *dev, u64 *max_sectors)
 	tf.protocol |= ATA_PROT_NODATA;
 	tf.device |= ATA_LBA;
 
-	err_mask = ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0);
+	err_mask = ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0, 0);
 	if (err_mask) {
 		ata_dev_printk(dev, KERN_WARNING, "failed to read native "
 			       "max address (err_mask=0x%x)\n", err_mask);
@@ -988,7 +988,7 @@ static int ata_set_max_sectors(struct ata_device *dev, u64 new_sectors)
 	tf.lbam = (new_sectors >> 8) & 0xff;
 	tf.lbah = (new_sectors >> 16) & 0xff;
 
-	err_mask = ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0);
+	err_mask = ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0, 0);
 	if (err_mask) {
 		ata_dev_printk(dev, KERN_WARNING, "failed to set "
 			       "max address (err_mask=0x%x)\n", err_mask);
@@ -1394,6 +1394,7 @@ static void ata_qc_complete_internal(struct ata_queued_cmd *qc)
  *	@dma_dir: Data tranfer direction of the command
  *	@sg: sg list for the data buffer of the command
  *	@n_elem: Number of sg entries
+ *	@timeout: Timeout in msecs (0 for default)
  *
  *	Executes libata internal command with timeout.  @tf contains
  *	command on entry and result on return.  Timeout and error
@@ -1410,7 +1411,7 @@ static void ata_qc_complete_internal(struct ata_queued_cmd *qc)
 unsigned ata_exec_internal_sg(struct ata_device *dev,
 			      struct ata_taskfile *tf, const u8 *cdb,
 			      int dma_dir, struct scatterlist *sg,
-			      unsigned int n_elem)
+			      unsigned int n_elem, unsigned long timeout)
 {
 	struct ata_link *link = dev->link;
 	struct ata_port *ap = link->ap;
@@ -1486,7 +1487,10 @@ unsigned ata_exec_internal_sg(struct ata_device *dev,
 
 	spin_unlock_irqrestore(ap->lock, flags);
 
-	rc = wait_for_completion_timeout(&wait, ata_probe_timeout);
+	if (!timeout)
+		timeout = ata_probe_timeout * 1000 / HZ;
+
+	rc = wait_for_completion_timeout(&wait, msecs_to_jiffies(timeout));
 
 	ata_port_flush_task(ap);
 
@@ -1571,6 +1575,7 @@ unsigned ata_exec_internal_sg(struct ata_device *dev,
  *	@dma_dir: Data tranfer direction of the command
  *	@buf: Data buffer of the command
  *	@buflen: Length of data buffer
+ *	@timeout: Timeout in msecs (0 for default)
  *
  *	Wrapper around ata_exec_internal_sg() which takes simple
  *	buffer instead of sg list.
@@ -1583,7 +1588,8 @@ unsigned ata_exec_internal_sg(struct ata_device *dev,
  */
 unsigned ata_exec_internal(struct ata_device *dev,
 			   struct ata_taskfile *tf, const u8 *cdb,
-			   int dma_dir, void *buf, unsigned int buflen)
+			   int dma_dir, void *buf, unsigned int buflen,
+			   unsigned long timeout)
 {
 	struct scatterlist *psg = NULL, sg;
 	unsigned int n_elem = 0;
@@ -1595,7 +1601,8 @@ unsigned ata_exec_internal(struct ata_device *dev,
 		n_elem++;
 	}
 
-	return ata_exec_internal_sg(dev, tf, cdb, dma_dir, psg, n_elem);
+	return ata_exec_internal_sg(dev, tf, cdb, dma_dir, psg, n_elem,
+				    timeout);
 }
 
 /**
@@ -1622,7 +1629,7 @@ unsigned int ata_do_simple_cmd(struct ata_device *dev, u8 cmd)
 	tf.flags |= ATA_TFLAG_DEVICE;
 	tf.protocol = ATA_PROT_NODATA;
 
-	return ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0);
+	return ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0, 0);
 }
 
 /**
@@ -1737,7 +1744,7 @@ int ata_dev_read_id(struct ata_device *dev, unsigned int *p_class,
 	tf.flags |= ATA_TFLAG_POLLING;
 
 	err_mask = ata_exec_internal(dev, &tf, NULL, DMA_FROM_DEVICE,
-				     id, sizeof(id[0]) * ATA_ID_WORDS);
+				     id, sizeof(id[0]) * ATA_ID_WORDS, 0);
 	if (err_mask) {
 		if (err_mask & AC_ERR_NODEV_HINT) {
 			DPRINTK("ata%u.%d: NODEV after polling detection\n",
@@ -1796,7 +1803,8 @@ int ata_dev_read_id(struct ata_device *dev, unsigned int *p_class,
 		tf.feature = SETFEATURES_SPINUP;
 		tf.protocol = ATA_PROT_NODATA;
 		tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
-		err_mask = ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0);
+		err_mask = ata_exec_internal(dev, &tf, NULL,
+					     DMA_NONE, NULL, 0, 0);
 		if (err_mask && id[2] != 0x738c) {
 			rc = -EIO;
 			reason = "SPINUP failed";
@@ -4154,7 +4162,7 @@ static unsigned int ata_dev_set_xfermode(struct ata_device *dev)
 	tf.protocol = ATA_PROT_NODATA;
 	tf.nsect = dev->xfer_mode;
 
-	err_mask = ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0);
+	err_mask = ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0, 0);
 
 	DPRINTK("EXIT, err_mask=%x\n", err_mask);
 	return err_mask;
@@ -4190,7 +4198,7 @@ static unsigned int ata_dev_set_AN(struct ata_device *dev, u8 enable)
 	tf.protocol = ATA_PROT_NODATA;
 	tf.nsect = SATA_AN;
 
-	err_mask = ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0);
+	err_mask = ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0, 0);
 
 	DPRINTK("EXIT, err_mask=%x\n", err_mask);
 	return err_mask;
@@ -4228,7 +4236,7 @@ static unsigned int ata_dev_init_params(struct ata_device *dev,
 	tf.nsect = sectors;
 	tf.device |= (heads - 1) & 0x0f; /* max head = num. of heads - 1 */
 
-	err_mask = ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0);
+	err_mask = ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0, 0);
 	/* A clean abort indicates an original or just out of spec drive
 	   and we should continue as we issue the setup based on the
 	   drive reported working geometry */
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 8aa6140..c0e9a42 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1249,7 +1249,7 @@ static unsigned int ata_read_log_page(struct ata_device *dev,
 	tf.protocol = ATA_PROT_PIO;
 
 	err_mask = ata_exec_internal(dev, &tf, NULL, DMA_FROM_DEVICE,
-				     buf, sectors * ATA_SECT_SIZE);
+				     buf, sectors * ATA_SECT_SIZE, 0);
 
 	DPRINTK("EXIT, err_mask=%x\n", err_mask);
 	return err_mask;
@@ -1363,7 +1363,7 @@ static unsigned int atapi_eh_request_sense(struct ata_queued_cmd *qc)
 	}
 
 	return ata_exec_internal(dev, &tf, cdb, DMA_FROM_DEVICE,
-				 sense_buf, SCSI_SENSE_BUFFERSIZE);
+				 sense_buf, SCSI_SENSE_BUFFERSIZE, 0);
 }
 
 /**
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index f8bd955..90df58a 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -69,11 +69,12 @@ extern void ata_dev_disable(struct ata_device *dev);
 extern void ata_port_flush_task(struct ata_port *ap);
 extern unsigned ata_exec_internal(struct ata_device *dev,
 				  struct ata_taskfile *tf, const u8 *cdb,
-				  int dma_dir, void *buf, unsigned int buflen);
+				  int dma_dir, void *buf, unsigned int buflen,
+				  unsigned long timeout);
 extern unsigned ata_exec_internal_sg(struct ata_device *dev,
 				     struct ata_taskfile *tf, const u8 *cdb,
 				     int dma_dir, struct scatterlist *sg,
-				     unsigned int n_elem);
+				     unsigned int n_elem, unsigned long timeout);
 extern unsigned int ata_do_simple_cmd(struct ata_device *dev, u8 cmd);
 extern int ata_dev_read_id(struct ata_device *dev, unsigned int *p_class,
 			   unsigned int flags, u16 *id);
-- 
1.5.0.3

