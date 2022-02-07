Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC0DC43217
	for <linux-ide@archiver.kernel.org>; Mon,  7 Feb 2022 06:01:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbiBGF7O (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 7 Feb 2022 00:59:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351417AbiBGETl (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 6 Feb 2022 23:19:41 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB63C061A73
        for <linux-ide@vger.kernel.org>; Sun,  6 Feb 2022 20:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644207577; x=1675743577;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ckH44nJb9fQpuS59S/2lcWi1oi/ZU1Nr3wwDyx+cHnk=;
  b=aK4UYqG3O8xmq7Jq9YquLcmJH+K7rzUeKaJEJ85yYg4bAmQbe/cq80oe
   l4MCRccHKMWlh4yv1DLmyJBSygtTXwpXJcBQfnJlA+rYhPi/wpRrmmZx3
   TW9jaFShBWV5zNrM1GxiaPTSh9Ansom0z3A61ugENc3ovy2qNgjwx44Tp
   Bob88AwWhqYuxRVXQJxqT5Vhb9yvH3EDjM/fpwEo+HVHrXJYoU/eX8Jbd
   sCqARS0lr532N5KBZ5sefx1z10qc3OaJWpKst8Uho8Frvng6N6S2ESb4B
   GTcsEmLykHq655gcPh3VsZ2yggtFmPrGGWs1Kv26lnMye0sy3JKRC6vgU
   A==;
X-IronPort-AV: E=Sophos;i="5.88,348,1635177600"; 
   d="scan'208";a="192295211"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Feb 2022 12:19:37 +0800
IronPort-SDR: JegnDhdqJrSw4jiBIIJsZpRgq9gitifdhZ7zC9942V0EFI1GvMCnd04EY52p4pnyal9gN2NxYn
 +x0RIsre3y3OOnTN6YuDUTbVnwo5WNiIQkT9qh4K+WPV4j9cNZumIWeN9ggm2pP1jdyrg4ithi
 HtZ8eip6AUTQkMLj1YEp0SXGCwRDT2aDR5lhnh9dk5PGlHY4m/aVx8C+UCiiIGpAegsVnRWPVD
 Wt3xxjl0s19g+gMq3hBJNOOmOb6eA01AFqCUNDjYo0mvld2q9hyH7DZaR1qxmFkNCIdYiFzJ0a
 n6T/tHXkBASWDL2kw/hBla7c
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2022 19:51:29 -0800
IronPort-SDR: m/CuaSRIJuuKyVLtSU1MPJ9UBW8J3A+OHCHvskNKYOwYsDz1cuC+M7VqeNUvz86WHi2jLfpaM1
 uaYkgAk1OblB7Eb2opLdgrlDM/2VAUFOD8s3cZOW428KlykplFbon/cgedgghFySuL6Tpa2lpr
 zKgtyNeZAZf6JSA83tw5fOuCYSZhMoBVCH38v9nPeWb2cOt5K7OnY14796Vmd/vLPzaH9dd8xW
 /HwKBtXNb39sY2c3HdlubRah284el5arbV7tYG0QLn81dsrdgg+2bVIqCnR3743saD3cjv+I++
 mWo=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2022 20:19:39 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JsXwV3qqPz1SHwl
        for <linux-ide@vger.kernel.org>; Sun,  6 Feb 2022 20:19:38 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1644207577;
         x=1646799578; bh=ckH44nJb9fQpuS59S/2lcWi1oi/ZU1Nr3wwDyx+cHnk=; b=
        BZxdAmEi3zT1B81yoO/SB/zTRUeqQiVDMV+Yc+DzrY0GsA0z2XTPvdauYWTkKxOy
        /Kc0zuCUiJTSoFFlh7xuUBzlSWtDTIMPqVnKjDO84ug/bQk3Klho/Z0Vrpw/W9v/
        5mRcBPW2FzfGY9SVb6LQheYlVSQmHAnc6RM21TVLuiBXsCXEA3a2JBksRd66Vh93
        cPbZiph1OOhdVzjG2UmyQ+GRXxP3tdu+GcbUW8d1GXZ+5Ti6gUYFfMdr/wqAHD5A
        3LZ0QeHuwSbaLO2RfbvsWrUXMYLCg9NkQPs8SltPz9z+qcHpEbtceHFr/c4VQ4+P
        G+teSE4cD+7U5QWC7VLEHw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ZPnffDxo-lsc for <linux-ide@vger.kernel.org>;
        Sun,  6 Feb 2022 20:19:37 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JsXwT0NW1z1Rwrw;
        Sun,  6 Feb 2022 20:19:36 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Cc:     Hannes Reinecke <hare@suse.de>
Subject: [PATCH v3] ata: libata-core: Fix ata_dev_config_cpr()
Date:   Mon,  7 Feb 2022 13:19:35 +0900
Message-Id: <20220207041935.967408-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The concurrent positioning ranges log page 47h is a general purpose log
page and not a subpage of the indentify device log. Using
ata_identify_page_supported() to test for concurrent positioning ranges
support is thus wrong. ata_log_supported() must be used.
This invalid test created boot problems for several users in the field.

While at it, strengthen the detection for concurrent positioning ranges
support by limiting the detection to drives implementing a recent ATA
standard, that is, ACS-4 (major version 11) or later ACS versions. This
additional condition effectively turns ata_dev_config_cpr() into a nop,
avoiding problems in the field with older drives.

Fixes: fe22e1c2f705 ("libata: support concurrent positioning ranges log")
BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=3D215519
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
Changes from v2:
* Move the definition of ATA_LOG_CONCURRENT_POSITIONING_RANGES together
  with other log pages numbers in the "READ_LOG_EXT pages" section in
  include/linux/ata.h.

Changes from v1:
* Removed error message in case of ata_read_log_page() error: that
  function already prints a message in case of failure.

 drivers/ata/libata-core.c | 14 ++++++--------
 include/linux/ata.h       |  2 +-
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index e1b1dd215267..ba9273f80069 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2448,23 +2448,21 @@ static void ata_dev_config_cpr(struct ata_device =
*dev)
 	struct ata_cpr_log *cpr_log =3D NULL;
 	u8 *desc, *buf =3D NULL;
=20
-	if (!ata_identify_page_supported(dev,
-				 ATA_LOG_CONCURRENT_POSITIONING_RANGES))
+	if (ata_id_major_version(dev->id) < 11 ||
+	    !ata_log_supported(dev, ATA_LOG_CONCURRENT_POSITIONING_RANGES))
 		goto out;
=20
 	/*
-	 * Read IDENTIFY DEVICE data log, page 0x47
-	 * (concurrent positioning ranges). We can have at most 255 32B range
-	 * descriptors plus a 64B header.
+	 * Read the concurrent positioning ranges log (0x47). We can have at
+	 * most 255 32B range descriptors plus a 64B header.
 	 */
 	buf_len =3D (64 + 255 * 32 + 511) & ~511;
 	buf =3D kzalloc(buf_len, GFP_KERNEL);
 	if (!buf)
 		goto out;
=20
-	err_mask =3D ata_read_log_page(dev, ATA_LOG_IDENTIFY_DEVICE,
-				     ATA_LOG_CONCURRENT_POSITIONING_RANGES,
-				     buf, buf_len >> 9);
+	err_mask =3D ata_read_log_page(dev, ATA_LOG_CONCURRENT_POSITIONING_RANG=
ES,
+				     0, buf, buf_len >> 9);
 	if (err_mask)
 		goto out;
=20
diff --git a/include/linux/ata.h b/include/linux/ata.h
index 199e47e97d64..21292b5bbb55 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -324,12 +324,12 @@ enum {
 	ATA_LOG_NCQ_NON_DATA	=3D 0x12,
 	ATA_LOG_NCQ_SEND_RECV	=3D 0x13,
 	ATA_LOG_IDENTIFY_DEVICE	=3D 0x30,
+	ATA_LOG_CONCURRENT_POSITIONING_RANGES =3D 0x47,
=20
 	/* Identify device log pages: */
 	ATA_LOG_SECURITY	  =3D 0x06,
 	ATA_LOG_SATA_SETTINGS	  =3D 0x08,
 	ATA_LOG_ZONED_INFORMATION =3D 0x09,
-	ATA_LOG_CONCURRENT_POSITIONING_RANGES =3D 0x47,
=20
 	/* Identify device SATA settings log:*/
 	ATA_LOG_DEVSLP_OFFSET	  =3D 0x30,
--=20
2.34.1

