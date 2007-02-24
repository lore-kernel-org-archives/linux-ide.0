From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: clear drvdata in ata_host_release()
Date: Sat, 24 Feb 2007 16:48:23 +0900
Message-ID: <20070224074823.GA20322@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.183]:65255 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933410AbXBXHs0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 24 Feb 2007 02:48:26 -0500
Received: by py-out-1112.google.com with SMTP id a29so373893pyi
        for <linux-ide@vger.kernel.org>; Fri, 23 Feb 2007 23:48:25 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

ata_host_release() uses drvdata to determine ata_host to release and
clearing drvdata in ->remove_one causes NULL pointer deference.  Clear
drvdata only in ata_host_release() after all resources are freed.

This bug was first analyzed by Alan Cox for pata_pcmcia.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
---
Alan, this is the bug you talked about, right?  I took the fix from
"[BUG] PATA_PCMCIA does not work" and expanded it.  If this isn't the
one, please let me know.  Thanks.

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index d3b4e25..a705b38 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5638,6 +5638,8 @@ static void ata_host_release(struct device *gendev, void *res)
 
 	if (host->ops->host_stop)
 		host->ops->host_stop(host);
+
+	dev_set_drvdata(gendev, NULL);
 }
 
 /**
@@ -5860,7 +5862,6 @@ int ata_device_add(const struct ata_probe_ent *ent)
 
  err_out:
 	devres_release_group(dev, ata_device_add);
-	dev_set_drvdata(dev, NULL);
 	VPRINTK("EXIT, returning %d\n", rc);
 	return 0;
 }
diff --git a/drivers/ata/pata_cs5520.c b/drivers/ata/pata_cs5520.c
index b49d8b7..30e20fa 100644
--- a/drivers/ata/pata_cs5520.c
+++ b/drivers/ata/pata_cs5520.c
@@ -306,7 +306,6 @@ static void __devexit cs5520_remove_one(struct pci_dev *pdev)
 	struct ata_host *host = dev_get_drvdata(dev);
 
 	ata_host_detach(host);
-	dev_set_drvdata(dev, NULL);
 }
 
 /**
diff --git a/drivers/ata/pata_isapnp.c b/drivers/ata/pata_isapnp.c
index 1bf5ec1..e19cebf 100644
--- a/drivers/ata/pata_isapnp.c
+++ b/drivers/ata/pata_isapnp.c
@@ -128,7 +128,6 @@ static void isapnp_remove_one(struct pnp_dev *idev)
 	struct ata_host *host = dev_get_drvdata(dev);
 
 	ata_host_detach(host);
-	dev_set_drvdata(dev, NULL);
 }
 
 static struct pnp_device_id isapnp_devices[] = {
diff --git a/drivers/ata/pata_pcmcia.c b/drivers/ata/pata_pcmcia.c
index d10ae3e..4ef477c 100644
--- a/drivers/ata/pata_pcmcia.c
+++ b/drivers/ata/pata_pcmcia.c
@@ -308,7 +308,6 @@ static void pcmcia_remove_one(struct pcmcia_device *pdev)
 		if (info->ndev) {
 			struct ata_host *host = dev_get_drvdata(dev);
 			ata_host_detach(host);
-			dev_set_drvdata(dev, NULL);
 		}
 		info->ndev = 0;
 		pdev->priv = NULL;
diff --git a/drivers/ata/pata_platform.c b/drivers/ata/pata_platform.c
index 02ea95f..4b82a54 100644
--- a/drivers/ata/pata_platform.c
+++ b/drivers/ata/pata_platform.c
@@ -228,7 +228,6 @@ static int __devexit pata_platform_remove(struct platform_device *pdev)
 	struct ata_host *host = dev_get_drvdata(dev);
 
 	ata_host_detach(host);
-	dev_set_drvdata(dev, NULL);
 
 	return 0;
 }
