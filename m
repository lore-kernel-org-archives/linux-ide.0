From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: PATCH: Add _with_fixup interfaces to ide_register_hw
Date: Fri, 05 Nov 2004 16:38:04 +0000
Message-ID: <1099672682.5630.52.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from clock-tower.bc.nu ([81.2.110.250]:12485 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262739AbUKERk6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 5 Nov 2004 12:40:58 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, linux-ide@vger.kernel.org

In order to be useful we need an _fixup version of both probe_hwif and
register_hw function. This completes the pair and again as Bart
requested keeps the old API around.

diff --exclude-from /usr/src/exclude -u --new-file --recursive
linux.vanilla-2.6.10rc1/drivers/ide/ide.c
linux-2.6.10rc1/drivers/ide/ide.c
--- linux.vanilla-2.6.10rc1/drivers/ide/ide.c	2004-11-05
15:42:15.000000000 +0000
+++ linux-2.6.10rc1/drivers/ide/ide.c	2004-11-05 16:06:29.000000000
+0000
@@ -988,17 +989,22 @@
 }
 
 /**
- *	ide_register_hw		-	register IDE interface
+ *	ide_register_hw_with_fixup	-	register IDE interface
  *	@hw: hardware registers
  *	@hwifp: pointer to returned hwif
+ *	@fixup function to call
  *
  *	Register an IDE interface, specifying exactly the registers etc.
  *	Set init=1 iff calling before probes have taken place.
  *
+ *	Invokes a fixup function after the probe and before device
attachment
+ *	that can be used by the driver to amend settings or to work around
+ *	hardware funnies.
+ *
  *	Returns -1 on error.
  */
 
-int ide_register_hw (hw_regs_t *hw, ide_hwif_t **hwifp)
+int ide_register_hw_with_fixup(hw_regs_t *hw, ide_hwif_t **hwifp, void
(*fixup)(ide_hwif_t *hwif))
 {
 	int index, retry = 1;
 	ide_hwif_t *hwif;
@@ -1037,7 +1043,7 @@
 	hwif->chipset = hw->chipset;
 
 	if (!initializing) {
-		probe_hwif_init(hwif);
+		probe_hwif_init_with_fixup(hwif, fixup);
 		create_proc_ide_interfaces();
 	}
 
@@ -1047,6 +1053,25 @@
 	return (initializing || hwif->present) ? index : -1;
 }
 
+EXPORT_SYMBOL(ide_register_hw_with_fixup);
+
+/**
+ *	ide_register_hw		-	register new IDE hardware
+ *	@hw: hardware registers
+ *	@hwifp: pointer to returned hwif
+ *
+ *	Register an IDE interface, specifying exactly the registers etc.
+ *	Set init=1 iff calling before probes have taken place. The
+ *	ide_cfg_sem protects this against races.
+ *
+ *	Returns -1 on error.
+ */
+ 
+int ide_register_hw(hw_regs_t *hw, ide_hwif_t **hwif)
+{
+	return ide_register_hw_with_fixup(hw, hwif, NULL);
+}
+
 EXPORT_SYMBOL(ide_register_hw);
 
 /*

