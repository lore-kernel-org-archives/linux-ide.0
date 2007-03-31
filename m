From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 3/4] libata: Limit max sector to 240 for TORiSAN DVD drives
Date: Sat, 31 Mar 2007 15:21:24 +0800
Message-ID: <460E0BF4.2010701@tw.ibm.com>
References: <460E08AF.8070900@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:37400 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750740AbXCaHVg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 31 Mar 2007 03:21:36 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id l2V7JW7X007256
	for <linux-ide@vger.kernel.org>; Sat, 31 Mar 2007 03:19:32 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l2V7LanK172950
	for <linux-ide@vger.kernel.org>; Sat, 31 Mar 2007 01:21:36 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l2V7LZ67020752
	for <linux-ide@vger.kernel.org>; Sat, 31 Mar 2007 01:21:35 -0600
In-Reply-To: <460E08AF.8070900@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Tejun Heo <htejun@gmail.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, YUP <yupadmin@gmail.com>, Vlad Codrea <VladCodrea@mail.utexas.edu>, IDE Linux <linux-ide@vger.kernel.org>

patch 3/4:
  The TORiSAN drive locks up when max sector == 256.
  Limit max sector to 240 for TORiSAN DRD-N216 drives.
  (http://bugzilla.kernel.org/show_bug.cgi?id=6710)

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
---
Patch against libata-dev tree, for your review, thanks.

diff -Nrup 02_aopen_rs/drivers/ata/libata-core.c 03_max_sect/drivers/ata/libata-core.c
--- 02_aopen_rs/drivers/ata/libata-core.c	2007-03-23 16:56:13.000000000 +0800
+++ 03_max_sect/drivers/ata/libata-core.c	2007-03-31 14:11:33.000000000 +0800
@@ -1784,6 +1784,9 @@ int ata_dev_configure(struct ata_device 
 		dev->max_sectors = ATA_MAX_SECTORS;
 	}
 
+	if (ata_device_blacklisted(dev) & ATA_HORKAGE_MAX_SEC_240)
+		dev->max_sectors = min(ATA_MAX_SECTORS_240, dev->max_sectors);
+
 	if (ap->ops->dev_config)
 		ap->ops->dev_config(ap, dev);
 
@@ -3352,6 +3355,9 @@ static const struct ata_blacklist_entry 
 	{ "_NEC DV5800A", 	NULL,		ATA_HORKAGE_NODMA },
 	{ "SAMSUNG CD-ROM SN-124","N001",	ATA_HORKAGE_NODMA },
 
+	/* Weird ATAPI devices */
+	{ "TORiSAN DVD-ROM DRD-N216", NULL,	ATA_HORKAGE_MAX_SEC_240 },
+
 	/* Devices we expect to fail diagnostics */
 
 	/* Devices where NCQ should be avoided */
diff -Nrup 02_aopen_rs/include/linux/ata.h 03_max_sect/include/linux/ata.h
--- 02_aopen_rs/include/linux/ata.h	2007-03-23 16:56:24.000000000 +0800
+++ 03_max_sect/include/linux/ata.h	2007-03-31 10:06:53.000000000 +0800
@@ -40,6 +40,7 @@ enum {
 	ATA_MAX_DEVICES		= 2,	/* per bus/port */
 	ATA_MAX_PRD		= 256,	/* we could make these 256/256 */
 	ATA_SECT_SIZE		= 512,
+	ATA_MAX_SECTORS_240	= 240,
 	ATA_MAX_SECTORS		= 256,
 	ATA_MAX_SECTORS_LBA48	= 65535,/* TODO: 65536? */
 
diff -Nrup 02_aopen_rs/include/linux/libata.h 03_max_sect/include/linux/libata.h
--- 02_aopen_rs/include/linux/libata.h	2007-03-26 12:33:28.000000000 +0800
+++ 03_max_sect/include/linux/libata.h	2007-03-31 14:07:49.000000000 +0800
@@ -311,6 +311,7 @@ enum {
 	ATA_HORKAGE_DIAGNOSTIC	= (1 << 0),	/* Failed boot diag */
 	ATA_HORKAGE_NODMA	= (1 << 1),	/* DMA problems */
 	ATA_HORKAGE_NONCQ	= (1 << 2),	/* Don't use NCQ */
+	ATA_HORKAGE_MAX_SEC_240	= (1 << 3),	/* Limit max sects below 256 */
 };
 
 enum hsm_task_states {


