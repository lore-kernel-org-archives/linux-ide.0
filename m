From: Robert Borkowski <rborkows@novator.com>
Subject: [PATCH] updated sata_promise.c with new device id
Date: Mon, 06 Feb 2006 14:17:08 -0500
Message-ID: <43E7A0B4.4050908@novator.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tor149-99-58-114.dedicated.sprintdsl.ca ([149.99.58.114]:50117
	"EHLO mail.novator.com") by vger.kernel.org with ESMTP
	id S932281AbWBFTRW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 6 Feb 2006 14:17:22 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

patch is against kernel 2.4.32
card is a Promise SATAII 300 TX4, PDC40718-GP printed on the main chip

Tested by making md raid5 on four drives and stressing with bonnie++.
Any other tests I should run?

Signed-off-by: Robert Borkowski <rborkows@novator.com>
--- drivers/scsi/sata_promise.c.orig    Mon Feb  6 11:45:06 2006
+++ drivers/scsi/sata_promise.c Mon Feb  6 11:45:39 2006
@@ -181,6 +181,8 @@
           board_20319 },
         { PCI_VENDOR_ID_PROMISE, 0x3319, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
           board_20319 },
+       { PCI_VENDOR_ID_PROMISE, 0x3d17, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+         board_20319 },
         { PCI_VENDOR_ID_PROMISE, 0x3d18, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
           board_20319 },

-- 
Robert Borkowski
