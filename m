From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] pata_it821x: Fix regression/corruptor
Date: Thu, 23 Aug 2007 20:18:55 +0100
Message-ID: <20070823201855.3f6b13e1@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:47547 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750922AbXHWTKy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 23 Aug 2007 15:10:54 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, torvalds@osdl.org, linux-ide@vger.kernel.org

Whoever did the PCI revision patch slipped up on the it821x, and I didn't
spot this at the time either. They moved the check for the errata from
the 0x10 revision to 0x11. Put it back

This one is important for 2.6.23 final as in some cases bad things will
occur if 0x10 revision boards don't get the fixups.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.23rc3-mm1/drivers/ata/pata_it821x.c linux-2.6.23rc3-mm1/drivers/ata/pata_it821x.c
--- linux.vanilla-2.6.23rc3-mm1/drivers/ata/pata_it821x.c	2007-08-22 17:23:00.000000000 +0100
+++ linux-2.6.23rc3-mm1/drivers/ata/pata_it821x.c	2007-08-23 19:40:10.000000000 +0100
@@ -586,7 +586,7 @@
 	itdev->want[1][1] = ATA_ANY;
 	itdev->last_device = -1;
 
-	if (pdev->revision == 0x11) {
+	if (pdev->revision == 0x10) {
 		itdev->timing10 = 1;
 		/* Need to disable ATAPI DMA for this case */
 		if (!itdev->smart)
