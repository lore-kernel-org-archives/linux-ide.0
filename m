From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: clear drvdata in ata_host_release(), take#2
Date: Tue, 27 Feb 2007 22:33:21 +0900
Message-ID: <20070227133321.GH20322@htj.dyndns.org>
References: <20070224074823.GA20322@htj.dyndns.org> <45E0EB9F.3050001@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.228]:23805 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751559AbXB0NdZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Feb 2007 08:33:25 -0500
Received: by wx-out-0506.google.com with SMTP id h31so1693941wxd
        for <linux-ide@vger.kernel.org>; Tue, 27 Feb 2007 05:33:24 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <45E0EB9F.3050001@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Komuro <komurojun-mbn@nifty.com>

Clearing drvdata in ->remove_one causes NULL pointer deference.  Clear
drvdata only in ata_host_release() after all resources are freed.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
pata_pcmcia is fixed by Alan's patch.  This fixes other drivers and
make libata always clear drvdata after detach.

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index bdde327..3bdb509 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5680,6 +5680,8 @@ static void ata_host_release(struct device *gendev, void *res)
 
 	if (host->ops->host_stop)
 		host->ops->host_stop(host);
+
+	dev_set_drvdata(gendev, NULL);
 }
 
 /**
@@ -5902,7 +5904,6 @@ int ata_device_add(const struct ata_probe_ent *ent)
 
  err_out:
 	devres_release_group(dev, ata_device_add);
-	dev_set_drvdata(dev, NULL);
 	VPRINTK("EXIT, returning %d\n", rc);
 	return 0;
 }
diff --git a/drivers/ata/pata_cs5520.c b/drivers/ata/pata_cs5520.c
index c1334c6..8ff2d58 100644
--- a/drivers/ata/pata_cs5520.c
+++ b/drivers/ata/pata_cs5520.c
@@ -306,7 +306,6 @@ static void __devexit cs5520_remove_one(struct pci_dev *pdev)
 	struct ata_host *host = dev_get_drvdata(dev);
 
 	ata_host_detach(host);
-	dev_set_drvdata(dev, NULL);
 }
 
 /**
diff --git a/drivers/ata/pata_isapnp.c b/drivers/ata/pata_isapnp.c
index d5f2e85..1a61cc8 100644
--- a/drivers/ata/pata_isapnp.c
+++ b/drivers/ata/pata_isapnp.c
@@ -128,7 +128,6 @@ static void isapnp_remove_one(struct pnp_dev *idev)
 	struct ata_host *host = dev_get_drvdata(dev);
 
 	ata_host_detach(host);
-	dev_set_drvdata(dev, NULL);
 }
 
 static struct pnp_device_id isapnp_devices[] = {
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
