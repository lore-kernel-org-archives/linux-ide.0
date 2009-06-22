From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] cs5520: add missing IRQ setup for the second port
Date: Mon, 22 Jun 2009 13:48:02 +0200
Message-ID: <200906221348.02632.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f224.google.com ([209.85.220.224]:45870 "EHLO
	mail-fx0-f224.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756326AbZFVLnX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Jun 2009 07:43:23 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] cs5520: add missing IRQ setup for the second port

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
This is obviously correct regression fix.  The only problem is that
it cannot be applied under the new rigid policy before somebody with
the hardware verifies it.  This will only result in a needless delay
in this case (IMHO a common sense works better than rigid policies).

 drivers/ide/cs5520.c |    1 +
 1 file changed, 1 insertion(+)

Index: b/drivers/ide/cs5520.c
===================================================================
--- a/drivers/ide/cs5520.c
+++ b/drivers/ide/cs5520.c
@@ -135,6 +135,7 @@ static int __devinit cs5520_init_one(str
 
 	ide_pci_setup_ports(dev, d, &hw[0], &hws[0]);
 	hw[0].irq = 14;
+	hw[1].irq = 15;
 
 	return ide_host_add(d, hws, 2, NULL);
 }
