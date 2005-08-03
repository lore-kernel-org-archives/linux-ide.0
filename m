From: Otto Meier <gf435@gmx.net>
Subject: [PATCH] aktivate sata300 TX4 in sata_promise
Date: Wed, 03 Aug 2005 10:59:04 +0200
Message-ID: <42F08758.9000109@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.183]:14275 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262160AbVHCI7T (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 3 Aug 2005 04:59:19 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hallo,

this Patch get the Promise SATA300 TX4 card working.
Please accept. Patch is against 2.6.13-rc3-git5.

Signed-off-by: Otto Meier <gf435@gmx.net>

--- linux/drivers/scsi/sata_promise.c.orig      2005-08-01 
17:09:48.474824778 +0200
+++ linux/drivers/scsi/sata_promise.c   2005-07-31 12:57:06.415979512 +0200
@@ -183,6 +183,8 @@ static struct pci_device_id pdc_ata_pci_
          board_20319 },
        { PCI_VENDOR_ID_PROMISE, 0x3319, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
          board_20319 },
+        { PCI_VENDOR_ID_PROMISE, 0x3d17, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+          board_20319 },
        { PCI_VENDOR_ID_PROMISE, 0x3d18, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
          board_20319 },



