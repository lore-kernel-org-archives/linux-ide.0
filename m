From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] cs5535: add pci id for AMD based CS5535 controllers
Date: Wed, 2 Dec 2009 18:56:33 +0100
Message-ID: <200912021856.34029.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:48316 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754954AbZLBR5e (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Dec 2009 12:57:34 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>

Based on commit 02cb009 for pata_cs5530.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/cs5535.c |    1 +
 1 file changed, 1 insertion(+)

Index: b/drivers/ide/cs5535.c
===================================================================
--- a/drivers/ide/cs5535.c
+++ b/drivers/ide/cs5535.c
@@ -187,6 +187,7 @@ static int __devinit cs5535_init_one(str
 
 static const struct pci_device_id cs5535_pci_tbl[] = {
 	{ PCI_VDEVICE(NS, PCI_DEVICE_ID_NS_CS5535_IDE), 0 },
+	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_CS5535_IDE), },
 	{ 0, },
 };
 
