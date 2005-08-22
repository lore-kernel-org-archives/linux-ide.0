From: Daniel Drake <dsd@gentoo.org>
Subject: [PATCH] sata_promise: Add PDC40519 id
Date: Mon, 22 Aug 2005 14:59:23 +0100
Message-ID: <4309DA3B.3030900@gentoo.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000801090808090102010107"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zeus1.kernel.org ([204.152.191.4]:58605 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751221AbVHVVY6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Aug 2005 17:24:58 -0400
Received: from mta07-winn.ispmail.ntl.com (mta07-winn.ispmail.ntl.com [81.103.221.47])
	by zeus1.kernel.org (8.13.1/8.13.1) with ESMTP id j7ME2KDe002589
	for <linux-ide@vger.kernel.org>; Mon, 22 Aug 2005 07:02:20 -0700
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, martin.povolny@solnet.cz

This is a multi-part message in MIME format.
--------------000801090808090102010107
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

The Promise TX4200 is a 4-port SATA controller based on the PDC40519 chip. It
meets the description of the 20319, so just a simple ID needs to be added to
support this hardware. Thanks to Martin Povolný for testing.

I sent this patch on 2005-07-28 but it has not yet been applied. This new 
patch depends on Otto Meier's PDC40718 id addition that I sent in the previous 
mail. Please apply.

Signed-off-by: Daniel Drake <dsd@gentoo.org>

--------------000801090808090102010107
Content-Type: text/x-patch;
 name="promise-tx4200.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="promise-tx4200.patch"

--- linux-2.6.13-rc6/drivers/scsi/sata_promise.c.otto	2005-08-22 14:50:11.000000000 +0100
+++ linux-2.6.13-rc6/drivers/scsi/sata_promise.c	2005-08-22 14:50:36.000000000 +0100
@@ -181,6 +181,8 @@ static struct pci_device_id pdc_ata_pci_
 	  board_20319 },
 	{ PCI_VENDOR_ID_PROMISE, 0x3319, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_20319 },
+	{ PCI_VENDOR_ID_PROMISE, 0x3519, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_20319 },
 	{ PCI_VENDOR_ID_PROMISE, 0x3d17, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_20319 },
 	{ PCI_VENDOR_ID_PROMISE, 0x3d18, PCI_ANY_ID, PCI_ANY_ID, 0, 0,

--------------000801090808090102010107--
