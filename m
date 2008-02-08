From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] pata_legacy: typo fix
Date: Fri, 8 Feb 2008 15:23:38 +0000
Message-ID: <20080208152338.7c1fcaa7@core>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:41503 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753115AbYBHPaE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 Feb 2008 10:30:04 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.24-mm1/drivers/ata/pata_legacy.c linux-2.6.24-mm1/drivers/ata/pata_legacy.c
--- linux.vanilla-2.6.24-mm1/drivers/ata/pata_legacy.c	2008-02-06 14:14:39.000000000 +0000
+++ linux-2.6.24-mm1/drivers/ata/pata_legacy.c	2008-02-06 14:38:54.000000000 +0000
@@ -127,7 +127,7 @@
 static int opti82c46x;		/* Opti 82c465MV present(pri/sec autodetect) */
 static int qdi;			/* Set to probe QDI controllers */
 static int winbond;		/* Set to probe Winbond controllers,
-					give I/O port if non stdanard */
+					give I/O port if non standard */
 static int autospeed;		/* Chip present which snoops speed changes */
 static int pio_mask = 0x1F;	/* PIO range for autospeed devices */
 static int iordy_mask = 0xFFFFFFFF;	/* Use iordy if available */
