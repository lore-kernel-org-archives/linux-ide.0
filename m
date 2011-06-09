From: Viresh Kumar <viresh.kumar@st.com>
Subject: [PATCH] ata/ahci_platform: Add support for enabling/disabling clock.
Date: Thu, 9 Jun 2011 14:28:12 +0530
Message-ID: <211461c299bab630fda07f81963cab0b5f40c98d.1307609821.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from eu1sys200aog120.obsmtp.com ([207.126.144.149]:50430 "EHLO
	eu1sys200aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751368Ab1FII6y (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Jun 2011 04:58:54 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: armando.visconti@st.com, shiraz.hashim@st.com, vipin.kumar@st.com, rajeev-dlh.kumar@st.com, deepak.sikri@st.com, vipulkumar.samar@st.com, amit.virdi@st.com, viresh.kumar@st.com, pratyush.anand@st.com, bhupesh.sharma@st.com, viresh.linux@gmail.com

On many architectures, drivers are supposed to enable/disable functional clock
of device. This patch adds support for clock enabling/disabling in
ahci_platform.c.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/ata/ahci.h          |    4 ++++
 drivers/ata/ahci_platform.c |   36 +++++++++++++++++++++++++++++++-----
 2 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 12c5282..fec6289 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -35,6 +35,7 @@
 #ifndef _AHCI_H
 #define _AHCI_H
 
+#include <linux/clk.h>
 #include <linux/libata.h>
 
 /* Enclosure Management Control */
@@ -296,6 +297,9 @@ struct ahci_host_priv {
 	u32 			em_loc; /* enclosure management location */
 	u32			em_buf_sz;	/* EM buffer size in byte */
 	u32			em_msg_type;	/* EM message type */
+#ifdef CONFIG_HAVE_CLK
+	struct clk *clk;	/* clk structure, only if HAVE_CLK is defined */
+#endif
 };
 
 extern int ahci_ignore_sss;
diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index 6fef1fa..eaa4053 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -12,6 +12,7 @@
  * any later version.
  */
 
+#include <linux/clk.h>
 #include <linux/kernel.h>
 #include <linux/gfp.h>
 #include <linux/module.h>
@@ -75,6 +76,20 @@ static int __init ahci_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+#ifdef CONFIG_HAVE_CLK
+	hpriv->clk = clk_get(dev, NULL);
+	if (IS_ERR(hpriv->clk)) {
+		dev_err(dev, "Clock not found\n");
+		return PTR_ERR(hpriv->clk);
+	}
+
+	rc = clk_enable(hpriv->clk);
+	if (rc) {
+		dev_err(dev, "clock enable failed");
+		goto free_clk;
+	}
+#endif
+
 	/*
 	 * Some platforms might need to prepare for mmio region access,
 	 * which could be done in the following init call. So, the mmio
@@ -84,7 +99,7 @@ static int __init ahci_probe(struct platform_device *pdev)
 	if (pdata && pdata->init) {
 		rc = pdata->init(dev, hpriv->mmio);
 		if (rc)
-			return rc;
+			goto disable_clk;
 	}
 
 	ahci_save_initial_config(dev, hpriv,
@@ -110,7 +125,7 @@ static int __init ahci_probe(struct platform_device *pdev)
 	host = ata_host_alloc_pinfo(dev, ppi, n_ports);
 	if (!host) {
 		rc = -ENOMEM;
-		goto err0;
+		goto pdata_exit;
 	}
 
 	host->private_data = hpriv;
@@ -140,7 +155,7 @@ static int __init ahci_probe(struct platform_device *pdev)
 
 	rc = ahci_reset_controller(host);
 	if (rc)
-		goto err0;
+		goto pdata_exit;
 
 	ahci_init_controller(host);
 	ahci_print_info(host, "platform");
@@ -148,12 +163,18 @@ static int __init ahci_probe(struct platform_device *pdev)
 	rc = ata_host_activate(host, irq, ahci_interrupt, IRQF_SHARED,
 			       &ahci_platform_sht);
 	if (rc)
-		goto err0;
+		goto pdata_exit;
 
 	return 0;
-err0:
+pdata_exit:
 	if (pdata && pdata->exit)
 		pdata->exit(dev);
+disable_clk:
+#ifdef CONFIG_HAVE_CLK
+	clk_disable(hpriv->clk);
+free_clk:
+	clk_put(hpriv->clk);
+#endif
 	return rc;
 }
 
@@ -162,12 +183,17 @@ static int __devexit ahci_remove(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct ahci_platform_data *pdata = dev->platform_data;
 	struct ata_host *host = dev_get_drvdata(dev);
+	struct ahci_host_priv *hpriv = host->private_data;
 
 	ata_host_detach(host);
 
 	if (pdata && pdata->exit)
 		pdata->exit(dev);
 
+#ifdef CONFIG_HAVE_CLK
+	clk_disable(hpriv->clk);
+	clk_put(hpriv->clk);
+#endif
 	return 0;
 }
 
-- 
1.7.2.2

