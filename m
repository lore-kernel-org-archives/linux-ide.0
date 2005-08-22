From: Daniel Drake <dsd@gentoo.org>
Subject: [PATCH] sata_promise: Add PDC40718 id
Date: Mon, 22 Aug 2005 14:58:57 +0100
Message-ID: <4309DA21.8050404@gentoo.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000206070705040204030004"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zeus1.kernel.org ([204.152.191.4]:53997 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751221AbVHVVYp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Aug 2005 17:24:45 -0400
Received: from mta07-winn.ispmail.ntl.com (mta07-winn.ispmail.ntl.com [81.103.221.47])
	by zeus1.kernel.org (8.13.1/8.13.1) with ESMTP id j7ME1sxc002334
	for <linux-ide@vger.kernel.org>; Mon, 22 Aug 2005 07:02:04 -0700
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, gf435@gmx.net

This is a multi-part message in MIME format.
--------------000206070705040204030004
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

From: Otto Meier <gf435@gmx.net>

Otto Meier recently submitted a patch to support the PDC40718 chip (marketed 
as SATA300 TX4, a 4-port SATA controller).

I am resending it as this patch has not been applied (maybe due to whitespace 
damage in the previous submission?). Please apply :)

Signed-off-by: Otto Meier <gf435@gmx.net>
Signed-off-by: Daniel Drake <dsd@gentoo.org>


--------------000206070705040204030004
Content-Type: text/x-patch;
 name="promise-tx4.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="promise-tx4.patch"

--- linux-2.6.13-rc6/drivers/scsi/sata_promise.c.orig	2005-08-22 14:32:11.000000000 +0100
+++ linux-2.6.13-rc6/drivers/scsi/sata_promise.c	2005-08-22 14:32:48.000000000 +0100
@@ -181,6 +181,8 @@ static struct pci_device_id pdc_ata_pci_
 	  board_20319 },
 	{ PCI_VENDOR_ID_PROMISE, 0x3319, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_20319 },
+	{ PCI_VENDOR_ID_PROMISE, 0x3d17, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_20319 },
 	{ PCI_VENDOR_ID_PROMISE, 0x3d18, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_20319 },
 

--------------000206070705040204030004--
