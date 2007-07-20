From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] pata_ali: Correct HP detect
Date: Fri, 20 Jul 2007 15:34:49 +0100
Message-ID: <20070720153449.5002bf8b@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:54767 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760336AbXGTO2K (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 Jul 2007 10:28:10 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, linux-ide@vger.kernel.org, jeff@garzik.org

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.22-rc6-mm1/drivers/ata/pata_ali.c linux-2.6.22-rc6-mm1/drivers/ata/pata_ali.c
--- linux.vanilla-2.6.22-rc6-mm1/drivers/ata/pata_ali.c	2007-07-02 20:50:11.000000000 +0100
+++ linux-2.6.22-rc6-mm1/drivers/ata/pata_ali.c	2007-07-19 10:11:43.000000000 +0100
@@ -45,7 +45,7 @@
 		.ident = "HP Pavilion N5430",
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "Hewlett-Packard"),
-			DMI_MATCH(DMI_BOARD_NAME, "OmniBook N32N-736"),
+			DMI_MATCH(DMI_BOARD_VERSION, "OmniBook N32N-736"),
 		},
 	},
 	{ }
