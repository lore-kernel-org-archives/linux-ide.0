From: Mikael Pettersson <mikpe@it.uu.se>
Subject: [PATCH 2.6.21-rc2] pmac ide: fix pmac_ide_dma_host_on() declaration
Date: Sat, 3 Mar 2007 14:24:31 +0100 (MET)
Message-ID: <200703031324.l23DOVjO003638@harpo.it.uu.se>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:46172 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965540AbXCCNY7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 3 Mar 2007 08:24:59 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: benh@kernel.crashing.org, bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org

Building 2.6.21-rc2 on a PowerMac, I get:

drivers/ide/ppc/pmac.c: In function 'pmac_ide_setup_dma':
drivers/ide/ppc/pmac.c:2042: warning: assignment from incompatible pointer type
drivers/ide/ppc/pmac.c: In function 'pmac_ide_dma_host_on':
drivers/ide/ppc/pmac.c:1988: warning: control reaches end of non-void function

These occur because ->dma_host_on should be a function
returning void, but pmac.c bogusly declares it as returning
int, and furthermore fails to return a value from it.

Correcting the return type to void fixes both warnings.

Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>

--- linux-2.6.21-rc2/drivers/ide/ppc/pmac.c.~1~	2007-03-03 12:31:07.000000000 +0100
+++ linux-2.6.21-rc2/drivers/ide/ppc/pmac.c	2007-03-03 13:18:56.000000000 +0100
@@ -1983,7 +1983,7 @@ static void pmac_ide_dma_host_off(ide_dr
 {
 }
 
-static int pmac_ide_dma_host_on(ide_drive_t *drive)
+static void pmac_ide_dma_host_on(ide_drive_t *drive)
 {
 }
 
