From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] libata-sff: Correct use of check_status()
Date: Mon, 15 Oct 2007 19:25:29 +0100
Message-ID: <20071015192529.2365b636@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:60516 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S933330AbXJOSVe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 Oct 2007 14:21:34 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, akpm@osdl.org

ata_check_status() does an SFF compliant check
ata_chk_status() does a generic call to ap->ops->check_status (usually
ata_check_status)

libata-sff uses the wrong one. Hardly suprising given the naming here,
which ought to get fixed to ata_sff_check_status() perhaps ?

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --exclude-from /usr/src/exclude --new-file --recursive linux.vanilla-2.6.23-mm1/drivers/ata/libata-sff.c linux-2.6.23-mm1/drivers/ata/libata-sff.c
--- linux.vanilla-2.6.23-mm1/drivers/ata/libata-sff.c	2007-10-15 15:03:26.000000000 +0100
+++ linux-2.6.23-mm1/drivers/ata/libata-sff.c	2007-10-15 15:16:29.000000000 +0100
@@ -156,7 +156,7 @@
 {
 	struct ata_ioports *ioaddr = &ap->ioaddr;
 
-	tf->command = ata_check_status(ap);
+	tf->command = ata_chk_status(ap);
 	tf->feature = ioread8(ioaddr->error_addr);
 	tf->nsect = ioread8(ioaddr->nsect_addr);
 	tf->lbal = ioread8(ioaddr->lbal_addr);
