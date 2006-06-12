From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/2] libata: kill ATA_FLAG_SRST
Date: Mon, 12 Jun 2006 23:41:00 +0900
Message-ID: <20060612144100.GB3892@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.178]:44161 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751845AbWFLOlI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 12 Jun 2006 10:41:08 -0400
Received: by py-out-1112.google.com with SMTP id x31so1711133pye
        for <linux-ide@vger.kernel.org>; Mon, 12 Jun 2006 07:41:07 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

As EDD support is removed, a LLD must implement either SRST or SATA
reset.  ATA_FLAG_SATA_RESET is enough to represent which one a LLD
implements.  Kill ATA_FLAG_SRST.

Note that both flags are already marked obsolete.  ATA_FLAG_SATA_RESET
will be removed too once all LLDs are converted to new probing
mechanism.  This partial removal is to make room for a new flag needed
for new PM.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c  |   21 ++++++---------------
 drivers/scsi/pdc_adma.c     |    4 ++--
 drivers/scsi/sata_nv.c      |    1 -
 drivers/scsi/sata_promise.c |    5 ++---
 drivers/scsi/sata_qstor.c   |    1 -
 drivers/scsi/sata_sx4.c     |    4 ++--
 drivers/scsi/sata_via.c     |    2 +-
 include/linux/libata.h      |    1 -
 8 files changed, 13 insertions(+), 26 deletions(-)

9c00ae663eb8d0dc012a3dc0af6c12a1fa7c11db
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index d73cb36..9a3bd15 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -2380,7 +2380,7 @@ void ata_bus_reset(struct ata_port *ap)
 	ap->ops->dev_select(ap, 0);
 
 	/* issue bus reset */
-	if (ap->flags & ATA_FLAG_SRST)
+	if (!(ap->flags & ATA_FLAG_SATA_RESET))
 		if (ata_bus_softreset(ap, devmask))
 			goto err_out;
 
@@ -2406,13 +2406,11 @@ void ata_bus_reset(struct ata_port *ap)
 	    (ap->device[1].class == ATA_DEV_NONE))
 		goto err_out;
 
-	if (ap->flags & (ATA_FLAG_SATA_RESET | ATA_FLAG_SRST)) {
-		/* set up device control for ATA_FLAG_SATA_RESET */
-		if (ap->flags & ATA_FLAG_MMIO)
-			writeb(ap->ctl, (void __iomem *) ioaddr->ctl_addr);
-		else
-			outb(ap->ctl, ioaddr->ctl_addr);
-	}
+	/* set up device control for ATA_FLAG_SATA_RESET */
+	if (ap->flags & ATA_FLAG_MMIO)
+		writeb(ap->ctl, (void __iomem *) ioaddr->ctl_addr);
+	else
+		outb(ap->ctl, ioaddr->ctl_addr);
 
 	DPRINTK("EXIT\n");
 	return;
@@ -5245,13 +5243,6 @@ static struct ata_port * ata_host_add(co
 
 	DPRINTK("ENTER\n");
 
-	if (!ent->port_ops->error_handler &&
-	    !(ent->host_flags & (ATA_FLAG_SATA_RESET | ATA_FLAG_SRST))) {
-		printk(KERN_ERR "ata%u: no reset mechanism available\n",
-		       port_no);
-		return NULL;
-	}
-
 	host = scsi_host_alloc(ent->sht, sizeof(struct ata_port));
 	if (!host)
 		return NULL;
diff --git a/drivers/scsi/pdc_adma.c b/drivers/scsi/pdc_adma.c
index 7ebe8e0..3831858 100644
--- a/drivers/scsi/pdc_adma.c
+++ b/drivers/scsi/pdc_adma.c
@@ -182,8 +182,8 @@ static struct ata_port_info adma_port_in
 	/* board_1841_idx */
 	{
 		.sht		= &adma_ata_sht,
-		.host_flags	= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST |
-				  ATA_FLAG_NO_LEGACY | ATA_FLAG_MMIO,
+		.host_flags	= ATA_FLAG_SLAVE_POSS | ATA_FLAG_NO_LEGACY |
+				  ATA_FLAG_MMIO,
 		.pio_mask	= 0x10, /* pio4 */
 		.udma_mask	= 0x1f, /* udma0-4 */
 		.port_ops	= &adma_ata_ops,
diff --git a/drivers/scsi/sata_nv.c b/drivers/scsi/sata_nv.c
index 9055124..aa69753 100644
--- a/drivers/scsi/sata_nv.c
+++ b/drivers/scsi/sata_nv.c
@@ -257,7 +257,6 @@ static struct ata_port_info nv_port_info
 	.sht		= &nv_sht,
 	.host_flags	= ATA_FLAG_SATA |
 			  /* ATA_FLAG_SATA_RESET | */
-			  ATA_FLAG_SRST |
 			  ATA_FLAG_NO_LEGACY,
 	.pio_mask	= NV_PIO_MASK,
 	.mwdma_mask	= NV_MWDMA_MASK,
diff --git a/drivers/scsi/sata_promise.c b/drivers/scsi/sata_promise.c
index b2b6ed5..083e06e 100644
--- a/drivers/scsi/sata_promise.c
+++ b/drivers/scsi/sata_promise.c
@@ -75,9 +75,8 @@ enum {
 
 	PDC_RESET		= (1 << 11), /* HDMA reset */
 
-	PDC_COMMON_FLAGS	= ATA_FLAG_NO_LEGACY | ATA_FLAG_SRST |
-				  ATA_FLAG_MMIO | ATA_FLAG_NO_ATAPI |
-				  ATA_FLAG_PIO_POLLING,
+	PDC_COMMON_FLAGS	= ATA_FLAG_NO_LEGACY | ATA_FLAG_MMIO |
+				  ATA_FLAG_NO_ATAPI | ATA_FLAG_PIO_POLLING,
 };
 
 
diff --git a/drivers/scsi/sata_qstor.c b/drivers/scsi/sata_qstor.c
index 98ddc25..5c84b06 100644
--- a/drivers/scsi/sata_qstor.c
+++ b/drivers/scsi/sata_qstor.c
@@ -176,7 +176,6 @@ static const struct ata_port_info qs_por
 		.sht		= &qs_ata_sht,
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_SATA_RESET |
-				  //FIXME ATA_FLAG_SRST |
 				  ATA_FLAG_MMIO | ATA_FLAG_PIO_POLLING,
 		.pio_mask	= 0x10, /* pio4 */
 		.udma_mask	= 0x7f, /* udma0-6 */
diff --git a/drivers/scsi/sata_sx4.c b/drivers/scsi/sata_sx4.c
index 7f86441..58a60ef 100644
--- a/drivers/scsi/sata_sx4.c
+++ b/drivers/scsi/sata_sx4.c
@@ -219,8 +219,8 @@ static const struct ata_port_info pdc_po
 	{
 		.sht		= &pdc_sata_sht,
 		.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
-				  ATA_FLAG_SRST | ATA_FLAG_MMIO |
-				  ATA_FLAG_NO_ATAPI | ATA_FLAG_PIO_POLLING,
+				  ATA_FLAG_MMIO | ATA_FLAG_NO_ATAPI |
+				  ATA_FLAG_PIO_POLLING,
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
diff --git a/drivers/scsi/sata_via.c b/drivers/scsi/sata_via.c
index c6975c5..44fc057 100644
--- a/drivers/scsi/sata_via.c
+++ b/drivers/scsi/sata_via.c
@@ -142,7 +142,7 @@ static const struct ata_port_operations 
 
 static struct ata_port_info svia_port_info = {
 	.sht		= &svia_sht,
-	.host_flags	= ATA_FLAG_SATA | ATA_FLAG_SRST | ATA_FLAG_NO_LEGACY,
+	.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY,
 	.pio_mask	= 0x1f,
 	.mwdma_mask	= 0x07,
 	.udma_mask	= 0x7f,
diff --git a/include/linux/libata.h b/include/linux/libata.h
index f03b866..5feb912 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -148,7 +148,6 @@ enum {
 	ATA_FLAG_SATA		= (1 << 1),
 	ATA_FLAG_NO_LEGACY	= (1 << 2), /* no legacy mode check */
 	ATA_FLAG_MMIO		= (1 << 3), /* use MMIO, not PIO */
-	ATA_FLAG_SRST		= (1 << 4), /* (obsolete) use ATA SRST, not E.D.D. */
 	ATA_FLAG_SATA_RESET	= (1 << 5), /* (obsolete) use COMRESET */
 	ATA_FLAG_NO_ATAPI	= (1 << 6), /* No ATAPI support */
 	ATA_FLAG_PIO_DMA	= (1 << 7), /* PIO cmds via DMA */
-- 
1.3.2

