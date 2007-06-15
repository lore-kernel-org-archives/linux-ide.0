From: Sonic Zhang <sonic.adi@gmail.com>
Subject: [PATCH] [libata] Add irq_flags to struct pata_platform_info
Date: Fri, 15 Jun 2007 17:45:49 +0800
Message-ID: <1181900749.23447.7.camel@sevens.analog.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nwd2mail10.analog.com ([137.71.25.55]:9832 "EHLO
	nwd2mail10.analog.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750861AbXFOJwd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 15 Jun 2007 05:52:33 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linux IDE <linux-ide@vger.kernel.org>
Cc: Jeff Garzik <jeff@garzik.org>

On some embedded platforms, such as blackfin, the gpio interrupt for
IDE interface is designed to be triggered with high voltage. The gpio
port should be configured properly by set_irq_type() when register
the irq. This patch enable the generic pata platform driver to
accept platform irq flags data.

Signed-off-by: Sonic Zhang <sonic.adi@gmail.com>
---
 drivers/ata/pata_platform.c   |    6 ++++--
 include/linux/pata_platform.h |    5 +++++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/pata_platform.c b/drivers/ata/pata_platform.c
index cbb7866..79f841b 100644
--- a/drivers/ata/pata_platform.c
+++ b/drivers/ata/pata_platform.c
@@ -139,6 +139,7 @@ static int __devinit pata_platform_probe(struct platform_device *pdev)
 	struct resource *io_res, *ctl_res;
 	struct ata_host *host;
 	struct ata_port *ap;
+	struct pata_platform_info *pp_info;
 	unsigned int mmio;
 
 	/*
@@ -208,11 +209,12 @@ static int __devinit pata_platform_probe(struct platform_device *pdev)
 
 	ap->ioaddr.altstatus_addr = ap->ioaddr.ctl_addr;
 
-	pata_platform_setup_port(&ap->ioaddr, pdev->dev.platform_data);
+	pp_info = (struct pata_platform_info *)(pdev->dev.platform_data);
+	pata_platform_setup_port(&ap->ioaddr, pp_info);
 
 	/* activate */
 	return ata_host_activate(host, platform_get_irq(pdev, 0), ata_interrupt,
-				 0, &pata_platform_sht);
+				 pp_info->irq_flags, &pata_platform_sht);
 }
 
 /**
diff --git a/include/linux/pata_platform.h b/include/linux/pata_platform.h
index 2d5fd64..5799e8d 100644
--- a/include/linux/pata_platform.h
+++ b/include/linux/pata_platform.h
@@ -8,6 +8,11 @@ struct pata_platform_info {
 	 * spacing used by ata_std_ports().
 	 */
 	unsigned int ioport_shift;
+	/* 
+	 * Indicate platform specific irq types and initial
+	 * IRQ flags when call request_irq()
+	 */
+	unsigned int irq_flags;
 };
 
 #endif /* __LINUX_PATA_PLATFORM_H */
-- 
1.5.1.3


