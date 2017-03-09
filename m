From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 2/3] ARM: davinci: add pata_bk3710 libata driver support
Date: Thu, 09 Mar 2017 14:01:35 +0100
Message-ID: <1489064496-6270-3-git-send-email-b.zolnierkie@samsung.com>
References: <1489064496-6270-1-git-send-email-b.zolnierkie@samsung.com>
 <CGME20170309130219epcas5p25c21acd3b3230cee14cc79c9b6bb10af@epcas5p2.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <1489064496-6270-1-git-send-email-b.zolnierkie@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tejun Heo <tj@kernel.org>
Cc: Russell King <linux@arm.linux.org.uk>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Arnd Bergmann <arnd@arndb.de>, b.zolnierkie@samsung.com, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Kevin Hilman <khilman@baylibre.com>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

From: Sekhar Nori <nsekhar@ti.com>

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
[b.zolnierkie: split from bigger patch + preserved old driver support]
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/mach-davinci/board-dm644x-evm.c  | 3 ++-
 arch/arm/mach-davinci/board-dm646x-evm.c  | 3 ++-
 arch/arm/mach-davinci/board-neuros-osd2.c | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
index 023480b..20f1874 100644
--- a/arch/arm/mach-davinci/board-dm644x-evm.c
+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
@@ -744,7 +744,8 @@ static int davinci_phy_fixup(struct phy_device *phydev)
 	return 0;
 }
 
-#define HAS_ATA		IS_ENABLED(CONFIG_BLK_DEV_PALMCHIP_BK3710)
+#define HAS_ATA		(IS_ENABLED(CONFIG_BLK_DEV_PALMCHIP_BK3710) || \
+			 IS_ENABLED(CONFIG_PATA_BK3710))
 
 #define HAS_NOR		IS_ENABLED(CONFIG_MTD_PHYSMAP)
 
diff --git a/arch/arm/mach-davinci/board-dm646x-evm.c b/arch/arm/mach-davinci/board-dm646x-evm.c
index f702d4f..cb17682 100644
--- a/arch/arm/mach-davinci/board-dm646x-evm.c
+++ b/arch/arm/mach-davinci/board-dm646x-evm.c
@@ -119,7 +119,8 @@
 	},
 };
 
-#define HAS_ATA		IS_ENABLED(CONFIG_BLK_DEV_PALMCHIP_BK3710)
+#define HAS_ATA		(IS_ENABLED(CONFIG_BLK_DEV_PALMCHIP_BK3710) || \
+			 IS_ENABLED(CONFIG_PATA_BK3710))
 
 #ifdef CONFIG_I2C
 /* CPLD Register 0 bits to control ATA */
diff --git a/arch/arm/mach-davinci/board-neuros-osd2.c b/arch/arm/mach-davinci/board-neuros-osd2.c
index 0a78388..0c02aaa 100644
--- a/arch/arm/mach-davinci/board-neuros-osd2.c
+++ b/arch/arm/mach-davinci/board-neuros-osd2.c
@@ -163,7 +163,8 @@ static void __init davinci_ntosd2_map_io(void)
 	.wires		= 4,
 };
 
-#define HAS_ATA		IS_ENABLED(CONFIG_BLK_DEV_PALMCHIP_BK3710)
+#define HAS_ATA		(IS_ENABLED(CONFIG_BLK_DEV_PALMCHIP_BK3710) || \
+			 IS_ENABLED(CONFIG_PATA_BK3710))
 
 #define HAS_NAND	IS_ENABLED(CONFIG_MTD_NAND_DAVINCI)
 
-- 
1.9.1
