From: Daniel Drake <dsd@gentoo.org>
Subject: [PATCH] via82cxxx: Add VIA VT8237A southbridge ID
Date: Mon, 24 Jul 2006 15:58:42 +0100 (BST)
Message-ID: <20060724145842.0E71F72E450@zog.reactivated.net>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:14695 "EHLO
	mtaout03-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S932201AbWGXO5r (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 24 Jul 2006 10:57:47 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

Some motherboards based on the KT890 chipset include this southbridge. Adding
it allows the via82cxxx IDE driver to be used on these systems.

Signed-off-by: Daniel Drake <dsd@gentoo.org>

Index: linux/drivers/ide/pci/via82cxxx.c
===================================================================
--- linux.orig/drivers/ide/pci/via82cxxx.c
+++ linux/drivers/ide/pci/via82cxxx.c
@@ -81,6 +81,7 @@ static struct via_isa_bridge {
 	{ "vt6410",	PCI_DEVICE_ID_VIA_6410,     0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
 	{ "vt8251",	PCI_DEVICE_ID_VIA_8251,     0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
 	{ "vt8237",	PCI_DEVICE_ID_VIA_8237,     0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
+	{ "vt8237a",	PCI_DEVICE_ID_VIA_8237A,    0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
 	{ "vt8235",	PCI_DEVICE_ID_VIA_8235,     0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
 	{ "vt8233a",	PCI_DEVICE_ID_VIA_8233A,    0x00, 0x2f, VIA_UDMA_133 | VIA_BAD_AST },
 	{ "vt8233c",	PCI_DEVICE_ID_VIA_8233C_0,  0x00, 0x2f, VIA_UDMA_100 },
