From: Lennert Buytenhek <buytenh@wantstofly.org>
Subject: [PATCH] ata_if_xfermask() word 51 fix
Date: Mon, 29 Jan 2007 13:28:47 +0100
Message-ID: <20070129122847.GC11895@xi.wantstofly.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from alephnull.demon.nl ([83.160.184.112]:45524 "EHLO
	xi.wantstofly.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751252AbXA2M2u (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Jan 2007 07:28:50 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org

If word 53 bit 1 isn't set, the maximum PIO mode is indicated by
the upper 8 bits of word 51, not the lower 8 bits.  Fixes PIO mode
detection on old Compact Flash cards.

Signed-off-by: Lennert Buytenhek <buytenh@wantstofly.org>

Index: linux-2.6.19/drivers/ata/libata-core.c
===================================================================
--- linux-2.6.19.orig/drivers/ata/libata-core.c
+++ linux-2.6.19/drivers/ata/libata-core.c
@@ -1037,7 +1048,7 @@ static unsigned int ata_id_xfermask(cons
 		 * the PIO timing number for the maximum. Turn it into
 		 * a mask.
 		 */
-		u8 mode = id[ATA_ID_OLD_PIO_MODES] & 0xFF;
+		u8 mode = (id[ATA_ID_OLD_PIO_MODES] >> 8) & 0xFF;
 		if (mode < 5)	/* Valid PIO range */
                 	pio_mask = (2 << mode) - 1;
 		else
