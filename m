From: Daniel Drake <dsd@gentoo.org>
Subject: [PATCH] sata_promise: Add TX4200 (PDC40519) ID
Date: Thu, 28 Jul 2005 13:36:34 +0100
Message-ID: <42E8D152.4050907@gentoo.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000806020708020101030009"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mta08-winn.ispmail.ntl.com ([81.103.221.48]:53881 "EHLO
	mta08-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S261432AbVG1MgN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 28 Jul 2005 08:36:13 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, murphy@sgtp.samara.ru, martin.povolny@solnet.cz

This is a multi-part message in MIME format.
--------------000806020708020101030009
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

The Promise TX4200 is a 4-port SATA controller based on the PDC40519 chip. It 
meets the description of the 20619, so just a simple ID needs to be added to 
support this hardware. Thanks to Martin Povolný for testing.

Signed-off-by: Daniel Drake <dsd@gentoo.org>


--------------000806020708020101030009
Content-Type: text/x-patch;
 name="sata-promise-tx4200.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sata-promise-tx4200.patch"

--- linux-2.6.13-rc3-git9/drivers/scsi/sata_promise.c.orig	2005-07-28 13:29:47.000000000 +0100
+++ linux-2.6.13-rc3-git9/drivers/scsi/sata_promise.c	2005-07-28 13:30:54.000000000 +0100
@@ -181,6 +181,8 @@ static struct pci_device_id pdc_ata_pci_
 	  board_20319 },
 	{ PCI_VENDOR_ID_PROMISE, 0x3319, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_20319 },
+	{ PCI_VENDOR_ID_PROMISE, 0x3519, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_20319 },
 	{ PCI_VENDOR_ID_PROMISE, 0x3d18, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_20319 },
 

--------------000806020708020101030009--
