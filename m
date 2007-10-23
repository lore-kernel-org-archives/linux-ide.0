From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] libata-core: auditting chk_status v check_status
Date: Tue, 23 Oct 2007 16:50:02 +0100
Message-ID: <20071023165002.15a7b09e@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:44518 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753361AbXJWPrI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 23 Oct 2007 11:47:08 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, jeff@garzik.org, linux-ide@vger.kernel.org

Did a complete audit of these and found we have another error case.

ata_bus_softreset calls ata_check_status which means that it tries to do
an ioread8 on the port blindly and check versus 0xFF for an error.

It should of course be using the ap->ops method for this via chk_status,
and this bug causes a wrog status call on the NS87415 at least.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --exclude-from /usr/src/exclude --new-file --recursive linux.vanilla-2.6.23-mm1/drivers/ata/libata-core.c linux-2.6.23-mm1/drivers/ata/libata-core.c
--- linux.vanilla-2.6.23-mm1/drivers/ata/libata-core.c	2007-10-15 15:03:26.000000000 +0100
+++ linux-2.6.23-mm1/drivers/ata/libata-core.c	2007-10-23 13:39:25.861931504 +0100
@@ -3305,7 +3323,7 @@
 	 * the bus shows 0xFF because the odd clown forgets the D7
 	 * pulldown resistor.
 	 */
-	if (ata_check_status(ap) == 0xFF)
+	if (ata_chk_status(ap) == 0xFF)
 		return -ENODEV;
 
 	return ata_bus_post_reset(ap, devmask, deadline);
