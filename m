From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 1/6] ata: SATA_MV should depend on HAS_DMA
Date: Tue,  3 Jan 2017 19:09:44 +0100
Message-ID: <1483466989-9091-2-git-send-email-geert@linux-m68k.org>
References: <1483466989-9091-1-git-send-email-geert@linux-m68k.org>
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <1483466989-9091-1-git-send-email-geert@linux-m68k.org>
Sender: linux-m68k-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-ide@vger.kernel.org, linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-ide@vger.kernel.org

If NO_DMA=y:

    ERROR: "dma_pool_alloc" [drivers/ata/sata_mv.ko] undefined!
    ERROR: "dmam_pool_create" [drivers/ata/sata_mv.ko] undefined!
    ERROR: "dma_pool_free" [drivers/ata/sata_mv.ko] undefined!

Add a dependency on HAS_DMA to fix this.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/ata/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index cbd101933c69322a..7b36b791078a4806 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -353,6 +353,7 @@ config SATA_HIGHBANK
 
 config SATA_MV
 	tristate "Marvell SATA support"
+	depends on HAS_DMA
 	depends on PCI || ARCH_DOVE || ARCH_MV78XX0 || \
 		   ARCH_MVEBU || ARCH_ORION5X || COMPILE_TEST
 	select GENERIC_PHY
-- 
1.9.1
