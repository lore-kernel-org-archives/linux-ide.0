From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH 2/4] pata_platform: Remove useless irq_flags field
Date: Sat, 23 Aug 2014 14:45:47 +0400
Message-ID: <1408790747-30251-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fallback1.mail.ru ([94.100.181.184]:52923 "EHLO
	fallback1.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752334AbaHWKqk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 23 Aug 2014 06:46:40 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Steven Miao <realmz6@gmail.com>, adi-buildroot-devel@lists.sourceforge.net, Alexander Shiyan <shc_work@mail.ru>

IRQ flags can be obtained from resource structure, there are no need
to use additional field in the platform_data to store these values.
This patch removes this field and convert existing users of this driver
to use IRQ flags from the resources.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/blackfin/mach-bf537/boards/cm_bf537e.c | 3 +--
 arch/blackfin/mach-bf537/boards/cm_bf537u.c | 3 +--
 arch/blackfin/mach-bf537/boards/stamp.c     | 3 +--
 arch/blackfin/mach-bf537/boards/tcm_bf537.c | 3 +--
 arch/blackfin/mach-bf561/boards/cm_bf561.c  | 3 +--
 drivers/ata/pata_of_platform.c              | 2 --
 drivers/ata/pata_platform.c                 | 4 +---
 include/linux/ata_platform.h                | 5 -----
 8 files changed, 6 insertions(+), 20 deletions(-)

diff --git a/arch/blackfin/mach-bf537/boards/cm_bf537e.c b/arch/blackfin/mach-bf537/boards/cm_bf537e.c
index 1e7290e..1e1014d 100644
--- a/arch/blackfin/mach-bf537/boards/cm_bf537e.c
+++ b/arch/blackfin/mach-bf537/boards/cm_bf537e.c
@@ -733,7 +733,6 @@ static struct platform_device bfin_mac_device = {
 
 static struct pata_platform_info bfin_pata_platform_data = {
 	.ioport_shift = 2,
-	.irq_type = IRQF_TRIGGER_HIGH,
 };
 
 static struct resource bfin_pata_resources[] = {
@@ -750,7 +749,7 @@ static struct resource bfin_pata_resources[] = {
 	{
 		.start = PATA_INT,
 		.end = PATA_INT,
-		.flags = IORESOURCE_IRQ,
+		.flags = IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHLEVEL,
 	},
 };
 
diff --git a/arch/blackfin/mach-bf537/boards/cm_bf537u.c b/arch/blackfin/mach-bf537/boards/cm_bf537u.c
index c7495dc..d056db9 100644
--- a/arch/blackfin/mach-bf537/boards/cm_bf537u.c
+++ b/arch/blackfin/mach-bf537/boards/cm_bf537u.c
@@ -587,7 +587,6 @@ static struct platform_device bfin_mac_device = {
 
 static struct pata_platform_info bfin_pata_platform_data = {
 	.ioport_shift = 2,
-	.irq_type = IRQF_TRIGGER_HIGH,
 };
 
 static struct resource bfin_pata_resources[] = {
@@ -604,7 +603,7 @@ static struct resource bfin_pata_resources[] = {
 	{
 		.start = PATA_INT,
 		.end = PATA_INT,
-		.flags = IORESOURCE_IRQ,
+		.flags = IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHLEVEL,
 	},
 };
 
diff --git a/arch/blackfin/mach-bf537/boards/stamp.c b/arch/blackfin/mach-bf537/boards/stamp.c
index de19b8a..88a19fc 100644
--- a/arch/blackfin/mach-bf537/boards/stamp.c
+++ b/arch/blackfin/mach-bf537/boards/stamp.c
@@ -2462,7 +2462,6 @@ static struct platform_device bfin_sport0_device = {
 #define PATA_INT	IRQ_PF5
 static struct pata_platform_info bfin_pata_platform_data = {
 	.ioport_shift = 1,
-	.irq_flags = IRQF_TRIGGER_HIGH,
 };
 
 static struct resource bfin_pata_resources[] = {
@@ -2479,7 +2478,7 @@ static struct resource bfin_pata_resources[] = {
 	{
 		.start = PATA_INT,
 		.end = PATA_INT,
-		.flags = IORESOURCE_IRQ,
+		.flags = IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHLEVEL,
 	},
 };
 #elif defined(CF_IDE_NAND_CARD_USE_CF_IN_COMMON_MEMORY_MODE)
diff --git a/arch/blackfin/mach-bf537/boards/tcm_bf537.c b/arch/blackfin/mach-bf537/boards/tcm_bf537.c
index 6b988ad..ed309c9 100644
--- a/arch/blackfin/mach-bf537/boards/tcm_bf537.c
+++ b/arch/blackfin/mach-bf537/boards/tcm_bf537.c
@@ -589,7 +589,6 @@ static struct platform_device bfin_mac_device = {
 
 static struct pata_platform_info bfin_pata_platform_data = {
 	.ioport_shift = 2,
-	.irq_type = IRQF_TRIGGER_HIGH,
 };
 
 static struct resource bfin_pata_resources[] = {
@@ -606,7 +605,7 @@ static struct resource bfin_pata_resources[] = {
 	{
 		.start = PATA_INT,
 		.end = PATA_INT,
-		.flags = IORESOURCE_IRQ,
+		.flags = IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHLEVEL,
 	},
 };
 
diff --git a/arch/blackfin/mach-bf561/boards/cm_bf561.c b/arch/blackfin/mach-bf561/boards/cm_bf561.c
index e862f78..c6db52b 100644
--- a/arch/blackfin/mach-bf561/boards/cm_bf561.c
+++ b/arch/blackfin/mach-bf561/boards/cm_bf561.c
@@ -354,7 +354,6 @@ static struct platform_device bfin_sir0_device = {
 
 static struct pata_platform_info bfin_pata_platform_data = {
 	.ioport_shift = 2,
-	.irq_type = IRQF_TRIGGER_HIGH,
 };
 
 static struct resource bfin_pata_resources[] = {
@@ -371,7 +370,7 @@ static struct resource bfin_pata_resources[] = {
 	{
 		.start = PATA_INT,
 		.end = PATA_INT,
-		.flags = IORESOURCE_IRQ,
+		.flags = IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHLEVEL,
 	},
 };
 
diff --git a/drivers/ata/pata_of_platform.c b/drivers/ata/pata_of_platform.c
index 6af1c9b..6496539 100644
--- a/drivers/ata/pata_of_platform.c
+++ b/drivers/ata/pata_of_platform.c
@@ -43,8 +43,6 @@ static int pata_of_platform_probe(struct platform_device *ofdev)
 	}
 
 	irq_res = platform_get_resource(ofdev, IORESOURCE_IRQ, 0);
-	if (irq_res)
-		irq_res->flags = 0;
 
 	prop = of_get_property(dn, "reg-shift", NULL);
 	if (prop)
diff --git a/drivers/ata/pata_platform.c b/drivers/ata/pata_platform.c
index a5579b5..f8cff3e 100644
--- a/drivers/ata/pata_platform.c
+++ b/drivers/ata/pata_platform.c
@@ -118,7 +118,7 @@ int __pata_platform_probe(struct device *dev, struct resource *io_res,
 	 */
 	if (irq_res && irq_res->start > 0) {
 		irq = irq_res->start;
-		irq_flags = irq_res->flags;
+		irq_flags = irq_res->flags & IRQF_TRIGGER_MASK;
 	}
 
 	/*
@@ -213,8 +213,6 @@ static int pata_platform_probe(struct platform_device *pdev)
 	 * And the IRQ
 	 */
 	irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (irq_res)
-		irq_res->flags = pp_info ? pp_info->irq_flags : 0;
 
 	return __pata_platform_probe(&pdev->dev, io_res, ctl_res, irq_res,
 				     pp_info ? pp_info->ioport_shift : 0,
diff --git a/include/linux/ata_platform.h b/include/linux/ata_platform.h
index b9fde17..5c618a0 100644
--- a/include/linux/ata_platform.h
+++ b/include/linux/ata_platform.h
@@ -8,11 +8,6 @@ struct pata_platform_info {
 	 * spacing used by ata_std_ports().
 	 */
 	unsigned int ioport_shift;
-	/* 
-	 * Indicate platform specific irq types and initial
-	 * IRQ flags when call request_irq()
-	 */
-	unsigned int irq_flags;
 };
 
 extern int __pata_platform_probe(struct device *dev,
-- 
1.8.5.5

