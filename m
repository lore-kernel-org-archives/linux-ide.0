From: Viresh Kumar <viresh.linux@gmail.com>
Subject: [PATCH 5/5] ata/ahci_platform: Add clock framework support
Date: Fri, 20 Apr 2012 20:08:23 +0530
Message-ID: <8308fd88100d4af942d920d51bf24184fcb33b72.1334932338.git.viresh.kumar@st.com>
References: <cover.1334932338.git.viresh.kumar@st.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:63319 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754768Ab2DTOkX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 Apr 2012 10:40:23 -0400
Received: by pbcun15 with SMTP id un15so1138948pbc.19
        for <linux-ide@vger.kernel.org>; Fri, 20 Apr 2012 07:40:23 -0700 (PDT)
In-Reply-To: <cover.1334932338.git.viresh.kumar@st.com>
In-Reply-To: <cover.1334932338.git.viresh.kumar@st.com>
References: <cover.1334932338.git.viresh.kumar@st.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@redhat.com
Cc: spear-devel@list.st.com, viresh.linux@gmail.com, linux-ide@vger.kernel.org, Viresh Kumar <viresh.kumar@st.com>

On many architectures, drivers are supposed to prepare/unprepare &
enable/disable functional clock of device. This patch adds clock support for
ahci_platform.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/ata/ahci.h          |    4 +++
 drivers/ata/ahci_platform.c |   63 ++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 60 insertions(+), 7 deletions(-)

diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index c2594dd..89172c8 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -35,6 +35,7 @@
 #ifndef _AHCI_H
 #define _AHCI_H
 
+#include <linux/clk.h>
 #include <linux/libata.h>
 
 /* Enclosure Management Control */
@@ -302,6 +303,9 @@ struct ahci_host_priv {
 	u32 			em_loc; /* enclosure management location */
 	u32			em_buf_sz;	/* EM buffer size in byte */
 	u32			em_msg_type;	/* EM message type */
+#ifdef CONFIG_HAVE_CLK
+	struct clk		*clk;	/* only if HAVE_CLK is defined */
+#endif
 };
 
 extern int ahci_ignore_sss;
diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index 9e419e1..730e214 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -12,6 +12,7 @@
  * any later version.
  */
 
+#include <linux/clk.h>
 #include <linux/kernel.h>
 #include <linux/gfp.h>
 #include <linux/module.h>
@@ -117,6 +118,20 @@ static int __init ahci_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+#ifdef CONFIG_HAVE_CLK
+	hpriv->clk = clk_get(dev, NULL);
+	if (IS_ERR(hpriv->clk)) {
+		dev_err(dev, "Clock not found\n");
+		return PTR_ERR(hpriv->clk);
+	}
+
+	rc = clk_prepare_enable(hpriv->clk);
+	if (rc) {
+		dev_err(dev, "clock prepare enable failed");
+		goto free_clk;
+	}
+#endif
+
 	/*
 	 * Some platforms might need to prepare for mmio region access,
 	 * which could be done in the following init call. So, the mmio
@@ -126,7 +141,7 @@ static int __init ahci_probe(struct platform_device *pdev)
 	if (pdata && pdata->init) {
 		rc = pdata->init(dev, hpriv->mmio);
 		if (rc)
-			return rc;
+			goto disable_unprepare_clk;
 	}
 
 	ahci_save_initial_config(dev, hpriv,
@@ -152,7 +167,7 @@ static int __init ahci_probe(struct platform_device *pdev)
 	host = ata_host_alloc_pinfo(dev, ppi, n_ports);
 	if (!host) {
 		rc = -ENOMEM;
-		goto err0;
+		goto pdata_exit;
 	}
 
 	host->private_data = hpriv;
@@ -182,7 +197,7 @@ static int __init ahci_probe(struct platform_device *pdev)
 
 	rc = ahci_reset_controller(host);
 	if (rc)
-		goto err0;
+		goto pdata_exit;
 
 	ahci_init_controller(host);
 	ahci_print_info(host, "platform");
@@ -190,12 +205,18 @@ static int __init ahci_probe(struct platform_device *pdev)
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
+disable_unprepare_clk:
+#ifdef CONFIG_HAVE_CLK
+	clk_disable_unprepare(hpriv->clk);
+free_clk:
+	clk_put(hpriv->clk);
+#endif
 	return rc;
 }
 
@@ -204,12 +225,19 @@ static int __devexit ahci_remove(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct ahci_platform_data *pdata = dev_get_platdata(dev);
 	struct ata_host *host = dev_get_drvdata(dev);
+#ifdef CONFIG_HAVE_CLK
+	struct ahci_host_priv *hpriv = host->private_data;
+#endif
 
 	ata_host_detach(host);
 
 	if (pdata && pdata->exit)
 		pdata->exit(dev);
 
+#ifdef CONFIG_HAVE_CLK
+	clk_disable_unprepare(hpriv->clk);
+	clk_put(hpriv->clk);
+#endif
 	return 0;
 }
 
@@ -244,6 +272,11 @@ static int ahci_suspend(struct device *dev)
 
 	if (pdata && pdata->suspend)
 		return pdata->suspend(dev);
+
+#ifdef CONFIG_HAVE_CLK
+	clk_disable_unprepare(hpriv->clk);
+#endif
+
 	return 0;
 }
 
@@ -253,16 +286,26 @@ static int ahci_resume(struct device *dev)
 	struct ata_host *host = dev_get_drvdata(dev);
 	int rc;
 
+#ifdef CONFIG_HAVE_CLK
+	struct ahci_host_priv *hpriv = host->private_data;
+
+	rc = clk_prepare_enable(hpriv->clk);
+	if (rc) {
+		dev_err(dev, "clock prepare enable failed");
+		return rc;
+	}
+#endif
+
 	if (pdata && pdata->resume) {
 		rc = pdata->resume(dev);
 		if (rc)
-			return rc;
+			goto disable_unprepare_clk;
 	}
 
 	if (dev->power.power_state.event == PM_EVENT_SUSPEND) {
 		rc = ahci_reset_controller(host);
 		if (rc)
-			return rc;
+			goto disable_unprepare_clk;
 
 		ahci_init_controller(host);
 	}
@@ -270,6 +313,12 @@ static int ahci_resume(struct device *dev)
 	ata_host_resume(host);
 
 	return 0;
+
+disable_unprepare_clk:
+#ifdef CONFIG_HAVE_CLK
+	clk_disable_unprepare(hpriv->clk);
+#endif
+	return rc;
 }
 
 static struct dev_pm_ops ahci_pm_ops = {
-- 
1.7.9

