From: Daniel Drake <dsd@gentoo.org>
Subject: [PATCH] sata_promise: Support FastTrak TX4300/TX4310
Date: Sat,  4 Mar 2006 15:36:21 +0000 (GMT)
Message-ID: <20060304153621.44067870414@zog.reactivated.net>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:33845 "EHLO
	mta07-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1751664AbWCDPgV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 4 Mar 2006 10:36:21 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

This patch adds support for the Promise FastTrak TX4300/TX4310 4-port PCI SATA
controllers based on the PDC40719 chip.

Signed-off-by: Daniel Drake <dsd@gentoo.org> 

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
