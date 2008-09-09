From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: [PATCH 2/2] TXx9: Add TX4939 ATA support
Date: Wed, 10 Sep 2008 01:08:30 +0900 (JST)
Message-ID: <20080910.010830.51865999.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mips-bounce@linux-mips.org>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: linux-mips@linux-mips.org
Cc: linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, ralf@linux-mips.org, sshtylyov@ru.mvista.com
List-Id: linux-ide@vger.kernel.org

Add a helper routine to register tx4939ide driver and use it on
RBTX4939 board.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
This patch is against linux-next 20080905.

 arch/mips/txx9/generic/setup_tx4939.c |   29 +++++++++++++++++++++++++++++
 arch/mips/txx9/rbtx4939/setup.c       |    1 +
 include/asm-mips/txx9/tx4939.h        |    1 +
 3 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/arch/mips/txx9/generic/setup_tx4939.c b/arch/mips/txx9/generic/setup_tx4939.c
index f14a497..ee00bde 100644
--- a/arch/mips/txx9/generic/setup_tx4939.c
+++ b/arch/mips/txx9/generic/setup_tx4939.c
@@ -20,6 +20,7 @@
 #include <linux/param.h>
 #include <linux/ptrace.h>
 #include <linux/mtd/physmap.h>
+#include <linux/platform_device.h>
 #include <asm/bootinfo.h>
 #include <asm/reboot.h>
 #include <asm/traps.h>
@@ -389,6 +390,34 @@ void __init tx4939_mtd_init(int ch)
 	txx9_physmap_flash_init(ch, start, size, &pdata);
 }
 
+void __init tx4939_ata_init(void)
+{
+	__u64 pcfg = __raw_readq(&tx4939_ccfgptr->pcfg);
+	if (pcfg & (TX4939_PCFG_ATA0MODE | TX4939_PCFG_ATA1MODE)) {
+		struct resource res[2];
+		int i;
+		memset(res, 0, sizeof(res));
+		for (i = 0; i < 2; i++) {
+			if (i == 0 &&
+			    !(pcfg & TX4939_PCFG_ATA0MODE))
+				continue;
+			if (i == 1 &&
+			    (pcfg & (TX4939_PCFG_ATA1MODE |
+				     TX4939_PCFG_ET1MODE |
+				     TX4939_PCFG_ET0MODE)) !=
+			    TX4939_PCFG_ATA1MODE)
+				continue;
+			res[0].start = TX4939_ATA_REG(i) & 0xfffffffffULL;
+			res[0].end = res[0].start + 0x1000 - 1;
+			res[0].flags = IORESOURCE_MEM;
+			res[1].start = TXX9_IRQ_BASE + TX4939_IR_ATA(i);
+			res[1].flags = IORESOURCE_IRQ;
+			platform_device_register_simple("tx4939ide", i,
+							res, ARRAY_SIZE(res));
+		}
+	}
+}
+
 static void __init tx4939_stop_unused_modules(void)
 {
 	__u64 pcfg, rst = 0, ckd = 0;
diff --git a/arch/mips/txx9/rbtx4939/setup.c b/arch/mips/txx9/rbtx4939/setup.c
index 277864d..9855d7b 100644
--- a/arch/mips/txx9/rbtx4939/setup.c
+++ b/arch/mips/txx9/rbtx4939/setup.c
@@ -264,6 +264,7 @@ static void __init rbtx4939_device_init(void)
 #endif
 	rbtx4939_led_setup();
 	tx4939_wdt_init();
+	tx4939_ata_init();
 }
 
 static void __init rbtx4939_setup(void)
diff --git a/include/asm-mips/txx9/tx4939.h b/include/asm-mips/txx9/tx4939.h
index 7ce2dff..88badb4 100644
--- a/include/asm-mips/txx9/tx4939.h
+++ b/include/asm-mips/txx9/tx4939.h
@@ -540,5 +540,6 @@ void tx4939_setup_pcierr_irq(void);
 void tx4939_irq_init(void);
 int tx4939_irq(void);
 void tx4939_mtd_init(int ch);
+void tx4939_ata_init(void);
 
 #endif /* __ASM_TXX9_TX4939_H */
-- 
1.5.6.3
