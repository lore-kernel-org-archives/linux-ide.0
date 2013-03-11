From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] pata_legacy: bogus clock in opti82c46x_set_piomode()
Date: Mon, 11 Mar 2013 14:41:51 +0300
Message-ID: <20130311114151.GB8235@longonot.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:38082 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753886Ab3CKLnW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 Mar 2013 07:43:22 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, kernel-janitors@vger.kernel.org

"sysclk" is used as an index into a 4 element array.  My static
checker complains because it can be out of bounds.  From the
context, it looks like there is a right bit shift missing.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
I don't have the hardware to test this.

diff --git a/drivers/ata/pata_legacy.c b/drivers/ata/pata_legacy.c
index 4fe9d21..be81642 100644
--- a/drivers/ata/pata_legacy.c
+++ b/drivers/ata/pata_legacy.c
@@ -542,7 +542,7 @@ static void opti82c46x_set_piomode(struct ata_port *ap, struct ata_device *adev)
 	u8 sysclk;
 
 	/* Get the clock */
-	sysclk = opti_syscfg(0xAC) & 0xC0;	/* BIOS set */
+	sysclk = (opti_syscfg(0xAC) & 0xC0) >> 6;	/* BIOS set */
 
 	/* Enter configuration mode */
 	ioread16(ap->ioaddr.error_addr);
