From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] ARM: SPEAr1340: static-ize SATA functions
Date: Fri, 04 Oct 2013 19:42:31 +0200
Message-ID: <2240706.IfNdWNvgId@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:41401 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751161Ab3JDRmi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 Oct 2013 13:42:38 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Viresh Kumar <viresh.linux@gmail.com>
Cc: Shiraz Hashim <shiraz.hashim@st.com>, spear-devel@list.st.com, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>

Make sata_miphy_exit(), sata_suspend() and sata_resume() static.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-spear/spear1340.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-spear/spear1340.c b/arch/arm/mach-spear/spear1340.c
index 3fb6834..e0e4251 100644
--- a/arch/arm/mach-spear/spear1340.c
+++ b/arch/arm/mach-spear/spear1340.c
@@ -93,7 +93,7 @@ static int sata_miphy_init(struct device *dev, void __iomem *addr)
 	return 0;
 }
 
-void sata_miphy_exit(struct device *dev)
+static void sata_miphy_exit(struct device *dev)
 {
 	writel(0, SPEAR1340_PCIE_SATA_CFG);
 	writel(0, SPEAR1340_PCIE_MIPHY_CFG);
@@ -107,7 +107,7 @@ void sata_miphy_exit(struct device *dev)
 	msleep(20);
 }
 
-int sata_suspend(struct device *dev)
+static int sata_suspend(struct device *dev)
 {
 	if (dev->power.power_state.event == PM_EVENT_FREEZE)
 		return 0;
@@ -117,7 +117,7 @@ int sata_suspend(struct device *dev)
 	return 0;
 }
 
-int sata_resume(struct device *dev)
+static int sata_resume(struct device *dev)
 {
 	if (dev->power.power_state.event == PM_EVENT_THAW)
 		return 0;
-- 
1.8.2.3


