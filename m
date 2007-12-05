From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 07/15] change-data_xfer
Date: Wed,  5 Dec 2007 16:43:07 +0900
Message-ID: <11968405971209-git-send-email-htejun@gmail.com>
References: <11968405951262-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:34008 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751968AbXLEHn7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Dec 2007 02:43:59 -0500
Received: by wa-out-1112.google.com with SMTP id v27so6895949wah
        for <linux-ide@vger.kernel.org>; Tue, 04 Dec 2007 23:43:58 -0800 (PST)
In-Reply-To: <11968405951262-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, liml@rtr.ca, albertl@mail.com, jens.axboe@oracle.com
Cc: Tejun Heo <htejun@gmail.com>

Depending on how many bytes are transferred as a unit, PIO data
tranasfer may consume more bytes than requested.  Knowing how much
data is consumed is necessary to determine how much is left for
draining.  This patch update ->data_xfer such that it returns the
number of consumed bytes.

While at it, it also makes the following changes.

* s/adev/dev/
* use READ/WRITE constants for rw indication
* misc clean ups

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c    |   46 +++++++++++++++++++++++++++--------------
 drivers/ata/pata_bf54x.c     |   28 +++++++++++++-----------
 drivers/ata/pata_ixp4xx_cf.c |   26 ++++++++++++-----------
 drivers/ata/pata_legacy.c    |   36 +++++++++++++++++---------------
 drivers/ata/pata_qdi.c       |   30 +++++++++++++++-----------
 drivers/ata/pata_scc.c       |   30 ++++++++++++++------------
 drivers/ata/pata_winbond.c   |   28 ++++++++++++++-----------
 include/linux/libata.h       |   11 +++++----
 8 files changed, 133 insertions(+), 102 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 1af9b84..70e273c 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4969,7 +4969,7 @@ void swap_buf_le16(u16 *buf, unsigned int buf_words)
 
 /**
  *	ata_data_xfer - Transfer data by PIO
- *	@adev: device to target
+ *	@dev: device to target
  *	@buf: data buffer
  *	@buflen: buffer length
  *	@write_data: read/write
@@ -4978,37 +4978,44 @@ void swap_buf_le16(u16 *buf, unsigned int buf_words)
  *
  *	LOCKING:
  *	Inherited from caller.
+ *
+ *	RETURNS:
+ *	Bytes consumed.
  */
-void ata_data_xfer(struct ata_device *adev, unsigned char *buf,
-		   unsigned int buflen, int write_data)
+unsigned int ata_data_xfer(struct ata_device *dev, unsigned char *buf,
+			   unsigned int buflen, int rw)
 {
-	struct ata_port *ap = adev->link->ap;
+	struct ata_port *ap = dev->link->ap;
+	void __iomem *data_addr = ap->ioaddr.data_addr;
 	unsigned int words = buflen >> 1;
 
 	/* Transfer multiple of 2 bytes */
-	if (write_data)
-		iowrite16_rep(ap->ioaddr.data_addr, buf, words);
+	if (rw == READ)
+		ioread16_rep(data_addr, buf, words);
 	else
-		ioread16_rep(ap->ioaddr.data_addr, buf, words);
+		iowrite16_rep(data_addr, buf, words);
 
 	/* Transfer trailing 1 byte, if any. */
 	if (unlikely(buflen & 0x01)) {
 		u16 align_buf[1] = { 0 };
 		unsigned char *trailing_buf = buf + buflen - 1;
 
-		if (write_data) {
-			memcpy(align_buf, trailing_buf, 1);
-			iowrite16(le16_to_cpu(align_buf[0]), ap->ioaddr.data_addr);
-		} else {
-			align_buf[0] = cpu_to_le16(ioread16(ap->ioaddr.data_addr));
+		if (rw == READ) {
+			align_buf[0] = cpu_to_le16(ioread16(data_addr));
 			memcpy(trailing_buf, align_buf, 1);
+		} else {
+			memcpy(align_buf, trailing_buf, 1);
+			iowrite16(le16_to_cpu(align_buf[0]), data_addr);
 		}
+		words++;
 	}
+
+	return words << 1;
 }
 
 /**
  *	ata_data_xfer_noirq - Transfer data by PIO
- *	@adev: device to target
+ *	@dev: device to target
  *	@buf: data buffer
  *	@buflen: buffer length
  *	@write_data: read/write
@@ -5018,14 +5025,21 @@ void ata_data_xfer(struct ata_device *adev, unsigned char *buf,
  *
  *	LOCKING:
  *	Inherited from caller.
+ *
+ *	RETURNS:
+ *	Bytes consumed.
  */
-void ata_data_xfer_noirq(struct ata_device *adev, unsigned char *buf,
-			 unsigned int buflen, int write_data)
+unsigned int ata_data_xfer_noirq(struct ata_device *dev, unsigned char *buf,
+				 unsigned int buflen, int rw)
 {
 	unsigned long flags;
+	unsigned int consumed;
+
 	local_irq_save(flags);
-	ata_data_xfer(adev, buf, buflen, write_data);
+	consumed = ata_data_xfer(dev, buf, buflen, rw);
 	local_irq_restore(flags);
+
+	return consumed;
 }
 
 
diff --git a/drivers/ata/pata_bf54x.c b/drivers/ata/pata_bf54x.c
index 088a41f..9970952 100644
--- a/drivers/ata/pata_bf54x.c
+++ b/drivers/ata/pata_bf54x.c
@@ -1167,34 +1167,36 @@ static unsigned char bfin_bmdma_status(struct ata_port *ap)
  *	Note: Original code is ata_data_xfer().
  */
 
-static void bfin_data_xfer(struct ata_device *adev, unsigned char *buf,
-			   unsigned int buflen, int write_data)
+static unsigned int bfin_data_xfer(struct ata_device *dev, unsigned char *buf,
+				   unsigned int buflen, int rw)
 {
-	struct ata_port *ap = adev->link->ap;
-	unsigned int words = buflen >> 1;
-	unsigned short *buf16 = (u16 *) buf;
+	struct ata_port *ap = dev->link->ap;
 	void __iomem *base = (void __iomem *)ap->ioaddr.ctl_addr;
+	unsigned int words = buflen >> 1;
+	unsigned short *buf16 = (u16 *)buf;
 
 	/* Transfer multiple of 2 bytes */
-	if (write_data) {
-		write_atapi_data(base, words, buf16);
-	} else {
+	if (rw == READ)
 		read_atapi_data(base, words, buf16);
-	}
+	else
+		write_atapi_data(base, words, buf16);
 
 	/* Transfer trailing 1 byte, if any. */
 	if (unlikely(buflen & 0x01)) {
 		unsigned short align_buf[1] = { 0 };
 		unsigned char *trailing_buf = buf + buflen - 1;
 
-		if (write_data) {
-			memcpy(align_buf, trailing_buf, 1);
-			write_atapi_data(base, 1, align_buf);
-		} else {
+		if (rw == READ) {
 			read_atapi_data(base, 1, align_buf);
 			memcpy(trailing_buf, align_buf, 1);
+		} else {
+			memcpy(align_buf, trailing_buf, 1);
+			write_atapi_data(base, 1, align_buf);
 		}
+		words++;
 	}
+
+	return words << 1;
 }
 
 /**
diff --git a/drivers/ata/pata_ixp4xx_cf.c b/drivers/ata/pata_ixp4xx_cf.c
index fcd532a..0ec3f62 100644
--- a/drivers/ata/pata_ixp4xx_cf.c
+++ b/drivers/ata/pata_ixp4xx_cf.c
@@ -42,13 +42,13 @@ static int ixp4xx_set_mode(struct ata_link *link, struct ata_device **error)
 	return 0;
 }
 
-static void ixp4xx_mmio_data_xfer(struct ata_device *adev, unsigned char *buf,
-				unsigned int buflen, int write_data)
+static unsigned int ixp4xx_mmio_data_xfer(struct ata_device *dev,
+				unsigned char *buf, unsigned int buflen, int rw)
 {
 	unsigned int i;
 	unsigned int words = buflen >> 1;
 	u16 *buf16 = (u16 *) buf;
-	struct ata_port *ap = adev->link->ap;
+	struct ata_port *ap = dev->link->ap;
 	void __iomem *mmio = ap->ioaddr.data_addr;
 	struct ixp4xx_pata_data *data = ap->host->dev->platform_data;
 
@@ -59,30 +59,32 @@ static void ixp4xx_mmio_data_xfer(struct ata_device *adev, unsigned char *buf,
 	udelay(100);
 
 	/* Transfer multiple of 2 bytes */
-	if (write_data) {
-		for (i = 0; i < words; i++)
-			writew(buf16[i], mmio);
-	} else {
+	if (rw == READ)
 		for (i = 0; i < words; i++)
 			buf16[i] = readw(mmio);
-	}
+	else
+		for (i = 0; i < words; i++)
+			writew(buf16[i], mmio);
 
 	/* Transfer trailing 1 byte, if any. */
 	if (unlikely(buflen & 0x01)) {
 		u16 align_buf[1] = { 0 };
 		unsigned char *trailing_buf = buf + buflen - 1;
 
-		if (write_data) {
-			memcpy(align_buf, trailing_buf, 1);
-			writew(align_buf[0], mmio);
-		} else {
+		if (rw == READ) {
 			align_buf[0] = readw(mmio);
 			memcpy(trailing_buf, align_buf, 1);
+		} else {
+			memcpy(align_buf, trailing_buf, 1);
+			writew(align_buf[0], mmio);
 		}
+		words++;
 	}
 
 	udelay(100);
 	*data->cs0_cfg |= 0x01;
+
+	return words << 1;
 }
 
 static struct scsi_host_template ixp4xx_sht = {
diff --git a/drivers/ata/pata_legacy.c b/drivers/ata/pata_legacy.c
index 7bed8d8..ed59667 100644
--- a/drivers/ata/pata_legacy.c
+++ b/drivers/ata/pata_legacy.c
@@ -249,13 +249,14 @@ static void pdc20230_set_piomode(struct ata_port *ap, struct ata_device *adev)
 
 }
 
-static void pdc_data_xfer_vlb(struct ata_device *adev, unsigned char *buf, unsigned int buflen, int write_data)
+static unsigned int pdc_data_xfer_vlb(struct ata_device *dev,
+				unsigned char *buf, unsigned int buflen, int rw)
 {
-	struct ata_port *ap = adev->link->ap;
-	int slop = buflen & 3;
-	unsigned long flags;
-
 	if (ata_id_has_dword_io(adev->id)) {
+		struct ata_port *ap = dev->link->ap;
+		int slop = buflen & 3;
+		unsigned long flags;
+
 		local_irq_save(flags);
 
 		/* Perform the 32bit I/O synchronization sequence */
@@ -264,28 +265,29 @@ static void pdc_data_xfer_vlb(struct ata_device *adev, unsigned char *buf, unsig
 		ioread8(ap->ioaddr.nsect_addr);
 
 		/* Now the data */
-
-		if (write_data)
-			iowrite32_rep(ap->ioaddr.data_addr, buf, buflen >> 2);
-		else
+		if (rw == READ)
 			ioread32_rep(ap->ioaddr.data_addr, buf, buflen >> 2);
+		else
+			iowrite32_rep(ap->ioaddr.data_addr, buf, buflen >> 2);
 
 		if (unlikely(slop)) {
 			u32 pad;
-			if (write_data) {
-				memcpy(&pad, buf + buflen - slop, slop);
-				pad = le32_to_cpu(pad);
-				iowrite32(pad, ap->ioaddr.data_addr);
-			} else {
+			if (rw == READ) {
 				pad = ioread32(ap->ioaddr.data_addr);
 				pad = cpu_to_le16(pad);
 				memcpy(buf + buflen - slop, &pad, slop);
+			} else {
+				memcpy(&pad, buf + buflen - slop, slop);
+				pad = le32_to_cpu(pad);
+				iowrite32(pad, ap->ioaddr.data_addr);
 			}
+			buflen += 4 - slop;
 		}
 		local_irq_restore(flags);
-	}
-	else
-		ata_data_xfer_noirq(adev, buf, buflen, write_data);
+	} else
+		buflen = ata_data_xfer_noirq(dev, buf, buflen, rw);
+
+	return buflen;
 }
 
 static struct ata_port_operations pdc20230_port_ops = {
diff --git a/drivers/ata/pata_qdi.c b/drivers/ata/pata_qdi.c
index 7d4c696..e0e26db 100644
--- a/drivers/ata/pata_qdi.c
+++ b/drivers/ata/pata_qdi.c
@@ -124,31 +124,35 @@ static unsigned int qdi_qc_issue_prot(struct ata_queued_cmd *qc)
 	return ata_qc_issue_prot(qc);
 }
 
-static void qdi_data_xfer(struct ata_device *adev, unsigned char *buf, unsigned int buflen, int write_data)
+static unsigned int qdi_data_xfer(struct ata_device *dev, unsigned char *buf,
+				  unsigned int buflen, int rw)
 {
-	struct ata_port *ap = adev->link->ap;
-	int slop = buflen & 3;
+	if (ata_id_has_dword_io(dev->id)) {
+		struct ata_port *ap = dev->link->ap;
+		int slop = buflen & 3;
 
-	if (ata_id_has_dword_io(adev->id)) {
-		if (write_data)
-			iowrite32_rep(ap->ioaddr.data_addr, buf, buflen >> 2);
-		else
+		if (rw == READ)
 			ioread32_rep(ap->ioaddr.data_addr, buf, buflen >> 2);
+		else
+			iowrite32_rep(ap->ioaddr.data_addr, buf, buflen >> 2);
 
 		if (unlikely(slop)) {
 			u32 pad;
-			if (write_data) {
-				memcpy(&pad, buf + buflen - slop, slop);
-				pad = le32_to_cpu(pad);
-				iowrite32(pad, ap->ioaddr.data_addr);
-			} else {
+			if (rw == READ) {
 				pad = ioread32(ap->ioaddr.data_addr);
 				pad = cpu_to_le32(pad);
 				memcpy(buf + buflen - slop, &pad, slop);
+			} else {
+				memcpy(&pad, buf + buflen - slop, slop);
+				pad = le32_to_cpu(pad);
+				iowrite32(pad, ap->ioaddr.data_addr);
 			}
+			buflen += 4 - slop;
 		}
 	} else
-		ata_data_xfer(adev, buf, buflen, write_data);
+		buflen = ata_data_xfer(dev, buf, buflen, rw);
+
+	return buflen;
 }
 
 static struct scsi_host_template qdi_sht = {
diff --git a/drivers/ata/pata_scc.c b/drivers/ata/pata_scc.c
index ea2ef9f..55055b2 100644
--- a/drivers/ata/pata_scc.c
+++ b/drivers/ata/pata_scc.c
@@ -768,45 +768,47 @@ static u8 scc_bmdma_status (struct ata_port *ap)
 
 /**
  *	scc_data_xfer - Transfer data by PIO
- *	@adev: device for this I/O
+ *	@dev: device for this I/O
  *	@buf: data buffer
  *	@buflen: buffer length
- *	@write_data: read/write
+ *	@rw: read/write
  *
  *	Note: Original code is ata_data_xfer().
  */
 
-static void scc_data_xfer (struct ata_device *adev, unsigned char *buf,
-			   unsigned int buflen, int write_data)
+static unsigned int scc_data_xfer (struct ata_device *dev, unsigned char *buf,
+				   unsigned int buflen, int rw)
 {
-	struct ata_port *ap = adev->link->ap;
+	struct ata_port *ap = dev->link->ap;
 	unsigned int words = buflen >> 1;
 	unsigned int i;
 	u16 *buf16 = (u16 *) buf;
 	void __iomem *mmio = ap->ioaddr.data_addr;
 
 	/* Transfer multiple of 2 bytes */
-	if (write_data) {
-		for (i = 0; i < words; i++)
-			out_be32(mmio, cpu_to_le16(buf16[i]));
-	} else {
+	if (rw == READ)
 		for (i = 0; i < words; i++)
 			buf16[i] = le16_to_cpu(in_be32(mmio));
-	}
+	else
+		for (i = 0; i < words; i++)
+			out_be32(mmio, cpu_to_le16(buf16[i]));
 
 	/* Transfer trailing 1 byte, if any. */
 	if (unlikely(buflen & 0x01)) {
 		u16 align_buf[1] = { 0 };
 		unsigned char *trailing_buf = buf + buflen - 1;
 
-		if (write_data) {
-			memcpy(align_buf, trailing_buf, 1);
-			out_be32(mmio, cpu_to_le16(align_buf[0]));
-		} else {
+		if (rw == READ) {
 			align_buf[0] = le16_to_cpu(in_be32(mmio));
 			memcpy(trailing_buf, align_buf, 1);
+		} else {
+			memcpy(align_buf, trailing_buf, 1);
+			out_be32(mmio, cpu_to_le16(align_buf[0]));
 		}
+		words++;
 	}
+
+	return words << 1;
 }
 
 /**
diff --git a/drivers/ata/pata_winbond.c b/drivers/ata/pata_winbond.c
index 311cdb3..3da36d2 100644
--- a/drivers/ata/pata_winbond.c
+++ b/drivers/ata/pata_winbond.c
@@ -92,31 +92,35 @@ static void winbond_set_piomode(struct ata_port *ap, struct ata_device *adev)
 }
 
 
-static void winbond_data_xfer(struct ata_device *adev, unsigned char *buf, unsigned int buflen, int write_data)
+static void winbond_data_xfer(struct ata_device *dev, unsigned char *buf,
+			      unsigned int buflen, int rw)
 {
-	struct ata_port *ap = adev->link->ap;
+	struct ata_port *ap = dev->link->ap;
 	int slop = buflen & 3;
 
-	if (ata_id_has_dword_io(adev->id)) {
-		if (write_data)
-			iowrite32_rep(ap->ioaddr.data_addr, buf, buflen >> 2);
-		else
+	if (ata_id_has_dword_io(dev->id)) {
+		if (rw == READ)
 			ioread32_rep(ap->ioaddr.data_addr, buf, buflen >> 2);
+		else
+			iowrite32_rep(ap->ioaddr.data_addr, buf, buflen >> 2);
 
 		if (unlikely(slop)) {
 			u32 pad;
-			if (write_data) {
-				memcpy(&pad, buf + buflen - slop, slop);
-				pad = le32_to_cpu(pad);
-				iowrite32(pad, ap->ioaddr.data_addr);
-			} else {
+			if (rw == read) {
 				pad = ioread32(ap->ioaddr.data_addr);
 				pad = cpu_to_le16(pad);
 				memcpy(buf + buflen - slop, &pad, slop);
+			} else {
+				memcpy(&pad, buf + buflen - slop, slop);
+				pad = le32_to_cpu(pad);
+				iowrite32(pad, ap->ioaddr.data_addr);
 			}
+			buflen += 4 - slop;
 		}
 	} else
-		ata_data_xfer(adev, buf, buflen, write_data);
+		buflen = ata_data_xfer(dev, buf, buflen, rw);
+
+	return buflen;
 }
 
 static struct scsi_host_template winbond_sht = {
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 72df408..e291f04 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -700,7 +700,8 @@ struct ata_port_operations {
 	void (*bmdma_setup) (struct ata_queued_cmd *qc);
 	void (*bmdma_start) (struct ata_queued_cmd *qc);
 
-	void (*data_xfer) (struct ata_device *, unsigned char *, unsigned int, int);
+	unsigned int (*data_xfer) (struct ata_device *dev, unsigned char *buf,
+				   unsigned int buflen, int rw);
 
 	int (*qc_defer) (struct ata_queued_cmd *qc);
 	void (*qc_prep) (struct ata_queued_cmd *qc);
@@ -880,10 +881,10 @@ extern void ata_exec_command(struct ata_port *ap, const struct ata_taskfile *tf)
 extern int ata_port_start(struct ata_port *ap);
 extern int ata_sff_port_start(struct ata_port *ap);
 extern irqreturn_t ata_interrupt(int irq, void *dev_instance);
-extern void ata_data_xfer(struct ata_device *adev, unsigned char *buf,
-			  unsigned int buflen, int write_data);
-extern void ata_data_xfer_noirq(struct ata_device *adev, unsigned char *buf,
-				unsigned int buflen, int write_data);
+extern unsigned int ata_data_xfer(struct ata_device *dev,
+			unsigned char *buf, unsigned int buflen, int rw);
+extern unsigned int ata_data_xfer_noirq(struct ata_device *dev,
+			unsigned char *buf, unsigned int buflen, int rw);
 extern int ata_std_qc_defer(struct ata_queued_cmd *qc);
 extern void ata_dumb_qc_prep(struct ata_queued_cmd *qc);
 extern void ata_qc_prep(struct ata_queued_cmd *qc);
-- 
1.5.2.4

