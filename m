From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH 02/10] ARM: at91/pm: move AT91_MEMCTRL_* to pm.h
Date: Mon, 16 Mar 2015 23:44:38 +0100
Message-ID: <1426545886-19162-3-git-send-email-alexandre.belloni@free-electrons.com>
References: <1426545886-19162-1-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pcmcia-bounces+glkpd-linux-pcmcia=m.gmane.org@lists.infradead.org>
In-Reply-To: <1426545886-19162-1-git-send-email-alexandre.belloni@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-pcmcia>,
 <mailto:linux-pcmcia-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-pcmcia/>
List-Post: <mailto:linux-pcmcia@lists.infradead.org>
List-Help: <mailto:linux-pcmcia-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-pcmcia>,
 <mailto:linux-pcmcia-request@lists.infradead.org?subject=subscribe>
Sender: "linux-pcmcia" <linux-pcmcia-bounces@lists.infradead.org>
Errors-To: linux-pcmcia-bounces+glkpd-linux-pcmcia=m.gmane.org@lists.infradead.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Lee Jones <lee.jones@linaro.org>, linux-pcmcia@lists.infradead.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Tejun Heo <tj@kernel.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

the AT91_MEMCTRL_* defines are only used by the pm code, move them to pm.h

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/mach-at91/include/mach/at91_ramc.h | 4 ----
 arch/arm/mach-at91/pm.h                     | 4 ++++
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-at91/include/mach/at91_ramc.h b/arch/arm/mach-at91/include/mach/at91_ramc.h
index e4492b151fee..493bc486e858 100644
--- a/arch/arm/mach-at91/include/mach/at91_ramc.h
+++ b/arch/arm/mach-at91/include/mach/at91_ramc.h
@@ -21,10 +21,6 @@ extern void __iomem *at91_ramc_base[];
 .extern at91_ramc_base
 #endif
 
-#define AT91_MEMCTRL_MC		0
-#define AT91_MEMCTRL_SDRAMC	1
-#define AT91_MEMCTRL_DDRSDR	2
-
 #include <soc/at91/at91rm9200_sdramc.h>
 #include <soc/at91/at91sam9_ddrsdr.h>
 #include <soc/at91/at91sam9_sdramc.h>
diff --git a/arch/arm/mach-at91/pm.h b/arch/arm/mach-at91/pm.h
index 3223967d3460..ecd875a91d52 100644
--- a/arch/arm/mach-at91/pm.h
+++ b/arch/arm/mach-at91/pm.h
@@ -15,6 +15,10 @@
 
 #include <mach/at91_ramc.h>
 
+#define AT91_MEMCTRL_MC		0
+#define AT91_MEMCTRL_SDRAMC	1
+#define AT91_MEMCTRL_DDRSDR	2
+
 #define	AT91_PM_MEMTYPE_MASK	0x0f
 
 #define	AT91_PM_MODE_OFFSET	4
-- 
2.1.0
