From: Sekhar Nori <nsekhar@ti.com>
Subject: [PATCH 1/5] davinci: psc.h: clean up indentation done using spaces
Date: Wed, 6 Jul 2011 11:31:20 +0530
Message-ID: <2112f84888cfb283ddb12f97ebe3d06116e39d94.1309927427.git.nsekhar@ti.com>
References: <cover.1309927427.git.nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48517 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754082Ab1GFGBq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 6 Jul 2011 02:01:46 -0400
In-Reply-To: <cover.1309927427.git.nsekhar@ti.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: davinci-linux-open-source@linux.davincidsp.com
Cc: khilman@ti.com, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, sshtylyov@mvista.com, Sekhar Nori <nsekhar@ti.com>

psc.h has indentation using spaces at a number of places.
Fix this by indenting using tabs instead.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/mach-davinci/include/mach/psc.h |  148 +++++++++++++++---------------
 1 files changed, 74 insertions(+), 74 deletions(-)

diff --git a/arch/arm/mach-davinci/include/mach/psc.h b/arch/arm/mach-davinci/include/mach/psc.h
index a47e6f2..1110fdd 100644
--- a/arch/arm/mach-davinci/include/mach/psc.h
+++ b/arch/arm/mach-davinci/include/mach/psc.h
@@ -30,47 +30,47 @@
 #define	DAVINCI_PWR_SLEEP_CNTRL_BASE	0x01C41000
 
 /* Power and Sleep Controller (PSC) Domains */
-#define DAVINCI_GPSC_ARMDOMAIN      0
-#define DAVINCI_GPSC_DSPDOMAIN      1
+#define DAVINCI_GPSC_ARMDOMAIN		0
+#define DAVINCI_GPSC_DSPDOMAIN		1
 
-#define DAVINCI_LPSC_VPSSMSTR       0
-#define DAVINCI_LPSC_VPSSSLV        1
-#define DAVINCI_LPSC_TPCC           2
-#define DAVINCI_LPSC_TPTC0          3
-#define DAVINCI_LPSC_TPTC1          4
-#define DAVINCI_LPSC_EMAC           5
-#define DAVINCI_LPSC_EMAC_WRAPPER   6
-#define DAVINCI_LPSC_USB            9
-#define DAVINCI_LPSC_ATA            10
-#define DAVINCI_LPSC_VLYNQ          11
-#define DAVINCI_LPSC_UHPI           12
-#define DAVINCI_LPSC_DDR_EMIF       13
-#define DAVINCI_LPSC_AEMIF          14
-#define DAVINCI_LPSC_MMC_SD         15
-#define DAVINCI_LPSC_McBSP          17
-#define DAVINCI_LPSC_I2C            18
-#define DAVINCI_LPSC_UART0          19
-#define DAVINCI_LPSC_UART1          20
-#define DAVINCI_LPSC_UART2          21
-#define DAVINCI_LPSC_SPI            22
-#define DAVINCI_LPSC_PWM0           23
-#define DAVINCI_LPSC_PWM1           24
-#define DAVINCI_LPSC_PWM2           25
-#define DAVINCI_LPSC_GPIO           26
-#define DAVINCI_LPSC_TIMER0         27
-#define DAVINCI_LPSC_TIMER1         28
-#define DAVINCI_LPSC_TIMER2         29
-#define DAVINCI_LPSC_SYSTEM_SUBSYS  30
-#define DAVINCI_LPSC_ARM            31
-#define DAVINCI_LPSC_SCR2           32
-#define DAVINCI_LPSC_SCR3           33
-#define DAVINCI_LPSC_SCR4           34
-#define DAVINCI_LPSC_CROSSBAR       35
-#define DAVINCI_LPSC_CFG27          36
-#define DAVINCI_LPSC_CFG3           37
-#define DAVINCI_LPSC_CFG5           38
-#define DAVINCI_LPSC_GEM            39
-#define DAVINCI_LPSC_IMCOP          40
+#define DAVINCI_LPSC_VPSSMSTR		0
+#define DAVINCI_LPSC_VPSSSLV		1
+#define DAVINCI_LPSC_TPCC		2
+#define DAVINCI_LPSC_TPTC0		3
+#define DAVINCI_LPSC_TPTC1		4
+#define DAVINCI_LPSC_EMAC		5
+#define DAVINCI_LPSC_EMAC_WRAPPER	6
+#define DAVINCI_LPSC_USB		9
+#define DAVINCI_LPSC_ATA		10
+#define DAVINCI_LPSC_VLYNQ		11
+#define DAVINCI_LPSC_UHPI		12
+#define DAVINCI_LPSC_DDR_EMIF		13
+#define DAVINCI_LPSC_AEMIF		14
+#define DAVINCI_LPSC_MMC_SD		15
+#define DAVINCI_LPSC_McBSP		17
+#define DAVINCI_LPSC_I2C		18
+#define DAVINCI_LPSC_UART0		19
+#define DAVINCI_LPSC_UART1		20
+#define DAVINCI_LPSC_UART2		21
+#define DAVINCI_LPSC_SPI		22
+#define DAVINCI_LPSC_PWM0		23
+#define DAVINCI_LPSC_PWM1		24
+#define DAVINCI_LPSC_PWM2		25
+#define DAVINCI_LPSC_GPIO		26
+#define DAVINCI_LPSC_TIMER0		27
+#define DAVINCI_LPSC_TIMER1		28
+#define DAVINCI_LPSC_TIMER2		29
+#define DAVINCI_LPSC_SYSTEM_SUBSYS	30
+#define DAVINCI_LPSC_ARM		31
+#define DAVINCI_LPSC_SCR2		32
+#define DAVINCI_LPSC_SCR3		33
+#define DAVINCI_LPSC_SCR4		34
+#define DAVINCI_LPSC_CROSSBAR		35
+#define DAVINCI_LPSC_CFG27		36
+#define DAVINCI_LPSC_CFG3		37
+#define DAVINCI_LPSC_CFG5		38
+#define DAVINCI_LPSC_GEM		39
+#define DAVINCI_LPSC_IMCOP		40
 
 #define DM355_LPSC_TIMER3		5
 #define DM355_LPSC_SPI1			6
@@ -102,39 +102,39 @@
 /*
  * LPSC Assignments
  */
-#define DM646X_LPSC_ARM            0
-#define DM646X_LPSC_C64X_CPU       1
-#define DM646X_LPSC_HDVICP0        2
-#define DM646X_LPSC_HDVICP1        3
-#define DM646X_LPSC_TPCC           4
-#define DM646X_LPSC_TPTC0          5
-#define DM646X_LPSC_TPTC1          6
-#define DM646X_LPSC_TPTC2          7
-#define DM646X_LPSC_TPTC3          8
-#define DM646X_LPSC_PCI            13
-#define DM646X_LPSC_EMAC           14
-#define DM646X_LPSC_VDCE           15
-#define DM646X_LPSC_VPSSMSTR       16
-#define DM646X_LPSC_VPSSSLV        17
-#define DM646X_LPSC_TSIF0          18
-#define DM646X_LPSC_TSIF1          19
-#define DM646X_LPSC_DDR_EMIF       20
-#define DM646X_LPSC_AEMIF          21
-#define DM646X_LPSC_McASP0         22
-#define DM646X_LPSC_McASP1         23
-#define DM646X_LPSC_CRGEN0         24
-#define DM646X_LPSC_CRGEN1         25
-#define DM646X_LPSC_UART0          26
-#define DM646X_LPSC_UART1          27
-#define DM646X_LPSC_UART2          28
-#define DM646X_LPSC_PWM0           29
-#define DM646X_LPSC_PWM1           30
-#define DM646X_LPSC_I2C            31
-#define DM646X_LPSC_SPI            32
-#define DM646X_LPSC_GPIO           33
-#define DM646X_LPSC_TIMER0         34
-#define DM646X_LPSC_TIMER1         35
-#define DM646X_LPSC_ARM_INTC       45
+#define DM646X_LPSC_ARM		0
+#define DM646X_LPSC_C64X_CPU	1
+#define DM646X_LPSC_HDVICP0	2
+#define DM646X_LPSC_HDVICP1	3
+#define DM646X_LPSC_TPCC	4
+#define DM646X_LPSC_TPTC0	5
+#define DM646X_LPSC_TPTC1	6
+#define DM646X_LPSC_TPTC2	7
+#define DM646X_LPSC_TPTC3	8
+#define DM646X_LPSC_PCI		13
+#define DM646X_LPSC_EMAC	14
+#define DM646X_LPSC_VDCE	15
+#define DM646X_LPSC_VPSSMSTR	16
+#define DM646X_LPSC_VPSSSLV	17
+#define DM646X_LPSC_TSIF0	18
+#define DM646X_LPSC_TSIF1	19
+#define DM646X_LPSC_DDR_EMIF	20
+#define DM646X_LPSC_AEMIF	21
+#define DM646X_LPSC_McASP0	22
+#define DM646X_LPSC_McASP1	23
+#define DM646X_LPSC_CRGEN0	24
+#define DM646X_LPSC_CRGEN1	25
+#define DM646X_LPSC_UART0	26
+#define DM646X_LPSC_UART1	27
+#define DM646X_LPSC_UART2	28
+#define DM646X_LPSC_PWM0	29
+#define DM646X_LPSC_PWM1	30
+#define DM646X_LPSC_I2C		31
+#define DM646X_LPSC_SPI		32
+#define DM646X_LPSC_GPIO	33
+#define DM646X_LPSC_TIMER0	34
+#define DM646X_LPSC_TIMER1	35
+#define DM646X_LPSC_ARM_INTC	45
 
 /* PSC0 defines */
 #define DA8XX_LPSC0_TPCC		0
@@ -243,7 +243,7 @@
 #define PSC_STATE_DISABLE	2
 #define PSC_STATE_ENABLE	3
 
-#define MDSTAT_STATE_MASK 0x1f
+#define MDSTAT_STATE_MASK	0x1f
 
 #ifndef __ASSEMBLER__
 
-- 
1.7.3.2

