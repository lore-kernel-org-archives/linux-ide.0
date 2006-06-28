From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 2/2] libata-dev: pata_pdc2027x - remove ATA_ENABLE_PATA ifdef
Date: Wed, 28 Jun 2006 14:43:19 +0800
Message-ID: <44A22507.4010309@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:56752 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932746AbWF1GnU
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 28 Jun 2006 02:43:20 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e34.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k5S6hKl5024552
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linux-ide@vger.kernel.org>; Wed, 28 Jun 2006 02:43:20 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id k5S6gmTW301186
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Wed, 28 Jun 2006 00:42:48 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k5S6hJdP023247
	for <linux-ide@vger.kernel.org>; Wed, 28 Jun 2006 00:43:19 -0600
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, IDE Linux <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>, Unicorn Chang <uchang@tw.ibm.com>


Currently pata_pdc2027x is the only libata PATA-only driver that needs
ATA_ENABLE_PATA to be defined. Remove the ATA_ENABLE_PATA #ifdef to
make pata_pdc2027x the same as other libata PATA drivers.

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---
Patch against the pata-drivers branch (0ab56aae451577586ecac6968d86251a83f1cb40).
For your review, thanks.

--- 01_pdc074-eh/drivers/scsi/pata_pdc2027x.c	2006-06-28 13:40:38.000000000 +0800
+++ 02_remove_define/drivers/scsi/pata_pdc2027x.c	2006-06-28 13:42:57.000000000 +0800
@@ -108,7 +108,6 @@ static struct pdc2027x_udma_timing {
 };
 
 static const struct pci_device_id pdc2027x_pci_tbl[] = {
-#ifdef ATA_ENABLE_PATA
 	{ PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20268, PCI_ANY_ID, PCI_ANY_ID, 0, 0, PDC_UDMA_100 },
 	{ PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20269, PCI_ANY_ID, PCI_ANY_ID, 0, 0, PDC_UDMA_133 },
 	{ PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20270, PCI_ANY_ID, PCI_ANY_ID, 0, 0, PDC_UDMA_100 },
@@ -116,7 +115,6 @@ static const struct pci_device_id pdc202
 	{ PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20275, PCI_ANY_ID, PCI_ANY_ID, 0, 0, PDC_UDMA_133 },
 	{ PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20276, PCI_ANY_ID, PCI_ANY_ID, 0, 0, PDC_UDMA_133 },
 	{ PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20277, PCI_ANY_ID, PCI_ANY_ID, 0, 0, PDC_UDMA_133 },
-#endif
 	{ }	/* terminate list */
 };
 


