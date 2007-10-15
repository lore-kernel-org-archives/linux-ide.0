From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] libata-core: Don't have screaming fits over DF/ERR
 combinations
Date: Mon, 15 Oct 2007 19:23:13 +0100
Message-ID: <20071015192313.5892ed42@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:60512 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754260AbXJOSUt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 Oct 2007 14:20:49 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, akpm@osdl.org

Some hardware seems to get this wrong in a non-harmful way, and there are
some devices that seem to do it deliberately for various reasons.

Just take it as a device error not a catastrophic state machine
explosion. 

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --exclude-from /usr/src/exclude --new-file --recursive linux.vanilla-2.6.23-mm1/drivers/ata/libata-core.c linux-2.6.23-mm1/drivers/ata/libata-core.c
--- linux.vanilla-2.6.23-mm1/drivers/ata/libata-core.c	2007-10-15 15:03:26.000000000 +0100
+++ linux-2.6.23-mm1/drivers/ata/libata-core.c	2007-10-15 15:13:49.000000000 +0100
@@ -5258,7 +5319,15 @@
 		if (unlikely(status & (ATA_ERR | ATA_DF))) {
 			ata_port_printk(ap, KERN_WARNING, "DRQ=1 with device "
 					"error, dev_stat 0x%X\n", status);
-			qc->err_mask |= AC_ERR_HSM;
+			/* Some devices muck this up. Some follow an ATA
+			   non-standard that permits the damaged sector to
+			   be retrieved at this point. The ATA spec says
+			   we should jump up and down on DRQ + ERR, reality
+			   says we should be a little more relaxed.
+
+			   Rather than an HSM error, take it as a device
+			   error */
+			qc->err_mask |= AC_ERR_DEV;
 			ap->hsm_task_state = HSM_ST_ERR;
 			goto fsm_start;
 		}
