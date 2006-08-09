From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH] libata: Use ATA_FLAG_PIO_POLLING for pdc_adma
Date: Wed, 09 Aug 2006 18:36:22 +0800
Message-ID: <44D9BAA6.2050005@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:37009 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030670AbWHIKgh
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 9 Aug 2006 06:36:37 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e33.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k79AaaBG026255
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linux-ide@vger.kernel.org>; Wed, 9 Aug 2006 06:36:36 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id k79AaZGL196520
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Wed, 9 Aug 2006 04:36:35 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k79AaZ3H029607
	for <linux-ide@vger.kernel.org>; Wed, 9 Aug 2006 04:36:35 -0600
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>, Mark Lord <liml@rtr.ca>, Tejun Heo <htejun@gmail.com>


pdc_adma was overlooked and broken by the irq-pio patch:
Only HSM_ST_LAST interrupts should be delivered to this LLDD.

Adding ATA_FLAG_PIO_POLLING to pdc_adma fixes the problem (temporarily),
before we convert the irq handler of pdc_adma to handle all interrupts.

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---
Patch against 2.6.18-rc4 and tested ok by Tejun.

--- linux-2.6.18-rc4/drivers/scsi/pdc_adma.c	2006-08-08 14:03:21.000000000 +0800
+++ linux-2.6.18-rc4-adma-poll/drivers/scsi/pdc_adma.c	2006-08-08 14:05:13.000000000 +0800
@@ -183,7 +183,8 @@ static struct ata_port_info adma_port_in
 	{
 		.sht		= &adma_ata_sht,
 		.host_flags	= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST |
-				  ATA_FLAG_NO_LEGACY | ATA_FLAG_MMIO,
+				  ATA_FLAG_NO_LEGACY | ATA_FLAG_MMIO |
+				  ATA_FLAG_PIO_POLLING,
 		.pio_mask	= 0x10, /* pio4 */
 		.udma_mask	= 0x1f, /* udma0-4 */
 		.port_ops	= &adma_ata_ops,


