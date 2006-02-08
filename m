From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 1/4] libata-dev: Fix array index value in ata_rwcmd_protocol()
Date: Wed, 08 Feb 2006 16:37:43 +0800
Message-ID: <43E9ADD7.6070406@tw.ibm.com>
References: <43DA2CFB.4010605@pobox.com> <43E9AAE0.8020302@tw.ibm.com> <43E9AD00.8070900@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:56744 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030179AbWBHIhx
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 8 Feb 2006 03:37:53 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e35.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id k188blB7026535
	for <linux-ide@vger.kernel.org>; Wed, 8 Feb 2006 03:37:47 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VERS6.8) with ESMTP id k188eD5b173906
	for <linux-ide@vger.kernel.org>; Wed, 8 Feb 2006 01:40:14 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k188bkWq006275
	for <linux-ide@vger.kernel.org>; Wed, 8 Feb 2006 01:37:46 -0700
In-Reply-To: <43E9AD00.8070900@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: Jeff Garzik <jgarzik@pobox.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, Doug Maxey <dwm@maxeymade.com>

Patch 1/4:

  - Fix the array index value in ata_rwcmd_protocol() for the added FUA commands.

For your review, thanks.

Albert
Signed-off-by: Albert Lee <albertcc@tw.ibm.com> 

===

--- irq-pio/drivers/scsi/libata-core.c	2006-02-07 16:59:14.000000000 +0800
+++ rwcmd/drivers/scsi/libata-core.c	2006-02-08 13:39:34.000000000 +0800
@@ -611,7 +611,7 @@ int ata_rwcmd_protocol(struct ata_queued
 	} else if (lba48 && (qc->ap->flags & ATA_FLAG_PIO_LBA48)) {
 		/* Unable to use DMA due to host limitation */
 		tf->protocol = ATA_PROT_PIO;
-		index = dev->multi_count ? 0 : 4;
+		index = dev->multi_count ? 0 : 8;
 	} else {
 		tf->protocol = ATA_PROT_DMA;
 		index = 16;


