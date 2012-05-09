From: Viresh Kumar <viresh.kumar@st.com>
Subject: [PATCH V3 3/3] ata/ahci_platform: Add clock framework support
Date: Wed, 9 May 2012 09:39:01 +0530
Message-ID: <0d73cf6a116a55356bdc42e8ec1e304b2777d15d.1336536285.git.viresh.kumar@st.com>
References: <cover.1336536285.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from eu1sys200aog110.obsmtp.com ([207.126.144.129]:46268 "EHLO
	eu1sys200aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751232Ab2EIEJa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 May 2012 00:09:30 -0400
In-Reply-To: <cover.1336536285.git.viresh.kumar@st.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@redhat.com
Cc: linux-ide@vger.kernel.org, sshtylyov@mvista.com, spear-devel@list.st.com, viresh.linux@gmail.com, Viresh Kumar <viresh.kumar@st.com>

On many architectures, drivers are supposed to prepare/unprepare &
enable/disable functional clock of device. This patch adds clock support for
ahci_platform.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/ata/ahci.h          |    2 +
 drivers/ata/ahci_platform.c |   57 +++++++++++++++++++++++++++++++++++++-----
 2 files changed, 52 insertions(+), 7 deletions(-)

diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index c2594dd..e36d7ae 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -35,6 +35,7 @@
 #ifndef _AHCI_H
 #define _AHCI_H
 
+#include <linux/clk.h>
 #include <linux/libata.h>
 
 /* Enclosure Management Control */
@@ -302,6 +303,7 @@ struct ahci_host_priv {
 	u32 			em_loc; /* enclosure management location */
 	u32			em_buf_sz;	/* EM buffer size in byte */
 	u32			em_msg_type;	/* EM message type */
+	struct clk		*clk;		/* Only for platforms supporting clk */
 };
 
 extern int ahci_ignore_sss;
diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index 9e419e1..d0126e8 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -12,6 +12,7 @@
  * any later version.
  */
 
+#include <linux/clk.h>
 #include <linux/kernel.h>
 #include <linux/gfp.h>
 #include <linux/module.h>
@@ -117,6 +118,17 @@ static int __init ahci_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	hpriv->clk = clk_get(dev, NULL);
+	if (IS_ERR(hpriv->clk)) {
+		dev_err(dev, "can't get clock\n");
+	} else {
+		rc = clk_prepare_enable(hpriv->clk);
+		if (rc) {
+			dev_err(dev, "clock prepare enable failed");
+			goto free_clk;
+		}
+	}
+
 	/*
 	 * Some platforms might need to prepare for mmio region access,
 	 * which could be done in the following init call. So, the mmio
@@ -126,7 +138,7 @@ static int __init ahci_probe(struct platform_device *pdev)
 	if (pdata && pdata->init) {
 		rc = pdata->init(dev, hpriv->mmio);
 		if (rc)
-			return rc;
+			goto disable_unprepare_clk;
 	}
 
 	ahci_save_initial_config(dev, hpriv,
@@ -152,7 +164,7 @@ static int __init ahci_probe(struct platform_device *pdev)
 	host = ata_host_alloc_pinfo(dev, ppi, n_ports);
 	if (!host) {
 		rc = -ENOMEM;
-		goto err0;
+		goto pdata_exit;
 	}
 
 	host->private_data = hpriv;
@@ -182,7 +194,7 @@ static int __init ahci_probe(struct platform_device *pdev)
 
 	rc = ahci_reset_controller(host);
 	if (rc)
-		goto err0;
+		goto pdata_exit;
 
 	ahci_init_controller(host);
 	ahci_print_info(host, "platform");
@@ -190,12 +202,18 @@ static int __init ahci_probe(struct platform_device *pdev)
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
+	if (!IS_ERR(hpriv->clk))
+		clk_disable_unprepare(hpriv->clk);
+free_clk:
+	if (!IS_ERR(hpriv->clk))
+		clk_put(hpriv->clk);
 	return rc;
 }
 
@@ -204,12 +222,18 @@ static int __devexit ahci_remove(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct ahci_platform_data *pdata = dev_get_platdata(dev);
 	struct ata_host *host = dev_get_drvdata(dev);
+	struct ahci_host_priv *hpriv = host->private_data;
 
 	ata_host_detach(host);
 
 	if (pdata && pdata->exit)
 		pdata->exit(dev);
 
+	if (!IS_ERR(hpriv->clk)) {
+		clk_disable_unprepare(hpriv->clk);
+		clk_put(hpriv->clk);
+	}
+
 	return 0;
 }
 
@@ -244,6 +268,10 @@ static int ahci_suspend(struct device *dev)
 
 	if (pdata && pdata->suspend)
 		return pdata->suspend(dev);
+
+	if (!IS_ERR(hpriv->clk))
+		clk_disable_unprepare(hpriv->clk);
+
 	return 0;
 }
 
@@ -251,18 +279,27 @@ static int ahci_resume(struct device *dev)
 {
 	struct ahci_platform_data *pdata = dev_get_platdata(dev);
 	struct ata_host *host = dev_get_drvdata(dev);
+	struct ahci_host_priv *hpriv = host->private_data;
 	int rc;
 
+	if (!IS_ERR(hpriv->clk)) {
+		rc = clk_prepare_enable(hpriv->clk);
+		if (rc) {
+			dev_err(dev, "clock prepare enable failed");
+			return rc;
+		}
+	}
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
@@ -270,6 +307,12 @@ static int ahci_resume(struct device *dev)
 	ata_host_resume(host);
 
 	return 0;
+
+disable_unprepare_clk:
+	if (!IS_ERR(hpriv->clk))
+		clk_disable_unprepare(hpriv->clk);
+
+	return rc;
 }
 
 static struct dev_pm_ops ahci_pm_ops = {
-- 
1.7.9

