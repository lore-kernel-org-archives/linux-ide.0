From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 3/6] ata: ATA_BMDMA should depend on HAS_DMA
Date: Tue,  3 Jan 2017 19:09:46 +0100
Message-ID: <1483466989-9091-4-git-send-email-geert@linux-m68k.org>
References: <1483466989-9091-1-git-send-email-geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1483466989-9091-1-git-send-email-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-ide@vger.kernel.org, linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-ide@vger.kernel.org

If NO_DMA=y:

    ERROR: "dmam_alloc_coherent" [drivers/ata/libata.ko] undefined!

Add a dependency on HAS_DMA to fix this.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/ata/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 275dbbded6dbe03b..a973aa8aa5513eea 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -289,6 +289,7 @@ config SATA_SX4
 
 config ATA_BMDMA
 	bool "ATA BMDMA support"
+	depends on HAS_DMA
 	default y
 	help
 	  This option adds support for SFF ATA controllers with BMDMA
-- 
1.9.1
