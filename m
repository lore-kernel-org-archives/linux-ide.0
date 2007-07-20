From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] pata_cs5520: Fix probe bug introduced by 2.6.22
 (regression)
Date: Fri, 20 Jul 2007 15:36:31 +0100
Message-ID: <20070720153631.10ba09da@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:54771 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758679AbXGTOaA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 Jul 2007 10:30:00 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, linux-ide@vger.kernel.org, jeff@garzik.org, torvalds@osdl.org

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.22-rc6-mm1/drivers/ata/pata_cs5520.c linux-2.6.22-rc6-mm1/drivers/ata/pata_cs5520.c
--- linux.vanilla-2.6.22-rc6-mm1/drivers/ata/pata_cs5520.c	2007-07-02 20:48:49.000000000 +0100
+++ linux-2.6.22-rc6-mm1/drivers/ata/pata_cs5520.c	2007-07-20 00:10:09.000000000 +0100
@@ -275,7 +275,7 @@
 
 	for (i = 0; i < 2; i++) {
 		static const int irq[] = { 14, 15 };
-		struct ata_port *ap = host->ports[0];
+		struct ata_port *ap = host->ports[i];
 
 		if (ata_port_is_dummy(ap))
 			continue;
