From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: PATCH: Use the new fixup interfaces in ide-cs
Date: Fri, 05 Nov 2004 16:30:36 +0000
Message-ID: <1099672234.5564.44.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from clock-tower.bc.nu ([81.2.110.250]:9669 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262728AbUKERdb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 5 Nov 2004 12:33:31 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, linux-ide@vger.kernel.org

diff --exclude-from /usr/src/exclude -u --new-file --recursive linux.vanilla-2.6.10rc1/drivers/ide/legacy/ide-cs.c linux-2.6.10rc1/drivers/ide/legacy/ide-cs.c
--- linux.vanilla-2.6.10rc1/drivers/ide/legacy/ide-cs.c	2004-11-05 15:34:46.000000000 +0000
+++ linux-2.6.10rc1/drivers/ide/legacy/ide-cs.c	2004-11-05 16:07:46.000000000 +0000
@@ -206,7 +206,7 @@
     ide_init_hwif_ports(&hw, io, ctl, NULL);
     hw.irq = irq;
     hw.chipset = ide_pci;
-    return ide_register_hw(&hw, NULL);
+    return ide_register_hw_with_fixup(&hw, NULL, ide_undecoded_slave);
 }
 
 /*======================================================================

