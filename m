From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] hpt3x2n: Correct revision boundary
Date: Mon, 21 May 2007 14:57:01 +0100
Message-ID: <20070521145701.7283c30a@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:38718 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756248AbXEUNwy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 May 2007 09:52:54 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, linux-ide@vger.kernel.org, jeff@garzik.org

We have a revision that isn't correctly claimed as two drivers both go
for it: Fix the test accordingly. Noticed originally by Bill Nottingham.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.22-rc1-mm1/drivers/ata/pata_hpt3x2n.c linux-2.6.22-rc1-mm1/drivers/ata/pata_hpt3x2n.c
--- linux.vanilla-2.6.22-rc1-mm1/drivers/ata/pata_hpt3x2n.c	2007-05-18 16:21:46.000000000 +0100
+++ linux-2.6.22-rc1-mm1/drivers/ata/pata_hpt3x2n.c	2007-05-18 16:33:57.000000000 +0100
@@ -521,8 +521,8 @@
 			/* 371N if rev > 1 */
 			break;
 		case PCI_DEVICE_ID_TTI_HPT372:
-			/* 372N if rev >= 1*/
-			if (class_rev == 0)
+			/* 372N if rev >= 2*/
+			if (class_rev < 2)
 				return -ENODEV;
 			break;
 		case PCI_DEVICE_ID_TTI_HPT302:
