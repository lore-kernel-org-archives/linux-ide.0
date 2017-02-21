From: Luiz Carlos Ramos <lramos.prof@yahoo.com.br>
Subject: [PATCH 2/2] ide-generic: added messages in case of PCI IDE devices
Date: Tue, 21 Feb 2017 11:22:49 -0300
Message-ID: <20170221142249.GC11234@giustizia>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nm34-vm2.bullet.mail.bf1.yahoo.com ([72.30.239.74]:51692 "EHLO
        nm34-vm2.bullet.mail.bf1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753062AbdBUOWd (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 21 Feb 2017 09:22:33 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, David Miller <davem@davemloft.net>, petkovbb@gmail.com

Two messages are now displayed (at "warn" level) to make sure the user
is aware that PCI IDE devices were detected at common addresses (0x1f0
and 0x170) and that they will not be managed by ide-generic, but rather
delegated to its specific driver.

Signed-off-by: Luiz Carlos Ramos <lramos.prof@yahoo.com.br>
---
 drivers/ide/ide-generic.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/ide/ide-generic.c b/drivers/ide/ide-generic.c
index ee11edcdba3170c077381d603918498d79ffa3bb..2204819ef73612deed4ebfe58c69cdadb40fa53b 100644
--- a/drivers/ide/ide-generic.c
+++ b/drivers/ide/ide-generic.c
@@ -125,9 +125,19 @@ static int __init ide_generic_init(void)
 
 		if (primary == 0)
 			probe_mask |= 0x1;
+		else {
+			printk(KERN_WARN DRV_NAME ": PCI IDE device detected at 0x%4.4x."
+			     " ide-generic will not grab this device, delegating it to"
+			     " the driver of its specific chipset\n", 0x1f0);
+		}
 
 		if (secondary == 0)
 			probe_mask |= 0x2;
+		else {
+			printk(KERN_WARN DRV_NAME ": PCI IDE device detected at 0x%4.4x."
+			     " ide-generic will not grab this device, delegating it to"
+			     " the driver of its specific chipset\n", 0x170);
+		}
 	} else
 		printk(KERN_INFO DRV_NAME ": enforcing probing of I/O ports "
 			"upon user request\n");
-- 
2.8.2

