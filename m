Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC953C433F5
	for <linux-ide@archiver.kernel.org>; Wed, 10 Nov 2021 08:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91017610F8
	for <linux-ide@archiver.kernel.org>; Wed, 10 Nov 2021 08:14:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbhKJIRb (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 10 Nov 2021 03:17:31 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:52761 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbhKJIRb (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 10 Nov 2021 03:17:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1636532083; x=1668068083;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7qNH0HboKZjpgkAkpCqxkh2OB5h8ryeolvPC7IenxWA=;
  b=Os9tcdH9X3wsfEMn5Wb+S9sBTCYqLa+MDahOsfoHASoBWIfOB2Tf2KOT
   TFrNnla9eZub7OnbkbaZa9OS+HYfIkeJJi4zuU9sqQPNZ5XlmcoubdMON
   /wwarC+or2SPjeHP5VlxpvvIvUzVkS+9sDrTlFk4WfhTFL5oUUgJuMtHT
   dT8UjIT6CaN1I/0FEqRIFSX7ITUed2rVdcsNAkKMKi1NLk6LjjVUKCr3g
   fS7BpMHSapNA98d8Y8SYgy7WxjkU24qRvyij4o0kqk/ddmMPFfJZ3HeIU
   hPIMkdpp4wzHApBVc/EiW+xyzyDztG2po+z5dTAPI6kldX3UOVS95MB9y
   g==;
X-IronPort-AV: E=Sophos;i="5.87,223,1631548800"; 
   d="scan'208";a="297012340"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Nov 2021 16:14:43 +0800
IronPort-SDR: 0/RjtqjRsM+BfBjxjaK5NcVt81m/rGuPTp5QYJUhHpRlIOrHdBfqOwbbS07Tw3p0417xYj7wde
 4KsnBNLKd5nUilPYdobuTyzzZczQFGr9Mf6WZTSBYRD1nZ68yCKFUlvqSbS2CzfDt438CmT4GH
 vvVjBPMRhlSHHw9E6S8xEjMmZDw8MUyngYg+i0mKhvmiaBHE2Oppa43wfoJArv6pcdnZo86ntw
 GBXfE/Zrk9pD09b/OEQIx64sFpkaJ0lj0tiaYS4PDHzfP900FKVxYWdr2jf8Eg+UPLDhhGfV4g
 3GCmmeL3/ibzk59d/H5YEoao
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2021 23:48:22 -0800
IronPort-SDR: r0C/UQUUAIue6lGucVqZV6PkgsydiCjHmf665EZBcYa1wyFQqcLtV1DjwvtfC7l/KmNnIEQzJN
 9lal6upIq47rMyqbafE9AvQiVHq37nsj4grTMFkDx8tjaHrGf1dmDvDn8I9a9tonYawHLVR6cy
 +rvkThIAEN2KwEQ7JPGs1j9P4PJ9GWBf03qALTHlumh0RS/h5PRhNvd/0K074UskMiMLUh02mv
 B/jKqRC/Suff1LbvwIMnzwOpAfKqcpjHEzeV7aznkAGclvUVWmevN8LYD88XlImZiTGeZfmpV9
 EKo=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2021 00:14:44 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4HpyLq4DDSz1RtVm
        for <linux-ide@vger.kernel.org>; Wed, 10 Nov 2021 00:14:43 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1636532083;
         x=1639124084; bh=7qNH0HboKZjpgkAkpCqxkh2OB5h8ryeolvPC7IenxWA=; b=
        QyFDgFXzTJaCxefBwkpS6DHU2a0xJccWcybmp65ZOaRNg7kKjb2a1koprs3ruVCb
        7i1xf8x1vQVi04/tol23yQkTugdSzIX2kUsAO/B3psxhmasLgnNMdfRESot5h9p1
        znm4Vz7U3AAid2ylPP036zf16wDKpRQjUAJgWGiE5f5001ffYADH+TgFw0u0v3ed
        gNTOeNOD+rNNmRL4LzJAy0H1uen1ZUTuvdlmuECeuYrXyeSiUUV3m552WwCgvI2v
        HU1mqZZgZ3efGCfzM1+lhdF5Pd5Esk/MVs8BYMoJ1BPdwnPvamVILWbgfDNMD4w2
        LBXSpWi7vd27209Ts5xA+g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id X9Cb1nen_Lzy for <linux-ide@vger.kernel.org>;
        Wed, 10 Nov 2021 00:14:43 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4HpyLp6Yymz1RtVl
        for <linux-ide@vger.kernel.org>; Wed, 10 Nov 2021 00:14:42 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Subject: [PATCH V2] libata: add horkage for missing Identify Device log
Date:   Wed, 10 Nov 2021 17:14:41 +0900
Message-Id: <20211110081441.587089-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

ACS-3 introduced the ATA Identify Device Data log as mandatory. A
warning message currently signals to the user if a device does not
report supporting this log page in the log directory page, regardless
of the ATA version of the device. Furthermore, this warning will appear
for all attempts at accessing this missing log page during device
revalidation.

Since it is useless to constantly access the log directory and warn
about this lack of support once we have discovered that the device
does not support this log page, introduce the horkage flag
ATA_HORKAGE_NO_ID_DEV_LOG to mark a device as lacking support for
the Identify Device Data log page. Set this flag when
ata_log_supported() returns false in ata_identify_page_supported().
The warning is printed only if the device ATA level is 10 or above
(ACS-3 or above), and only once on device scan. With this flag set, the
log directory page is not accessed again to test for Identify Device
Data log page support.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
Changes from v1:
* Print the warning only for drives with an ATA version equal to or
  higher than 10 (ACS-3 and above).

 drivers/ata/libata-core.c | 13 ++++++++++++-
 include/linux/libata.h    |  1 +
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 3018ca84a3d8..8a0ccb190d76 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2052,8 +2052,19 @@ static bool ata_identify_page_supported(struct ata=
_device *dev, u8 page)
 	struct ata_port *ap =3D dev->link->ap;
 	unsigned int err, i;
=20
+	if (dev->horkage & ATA_HORKAGE_NO_ID_DEV_LOG)
+		return false;
+
 	if (!ata_log_supported(dev, ATA_LOG_IDENTIFY_DEVICE)) {
-		ata_dev_warn(dev, "ATA Identify Device Log not supported\n");
+		/*
+		 * IDENTIFY DEVICE data log is defined as mandatory starting
+		 * with ACS-3 (ATA version 10). Warn about the missing log
+		 * for drives which implement this ATA level or above.
+		 */
+		if (ata_id_major_version(dev->id) >=3D 10)
+			ata_dev_warn(dev,
+				"ATA Identify Device Log not supported\n");
+		dev->horkage |=3D ATA_HORKAGE_NO_ID_DEV_LOG;
 		return false;
 	}
=20
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 5331557316e8..2a8404b26083 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -427,6 +427,7 @@ enum {
 	ATA_HORKAGE_MAX_SEC_1024 =3D (1 << 25),	/* Limit max sects to 1024 */
 	ATA_HORKAGE_MAX_TRIM_128M =3D (1 << 26),	/* Limit max trim size to 128M=
 */
 	ATA_HORKAGE_NO_NCQ_ON_ATI =3D (1 << 27),	/* Disable NCQ on ATI chipset =
*/
+	ATA_HORKAGE_NO_ID_DEV_LOG =3D (1 << 28),	/* Identify device log missing=
 */
=20
 	 /* DMA mask for user DMA control: User visible values; DO NOT
 	    renumber */
--=20
2.31.1

