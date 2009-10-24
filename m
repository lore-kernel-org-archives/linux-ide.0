From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 04/16] pcmcia: use dynamic debug infrastructure, deprecate CS_CHECK (ide)
Date: Sat, 24 Oct 2009 21:42:54 +0200
Message-ID: <1256413386-20501-4-git-send-email-linux@dominikbrodowski.net>
References: <20091024194219.GA19546@comet.dominikbrodowski.net>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from isilmar.linta.de ([213.133.102.198]:55661 "EHLO linta.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751841AbZJXTnQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 24 Oct 2009 15:43:16 -0400
In-Reply-To: <20091024194219.GA19546@comet.dominikbrodowski.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-pcmcia@lists.infradead.org
Cc: Dominik Brodowski <linux@dominikbrodowski.net>, linux-ide@vger.kernel.org

ide-cs.c is the only PCMCIA device driver making use of CONFIG_PCMCIA_DEBUG,
so convert it to use the dynamic debug infrastructure.

Also, remove all usages of the CS_CHECK macro and replace them with proper
Linux style calling and return value checking. The extra error reporting may
be dropped, as the PCMCIA core already complains about any (non-driver-author)
errors.

CC: linux-ide@vger.kernel.org
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 drivers/ata/pata_pcmcia.c |   16 ++++++++--------
 drivers/ide/ide-cs.c      |   32 +++++++++++---------------------
 2 files changed, 19 insertions(+), 29 deletions(-)

diff --git a/drivers/ata/pata_pcmcia.c b/drivers/ata/pata_pcmcia.c
index dc99e26..5f94e21 100644
--- a/drivers/ata/pata_pcmcia.c
+++ b/drivers/ata/pata_pcmcia.c
@@ -177,9 +177,6 @@ static struct ata_port_operations pcmcia_8bit_port_ops = {
 	.drain_fifo	= pcmcia_8bit_drain_fifo,
 };
 
-#define CS_CHECK(fn, ret) \
-do { last_fn = (fn); if ((last_ret = (ret)) != 0) goto cs_failed; } while (0)
-
 
 struct pcmcia_config_check {
 	unsigned long ctl_base;
@@ -252,7 +249,7 @@ static int pcmcia_init_one(struct pcmcia_device *pdev)
 	struct ata_port *ap;
 	struct ata_pcmcia_info *info;
 	struct pcmcia_config_check *stk = NULL;
-	int last_ret = 0, last_fn = 0, is_kme = 0, ret = -ENOMEM, p;
+	int is_kme = 0, ret = -ENOMEM, p;
 	unsigned long io_base, ctl_base;
 	void __iomem *io_addr, *ctl_addr;
 	int n_ports = 1;
@@ -296,8 +293,13 @@ static int pcmcia_init_one(struct pcmcia_device *pdev)
 	}
 	io_base = pdev->io.BasePort1;
 	ctl_base = stk->ctl_base;
-	CS_CHECK(RequestIRQ, pcmcia_request_irq(pdev, &pdev->irq));
-	CS_CHECK(RequestConfiguration, pcmcia_request_configuration(pdev, &pdev->conf));
+	ret = pcmcia_request_irq(pdev, &pdev->irq);
+	if (ret)
+		goto failed;
+
+	ret = pcmcia_request_configuration(pdev, &pdev->conf);
+	if (ret)
+		goto failed;
 
 	/* iomap */
 	ret = -ENOMEM;
@@ -351,8 +353,6 @@ static int pcmcia_init_one(struct pcmcia_device *pdev)
 	kfree(stk);
 	return 0;
 
-cs_failed:
-	cs_error(pdev, last_fn, last_ret);
 failed:
 	kfree(stk);
 	info->ndev = 0;
diff --git a/drivers/ide/ide-cs.c b/drivers/ide/ide-cs.c
index 063b933..6cee6c8 100644
--- a/drivers/ide/ide-cs.c
+++ b/drivers/ide/ide-cs.c
@@ -60,15 +60,6 @@ MODULE_AUTHOR("David Hinds <dahinds@users.sourceforge.net>");
 MODULE_DESCRIPTION("PCMCIA ATA/IDE card driver");
 MODULE_LICENSE("Dual MPL/GPL");
 
-#define INT_MODULE_PARM(n, v) static int n = v; module_param(n, int, 0)
-
-#ifdef CONFIG_PCMCIA_DEBUG
-INT_MODULE_PARM(pc_debug, 0);
-#define DEBUG(n, args...) if (pc_debug>(n)) printk(KERN_DEBUG args)
-#else
-#define DEBUG(n, args...)
-#endif
-
 /*====================================================================*/
 
 typedef struct ide_info_t {
@@ -98,7 +89,7 @@ static int ide_probe(struct pcmcia_device *link)
 {
     ide_info_t *info;
 
-    DEBUG(0, "ide_attach()\n");
+    dev_dbg(&link->dev, "ide_attach()\n");
 
     /* Create new ide device */
     info = kzalloc(sizeof(*info), GFP_KERNEL);
@@ -134,7 +125,7 @@ static void ide_detach(struct pcmcia_device *link)
     ide_hwif_t *hwif = info->host->ports[0];
     unsigned long data_addr, ctl_addr;
 
-    DEBUG(0, "ide_detach(0x%p)\n", link);
+    dev_dbg(&link->dev, "ide_detach(0x%p)\n", link);
 
     data_addr = hwif->io_ports.data_addr;
     ctl_addr  = hwif->io_ports.ctl_addr;
@@ -217,9 +208,6 @@ out_release:
 
 ======================================================================*/
 
-#define CS_CHECK(fn, ret) \
-do { last_fn = (fn); if ((last_ret = (ret)) != 0) goto cs_failed; } while (0)
-
 struct pcmcia_config_check {
 	unsigned long ctl_base;
 	int skip_vcc;
@@ -282,11 +270,11 @@ static int ide_config(struct pcmcia_device *link)
 {
     ide_info_t *info = link->priv;
     struct pcmcia_config_check *stk = NULL;
-    int last_ret = 0, last_fn = 0, is_kme = 0;
+    int ret = 0, is_kme = 0;
     unsigned long io_base, ctl_base;
     struct ide_host *host;
 
-    DEBUG(0, "ide_config(0x%p)\n", link);
+    dev_dbg(&link->dev, "ide_config(0x%p)\n", link);
 
     is_kme = ((link->manf_id == MANFID_KME) &&
 	      ((link->card_id == PRODID_KME_KXLC005_A) ||
@@ -306,8 +294,12 @@ static int ide_config(struct pcmcia_device *link)
     io_base = link->io.BasePort1;
     ctl_base = stk->ctl_base;
 
-    CS_CHECK(RequestIRQ, pcmcia_request_irq(link, &link->irq));
-    CS_CHECK(RequestConfiguration, pcmcia_request_configuration(link, &link->conf));
+    ret = pcmcia_request_irq(link, &link->irq);
+    if (ret)
+	    goto failed;
+    ret = pcmcia_request_configuration(link, &link->conf);
+    if (ret)
+	    goto failed;
 
     /* disable drive interrupts during IDE probe */
     outb(0x02, ctl_base);
@@ -342,8 +334,6 @@ err_mem:
     printk(KERN_NOTICE "ide-cs: ide_config failed memory allocation\n");
     goto failed;
 
-cs_failed:
-    cs_error(link, last_fn, last_ret);
 failed:
     kfree(stk);
     ide_release(link);
@@ -363,7 +353,7 @@ static void ide_release(struct pcmcia_device *link)
     ide_info_t *info = link->priv;
     struct ide_host *host = info->host;
 
-    DEBUG(0, "ide_release(0x%p)\n", link);
+    dev_dbg(&link->dev, "ide_release(0x%p)\n", link);
 
     if (info->ndev)
 	/* FIXME: if this fails we need to queue the cleanup somehow
-- 
1.6.0.4

