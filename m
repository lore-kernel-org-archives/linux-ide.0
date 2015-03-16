From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH 08/10] ARM: at91/pm: use the atmel-mc syscon defines
Date: Mon, 16 Mar 2015 23:44:44 +0100
Message-ID: <1426545886-19162-9-git-send-email-alexandre.belloni@free-electrons.com>
References: <1426545886-19162-1-git-send-email-alexandre.belloni@free-electrons.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:38420 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755079AbbCPWo4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Mar 2015 18:44:56 -0400
In-Reply-To: <1426545886-19162-1-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Lee Jones <lee.jones@linaro.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-pcmcia@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>

Use the defines from atmel-mc.h instead of at91rm9200_sdramc.h

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/mach-at91/include/mach/at91_ramc.h | 2 +-
 arch/arm/mach-at91/pm.c                     | 8 ++++----
 arch/arm/mach-at91/pm_suspend.S             | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-at91/include/mach/at91_ramc.h b/arch/arm/mach-at91/include/mach/at91_ramc.h
index 493bc486e858..39547496d4b0 100644
--- a/arch/arm/mach-at91/include/mach/at91_ramc.h
+++ b/arch/arm/mach-at91/include/mach/at91_ramc.h
@@ -21,7 +21,7 @@ extern void __iomem *at91_ramc_base[];
 .extern at91_ramc_base
 #endif
 
-#include <soc/at91/at91rm9200_sdramc.h>
+#include <linux/mfd/syscon/atmel-mc.h>
 #include <soc/at91/at91sam9_ddrsdr.h>
 #include <soc/at91/at91sam9_sdramc.h>
 
diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 5062699cbb12..1e184767c3be 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -233,7 +233,7 @@ static void at91_pm_set_standby(void (*at91_standby)(void))
  */
 static void at91rm9200_standby(void)
 {
-	u32 lpr = at91_ramc_read(0, AT91RM9200_SDRAMC_LPR);
+	u32 lpr = at91_ramc_read(0, AT91_MC_SDRAMC_LPR);
 
 	asm volatile(
 		"b    1f\n\t"
@@ -244,8 +244,8 @@ static void at91rm9200_standby(void)
 		"    mcr    p15, 0, %0, c7, c0, 4\n\t"
 		"    str    %5, [%1, %2]"
 		:
-		: "r" (0), "r" (at91_ramc_base[0]), "r" (AT91RM9200_SDRAMC_LPR),
-		  "r" (1), "r" (AT91RM9200_SDRAMC_SRR),
+		: "r" (0), "r" (at91_ramc_base[0]), "r" (AT91_MC_SDRAMC_LPR),
+		  "r" (1), "r" (AT91_MC_SDRAMC_SRR),
 		  "r" (lpr));
 }
 
@@ -414,7 +414,7 @@ void __init at91rm9200_pm_init(void)
 	/*
 	 * AT91RM9200 SDRAM low-power mode cannot be used with self-refresh.
 	 */
-	at91_ramc_write(0, AT91RM9200_SDRAMC_LPR, 0);
+	at91_ramc_write(0, AT91_MC_SDRAMC_LPR, 0);
 
 	at91_pm_data.uhp_udp_mask = AT91RM9200_PMC_UHP | AT91RM9200_PMC_UDP;
 	at91_pm_data.memctrl = AT91_MEMCTRL_MC;
diff --git a/arch/arm/mach-at91/pm_suspend.S b/arch/arm/mach-at91/pm_suspend.S
index bd22b2c8a051..fda4e0164ed7 100644
--- a/arch/arm/mach-at91/pm_suspend.S
+++ b/arch/arm/mach-at91/pm_suspend.S
@@ -216,7 +216,7 @@ ENTRY(at91_sramc_self_refresh)
 
 	/* Active SDRAM self-refresh mode */
 	mov	r3, #1
-	str	r3, [r2, #AT91RM9200_SDRAMC_SRR]
+	str	r3, [r2, #AT91_MC_SDRAMC_SRR]
 	b	exit_sramc_sf
 
 ddrc_sf:
-- 
2.1.0

