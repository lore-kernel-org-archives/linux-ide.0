From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] ppc32: Fix via IDE driver for pegasos
Date: Thu, 27 Jan 2005 13:13:54 +1100
Message-ID: <1106792034.5235.89.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:26841 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261954AbVA0CPJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 26 Jan 2005 21:15:09 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: list linux-ide <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>

Hi Andrew !

The Pegasos machines have the VIA IDE controller configured in a strange
way by the firmware. It claims to be fully native, but is actually
routed to legacy irqs 14 and 15.

This patch works around that in the driver. In the future, I'll try to
do an ifdef-less patch by detecting that setup from the chip, and using
the new pci_get_legacy_ide_irq() in that case, but I don't have proper
HW infos. This patch is good enough in the meantime, I'll come up with a
better one later eventually.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

--- kernel-source-2.6.8/drivers/ide/pci/via82cxxx.c.orig	2004-11-24 22:47:24.000000000 +0100
+++ kernel-source-2.6.8/drivers/ide/pci/via82cxxx.c	2004-12-26 12:10:06.900614568 +0100
@@ -36,6 +36,10 @@
 #include <linux/ide.h>
 #include <asm/io.h>
 
+#ifdef CONFIG_PPC_MULTIPLATFORM
+#include <asm/processor.h>
+#endif
+
 #include "ide-timing.h"
 
 #define DISPLAY_VIA_TIMINGS
@@ -584,6 +588,13 @@
 	hwif->tuneproc = &via82cxxx_tune_drive;
 	hwif->speedproc = &via_set_drive;
 
+
+#ifdef CONFIG_PPC_MULTIPLATFORM
+	if(_machine == _MACH_chrp && _chrp_type == _CHRP_Pegasos) {
+		hwif->irq = hwif->channel ? 15 : 14;
+	}
+#endif
+
 	for (i = 0; i < 2; i++) {
 		hwif->drives[i].io_32bit = 1;
 		hwif->drives[i].unmask = (via_config->flags & VIA_NO_UNMASK) ? 0 : 1;


