From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 1/1] libata: minor patch for ATA_DFLAG_PIO
Date: Tue, 20 Jun 2006 20:35:20 +0800
Message-ID: <4497EB88.8030903@tw.ibm.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:64683 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030245AbWFTMf2
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 20 Jun 2006 08:35:28 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e34.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k5KCZSPS012782
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linux-ide@vger.kernel.org>; Tue, 20 Jun 2006 08:35:28 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id k5KCZ6RD223558
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Tue, 20 Jun 2006 06:35:06 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k5KCZRgM032322
	for <linux-ide@vger.kernel.org>; Tue, 20 Jun 2006 06:35:27 -0600
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <htejun@gmail.com>, Doug Maxey <dwm@bebe.enoyolf.org>, Linux IDE <linux-ide@vger.kernel.org>, Unicorn Chang <uchang@tw.ibm.com>

Problem:
 - With 2.6.17, some PIO-only devices are given DMA commands.

Changes:
 - Do not clear the ATA_DFLAG_PIO flag in ata_dev_configure().

Original patch by Tejun.
Signed-off-by: Albert Lee <albertcc@tw.ibm.com>

--
The patch is done by Tejun and already in libata-dev upstream.
Maybe we also need this for 2.6.17.

For your review, thanks.

albert

diff -Nrup linux-2.6.17-0/drivers/scsi/libata-core.c linux-2.6.17-1/drivers/scsi/libata-core.c
--- linux-2.6.17-0/drivers/scsi/libata-core.c	2006-06-18 09:49:35.000000000 +0800
+++ linux-2.6.17-1/drivers/scsi/libata-core.c	2006-06-20 16:56:14.000000000 +0800
@@ -1229,7 +1229,7 @@ static int ata_dev_configure(struct ata_
 		       id[84], id[85], id[86], id[87], id[88]);
 
 	/* initialize to-be-configured parameters */
-	dev->flags = 0;
+	dev->flags &= ~ATA_DFLAG_CFG_MASK;
 	dev->max_sectors = 0;
 	dev->cdb_len = 0;
 	dev->n_sectors = 0;
diff -Nrup linux-2.6.17-0/include/linux/libata.h linux-2.6.17-1/include/linux/libata.h
--- linux-2.6.17-0/include/linux/libata.h	2006-06-18 09:49:35.000000000 +0800
+++ linux-2.6.17-1/include/linux/libata.h	2006-06-20 16:55:41.000000000 +0800
@@ -120,9 +120,12 @@ enum {
 	ATA_SHT_USE_CLUSTERING	= 1,
 
 	/* struct ata_device stuff */
-	ATA_DFLAG_LBA48		= (1 << 0), /* device supports LBA48 */
-	ATA_DFLAG_PIO		= (1 << 1), /* device currently in PIO mode */
-	ATA_DFLAG_LBA		= (1 << 2), /* device supports LBA */
+	ATA_DFLAG_LBA		= (1 << 0), /* device supports LBA */
+	ATA_DFLAG_LBA48		= (1 << 1), /* device supports LBA48 */
+
+	ATA_DFLAG_CFG_MASK	= (1 << 8) - 1,
+
+	ATA_DFLAG_PIO		= (1 << 8), /* device currently in PIO mode */
 
 	ATA_DEV_UNKNOWN		= 0,	/* unknown device */
 	ATA_DEV_ATA		= 1,	/* ATA device */


