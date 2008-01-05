From: Tejun Heo <htejun@gmail.com>
Subject: ahci: factor out AHCI enabling and enable AHCI before reading CAP
Date: Sat, 05 Jan 2008 23:11:57 +0900
Message-ID: <477F902D.2000400@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.191]:14288 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752606AbYAEOMG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 5 Jan 2008 09:12:06 -0500
Received: by rv-out-0910.google.com with SMTP id k20so6463773rvb.1
        for <linux-ide@vger.kernel.org>; Sat, 05 Jan 2008 06:12:05 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Factor out AHCI enabling into ahci_enable_ahci() and enabling AHCI
before reading CAP in ahci_save_initial_config() as the spec requires
enabling AHCI mode before accessing any other registers.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ahci.c |   27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

Index: work/drivers/ata/ahci.c
===================================================================
--- work.orig/drivers/ata/ahci.c
+++ work/drivers/ata/ahci.c
@@ -597,6 +597,20 @@ static inline void __iomem *ahci_port_ba
 	return __ahci_port_base(ap->host, ap->port_no);
 }
 
+static void ahci_enable_ahci(void __iomem *mmio)
+{
+	u32 tmp;
+
+	/* turn on AHCI_EN */
+	tmp = readl(mmio + HOST_CTL);
+	if (!(tmp & HOST_AHCI_EN)) {
+		tmp |= HOST_AHCI_EN;
+		writel(tmp, mmio + HOST_CTL);
+		tmp = readl(mmio + HOST_CTL);	/* flush && sanity check */
+		WARN_ON(!(tmp & HOST_AHCI_EN));
+	}
+}
+
 /**
  *	ahci_save_initial_config - Save and fixup initial config values
  *	@pdev: target PCI device
@@ -619,6 +633,9 @@ static void ahci_save_initial_config(str
 	u32 cap, port_map;
 	int i;
 
+	/* make sure AHCI mode is enabled before accessing CAP */
+	ahci_enable_ahci(mmio);
+
 	/* Values prefixed with saved_ are written back to host after
 	 * reset.  Values without are used for driver operation.
 	 */
@@ -1042,13 +1059,10 @@ static int ahci_reset_controller(struct 
 	/* we must be in AHCI mode, before using anything
 	 * AHCI-specific, such as HOST_RESET.
 	 */
-	tmp = readl(mmio + HOST_CTL);
-	if (!(tmp & HOST_AHCI_EN)) {
-		tmp |= HOST_AHCI_EN;
-		writel(tmp, mmio + HOST_CTL);
-	}
+	ahci_enable_ahci(mmio);
 
 	/* global controller reset */
+	tmp = readl(mmio + HOST_CTL);
 	if ((tmp & HOST_RESET) == 0) {
 		writel(tmp | HOST_RESET, mmio + HOST_CTL);
 		readl(mmio + HOST_CTL); /* flush */
@@ -1067,8 +1081,7 @@ static int ahci_reset_controller(struct 
 	}
 
 	/* turn on AHCI mode */
-	writel(HOST_AHCI_EN, mmio + HOST_CTL);
-	(void) readl(mmio + HOST_CTL);	/* flush */
+	ahci_enable_ahci(mmio);
 
 	/* some registers might be cleared on reset.  restore initial values */
 	ahci_restore_initial_config(host);
