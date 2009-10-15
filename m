From: <JosephChan@via.com.tw>
Subject: RE: [patch 1/1] pata_via.c : extend the rev_max for VT6430
Date: Thu, 15 Oct 2009 16:06:52 +0800
Message-ID: <C80EF34A3D2E494DBAF9AC29C7AE4EB80A1D155C@exchtp03.taipei.via.com.tw>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from exchtp08.via.com.tw ([61.66.243.7]:4477 "EHLO
	exchtp08.via.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755832AbZJOIHa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 Oct 2009 04:07:30 -0400
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk, tj@kernel.org, jeff@garzik.org, JosephChan@via.com.tw

Sorry, it's a typo.  It should be VT6330, not VT6430.

-----Original Message-----
From: Joseph Chan 
Sent: Thursday, October 15, 2009 3:39 PM
To: 'linux-ide@vger.kernel.org'
Cc: 'Alan Cox'; 'Tejun Heo'; jeff@garzik.org; Joseph Chan
Subject: [patch 1/1] pata_via.c : extend the rev_max for VT6430

Fix the VT6330 issue, it's because the rev_max of VT6330 exceeds 0x2f.
The VT6415 and VT6430 share the same device ID.

Signed-off-by: Joseph Chan <josephchan@via.com.tw>

--- a/drivers/ata/pata_via.c	2009-10-15 23:12:49.000000000 +0800
+++ b/drivers/ata/pata_via.c	2009-10-15 23:12:57.000000000 +0800
@@ -111,7 +111,7 @@
 	{ "vt8251",	PCI_DEVICE_ID_VIA_8251,     0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
 	{ "cx700",	PCI_DEVICE_ID_VIA_CX700,    0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST | VIA_SATA_PATA },
 	{ "vt6410",	PCI_DEVICE_ID_VIA_6410,     0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST | VIA_NO_ENABLES },
-	{ "vt6415",	PCI_DEVICE_ID_VIA_6415,     0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST | VIA_NO_ENABLES },
+	{ "vt6415",	PCI_DEVICE_ID_VIA_6415,     0x00, 0xff, VIA_UDMA_133 | VIA_BAD_AST | VIA_NO_ENABLES },
 	{ "vt8237a",	PCI_DEVICE_ID_VIA_8237A,    0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
 	{ "vt8237",	PCI_DEVICE_ID_VIA_8237,     0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
 	{ "vt8235",	PCI_DEVICE_ID_VIA_8235,     0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
