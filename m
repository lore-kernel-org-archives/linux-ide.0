From: Daniel Drake <dsd@gentoo.org>
Subject: [PATCH] sata_promise: Support FastTrak TX4310
Date: Mon, 13 Feb 2006 22:53:17 +0000
Message-ID: <43F10DDD.901@gentoo.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040203090301080001070909"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mta08-winn.ispmail.ntl.com ([81.103.221.48]:46146 "EHLO
	mta08-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1030225AbWBMWtG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 13 Feb 2006 17:49:06 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------040203090301080001070909
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch adds support for the Promise FastTrak TX4310, a 4-port PCI 
SATA controller based on the PDC40719 chip.

Signed-off-by: Daniel Drake <dsd@gentoo.org>


--------------040203090301080001070909
Content-Type: text/x-patch;
 name="sata-promise-tx4310.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sata-promise-tx4310.patch"

--- linux/drivers/scsi/sata_promise.c.orig	2006-02-12 17:12:34.000000000 +0000
+++ linux/drivers/scsi/sata_promise.c	2006-02-12 17:13:46.000000000 +0000
@@ -228,6 +228,8 @@ static const struct pci_device_id pdc_at
 	  board_20319 },
 	{ PCI_VENDOR_ID_PROMISE, 0x3319, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_20319 },
+	{ PCI_VENDOR_ID_PROMISE, 0x3515, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_20319 },
 	{ PCI_VENDOR_ID_PROMISE, 0x3519, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_20319 },
 	{ PCI_VENDOR_ID_PROMISE, 0x3d17, PCI_ANY_ID, PCI_ANY_ID, 0, 0,

--------------040203090301080001070909--
