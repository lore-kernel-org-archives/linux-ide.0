From: Sekhar Nori <nsekhar@ti.com>
Subject: [PATCH v2 3/5] davinci: enable forced transitions on PSC
Date: Wed, 6 Jul 2011 11:31:22 +0530
Message-ID: <16e4a0ff95e42ddbe4a031af5f7a236f6837effd.1309927428.git.nsekhar@ti.com>
References: <cover.1309927427.git.nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:32882 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753941Ab1GFGBp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 6 Jul 2011 02:01:45 -0400
In-Reply-To: <cover.1309927427.git.nsekhar@ti.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: davinci-linux-open-source@linux.davincidsp.com
Cc: khilman@ti.com, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, sshtylyov@mvista.com, Sekhar Nori <nsekhar@ti.com>

Some DaVinci modules like the SATA on DA850
need forced module state transitions.

Define a "force" flag which can be passed to
the PSC config function to enable it to make
forced transitions.

Forced transitions shouldn't normally be attempted,
unless the TRM explicitly specifies its usage.

ChangeLog:
v2:
Modified to take care of the fact that
davinci_psc_config() now takes the flags
directly.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/mach-davinci/clock.h            |    1 +
 arch/arm/mach-davinci/include/mach/psc.h |    1 +
 arch/arm/mach-davinci/psc.c              |    2 ++
 3 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/clock.h b/arch/arm/mach-davinci/clock.h
index 0dd2203..48ee462 100644
--- a/arch/arm/mach-davinci/clock.h
+++ b/arch/arm/mach-davinci/clock.h
@@ -111,6 +111,7 @@ struct clk {
 #define CLK_PLL			BIT(4) /* PLL-derived clock */
 #define PRE_PLL			BIT(5) /* source is before PLL mult/div */
 #define PSC_SWRSTDISABLE	BIT(6) /* Disable state is SwRstDisable */
+#define PSC_FORCE		BIT(7) /* Force module state transtition */
 
 #define CLK(dev, con, ck) 	\
 	{			\
diff --git a/arch/arm/mach-davinci/include/mach/psc.h b/arch/arm/mach-davinci/include/mach/psc.h
index be9d63e..47fd0bc 100644
--- a/arch/arm/mach-davinci/include/mach/psc.h
+++ b/arch/arm/mach-davinci/include/mach/psc.h
@@ -244,6 +244,7 @@
 #define PSC_STATE_ENABLE	3
 
 #define MDSTAT_STATE_MASK	0x1f
+#define MDCTL_FORCE		BIT(31)
 
 #ifndef __ASSEMBLER__
 
diff --git a/arch/arm/mach-davinci/psc.c b/arch/arm/mach-davinci/psc.c
index 823cb1b..1fb6bdf 100644
--- a/arch/arm/mach-davinci/psc.c
+++ b/arch/arm/mach-davinci/psc.c
@@ -75,6 +75,8 @@ void davinci_psc_config(unsigned int domain, unsigned int ctlr,
 	mdctl = __raw_readl(psc_base + MDCTL + 4 * id);
 	mdctl &= ~MDSTAT_STATE_MASK;
 	mdctl |= next_state;
+	if (flags & PSC_FORCE)
+		mdctl |= MDCTL_FORCE;
 	__raw_writel(mdctl, psc_base + MDCTL + 4 * id);
 
 	pdstat = __raw_readl(psc_base + PDSTAT);
-- 
1.7.3.2

