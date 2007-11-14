From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 2/2] libata: use ATA_HORKAGE_STUCK_ERR for ATAPI tape drives
Date: Wed, 14 Nov 2007 14:20:38 +0800
Message-ID: <473A93B6.5040009@tw.ibm.com>
References: <471C6C44.2030607@gmail.com>	<471CEDD4.5040201@garzik.org>	<471D25D0.9020702@rtr.ca>	<47397784.9070205@tw.ibm.com>	<47397CC0.1070401@tw.ibm.com>	<4739AB5B.7000703@rtr.ca>	<20071113151459.086ffcae@the-village.bc.nu>	<4739DDDD.7060305@rtr.ca> <20071113181257.24ab95dd@the-village.bc.nu> <4739EB53.5010206@rtr.ca> <473A56CE.4080804@gmail.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:41754 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750988AbXKNGUv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Nov 2007 01:20:51 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id lAE6KkbE015224
	for <linux-ide@vger.kernel.org>; Wed, 14 Nov 2007 01:20:46 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id lAE6Kkbv114844
	for <linux-ide@vger.kernel.org>; Tue, 13 Nov 2007 23:20:46 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id lAE6Kj7d029533
	for <linux-ide@vger.kernel.org>; Tue, 13 Nov 2007 23:20:45 -0700
In-Reply-To: <473A56CE.4080804@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>, Mark Lord <liml@rtr.ca>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Per Mark's comments, maybe all ATAPI tape drives need ATA_HORKAGE_STUCK_ERR.
This patch applys ATA_HORKAGE_STUCK_ERR for all ATAPI tape drives.

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
Cc: Mark Lord <liml@rtr.ca>
---

diff -Nrup 01_ide_tape_stuck_err/drivers/ata/libata-core.c 02_black_ide_tape_drives/drivers/ata/libata-core.c
--- 01_ide_tape_stuck_err/drivers/ata/libata-core.c	2007-11-14 11:20:31.000000000 +0800
+++ 02_black_ide_tape_drives/drivers/ata/libata-core.c	2007-11-14 11:45:33.000000000 +0800
@@ -2307,8 +2307,10 @@ int ata_dev_configure(struct ata_device 
 	}
 
 	if ((dev->class == ATA_DEV_ATAPI) &&
-	    (atapi_command_packet_set(id) == TYPE_TAPE))
+	    (atapi_command_packet_set(id) == TYPE_TAPE)) {
 		dev->max_sectors = ATA_MAX_SECTORS_TAPE;
+		dev->horkage |= ATA_HORKAGE_STUCK_ERR;
+	}
 
 	if (dev->horkage & ATA_HORKAGE_MAX_SEC_128)
 		dev->max_sectors = min_t(unsigned int, ATA_MAX_SECTORS_128,


