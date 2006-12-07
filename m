From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 1/1] libata: let ATA_FLAG_PIO_POLLING use polling pio for
 ATA_PROT_NODATA
Date: Thu, 07 Dec 2006 11:37:58 +0800
Message-ID: <45778C96.7010101@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:42079 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968084AbWLGDiS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 6 Dec 2006 22:38:18 -0500
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e33.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id kB73cDC7022735
	for <linux-ide@vger.kernel.org>; Wed, 6 Dec 2006 22:38:13 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id kB73cDrn398512
	for <linux-ide@vger.kernel.org>; Wed, 6 Dec 2006 20:38:13 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id kB73cCDB004149
	for <linux-ide@vger.kernel.org>; Wed, 6 Dec 2006 20:38:13 -0700
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, Linux IDE <linux-ide@vger.kernel.org>

Even if ATA_FLAG_PIO_POLLING is set, libata uses irq pio for the ATA_PROT_NODATA protocol.
This patch let ATA_FLAG_PIO_POLLING use polling pio for the ATA_PROT_NODATA protocol.

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---
Currently even if ATA_FLAG_PIO_POLLING is set, irq driven pio is used for the
ATA_PROT_NODATA protocol. This won't cause problem for the current users of
ATA_FLAG_PIO_POLLING (sata_mv, pdc_adma.c, etc.) since the older drivers can
handle the PIO_NODATA interrupts just like the DMA interrupts.

However, pata_ixp4xx_cf, the new user of ATA_FLAG_PIO_POLLING, might have no
interrupt at all. Using irq driven pio for the ATA_PROT_NODATA protocol will
cause timeout for pata_ixp4xx_cf.

The patch is against libata-dev (2b25ec4b7b73f57f09c1262d2f2d4a567b18f44f).
For your review, thanks.

--- libata-dev/drivers/ata/libata-core.c	2006-12-07 11:05:23.000000000 +0800
+++ pio_polling/drivers/ata/libata-core.c	2006-12-07 11:10:21.000000000 +0800
@@ -4975,6 +4975,7 @@ unsigned int ata_qc_issue_prot(struct at
 	if (ap->flags & ATA_FLAG_PIO_POLLING) {
 		switch (qc->tf.protocol) {
 		case ATA_PROT_PIO:
+		case ATA_PROT_NODATA:
 		case ATA_PROT_ATAPI:
 		case ATA_PROT_ATAPI_NODATA:
 			qc->tf.flags |= ATA_TFLAG_POLLING;


