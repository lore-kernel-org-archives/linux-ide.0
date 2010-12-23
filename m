From: Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [v2 PATCH] [libata] pata_cs5536: Add support for non-X86_32 platforms
Date: Fri, 24 Dec 2010 00:35:32 +0800
Message-ID: <21c0c6ed72c9fb53f47562705de1c2dfc3f3b2ee.1293121910.git.wuzhangjin@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:33299 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751927Ab0LWQfx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 23 Dec 2010 11:35:53 -0500
Received: by pxi15 with SMTP id 15so1213615pxi.19
        for <linux-ide@vger.kernel.org>; Thu, 23 Dec 2010 08:35:53 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Sergei Shtylyov <sshtylyov@mvista.com>, linux-ide@vger.kernel.org, Wu Zhangjin <wuzhangjin@gmail.com>, Zhang Le <r0bertz@gentoo.org>, Chen Jie <chenj@lemote.com>

pata_cs5536 does work on the other platforms(e.g. Loongson, a MIPS
variant), so, remove the dependency of X86_32 and fix the building
errors under the other platforms via only reserving the X86_32 specific
parts for X86_32.

pata_amd also supports cs5536 IDE controller, but this one saves about
33k for the compressed kernel image(vmlinuz for MIPS).

The driver version is incremented to 0.08 as feedback from "Sergei Shtylyov"
<sshtylyov@mvista.com>.

Signed-off-by: Zhang Le <r0bertz@gentoo.org>
Signed-off-by: Chen Jie <chenj@lemote.com>
Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 drivers/ata/Kconfig       |    2 +-
 drivers/ata/pata_cs5536.c |   18 ++++++++++++------
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 11ec911..cfd04f4 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -366,7 +366,7 @@ config PATA_CS5535
 
 config PATA_CS5536
 	tristate "CS5536 PATA support"
-	depends on PCI && X86 && !X86_64
+	depends on PCI
 	help
 	  This option enables support for the AMD CS5536
 	  companion chip used with the Geode LX processor family.
diff --git a/drivers/ata/pata_cs5536.c b/drivers/ata/pata_cs5536.c
index 21ee23f..a6e6c96 100644
--- a/drivers/ata/pata_cs5536.c
+++ b/drivers/ata/pata_cs5536.c
@@ -37,10 +37,20 @@
 #include <linux/delay.h>
 #include <linux/libata.h>
 #include <scsi/scsi_host.h>
+
+#ifdef CONFIG_X86_32
 #include <asm/msr.h>
+static int use_msr;
+module_param_named(msr, use_msr, int, 0644);
+MODULE_PARM_DESC(msr, "Force using MSR to configure IDE function (Default: 0)");
+#else
+#define rdmsr(x, y, z) do { } while (0)
+#define wrmsr(x, y, z) do { } while (0)
+#define use_msr 0
+#endif
 
 #define DRV_NAME	"pata_cs5536"
-#define DRV_VERSION	"0.0.7"
+#define DRV_VERSION	"0.0.8"
 
 enum {
 	CFG			= 0,
@@ -75,8 +85,6 @@ enum {
 	IDE_ETC_NODMA		= 0x03,
 };
 
-static int use_msr;
-
 static const u32 msr_reg[4] = {
 	MSR_IDE_CFG, MSR_IDE_DTC, MSR_IDE_CAST, MSR_IDE_ETC,
 };
@@ -88,7 +96,7 @@ static const u8 pci_reg[4] = {
 static inline int cs5536_read(struct pci_dev *pdev, int reg, u32 *val)
 {
 	if (unlikely(use_msr)) {
-		u32 dummy;
+		u32 dummy __maybe_unused;
 
 		rdmsr(msr_reg[reg], *val, dummy);
 		return 0;
@@ -294,8 +302,6 @@ MODULE_DESCRIPTION("low-level driver for the CS5536 IDE controller");
 MODULE_LICENSE("GPL");
 MODULE_DEVICE_TABLE(pci, cs5536);
 MODULE_VERSION(DRV_VERSION);
-module_param_named(msr, use_msr, int, 0644);
-MODULE_PARM_DESC(msr, "Force using MSR to configure IDE function (Default: 0)");
 
 module_init(cs5536_init);
 module_exit(cs5536_exit);
-- 
1.7.1

