From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] ide: Fix a theoretical Ooops case
Date: Fri, 22 Jun 2007 14:20:05 +0100
Message-ID: <20070622142005.7a20d4c4@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:34821 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752085AbXFVNOs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 22 Jun 2007 09:14:48 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, bzolnier@gmail.com, linux-ide@vger.kernel.org

Found by a static analyser. It is in theory possible we dereference
dev->id when it has become invalid. Re-order to avoid this.

Not needed for new-ide as we no longer support the crazy exabyte nest stuff

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.22-rc4-mm2/drivers/ide/ide-probe.c linux-2.6.22-rc4-mm2/drivers/ide/ide-probe.c
--- linux.vanilla-2.6.22-rc4-mm2/drivers/ide/ide-probe.c	2007-06-07 14:26:08.000000000 +0100
+++ linux-2.6.22-rc4-mm2/drivers/ide/ide-probe.c	2007-06-18 16:45:28.000000000 +0100
@@ -574,11 +574,11 @@
 			/* look for ATAPI device */
 			(void) do_probe(drive, WIN_PIDENTIFY);
 		}
-		if (strstr(drive->id->model, "E X A B Y T E N E S T"))
-			enable_nest(drive);
 		if (!drive->present)
 			/* drive not found */
 			return 0;
+		if (strstr(drive->id->model, "E X A B Y T E N E S T"))
+			enable_nest(drive);
 	
 		/* identification failed? */
 		if (!drive->id_read) {
