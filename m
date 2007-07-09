From: akpm@linux-foundation.org
Subject: [patch 11/11] ata: use iomap_name()
Date: Mon, 09 Jul 2007 11:46:23 -0700
Message-ID: <200707091846.l69IkNrm001398@imap1.linux-foundation.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:37356 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756397AbXGISzD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 9 Jul 2007 14:55:03 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org, alan@lxorguk.ukuu.org.uk, alan@redhat.com, htejun@gmail.com

From: Alan Cox <alan@lxorguk.ukuu.org.uk>

Use iomap_name() in the libata layer

Signed-off-by: Alan Cox <alan@redhat.com>
Cc: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/ata/libata-core.c |   11 ++++++-----
 include/linux/libata.h    |    9 ++++++---
 2 files changed, 12 insertions(+), 8 deletions(-)

diff -puN drivers/ata/libata-core.c~ata-use-iomap_name drivers/ata/libata-core.c
--- a/drivers/ata/libata-core.c~ata-use-iomap_name
+++ a/drivers/ata/libata-core.c
@@ -6354,6 +6354,7 @@ void ata_host_init(struct ata_host *host
 int ata_host_register(struct ata_host *host, struct scsi_host_template *sht)
 {
 	int i, rc;
+	char ctlbuf[IOMAP_NAMELEN], cmdbuf[IOMAP_NAMELEN], dmabuf[IOMAP_NAMELEN];
 
 	/* host must have been started */
 	if (!(host->flags & ATA_HOST_STARTED)) {
@@ -6410,13 +6411,13 @@ int ata_host_register(struct ata_host *h
 
 		/* print per-port info to dmesg */
 		if (!ata_port_is_dummy(ap))
-			ata_port_printk(ap, KERN_INFO, "%cATA max %s cmd 0x%p "
-					"ctl 0x%p bmdma 0x%p irq %d\n",
+			ata_port_printk(ap, KERN_INFO, "%cATA max %s cmd %s "
+					"ctl %s bmdma %s irq %d\n",
 					(ap->flags & ATA_FLAG_SATA) ? 'S' : 'P',
 					ata_mode_string(xfer_mask),
-					ap->ioaddr.cmd_addr,
-					ap->ioaddr.ctl_addr,
-					ap->ioaddr.bmdma_addr,
+					iomap_name(ap->ioaddr.cmd_addr, cmdbuf, sizeof(cmdbuf)),
+					iomap_name(ap->ioaddr.ctl_addr, ctlbuf, sizeof(ctlbuf)),
+					iomap_name(ap->ioaddr.bmdma_addr, dmabuf, sizeof(dmabuf)),
 					irq_line);
 		else
 			ata_port_printk(ap, KERN_INFO, "DUMMY\n");
diff -puN include/linux/libata.h~ata-use-iomap_name include/linux/libata.h
--- a/include/linux/libata.h~ata-use-iomap_name
+++ a/include/linux/libata.h
@@ -1114,11 +1114,14 @@ static inline u8 ata_busy_wait(struct at
 
 static inline u8 ata_wait_idle(struct ata_port *ap)
 {
+	char buf[IOMAP_NAMELEN];
 	u8 status = ata_busy_wait(ap, ATA_BUSY | ATA_DRQ, 1000);
 
-	if (status != 0xff && (status & (ATA_BUSY | ATA_DRQ)))
-		DPRINTK("ATA: abnormal status 0x%X on port 0x%p\n",
-			status, ap->ioaddr.status_addr);
+	if (status != 0xff && (status & (ATA_BUSY | ATA_DRQ))) {
+  		if (ata_msg_warn(ap))
+			printk(KERN_WARNING "ATA: abnormal status 0x%X on port %s\n",
+ 				status, iomap_name(ap->ioaddr.status_addr, buf, sizeof(buf)));
+	}
 
 	return status;
 }
_
