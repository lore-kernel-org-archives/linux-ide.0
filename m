From: Mohit Kumar <mohit.kumar@st.com>
Subject: [PATCH V3 5/8] ata: ahci platform: Add phy hooks to make it more generic
Date: Thu, 30 Jan 2014 16:18:47 +0530
Message-ID: <f82b7b246b8bedb153de5d360638ce79f13d61f0.1391077731.git.mohit.kumar@st.com>
References: <cover.1391077731.git.mohit.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from eu1sys200aog123.obsmtp.com ([207.126.144.155]:33422 "EHLO
	eu1sys200aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753049AbaA3Kth (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 30 Jan 2014 05:49:37 -0500
In-Reply-To: <cover.1391077731.git.mohit.kumar@st.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: arnd@arndb.de
Cc: Pratyush Anand <pratyush.anand@st.com>, Mohit Kumar <mohit.kumar@st.com>, Tejun Heo <tj@kernel.org>, spear-devel@list.st.com, linux-ide@vger.kernel.org

From: Pratyush Anand <pratyush.anand@st.com>

Few platform does only phy specific work in platform callbacks. It is
better to use standard phy callbacks for such platform in stead of
platform callbacks.

This patch does not break any platform callbacks. It adds phy plugins
on top of that.

It has been assumed that no platform will need both phy plugins as well
as platform callbacks.

Signed-off-by: Pratyush Anand <pratyush.anand@st.com>
Cc: Mohit Kumar <mohit.kumar@st.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: spear-devel@list.st.com
Cc: linux-ide@vger.kernel.org
---
 .../devicetree/bindings/ata/ahci-platform.txt      |    2 ++
 drivers/ata/ahci.h                                 |    2 ++
 drivers/ata/ahci_platform.c                        |   20 ++++++++++++++++++++
 3 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt b/Documentation/devicetree/bindings/ata/ahci-platform.txt
index 89de156..73dff5a 100644
--- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
+++ b/Documentation/devicetree/bindings/ata/ahci-platform.txt
@@ -10,6 +10,8 @@ Required properties:
 
 Optional properties:
 - dma-coherent      : Present if dma operations are coherent
+- phys		    : phandle to phy node associated with ahci controller
+- phy-names	    : must be "ahci-phy"
 
 Example:
         sata@ffe08000 {
diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 2289efd..77d1412 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -37,6 +37,7 @@
 
 #include <linux/clk.h>
 #include <linux/libata.h>
+#include <linux/phy/phy.h>
 
 /* Enclosure Management Control */
 #define EM_CTRL_MSG_TYPE              0x000f0000
@@ -322,6 +323,7 @@ struct ahci_host_priv {
 	u32			em_buf_sz;	/* EM buffer size in byte */
 	u32			em_msg_type;	/* EM message type */
 	struct clk		*clk;		/* Only for platforms supporting clk */
+	struct phy		*phy;		/* associated phy struct */
 	void			*plat_data;	/* Other platform data */
 };
 
diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index f955431..4253c03 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -123,6 +123,12 @@ static int ahci_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	/*
+	 * all ahci platform may not have phy node. So no need to
+	 * check return value of devm_phy_get.
+	 */
+	hpriv->phy = devm_phy_get(dev, "ahci-phy");
+
 	hpriv->flags |= (unsigned long)pi.private_data;
 
 	hpriv->mmio = devm_ioremap(dev, mem->start, resource_size(mem));
@@ -152,6 +158,10 @@ static int ahci_probe(struct platform_device *pdev)
 		rc = pdata->init(dev, hpriv->mmio);
 		if (rc)
 			goto disable_unprepare_clk;
+	} else if (hpriv->phy && hpriv->phy->ops->init) {
+		rc = hpriv->phy->ops->init(hpriv->phy);
+		if (rc)
+			goto disable_unprepare_clk;
 	}
 
 	ahci_save_initial_config(dev, hpriv,
@@ -221,6 +231,8 @@ static int ahci_probe(struct platform_device *pdev)
 pdata_exit:
 	if (pdata && pdata->exit)
 		pdata->exit(dev);
+	else if (hpriv->phy && hpriv->phy->ops->exit)
+		hpriv->phy->ops->exit(hpriv->phy);
 disable_unprepare_clk:
 	if (!IS_ERR(hpriv->clk))
 		clk_disable_unprepare(hpriv->clk);
@@ -238,6 +250,8 @@ static void ahci_host_stop(struct ata_host *host)
 
 	if (pdata && pdata->exit)
 		pdata->exit(dev);
+	else if (hpriv->phy && hpriv->phy->ops->exit)
+		hpriv->phy->ops->exit(hpriv->phy);
 
 	if (!IS_ERR(hpriv->clk)) {
 		clk_disable_unprepare(hpriv->clk);
@@ -276,6 +290,8 @@ static int ahci_suspend(struct device *dev)
 
 	if (pdata && pdata->suspend)
 		return pdata->suspend(dev);
+	else if (hpriv->phy && hpriv->phy->ops->power_off)
+		return hpriv->phy->ops->power_off(hpriv->phy);
 
 	if (!IS_ERR(hpriv->clk))
 		clk_disable_unprepare(hpriv->clk);
@@ -302,6 +318,10 @@ static int ahci_resume(struct device *dev)
 		rc = pdata->resume(dev);
 		if (rc)
 			goto disable_unprepare_clk;
+	} else if (hpriv->phy && hpriv->phy->ops->power_on) {
+		rc = hpriv->phy->ops->power_on(hpriv->phy);
+		if (rc)
+			goto disable_unprepare_clk;
 	}
 
 	if (dev->power.power_state.event == PM_EVENT_SUSPEND) {
-- 
1.7.0.1

