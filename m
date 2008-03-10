From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH #upstream-fixes] ahci: implement skip_host_reset parameter
Date: Mon, 10 Mar 2008 10:25:25 +0900
Message-ID: <47D48E05.4090001@gmail.com>
References: <Pine.LNX.4.64.0803051143450.27209@Soyuz-KT.TeNet.Odessa.UA> <47CE9264.1010600@garzik.org> <Pine.LNX.4.64.0803051443500.28213@Soyuz-KT.TeNet.Odessa.UA> <47CFBDB6.8040400@gmail.com> <Pine.LNX.4.64.0803061417540.5200@Soyuz-KT.TeNet.Odessa.UA> <47D0BC5A.9000208@gmail.com> <Pine.LNX.4.64.0803071038380.12026@Soyuz-KT.TeNet.Odessa.UA> <47D1E91D.8090704@gmail.com> <Pine.LNX.4.64.0803081801120.23474@Soyuz-KT.TeNet.Odessa.UA> <47D371F5.1020804@gmail.com> <47D3720D.7040004@gmail.com> <Pine.LNX.4.64.0803091938210.28462@Soyuz-KT.TeNet.Odessa.UA>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:58286 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752084AbYCJBZf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Mar 2008 21:25:35 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1996038wah.23
        for <linux-ide@vger.kernel.org>; Sun, 09 Mar 2008 18:25:35 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0803091938210.28462@Soyuz-KT.TeNet.Odessa.UA>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Rus V. Brushkoff" <rus@SoyuzKT.Od.UA>, Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, Mark Lord <liml@rtr.ca>

Under certain circumstances (SSP turned off by the BIOS) and for
debugging purposes, skipping global controller reset is helpful.  Add
a kernel parameter for it.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ahci.c |   48 +++++++++++++++++++++++++++++-------------------
 1 file changed, 29 insertions(+), 19 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 70a0f07..fb1af0f 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -49,6 +49,10 @@
 #define DRV_NAME	"ahci"
 #define DRV_VERSION	"3.0"
 
+static int ahci_skip_host_reset;
+module_param_named(skip_host_reset, ahci_skip_host_reset, int, 0444);
+MODULE_PARM_DESC(skip_host_reset, "skip global host reset (0=don't skip, 1=skip)");
+
 static int ahci_enable_alpm(struct ata_port *ap,
 		enum link_pm policy);
 static void ahci_disable_alpm(struct ata_port *ap);
@@ -1057,29 +1061,35 @@ static int ahci_reset_controller(struct ata_host *host)
 	ahci_enable_ahci(mmio);
 
 	/* global controller reset */
-	tmp = readl(mmio + HOST_CTL);
-	if ((tmp & HOST_RESET) == 0) {
-		writel(tmp | HOST_RESET, mmio + HOST_CTL);
-		readl(mmio + HOST_CTL); /* flush */
-	}
+	if (!ahci_skip_host_reset) {
+		tmp = readl(mmio + HOST_CTL);
+		if ((tmp & HOST_RESET) == 0) {
+			writel(tmp | HOST_RESET, mmio + HOST_CTL);
+			readl(mmio + HOST_CTL); /* flush */
+		}
 
-	/* reset must complete within 1 second, or
-	 * the hardware should be considered fried.
-	 */
-	ssleep(1);
+		/* reset must complete within 1 second, or
+		 * the hardware should be considered fried.
+		 */
+		ssleep(1);
 
-	tmp = readl(mmio + HOST_CTL);
-	if (tmp & HOST_RESET) {
-		dev_printk(KERN_ERR, host->dev,
-			   "controller reset failed (0x%x)\n", tmp);
-		return -EIO;
-	}
+		tmp = readl(mmio + HOST_CTL);
+		if (tmp & HOST_RESET) {
+			dev_printk(KERN_ERR, host->dev,
+				   "controller reset failed (0x%x)\n", tmp);
+			return -EIO;
+		}
 
-	/* turn on AHCI mode */
-	ahci_enable_ahci(mmio);
+		/* turn on AHCI mode */
+		ahci_enable_ahci(mmio);
 
-	/* some registers might be cleared on reset.  restore initial values */
-	ahci_restore_initial_config(host);
+		/* Some registers might be cleared on reset.  Restore
+		 * initial values.
+		 */
+		ahci_restore_initial_config(host);
+	} else
+		dev_printk(KERN_INFO, host->dev,
+			   "skipping global host reset\n");
 
 	if (pdev->vendor == PCI_VENDOR_ID_INTEL) {
 		u16 tmp16;
