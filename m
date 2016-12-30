From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 2/3] ata: pass queued command to ->sff_data_xfer method
Date: Fri, 30 Dec 2016 15:01:17 +0100
Message-ID: <1483106478-1382-3-git-send-email-b.zolnierkie@samsung.com>
References: <1483106478-1382-1-git-send-email-b.zolnierkie@samsung.com>
 <CGME20161230140144epcas1p2ada13244f4ba5b45ed903ab7d614f6db@epcas1p2.samsung.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:55804 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754209AbcL3OBq (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 30 Dec 2016 09:01:46 -0500
In-reply-to: <1483106478-1382-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Michael Schmitz <schmitzmic@gmail.com>, linux-ide@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com

For Atari Falcon PATA support we need to check the current command
in its ->sff_data_xfer method.  Update core code and all users
accordingly.

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/libata-sff.c      | 29 +++++++++++++++--------------
 drivers/ata/pata_at91.c       |  6 +++---
 drivers/ata/pata_bf54x.c      |  7 ++++---
 drivers/ata/pata_ep93xx.c     |  4 ++--
 drivers/ata/pata_ixp4xx_cf.c  |  4 ++--
 drivers/ata/pata_legacy.c     | 15 +++++++++------
 drivers/ata/pata_octeon_cf.c  | 12 ++++++------
 drivers/ata/pata_pcmcia.c     |  6 +++---
 drivers/ata/pata_samsung_cf.c |  4 ++--
 drivers/ata/sata_rcar.c       |  4 ++--
 include/linux/libata.h        |  8 ++++----
 11 files changed, 52 insertions(+), 47 deletions(-)

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 051b615..4441b5c 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -542,7 +542,7 @@ static inline void ata_tf_to_host(struct ata_port *ap,
 
 /**
  *	ata_sff_data_xfer - Transfer data by PIO
- *	@dev: device to target
+ *	@qc: queued command
  *	@buf: data buffer
  *	@buflen: buffer length
  *	@rw: read/write
@@ -555,10 +555,10 @@ static inline void ata_tf_to_host(struct ata_port *ap,
  *	RETURNS:
  *	Bytes consumed.
  */
-unsigned int ata_sff_data_xfer(struct ata_device *dev, unsigned char *buf,
+unsigned int ata_sff_data_xfer(struct ata_queued_cmd *qc, unsigned char *buf,
 			       unsigned int buflen, int rw)
 {
-	struct ata_port *ap = dev->link->ap;
+	struct ata_port *ap = qc->dev->link->ap;
 	void __iomem *data_addr = ap->ioaddr.data_addr;
 	unsigned int words = buflen >> 1;
 
@@ -595,7 +595,7 @@ unsigned int ata_sff_data_xfer(struct ata_device *dev, unsigned char *buf,
 
 /**
  *	ata_sff_data_xfer32 - Transfer data by PIO
- *	@dev: device to target
+ *	@qc: queued command
  *	@buf: data buffer
  *	@buflen: buffer length
  *	@rw: read/write
@@ -610,16 +610,17 @@ unsigned int ata_sff_data_xfer(struct ata_device *dev, unsigned char *buf,
  *	Bytes consumed.
  */
 
-unsigned int ata_sff_data_xfer32(struct ata_device *dev, unsigned char *buf,
+unsigned int ata_sff_data_xfer32(struct ata_queued_cmd *qc, unsigned char *buf,
 			       unsigned int buflen, int rw)
 {
+	struct ata_device *dev = qc->dev;
 	struct ata_port *ap = dev->link->ap;
 	void __iomem *data_addr = ap->ioaddr.data_addr;
 	unsigned int words = buflen >> 2;
 	int slop = buflen & 3;
 
 	if (!(ap->pflags & ATA_PFLAG_PIO32))
-		return ata_sff_data_xfer(dev, buf, buflen, rw);
+		return ata_sff_data_xfer(qc, buf, buflen, rw);
 
 	/* Transfer multiple of 4 bytes */
 	if (rw == READ)
@@ -658,7 +659,7 @@ unsigned int ata_sff_data_xfer32(struct ata_device *dev, unsigned char *buf,
 
 /**
  *	ata_sff_data_xfer_noirq - Transfer data by PIO
- *	@dev: device to target
+ *	@qc: queued command
  *	@buf: data buffer
  *	@buflen: buffer length
  *	@rw: read/write
@@ -672,14 +673,14 @@ unsigned int ata_sff_data_xfer32(struct ata_device *dev, unsigned char *buf,
  *	RETURNS:
  *	Bytes consumed.
  */
-unsigned int ata_sff_data_xfer_noirq(struct ata_device *dev, unsigned char *buf,
+unsigned int ata_sff_data_xfer_noirq(struct ata_queued_cmd *qc, unsigned char *buf,
 				     unsigned int buflen, int rw)
 {
 	unsigned long flags;
 	unsigned int consumed;
 
 	local_irq_save(flags);
-	consumed = ata_sff_data_xfer32(dev, buf, buflen, rw);
+	consumed = ata_sff_data_xfer32(qc, buf, buflen, rw);
 	local_irq_restore(flags);
 
 	return consumed;
@@ -723,14 +724,14 @@ static void ata_pio_sector(struct ata_queued_cmd *qc)
 		buf = kmap_atomic(page);
 
 		/* do the actual data transfer */
-		ap->ops->sff_data_xfer(qc->dev, buf + offset, qc->sect_size,
+		ap->ops->sff_data_xfer(qc, buf + offset, qc->sect_size,
 				       do_write);
 
 		kunmap_atomic(buf);
 		local_irq_restore(flags);
 	} else {
 		buf = page_address(page);
-		ap->ops->sff_data_xfer(qc->dev, buf + offset, qc->sect_size,
+		ap->ops->sff_data_xfer(qc, buf + offset, qc->sect_size,
 				       do_write);
 	}
 
@@ -791,7 +792,7 @@ static void atapi_send_cdb(struct ata_port *ap, struct ata_queued_cmd *qc)
 	DPRINTK("send cdb\n");
 	WARN_ON_ONCE(qc->dev->cdb_len < 12);
 
-	ap->ops->sff_data_xfer(qc->dev, qc->cdb, qc->dev->cdb_len, 1);
+	ap->ops->sff_data_xfer(qc, qc->cdb, qc->dev->cdb_len, 1);
 	ata_sff_sync(ap);
 	/* FIXME: If the CDB is for DMA do we need to do the transition delay
 	   or is bmdma_start guaranteed to do it ? */
@@ -868,14 +869,14 @@ static int __atapi_pio_bytes(struct ata_queued_cmd *qc, unsigned int bytes)
 		buf = kmap_atomic(page);
 
 		/* do the actual data transfer */
-		consumed = ap->ops->sff_data_xfer(dev,  buf + offset,
+		consumed = ap->ops->sff_data_xfer(qc, buf + offset,
 								count, rw);
 
 		kunmap_atomic(buf);
 		local_irq_restore(flags);
 	} else {
 		buf = page_address(page);
-		consumed = ap->ops->sff_data_xfer(dev,  buf + offset,
+		consumed = ap->ops->sff_data_xfer(qc, buf + offset,
 								count, rw);
 	}
 
diff --git a/drivers/ata/pata_at91.c b/drivers/ata/pata_at91.c
index 1611e0e..fd5b34f 100644
--- a/drivers/ata/pata_at91.c
+++ b/drivers/ata/pata_at91.c
@@ -286,10 +286,10 @@ static void pata_at91_set_piomode(struct ata_port *ap, struct ata_device *adev)
 	set_smc_timing(ap->dev, adev, info, &timing);
 }
 
-static unsigned int pata_at91_data_xfer_noirq(struct ata_device *dev,
+static unsigned int pata_at91_data_xfer_noirq(struct ata_queued_cmd *qc,
 		unsigned char *buf, unsigned int buflen, int rw)
 {
-	struct at91_ide_info *info = dev->link->ap->host->private_data;
+	struct at91_ide_info *info = qc->dev->link->ap->host->private_data;
 	unsigned int consumed;
 	unsigned int mode;
 	unsigned long flags;
@@ -301,7 +301,7 @@ static unsigned int pata_at91_data_xfer_noirq(struct ata_device *dev,
 	regmap_fields_write(fields.mode, info->cs, (mode & ~AT91_SMC_DBW) |
 			    AT91_SMC_DBW_16);
 
-	consumed = ata_sff_data_xfer(dev, buf, buflen, rw);
+	consumed = ata_sff_data_xfer(qc, buf, buflen, rw);
 
 	/* restore 8bit mode after data is written */
 	regmap_fields_write(fields.mode, info->cs, (mode & ~AT91_SMC_DBW) |
diff --git a/drivers/ata/pata_bf54x.c b/drivers/ata/pata_bf54x.c
index ec748d3..9c5780a 100644
--- a/drivers/ata/pata_bf54x.c
+++ b/drivers/ata/pata_bf54x.c
@@ -1143,7 +1143,7 @@ static unsigned char bfin_bmdma_status(struct ata_port *ap)
 
 /**
  *	bfin_data_xfer - Transfer data by PIO
- *	@adev: device for this I/O
+ *	@qc: queued command
  *	@buf: data buffer
  *	@buflen: buffer length
  *	@write_data: read/write
@@ -1151,10 +1151,11 @@ static unsigned char bfin_bmdma_status(struct ata_port *ap)
  *	Note: Original code is ata_sff_data_xfer().
  */
 
-static unsigned int bfin_data_xfer(struct ata_device *dev, unsigned char *buf,
+static unsigned int bfin_data_xfer(struct ata_queued_cmd *qc,
+				   unsigned char *buf,
 				   unsigned int buflen, int rw)
 {
-	struct ata_port *ap = dev->link->ap;
+	struct ata_port *ap = qc->dev->link->ap;
 	void __iomem *base = (void __iomem *)ap->ioaddr.ctl_addr;
 	unsigned int words = buflen >> 1;
 	unsigned short *buf16 = (u16 *)buf;
diff --git a/drivers/ata/pata_ep93xx.c b/drivers/ata/pata_ep93xx.c
index bd6b089..bf1b910 100644
--- a/drivers/ata/pata_ep93xx.c
+++ b/drivers/ata/pata_ep93xx.c
@@ -474,11 +474,11 @@ static void ep93xx_pata_set_devctl(struct ata_port *ap, u8 ctl)
 }
 
 /* Note: original code is ata_sff_data_xfer */
-static unsigned int ep93xx_pata_data_xfer(struct ata_device *adev,
+static unsigned int ep93xx_pata_data_xfer(struct ata_queued_cmd *qc,
 					  unsigned char *buf,
 					  unsigned int buflen, int rw)
 {
-	struct ata_port *ap = adev->link->ap;
+	struct ata_port *ap = qc->dev->link->ap;
 	struct ep93xx_pata_data *drv_data = ap->host->private_data;
 	u16 *data = (u16 *)buf;
 	unsigned int words = buflen >> 1;
diff --git a/drivers/ata/pata_ixp4xx_cf.c b/drivers/ata/pata_ixp4xx_cf.c
index abda441..0b0d930 100644
--- a/drivers/ata/pata_ixp4xx_cf.c
+++ b/drivers/ata/pata_ixp4xx_cf.c
@@ -40,13 +40,13 @@ static int ixp4xx_set_mode(struct ata_link *link, struct ata_device **error)
 	return 0;
 }
 
-static unsigned int ixp4xx_mmio_data_xfer(struct ata_device *dev,
+static unsigned int ixp4xx_mmio_data_xfer(struct ata_queued_cmd *qc,
 				unsigned char *buf, unsigned int buflen, int rw)
 {
 	unsigned int i;
 	unsigned int words = buflen >> 1;
 	u16 *buf16 = (u16 *) buf;
-	struct ata_port *ap = dev->link->ap;
+	struct ata_port *ap = qc->dev->link->ap;
 	void __iomem *mmio = ap->ioaddr.data_addr;
 	struct ixp4xx_pata_data *data = dev_get_platdata(ap->host->dev);
 
diff --git a/drivers/ata/pata_legacy.c b/drivers/ata/pata_legacy.c
index bce2a8c..53828b6c 100644
--- a/drivers/ata/pata_legacy.c
+++ b/drivers/ata/pata_legacy.c
@@ -303,11 +303,12 @@ static void pdc20230_set_piomode(struct ata_port *ap, struct ata_device *adev)
 
 }
 
-static unsigned int pdc_data_xfer_vlb(struct ata_device *dev,
+static unsigned int pdc_data_xfer_vlb(struct ata_queued_cmd *qc,
 			unsigned char *buf, unsigned int buflen, int rw)
 {
-	int slop = buflen & 3;
+	struct ata_device *dev = qc->dev;
 	struct ata_port *ap = dev->link->ap;
+	int slop = buflen & 3;
 
 	/* 32bit I/O capable *and* we need to write a whole number of dwords */
 	if (ata_id_has_dword_io(dev->id) && (slop == 0 || slop == 3)
@@ -340,7 +341,7 @@ static unsigned int pdc_data_xfer_vlb(struct ata_device *dev,
 		}
 		local_irq_restore(flags);
 	} else
-		buflen = ata_sff_data_xfer_noirq(dev, buf, buflen, rw);
+		buflen = ata_sff_data_xfer_noirq(qc, buf, buflen, rw);
 
 	return buflen;
 }
@@ -702,9 +703,11 @@ static unsigned int qdi_qc_issue(struct ata_queued_cmd *qc)
 	return ata_sff_qc_issue(qc);
 }
 
-static unsigned int vlb32_data_xfer(struct ata_device *adev, unsigned char *buf,
-					unsigned int buflen, int rw)
+static unsigned int vlb32_data_xfer(struct ata_queued_cmd *qc,
+				    unsigned char *buf,
+				    unsigned int buflen, int rw)
 {
+	struct ata_device *adev = qc->dev;
 	struct ata_port *ap = adev->link->ap;
 	int slop = buflen & 3;
 
@@ -727,7 +730,7 @@ static unsigned int vlb32_data_xfer(struct ata_device *adev, unsigned char *buf,
 		}
 		return (buflen + 3) & ~3;
 	} else
-		return ata_sff_data_xfer(adev, buf, buflen, rw);
+		return ata_sff_data_xfer(qc, buf, buflen, rw);
 }
 
 static int qdi_port(struct platform_device *dev,
diff --git a/drivers/ata/pata_octeon_cf.c b/drivers/ata/pata_octeon_cf.c
index 475a006..e94e7ca 100644
--- a/drivers/ata/pata_octeon_cf.c
+++ b/drivers/ata/pata_octeon_cf.c
@@ -293,17 +293,17 @@ static void octeon_cf_set_dmamode(struct ata_port *ap, struct ata_device *dev)
 /**
  * Handle an 8 bit I/O request.
  *
- * @dev:        Device to access
+ * @qc:         Queued command
  * @buffer:     Data buffer
  * @buflen:     Length of the buffer.
  * @rw:         True to write.
  */
-static unsigned int octeon_cf_data_xfer8(struct ata_device *dev,
+static unsigned int octeon_cf_data_xfer8(struct ata_queued_cmd *qc,
 					 unsigned char *buffer,
 					 unsigned int buflen,
 					 int rw)
 {
-	struct ata_port *ap		= dev->link->ap;
+	struct ata_port *ap		= qc->dev->link->ap;
 	void __iomem *data_addr		= ap->ioaddr.data_addr;
 	unsigned long words;
 	int count;
@@ -332,17 +332,17 @@ static unsigned int octeon_cf_data_xfer8(struct ata_device *dev,
 /**
  * Handle a 16 bit I/O request.
  *
- * @dev:        Device to access
+ * @qc:         Queued command
  * @buffer:     Data buffer
  * @buflen:     Length of the buffer.
  * @rw:         True to write.
  */
-static unsigned int octeon_cf_data_xfer16(struct ata_device *dev,
+static unsigned int octeon_cf_data_xfer16(struct ata_queued_cmd *qc,
 					  unsigned char *buffer,
 					  unsigned int buflen,
 					  int rw)
 {
-	struct ata_port *ap		= dev->link->ap;
+	struct ata_port *ap		= qc->dev->link->ap;
 	void __iomem *data_addr		= ap->ioaddr.data_addr;
 	unsigned long words;
 	int count;
diff --git a/drivers/ata/pata_pcmcia.c b/drivers/ata/pata_pcmcia.c
index bcc4b96..a541eac 100644
--- a/drivers/ata/pata_pcmcia.c
+++ b/drivers/ata/pata_pcmcia.c
@@ -90,7 +90,7 @@ static int pcmcia_set_mode_8bit(struct ata_link *link,
 
 /**
  *	ata_data_xfer_8bit	 -	Transfer data by 8bit PIO
- *	@dev: device to target
+ *	@qc: queued command
  *	@buf: data buffer
  *	@buflen: buffer length
  *	@rw: read/write
@@ -101,10 +101,10 @@ static int pcmcia_set_mode_8bit(struct ata_link *link,
  *	Inherited from caller.
  */
 
-static unsigned int ata_data_xfer_8bit(struct ata_device *dev,
+static unsigned int ata_data_xfer_8bit(struct ata_queued_cmd *qc,
 				unsigned char *buf, unsigned int buflen, int rw)
 {
-	struct ata_port *ap = dev->link->ap;
+	struct ata_port *ap = qc->dev->link->ap;
 
 	if (rw == READ)
 		ioread8_rep(ap->ioaddr.data_addr, buf, buflen);
diff --git a/drivers/ata/pata_samsung_cf.c b/drivers/ata/pata_samsung_cf.c
index f6facd6..431c7de 100644
--- a/drivers/ata/pata_samsung_cf.c
+++ b/drivers/ata/pata_samsung_cf.c
@@ -263,10 +263,10 @@ static u8 pata_s3c_check_altstatus(struct ata_port *ap)
 /*
  * pata_s3c_data_xfer - Transfer data by PIO
  */
-static unsigned int pata_s3c_data_xfer(struct ata_device *dev,
+static unsigned int pata_s3c_data_xfer(struct ata_queued_cmd *qc,
 				unsigned char *buf, unsigned int buflen, int rw)
 {
-	struct ata_port *ap = dev->link->ap;
+	struct ata_port *ap = qc->dev->link->ap;
 	struct s3c_ide_info *info = ap->host->private_data;
 	void __iomem *data_addr = ap->ioaddr.data_addr;
 	unsigned int words = buflen >> 1, i;
diff --git a/drivers/ata/sata_rcar.c b/drivers/ata/sata_rcar.c
index f72d601..5d38245 100644
--- a/drivers/ata/sata_rcar.c
+++ b/drivers/ata/sata_rcar.c
@@ -447,11 +447,11 @@ static void sata_rcar_exec_command(struct ata_port *ap,
 	ata_sff_pause(ap);
 }
 
-static unsigned int sata_rcar_data_xfer(struct ata_device *dev,
+static unsigned int sata_rcar_data_xfer(struct ata_queued_cmd *qc,
 					      unsigned char *buf,
 					      unsigned int buflen, int rw)
 {
-	struct ata_port *ap = dev->link->ap;
+	struct ata_port *ap = qc->dev->link->ap;
 	void __iomem *data_addr = ap->ioaddr.data_addr;
 	unsigned int words = buflen >> 1;
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index c170be5..0e8a800 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -968,7 +968,7 @@ struct ata_port_operations {
 	void (*sff_tf_read)(struct ata_port *ap, struct ata_taskfile *tf);
 	void (*sff_exec_command)(struct ata_port *ap,
 				 const struct ata_taskfile *tf);
-	unsigned int (*sff_data_xfer)(struct ata_device *dev,
+	unsigned int (*sff_data_xfer)(struct ata_queued_cmd *qc,
 			unsigned char *buf, unsigned int buflen, int rw);
 	void (*sff_irq_on)(struct ata_port *);
 	bool (*sff_irq_check)(struct ata_port *);
@@ -1823,11 +1823,11 @@ extern int ata_sff_busy_sleep(struct ata_port *ap,
 extern void ata_sff_tf_read(struct ata_port *ap, struct ata_taskfile *tf);
 extern void ata_sff_exec_command(struct ata_port *ap,
 				 const struct ata_taskfile *tf);
-extern unsigned int ata_sff_data_xfer(struct ata_device *dev,
+extern unsigned int ata_sff_data_xfer(struct ata_queued_cmd *qc,
 			unsigned char *buf, unsigned int buflen, int rw);
-extern unsigned int ata_sff_data_xfer32(struct ata_device *dev,
+extern unsigned int ata_sff_data_xfer32(struct ata_queued_cmd *qc,
 			unsigned char *buf, unsigned int buflen, int rw);
-extern unsigned int ata_sff_data_xfer_noirq(struct ata_device *dev,
+extern unsigned int ata_sff_data_xfer_noirq(struct ata_queued_cmd *qc,
 			unsigned char *buf, unsigned int buflen, int rw);
 extern void ata_sff_irq_on(struct ata_port *ap);
 extern void ata_sff_irq_clear(struct ata_port *ap);
-- 
1.9.1

