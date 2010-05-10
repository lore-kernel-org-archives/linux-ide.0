From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 13/23] libata-sff: ap->[last_]ctl are SFF specific
Date: Mon, 10 May 2010 21:41:37 +0200
Message-ID: <1273520507-32459-14-git-send-email-tj@kernel.org>
References: <1273520507-32459-1-git-send-email-tj@kernel.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:44951 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756136Ab0EJTm1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 10 May 2010 15:42:27 -0400
In-Reply-To: <1273520507-32459-1-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, sshtylyov@mvista.com
Cc: Tejun Heo <tj@kernel.org>

ap->[last_]ctl are specific to SFF controllers.  Put them inside
CONFIG_ATA_SFF and move initialization into ata_sff_port_init().

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/ata/libata-core.c |    2 --
 drivers/ata/libata-sff.c  |    2 ++
 include/linux/libata.h    |    8 ++++++--
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 200f49d..bf6ffc1 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5634,10 +5634,8 @@ struct ata_port *ata_port_alloc(struct ata_host *host)
 	ap->pflags |= ATA_PFLAG_INITIALIZING;
 	ap->lock = &host->lock;
 	ap->print_id = -1;
-	ap->ctl = ATA_DEVCTL_OBS;
 	ap->host = host;
 	ap->dev = host->dev;
-	ap->last_ctl = 0xFF;
 
 #if defined(ATA_VERBOSE_DEBUG)
 	/* turn on all debugging levels */
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 9effce9..0d55440 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -3054,6 +3054,8 @@ EXPORT_SYMBOL_GPL(ata_pci_bmdma_init);
  */
 void ata_sff_port_init(struct ata_port *ap)
 {
+	ap->ctl = ATA_DEVCTL_OBS;
+	ap->last_ctl = 0xFF;
 }
 
 int __init ata_sff_init(void)
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 3c451ab..88c4cc9 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -721,10 +721,10 @@ struct ata_port {
 
 #ifdef CONFIG_ATA_SFF
 	struct ata_ioports	ioaddr;	/* ATA cmd/ctl/dma register blocks */
-#endif /* CONFIG_ATA_SFF */
-
 	u8			ctl;	/* cache of ATA control register */
 	u8			last_ctl;	/* Cache last written value */
+#endif /* CONFIG_ATA_SFF */
+
 	unsigned int		pio_mask;
 	unsigned int		mwdma_mask;
 	unsigned int		udma_mask;
@@ -1434,7 +1434,11 @@ static inline void ata_tf_init(struct ata_device *dev, struct ata_taskfile *tf)
 {
 	memset(tf, 0, sizeof(*tf));
 
+#ifdef CONFIG_ATA_SFF
 	tf->ctl = dev->link->ap->ctl;
+#else
+	tf->ctl = ATA_DEVCTL_OBS;
+#endif
 	if (dev->devno == 0)
 		tf->device = ATA_DEVICE_OBS;
 	else
-- 
1.6.4.2

