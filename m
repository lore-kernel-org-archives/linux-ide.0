From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH 01/10] ARM: at91/pm: move the standby functions to pm.c
Date: Mon, 16 Mar 2015 23:44:37 +0100
Message-ID: <1426545886-19162-2-git-send-email-alexandre.belloni@free-electrons.com>
References: <1426545886-19162-1-git-send-email-alexandre.belloni@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426545886-19162-1-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Lee Jones <lee.jones@linaro.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-pcmcia@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>
List-Id: linux-ide@vger.kernel.org

The standby functions are now only used in pm.c, move them there.

Also, they are not inlined as a pointer to those functions is passed to the
cpuidle driver.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/mach-at91/pm.c | 89 +++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-at91/pm.h | 92 -------------------------------------------------
 2 files changed, 89 insertions(+), 92 deletions(-)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index f93a735ba327..5062699cbb12 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -222,6 +222,95 @@ static void at91_pm_set_standby(void (*at91_standby)(void))
 		at91_cpuidle_device.dev.platform_data = at91_standby;
 }
 
+/*
+ * The AT91RM9200 goes into self-refresh mode with this command, and will
+ * terminate self-refresh automatically on the next SDRAM access.
+ *
+ * Self-refresh mode is exited as soon as a memory access is made, but we don't
+ * know for sure when that happens. However, we need to restore the low-power
+ * mode if it was enabled before going idle. Restoring low-power mode while
+ * still in self-refresh is "not recommended", but seems to work.
+ */
+static void at91rm9200_standby(void)
+{
+	u32 lpr = at91_ramc_read(0, AT91RM9200_SDRAMC_LPR);
+
+	asm volatile(
+		"b    1f\n\t"
+		".align    5\n\t"
+		"1:  mcr    p15, 0, %0, c7, c10, 4\n\t"
+		"    str    %0, [%1, %2]\n\t"
+		"    str    %3, [%1, %4]\n\t"
+		"    mcr    p15, 0, %0, c7, c0, 4\n\t"
+		"    str    %5, [%1, %2]"
+		:
+		: "r" (0), "r" (at91_ramc_base[0]), "r" (AT91RM9200_SDRAMC_LPR),
+		  "r" (1), "r" (AT91RM9200_SDRAMC_SRR),
+		  "r" (lpr));
+}
+
+/* We manage both DDRAM/SDRAM controllers, we need more than one value to
+ * remember.
+ */
+static void at91_ddr_standby(void)
+{
+	/* Those two values allow us to delay self-refresh activation
+	 * to the maximum. */
+	u32 lpr0, lpr1 = 0;
+	u32 saved_lpr0, saved_lpr1 = 0;
+
+	if (at91_ramc_base[1]) {
+		saved_lpr1 = at91_ramc_read(1, AT91_DDRSDRC_LPR);
+		lpr1 = saved_lpr1 & ~AT91_DDRSDRC_LPCB;
+		lpr1 |= AT91_DDRSDRC_LPCB_SELF_REFRESH;
+	}
+
+	saved_lpr0 = at91_ramc_read(0, AT91_DDRSDRC_LPR);
+	lpr0 = saved_lpr0 & ~AT91_DDRSDRC_LPCB;
+	lpr0 |= AT91_DDRSDRC_LPCB_SELF_REFRESH;
+
+	/* self-refresh mode now */
+	at91_ramc_write(0, AT91_DDRSDRC_LPR, lpr0);
+	if (at91_ramc_base[1])
+		at91_ramc_write(1, AT91_DDRSDRC_LPR, lpr1);
+
+	cpu_do_idle();
+
+	at91_ramc_write(0, AT91_DDRSDRC_LPR, saved_lpr0);
+	if (at91_ramc_base[1])
+		at91_ramc_write(1, AT91_DDRSDRC_LPR, saved_lpr1);
+}
+
+/* We manage both DDRAM/SDRAM controllers, we need more than one value to
+ * remember.
+ */
+static void at91sam9_sdram_standby(void)
+{
+	u32 lpr0, lpr1 = 0;
+	u32 saved_lpr0, saved_lpr1 = 0;
+
+	if (at91_ramc_base[1]) {
+		saved_lpr1 = at91_ramc_read(1, AT91_SDRAMC_LPR);
+		lpr1 = saved_lpr1 & ~AT91_SDRAMC_LPCB;
+		lpr1 |= AT91_SDRAMC_LPCB_SELF_REFRESH;
+	}
+
+	saved_lpr0 = at91_ramc_read(0, AT91_SDRAMC_LPR);
+	lpr0 = saved_lpr0 & ~AT91_SDRAMC_LPCB;
+	lpr0 |= AT91_SDRAMC_LPCB_SELF_REFRESH;
+
+	/* self-refresh mode now */
+	at91_ramc_write(0, AT91_SDRAMC_LPR, lpr0);
+	if (at91_ramc_base[1])
+		at91_ramc_write(1, AT91_SDRAMC_LPR, lpr1);
+
+	cpu_do_idle();
+
+	at91_ramc_write(0, AT91_SDRAMC_LPR, saved_lpr0);
+	if (at91_ramc_base[1])
+		at91_ramc_write(1, AT91_SDRAMC_LPR, saved_lpr1);
+}
+
 static const struct of_device_id ramc_ids[] __initconst = {
 	{ .compatible = "atmel,at91rm9200-sdramc", .data = at91rm9200_standby },
 	{ .compatible = "atmel,at91sam9260-sdramc", .data = at91sam9_sdram_standby },
diff --git a/arch/arm/mach-at91/pm.h b/arch/arm/mach-at91/pm.h
index dcacfa1ad3fa..3223967d3460 100644
--- a/arch/arm/mach-at91/pm.h
+++ b/arch/arm/mach-at91/pm.h
@@ -23,96 +23,4 @@
 
 #define	AT91_PM_SLOW_CLOCK	0x01
 
-/*
- * The AT91RM9200 goes into self-refresh mode with this command, and will
- * terminate self-refresh automatically on the next SDRAM access.
- *
- * Self-refresh mode is exited as soon as a memory access is made, but we don't
- * know for sure when that happens. However, we need to restore the low-power
- * mode if it was enabled before going idle. Restoring low-power mode while
- * still in self-refresh is "not recommended", but seems to work.
- */
-
-#ifndef __ASSEMBLY__
-static inline void at91rm9200_standby(void)
-{
-	u32 lpr = at91_ramc_read(0, AT91RM9200_SDRAMC_LPR);
-
-	asm volatile(
-		"b    1f\n\t"
-		".align    5\n\t"
-		"1:  mcr    p15, 0, %0, c7, c10, 4\n\t"
-		"    str    %0, [%1, %2]\n\t"
-		"    str    %3, [%1, %4]\n\t"
-		"    mcr    p15, 0, %0, c7, c0, 4\n\t"
-		"    str    %5, [%1, %2]"
-		:
-		: "r" (0), "r" (at91_ramc_base[0]), "r" (AT91RM9200_SDRAMC_LPR),
-		  "r" (1), "r" (AT91RM9200_SDRAMC_SRR),
-		  "r" (lpr));
-}
-
-/* We manage both DDRAM/SDRAM controllers, we need more than one value to
- * remember.
- */
-static inline void at91_ddr_standby(void)
-{
-	/* Those two values allow us to delay self-refresh activation
-	 * to the maximum. */
-	u32 lpr0, lpr1 = 0;
-	u32 saved_lpr0, saved_lpr1 = 0;
-
-	if (at91_ramc_base[1]) {
-		saved_lpr1 = at91_ramc_read(1, AT91_DDRSDRC_LPR);
-		lpr1 = saved_lpr1 & ~AT91_DDRSDRC_LPCB;
-		lpr1 |= AT91_DDRSDRC_LPCB_SELF_REFRESH;
-	}
-
-	saved_lpr0 = at91_ramc_read(0, AT91_DDRSDRC_LPR);
-	lpr0 = saved_lpr0 & ~AT91_DDRSDRC_LPCB;
-	lpr0 |= AT91_DDRSDRC_LPCB_SELF_REFRESH;
-
-	/* self-refresh mode now */
-	at91_ramc_write(0, AT91_DDRSDRC_LPR, lpr0);
-	if (at91_ramc_base[1])
-		at91_ramc_write(1, AT91_DDRSDRC_LPR, lpr1);
-
-	cpu_do_idle();
-
-	at91_ramc_write(0, AT91_DDRSDRC_LPR, saved_lpr0);
-	if (at91_ramc_base[1])
-		at91_ramc_write(1, AT91_DDRSDRC_LPR, saved_lpr1);
-}
-
-/* We manage both DDRAM/SDRAM controllers, we need more than one value to
- * remember.
- */
-static inline void at91sam9_sdram_standby(void)
-{
-	u32 lpr0, lpr1 = 0;
-	u32 saved_lpr0, saved_lpr1 = 0;
-
-	if (at91_ramc_base[1]) {
-		saved_lpr1 = at91_ramc_read(1, AT91_SDRAMC_LPR);
-		lpr1 = saved_lpr1 & ~AT91_SDRAMC_LPCB;
-		lpr1 |= AT91_SDRAMC_LPCB_SELF_REFRESH;
-	}
-
-	saved_lpr0 = at91_ramc_read(0, AT91_SDRAMC_LPR);
-	lpr0 = saved_lpr0 & ~AT91_SDRAMC_LPCB;
-	lpr0 |= AT91_SDRAMC_LPCB_SELF_REFRESH;
-
-	/* self-refresh mode now */
-	at91_ramc_write(0, AT91_SDRAMC_LPR, lpr0);
-	if (at91_ramc_base[1])
-		at91_ramc_write(1, AT91_SDRAMC_LPR, lpr1);
-
-	cpu_do_idle();
-
-	at91_ramc_write(0, AT91_SDRAMC_LPR, saved_lpr0);
-	if (at91_ramc_base[1])
-		at91_ramc_write(1, AT91_SDRAMC_LPR, saved_lpr1);
-}
-
-#endif
 #endif
-- 
2.1.0
