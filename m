From: Sekhar Nori <nsekhar@ti.com>
Subject: [PATCH 2/5] davinci: pass clock flags to davinci_psc_config()
Date: Wed, 6 Jul 2011 11:31:21 +0530
Message-ID: <595d0b3fe19ad626eaa8edc11b1cc872c06ab176.1309927427.git.nsekhar@ti.com>
References: <cover.1309927427.git.nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48516 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753941Ab1GFGBq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 6 Jul 2011 02:01:46 -0400
In-Reply-To: <cover.1309927427.git.nsekhar@ti.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: davinci-linux-open-source@linux.davincidsp.com
Cc: khilman@ti.com, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, sshtylyov@mvista.com, Sekhar Nori <nsekhar@ti.com>

Enabling or disabling a PSC can take certain
modifiers like "disable with reset", "force
enable/disable" and "enable/disable with local
reset" apart from the regular clock gating
functionality.

Pass a flags argument to davinci_psc_config()
so these variations can be supported there.

At this time only "disable with reset" is
supported, but other functionality will be
added in subsequent patches.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/mach-davinci/clock.c            |    8 +++-----
 arch/arm/mach-davinci/include/mach/psc.h |    2 +-
 arch/arm/mach-davinci/psc.c              |   12 +++++++++++-
 3 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-davinci/clock.c b/arch/arm/mach-davinci/clock.c
index e4e3af1..d0450ac 100644
--- a/arch/arm/mach-davinci/clock.c
+++ b/arch/arm/mach-davinci/clock.c
@@ -44,7 +44,7 @@ static void __clk_enable(struct clk *clk)
 		__clk_enable(clk->parent);
 	if (clk->usecount++ == 0 && (clk->flags & CLK_PSC))
 		davinci_psc_config(psc_domain(clk), clk->gpsc, clk->lpsc,
-				PSC_STATE_ENABLE);
+				true, clk->flags);
 }
 
 static void __clk_disable(struct clk *clk)
@@ -54,8 +54,7 @@ static void __clk_disable(struct clk *clk)
 	if (--clk->usecount == 0 && !(clk->flags & CLK_PLL) &&
 	    (clk->flags & CLK_PSC))
 		davinci_psc_config(psc_domain(clk), clk->gpsc, clk->lpsc,
-				(clk->flags & PSC_SWRSTDISABLE) ?
-				PSC_STATE_SWRSTDISABLE : PSC_STATE_DISABLE);
+				false, clk->flags);
 	if (clk->parent)
 		__clk_disable(clk->parent);
 }
@@ -239,8 +238,7 @@ static int __init clk_disable_unused(void)
 		pr_debug("Clocks: disable unused %s\n", ck->name);
 
 		davinci_psc_config(psc_domain(ck), ck->gpsc, ck->lpsc,
-				(ck->flags & PSC_SWRSTDISABLE) ?
-				PSC_STATE_SWRSTDISABLE : PSC_STATE_DISABLE);
+				false, ck->flags);
 	}
 	spin_unlock_irq(&clockfw_lock);
 
diff --git a/arch/arm/mach-davinci/include/mach/psc.h b/arch/arm/mach-davinci/include/mach/psc.h
index 1110fdd..be9d63e 100644
--- a/arch/arm/mach-davinci/include/mach/psc.h
+++ b/arch/arm/mach-davinci/include/mach/psc.h
@@ -249,7 +249,7 @@
 
 extern int davinci_psc_is_clk_active(unsigned int ctlr, unsigned int id);
 extern void davinci_psc_config(unsigned int domain, unsigned int ctlr,
-		unsigned int id, u32 next_state);
+		unsigned int id, bool enable, u32 flags);
 
 #endif
 
diff --git a/arch/arm/mach-davinci/psc.c b/arch/arm/mach-davinci/psc.c
index a415804..823cb1b 100644
--- a/arch/arm/mach-davinci/psc.c
+++ b/arch/arm/mach-davinci/psc.c
@@ -25,6 +25,8 @@
 #include <mach/cputype.h>
 #include <mach/psc.h>
 
+#include "clock.h"
+
 /* Return nonzero iff the domain's clock is active */
 int __init davinci_psc_is_clk_active(unsigned int ctlr, unsigned int id)
 {
@@ -48,11 +50,12 @@ int __init davinci_psc_is_clk_active(unsigned int ctlr, unsigned int id)
 
 /* Enable or disable a PSC domain */
 void davinci_psc_config(unsigned int domain, unsigned int ctlr,
-		unsigned int id, u32 next_state)
+		unsigned int id, bool enable, u32 flags)
 {
 	u32 epcpr, ptcmd, ptstat, pdstat, pdctl1, mdstat, mdctl;
 	void __iomem *psc_base;
 	struct davinci_soc_info *soc_info = &davinci_soc_info;
+	u32 next_state = PSC_STATE_ENABLE;
 
 	if (!soc_info->psc_bases || (ctlr >= soc_info->psc_bases_num)) {
 		pr_warning("PSC: Bad psc data: 0x%x[%d]\n",
@@ -62,6 +65,13 @@ void davinci_psc_config(unsigned int domain, unsigned int ctlr,
 
 	psc_base = ioremap(soc_info->psc_bases[ctlr], SZ_4K);
 
+	if (!enable) {
+		if (flags & PSC_SWRSTDISABLE)
+			next_state = PSC_STATE_SWRSTDISABLE;
+		else
+			next_state = PSC_STATE_DISABLE;
+	}
+
 	mdctl = __raw_readl(psc_base + MDCTL + 4 * id);
 	mdctl &= ~MDSTAT_STATE_MASK;
 	mdctl |= next_state;
-- 
1.7.3.2

