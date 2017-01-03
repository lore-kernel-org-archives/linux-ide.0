From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 4/6] ata: AHCI and other non-SFF native drivers should depend on HAS_DMA
Date: Tue,  3 Jan 2017 19:09:47 +0100
Message-ID: <1483466989-9091-5-git-send-email-geert@linux-m68k.org>
References: <1483466989-9091-1-git-send-email-geert@linux-m68k.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from laurent.telenet-ops.be ([195.130.137.89]:38146 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753227AbdACSKa (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 3 Jan 2017 13:10:30 -0500
In-Reply-To: <1483466989-9091-1-git-send-email-geert@linux-m68k.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-ide@vger.kernel.org, linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>

If NO_DMA=y:

    ERROR: "bad_dma_ops" [drivers/ata/libahci_platform.ko] undefined!
    ERROR: "dmam_alloc_coherent" [drivers/ata/libahci.ko] undefined!

Add a block dependency on HAS_DMA to fix this.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/ata/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index a973aa8aa5513eea..78c00202102913a0 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -80,6 +80,8 @@ config SATA_PMP
 	  This option adds support for SATA Port Multipliers
 	  (the SATA version of an ethernet hub, or SAS expander).
 
+if HAS_DMA
+
 comment "Controllers with non-SFF native interface"
 
 config SATA_AHCI
@@ -232,6 +234,8 @@ config SATA_SIL24
 
 	  If unsure, say N.
 
+endif # HAS_DMA
+
 config ATA_SFF
 	bool "ATA SFF support (for legacy IDE and PATA)"
 	default y
-- 
1.9.1

