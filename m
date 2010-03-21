From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [RFC PATCH 19/19] pata_pcmcia: get rid of extra indirection
Date: Mon, 22 Mar 2010 00:07:37 +0100
Message-ID: <1269212857-25364-19-git-send-email-linux@dominikbrodowski.net>
References: <20100321230617.GA24791@comet.dominikbrodowski.net>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from isilmar.linta.de ([213.133.102.198]:60051 "EHLO linta.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753266Ab0CUXIh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 21 Mar 2010 19:08:37 -0400
In-Reply-To: <20100321230617.GA24791@comet.dominikbrodowski.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-pcmcia@lists.infradead.org
Cc: Dominik Brodowski <linux@dominikbrodowski.net>, linux-ide@vger.kernel.org

We don't need ata_pcmcia_info any more.

CC: linux-ide@vger.kernel.org
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 drivers/ata/pata_pcmcia.c |   41 ++++++-----------------------------------
 1 files changed, 6 insertions(+), 35 deletions(-)

diff --git a/drivers/ata/pata_pcmcia.c b/drivers/ata/pata_pcmcia.c
index 1336216..8bcb8b6 100644
--- a/drivers/ata/pata_pcmcia.c
+++ b/drivers/ata/pata_pcmcia.c
@@ -44,16 +44,6 @@
 #define DRV_NAME "pata_pcmcia"
 #define DRV_VERSION "0.3.5"
 
-/*
- *	Private data structure to glue stuff together
- */
-
-struct ata_pcmcia_info {
-	struct pcmcia_device *pdev;
-	int		ndev;
-	dev_node_t	node;
-};
-
 /**
  *	pcmcia_set_mode	-	PCMCIA specific mode setup
  *	@link: link
@@ -247,7 +237,6 @@ static int pcmcia_init_one(struct pcmcia_device *pdev)
 {
 	struct ata_host *host;
 	struct ata_port *ap;
-	struct ata_pcmcia_info *info;
 	struct pcmcia_config_check *stk = NULL;
 	int is_kme = 0, ret = -ENOMEM, p;
 	unsigned long io_base, ctl_base;
@@ -255,14 +244,6 @@ static int pcmcia_init_one(struct pcmcia_device *pdev)
 	int n_ports = 1;
 	struct ata_port_operations *ops = &pcmcia_port_ops;
 
-	info = kzalloc(sizeof(*info), GFP_KERNEL);
-	if (info == NULL)
-		return -ENOMEM;
-
-	/* Glue stuff together. FIXME: We may be able to get rid of info with care */
-	info->pdev = pdev;
-	pdev->priv = info;
-
 	/* Set up attributes in order to probe card and get resources */
 	pdev->io.Attributes1 = IO_DATA_PATH_WIDTH_AUTO;
 	pdev->io.Attributes2 = IO_DATA_PATH_WIDTH_8;
@@ -346,16 +327,14 @@ static int pcmcia_init_one(struct pcmcia_device *pdev)
 	if (ret)
 		goto failed;
 
-	info->ndev = 1;
+	pdev->priv = host;
 	kfree(stk);
 	return 0;
 
 failed:
 	kfree(stk);
-	info->ndev = 0;
 	pcmcia_disable_device(pdev);
 out1:
-	kfree(info);
 	return ret;
 }
 
@@ -369,20 +348,12 @@ out1:
 
 static void pcmcia_remove_one(struct pcmcia_device *pdev)
 {
-	struct ata_pcmcia_info *info = pdev->priv;
-	struct device *dev = &pdev->dev;
-
-	if (info != NULL) {
-		/* If we have attached the device to the ATA layer, detach it */
-		if (info->ndev) {
-			struct ata_host *host = dev_get_drvdata(dev);
-			ata_host_detach(host);
-		}
-		info->ndev = 0;
-		pdev->priv = NULL;
-	}
+	struct ata_host *host = pdev->priv;
+
+	if (host)
+		ata_host_detach(host);
+
 	pcmcia_disable_device(pdev);
-	kfree(info);
 }
 
 static struct pcmcia_device_id pcmcia_devices[] = {
-- 
1.6.3.3

