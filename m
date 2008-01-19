From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] pata_winbond: error return
Date: Sat, 19 Jan 2008 15:53:55 +0000
Message-ID: <20080119155355.78817058@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:34209 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757635AbYASPzt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 19 Jan 2008 10:55:49 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, akpm@osdl.org, linux-ide@vger.kernel.org

If no device is active return an error not zero.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.24-rc8-mm1/drivers/ata/pata_winbond.c linux-2.6.24-rc8-mm1/drivers/ata/pata_winbond.c
--- linux.vanilla-2.6.24-rc8-mm1/drivers/ata/pata_winbond.c	2008-01-19 14:47:56.000000000 +0000
+++ linux-2.6.24-rc8-mm1/drivers/ata/pata_winbond.c	2008-01-19 14:58:34.000000000 +0000
@@ -195,7 +195,7 @@
 	reg = winbond_readcfg(port, 0x81);
 
 	if (!(reg & 0x03))		/* Disabled */
-		return 0;
+		return -ENODEV;
 
 	for (i = 0; i < 2 ; i ++) {
 		unsigned long cmd_port = 0x1F0 - (0x80 * i);
