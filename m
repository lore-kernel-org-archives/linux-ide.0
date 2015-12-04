From: Andreas Werner <andreas.werner@men.de>
Subject: [v2 1/2] libata-eh.c: Introduce new ata port flag for controller
 which lockup on read log page
Date: Fri, 4 Dec 2015 18:12:49 +0100
Message-ID: <a6e9f8f1d473b6b1d52b8cec26dd33065ee8bb6e.1449248754.git.andreas.werner@men.de>
References: <cover.1449248754.git.andreas.werner@men.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1449248754.git.andreas.werner@men.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-ide@vger.kernel.org, tj@kernel.org
List-Id: linux-ide@vger.kernel.org

Some controller lockup on a ata_read_log_page.
Add new ata port flag ATA_FLAG_NO_LOG_PAGE which can used
to blacklist a controller.

If this flag is set, any attempt to read a log page returns an error
without actually issuing the command.

Signed-off-by: Andreas Werner <andreas.werner@men.de>
---
 drivers/ata/libata-eh.c | 9 +++++++++
 include/linux/libata.h  | 1 +
 2 files changed, 10 insertions(+)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index cb0508a..c59c2bc 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1505,12 +1505,21 @@ static const char *ata_err_string(unsigned int err_mask)
 unsigned int ata_read_log_page(struct ata_device *dev, u8 log,
 			       u8 page, void *buf, unsigned int sectors)
 {
+	unsigned long ap_flags = dev->link->ap->flags;
 	struct ata_taskfile tf;
 	unsigned int err_mask;
 	bool dma = false;
 
 	DPRINTK("read log page - log 0x%x, page 0x%x\n", log, page);
 
+	/*
+	 * Return error without actually issuing the
+	 * command on controller which e.g. lockup
+	 * on a read log page.
+	 */
+	if (ap_flags & ATA_FLAG_NO_LOG_PAGE)
+		return AC_ERR_DEV;
+
 retry:
 	ata_tf_init(dev, &tf);
 	if (dev->dma_mode && ata_id_has_read_log_dma_ext(dev->id) &&
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 83577f8..600c1e0 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -210,6 +210,7 @@ enum {
 	ATA_FLAG_SLAVE_POSS	= (1 << 0), /* host supports slave dev */
 					    /* (doesn't imply presence) */
 	ATA_FLAG_SATA		= (1 << 1),
+	ATA_FLAG_NO_LOG_PAGE	= (1 << 5), /* do not issue log page read */
 	ATA_FLAG_NO_ATAPI	= (1 << 6), /* No ATAPI support */
 	ATA_FLAG_PIO_DMA	= (1 << 7), /* PIO cmds via DMA */
 	ATA_FLAG_PIO_LBA48	= (1 << 8), /* Host DMA engine is LBA28 only */
-- 
2.6.2
