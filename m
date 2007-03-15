From: Daniel Mack <daniel@caiaq.de>
Subject: [PATCH] removed static prototypes from include/asm-mips/mach-au1x00/au1xxx_ide.h
Date: Thu, 15 Mar 2007 21:14:26 +0100
Message-ID: <20070315201426.GA16573@ipxXXXXX>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="OXfL5xGRrasGEqWY"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from buzzloop.caiaq.de ([212.112.241.133]:4555 "EHLO
	buzzloop.caiaq.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751003AbXCOUcV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 Mar 2007 16:32:21 -0400
Received: from localhost (localhost [127.0.0.1])
	by buzzloop.caiaq.de (Postfix) with ESMTP id E5AEE7F402B
	for <linux-ide@vger.kernel.org>; Thu, 15 Mar 2007 21:14:32 +0100 (CET)
Received: from buzzloop.caiaq.de ([127.0.0.1])
	by localhost (buzzloop [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 16565-09 for <linux-ide@vger.kernel.org>;
	Thu, 15 Mar 2007 21:14:26 +0100 (CET)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

This patch removes the static prototypes from the au1xxx_ide.h, some of
them were not even implemented. Also, they caused build breakage since
they differed from the functions actually implemented in
drivers/ide/mips/au1xxx-ide.c.

Signed-off-by: Daniel Mack <daniel@caiaq.de>


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="au1xxx_ide.h.patch"

diff --git a/include/asm-mips/mach-au1x00/au1xxx_ide.h b/include/asm-mips/mach-au1x00/au1xxx_ide.h
index e9fa252..8fcae21 100644
--- a/include/asm-mips/mach-au1x00/au1xxx_ide.h
+++ b/include/asm-mips/mach-au1x00/au1xxx_ide.h
@@ -141,40 +141,6 @@ static int auide_ddma_init( _auide_hwif *auide );
 static void auide_setup_ports(hw_regs_t *hw, _auide_hwif *ahwif);
 int __init auide_probe(void);
 
-#ifdef CONFIG_PM
-        int au1200ide_pm_callback( au1xxx_power_dev_t *dev,
-                                   au1xxx_request_t request, void *data);
-        static int au1xxxide_pm_standby( au1xxx_power_dev_t *dev );
-        static int au1xxxide_pm_sleep( au1xxx_power_dev_t *dev );
-        static int au1xxxide_pm_resume( au1xxx_power_dev_t *dev );
-        static int au1xxxide_pm_getstatus( au1xxx_power_dev_t *dev );
-        static int au1xxxide_pm_access( au1xxx_power_dev_t *dev );
-        static int au1xxxide_pm_idle( au1xxx_power_dev_t *dev );
-        static int au1xxxide_pm_cleanup( au1xxx_power_dev_t *dev );
-#endif
-
-
-/*
- * Multi-Word DMA + DbDMA functions
- */
-#ifdef CONFIG_BLK_DEV_IDE_AU1XXX_MDMA2_DBDMA
-        static int auide_build_sglist(ide_drive_t *drive,  struct request *rq);
-        static int auide_build_dmatable(ide_drive_t *drive);
-        static int auide_dma_end(ide_drive_t *drive);
-        ide_startstop_t auide_dma_intr (ide_drive_t *drive);
-        static void auide_dma_exec_cmd(ide_drive_t *drive, u8 command);
-        static int auide_dma_setup(ide_drive_t *drive);
-        static int auide_dma_check(ide_drive_t *drive);
-        static int auide_dma_test_irq(ide_drive_t *drive);
-        static int auide_dma_host_off(ide_drive_t *drive);
-        static int auide_dma_host_on(ide_drive_t *drive);
-        static int auide_dma_lostirq(ide_drive_t *drive);
-        static int auide_dma_on(ide_drive_t *drive);
-        static void auide_ddma_tx_callback(int irq, void *param);
-        static void auide_ddma_rx_callback(int irq, void *param);
-        static int auide_dma_off_quietly(ide_drive_t *drive);
-#endif /* end CONFIG_BLK_DEV_IDE_AU1XXX_MDMA2_DBDMA */
-
 /*******************************************************************************
 * PIO Mode timing calculation :                                                *
 *                                                                              *

--OXfL5xGRrasGEqWY--
