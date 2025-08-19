Received: from zg8tmty1ljiyny4xntuumtyw.icoremail.net (zg8tmty1ljiyny4xntuumtyw.icoremail.net [165.227.155.160])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C471EF09B;
	Tue, 19 Aug 2025 14:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=165.227.155.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755612062; cv=none; b=FEO6kYIScye8JIQ0RzoG2GX26We7Y1e3NQW2RwpfeW8YF2tFEng5JqXxAtowUcdzGNEUkYpGdrXRCja5ivRYyR9fSiNwOkDHb6Ub8YUE7zpVwNzAuhzCeNkZhMz8YMY8uypt0VnClusJIlnUZ+6JVoRxUIE8ocDbl5k1p8lk67g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755612062; c=relaxed/simple;
	bh=rdvJbsWDu/ujIdLpdIOR4iWehy6iFX6UuTRVqm9Rmmg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g78tI/6kZTb9MALCN1Q3cLjIiZQPWaU60HBjXxlQNmvlCNa7WDQHJzjxKc5kLeSkqzfwIS4qRdjGVDKA3ECeryOtgZgRfQXsQLqCpFDKy23aD7nPnkkHWxMhoBRwnUa0cs9q2Jk3NEgqBKh5fZIdmHGI/QvLeY9Jsr+MAQyI0II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=165.227.155.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0006800LT.eswin.cn (unknown [10.12.96.77])
	by app2 (Coremail) with SMTP id TQJkCgDHWZOUg6RoI6nAAA--.20466S2;
	Tue, 19 Aug 2025 22:00:54 +0800 (CST)
From: Yulin Lu <luyulin@eswincomputing.com>
To: dlemoal@kernel.org,
	cassel@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-ide@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vkoul@kernel.org,
	kishon@kernel.org,
	linux-phy@lists.infradead.org
Cc: ningyu@eswincomputing.com,
	zhengyu@eswincomputing.com,
	linmin@eswincomputing.com,
	huangyifeng@eswincomputing.com,
	fenglin@eswincomputing.com,
	lianghujun@eswincomputing.com,
	luyulin <luyulin@eswincomputing.com>
Subject: [PATCH v2 3/3] phy: eswin: Create eswin directory and add EIC7700 SATA PHY driver
Date: Tue, 19 Aug 2025 22:00:43 +0800
Message-Id: <20250819140043.1862-1-luyulin@eswincomputing.com>
X-Mailer: git-send-email 2.31.1.windows.1
In-Reply-To: <20250819134722.220-1-luyulin@eswincomputing.com>
References: <20250819134722.220-1-luyulin@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TQJkCgDHWZOUg6RoI6nAAA--.20466S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtF43tw4rZw4rGw1fAr45Awb_yoWfGr45pF
	4DCFyUWrWktF47Ka97J3WqyF43GrnFqrya9FyDGa4avFW3Jr18XanIqa95tFn0vrn7J3yU
	K3sYqa47Ga15A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9C14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wrylc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMx
	C20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAF
	wI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20x
	vE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxK
	x2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI
	0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRJPE-UUUUU=
X-CM-SenderInfo: pox13z1lq6v25zlqu0xpsx3x1qjou0bp/

From: luyulin <luyulin@eswincomputing.com>

Created the eswin phy driver directory and added support for
the SATA phy driver on the EIC7700 SoC platform.

Signed-off-by: luyulin <luyulin@eswincomputing.com>
---
 drivers/phy/Kconfig                  |   1 +
 drivers/phy/Makefile                 |   1 +
 drivers/phy/eswin/Kconfig            |  14 ++
 drivers/phy/eswin/Makefile           |   2 +
 drivers/phy/eswin/phy-eic7700-sata.c | 197 +++++++++++++++++++++++++++
 5 files changed, 215 insertions(+)
 create mode 100644 drivers/phy/eswin/Kconfig
 create mode 100644 drivers/phy/eswin/Makefile
 create mode 100644 drivers/phy/eswin/phy-eic7700-sata.c

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index 58c911e1b2d2..e82ebcfe534a 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -105,6 +105,7 @@ source "drivers/phy/allwinner/Kconfig"
 source "drivers/phy/amlogic/Kconfig"
 source "drivers/phy/broadcom/Kconfig"
 source "drivers/phy/cadence/Kconfig"
+source "drivers/phy/eswin/Kconfig"
 source "drivers/phy/freescale/Kconfig"
 source "drivers/phy/hisilicon/Kconfig"
 source "drivers/phy/ingenic/Kconfig"
diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index c670a8dac468..ed7444949259 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -17,6 +17,7 @@ obj-y					+= allwinner/	\
 					   amlogic/	\
 					   broadcom/	\
 					   cadence/	\
+					   eswin/	\
 					   freescale/	\
 					   hisilicon/	\
 					   ingenic/	\
diff --git a/drivers/phy/eswin/Kconfig b/drivers/phy/eswin/Kconfig
new file mode 100644
index 000000000000..3fcd76582c3b
--- /dev/null
+++ b/drivers/phy/eswin/Kconfig
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Phy drivers for Eswin platforms
+#
+config PHY_EIC7700_SATA
+	tristate "eic7700 Sata SerDes/PHY driver"
+	depends on ARCH_ESWIN || COMPILE_TEST
+	depends on HAS_IOMEM
+	select GENERIC_PHY
+	help
+	  Enable this to support SerDes/Phy found on ESWIN's
+	  EIC7700 SoC.This Phy supports SATA 1.5 Gb/s,
+	  SATA 3.0 Gb/s, SATA 6.0 Gb/s speeds.
+	  It supports one SATA host port to accept one SATA device.
diff --git a/drivers/phy/eswin/Makefile b/drivers/phy/eswin/Makefile
new file mode 100644
index 000000000000..db08c66be812
--- /dev/null
+++ b/drivers/phy/eswin/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_PHY_EIC7700_SATA)	+= phy-eic7700-sata.o
diff --git a/drivers/phy/eswin/phy-eic7700-sata.c b/drivers/phy/eswin/phy-eic7700-sata.c
new file mode 100644
index 000000000000..8a757839e868
--- /dev/null
+++ b/drivers/phy/eswin/phy-eic7700-sata.c
@@ -0,0 +1,197 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ESWIN SATA PHY driver
+ *
+ * Copyright 2024, Beijing ESWIN Computing Technology Co., Ltd..
+ * All rights reserved.
+ *
+ * Authors: Yulin Lu <luyulin@eswincomputing.com>
+ */
+
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+
+#define SATA_CLK_CTRL			0x0
+#define SATA_AXI_LP_CTRL		0x08
+#define SATA_MPLL_CTRL			0x20
+#define SATA_PHY_CTRL0			0x28
+#define SATA_PHY_CTRL1			0x2c
+#define SATA_REF_CTRL1			0x38
+#define SATA_REG_CTRL			0x34
+#define SATA_LOS_IDEN			0x3c
+#define SATA_RESET_CTRL			0x40
+#define SATA_CLK_RST_SOURCE_PHY		BIT(0)
+#define SATA_SYS_CLK_EN			BIT(28)
+#define SATA_PHY_RESET			BIT(0)
+#define SATA_PORT_RESET			BIT(1)
+#define SATA_LOS_LEVEL			0x9
+#define SATA_LOS_BIAS			(0x02 << 16)
+#define SATA_REF_REPEATCLK_EN		BIT(0)
+#define SATA_REF_USE_PAD		BIT(20)
+#define SATA_P0_AMPLITUDE_GEN1		0x42
+#define SATA_P0_AMPLITUDE_GEN2		(0x46 << 8)
+#define SATA_P0_AMPLITUDE_GEN3		(0x73 << 16)
+#define SATA_P0_PHY_TX_PREEMPH_GEN1	0x05
+#define SATA_P0_PHY_TX_PREEMPH_GEN2	(0x05 << 8)
+#define SATA_P0_PHY_TX_PREEMPH_GEN3	(0x08 << 16)
+#define SATA_MPLL_MULTIPLIER		(0x3c << 16)
+#define SATA_M_CSYSREQ			BIT(0)
+#define SATA_S_CSYSREQ			BIT(16)
+#define SATA_P0_PHY_STAT		0x24
+#define SATA_P0_PHY_READY		BIT(0)
+
+#define PHY_READY_TIMEOUT		(usecs_to_jiffies(4000))
+
+struct eic7700_sata_phy {
+	struct phy *phy;
+	void __iomem *regs;
+};
+
+static int wait_for_phy_ready(void __iomem *base, u32 reg, u32 checkbit,
+			      u32 status)
+{
+	unsigned long start = jiffies;
+	unsigned long timeout = start + PHY_READY_TIMEOUT;
+
+	while (time_before(start, timeout)) {
+		if ((readl(base + reg) & checkbit) == status)
+			return 0;
+		usleep_range(50, 70);
+	}
+
+	return -EFAULT;
+}
+
+static int eic7700_sata_phy_init(struct phy *phy)
+{
+	struct eic7700_sata_phy *sata_phy = phy_get_drvdata(phy);
+	u32 val = 0;
+	int ret = 0;
+
+	/*
+	 * The SATA_CLK_CTRL register offset controls the pmalive, rxoob,
+	 * and rbc clocks gate provided by the PHY through the HSP bus,
+	 * and it is not registered in the clock tree.
+	 */
+	val = readl(sata_phy->regs + SATA_CLK_CTRL);
+	val |= SATA_SYS_CLK_EN;
+	writel(val, sata_phy->regs + SATA_CLK_CTRL);
+
+	writel(SATA_CLK_RST_SOURCE_PHY, sata_phy->regs + SATA_REF_CTRL1);
+	writel(SATA_P0_AMPLITUDE_GEN1 | SATA_P0_AMPLITUDE_GEN2 |
+	       SATA_P0_AMPLITUDE_GEN3, sata_phy->regs + SATA_PHY_CTRL0);
+	writel(SATA_P0_PHY_TX_PREEMPH_GEN1 | SATA_P0_PHY_TX_PREEMPH_GEN2 |
+	       SATA_P0_PHY_TX_PREEMPH_GEN3, sata_phy->regs + SATA_PHY_CTRL1);
+	writel(SATA_LOS_LEVEL | SATA_LOS_BIAS,
+	       sata_phy->regs + SATA_LOS_IDEN);
+	writel(SATA_M_CSYSREQ | SATA_S_CSYSREQ,
+	       sata_phy->regs + SATA_AXI_LP_CTRL);
+	writel(SATA_REF_REPEATCLK_EN | SATA_REF_USE_PAD,
+	       sata_phy->regs + SATA_REG_CTRL);
+	writel(SATA_MPLL_MULTIPLIER, sata_phy->regs + SATA_MPLL_CTRL);
+	usleep_range(15, 20);
+
+	/*
+	 * The SATA_RESET_CTRL register offset controls reset/deassert
+	 * for both the port and the PHY through the HSP bus,
+	 * and it is not registered in the reset tree.
+	 */
+	val = readl(sata_phy->regs + SATA_RESET_CTRL);
+	val &= ~(SATA_PHY_RESET | SATA_PORT_RESET);
+	writel(val, sata_phy->regs + SATA_RESET_CTRL);
+
+	ret = wait_for_phy_ready(sata_phy->regs, SATA_P0_PHY_STAT,
+				 SATA_P0_PHY_READY, 1);
+	if (ret < 0)
+		dev_err(&sata_phy->phy->dev,
+			"PHY READY check failed\n");
+	return ret;
+}
+
+static int eic7700_sata_phy_exit(struct phy *phy)
+{
+	struct eic7700_sata_phy *sata_phy = phy_get_drvdata(phy);
+	u32 val = 0;
+
+	val = readl(sata_phy->regs + SATA_RESET_CTRL);
+	val |= SATA_PHY_RESET | SATA_PORT_RESET;
+	writel(val, sata_phy->regs + SATA_RESET_CTRL);
+
+	val = readl(sata_phy->regs + SATA_CLK_CTRL);
+	val &= ~SATA_SYS_CLK_EN;
+	writel(val, sata_phy->regs + SATA_CLK_CTRL);
+
+	return 0;
+}
+
+static const struct phy_ops eic7700_sata_phy_ops = {
+	.init		= eic7700_sata_phy_init,
+	.exit		= eic7700_sata_phy_exit,
+	.owner		= THIS_MODULE,
+};
+
+static int eic7700_sata_phy_probe(struct platform_device *pdev)
+{
+	struct eic7700_sata_phy *sata_phy;
+	struct device *dev = &pdev->dev;
+	struct phy_provider *phy_provider;
+	u32 val = 0;
+	int ret = 0;
+
+	sata_phy = devm_kzalloc(dev, sizeof(*sata_phy), GFP_KERNEL);
+	if (!sata_phy)
+		return -ENOMEM;
+
+	sata_phy->regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(sata_phy->regs))
+		return PTR_ERR(sata_phy->regs);
+
+	dev_set_drvdata(dev, sata_phy);
+
+	sata_phy->phy = devm_phy_create(dev, NULL, &eic7700_sata_phy_ops);
+	if (IS_ERR(sata_phy->phy)) {
+		dev_err(dev, "failed to create PHY\n");
+		ret = PTR_ERR(sata_phy->phy);
+		goto clk_disable;
+	}
+
+	phy_set_drvdata(sata_phy->phy, sata_phy);
+
+	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+	if (IS_ERR(phy_provider)) {
+		ret = PTR_ERR(phy_provider);
+		goto clk_disable;
+	}
+
+	return 0;
+
+clk_disable:
+	val = readl(sata_phy->regs + SATA_CLK_CTRL);
+	val &= ~SATA_SYS_CLK_EN;
+	writel(val, sata_phy->regs + SATA_CLK_CTRL);
+
+	return ret;
+}
+
+static const struct of_device_id eic7700_sata_phy_of_match[] = {
+	{ .compatible = "eswin,eic7700-sata-phy" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, eic7700_sata_phy_of_match);
+
+static struct platform_driver eic7700_sata_phy_driver = {
+	.probe	= eic7700_sata_phy_probe,
+	.driver = {
+		.of_match_table	= eic7700_sata_phy_of_match,
+		.name  = "eswin,sata-phy",
+		.suppress_bind_attrs = true,
+	}
+};
+module_platform_driver(eic7700_sata_phy_driver);
+
+MODULE_DESCRIPTION("SATA PHY driver for the ESWIN EIC7700 SoC");
+MODULE_AUTHOR("Yulin Lu <luyulin@eswincomputing.com>");
+MODULE_LICENSE("GPL");
-- 
2.25.1

