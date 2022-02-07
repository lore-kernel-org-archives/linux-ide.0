Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86BF3C433F5
	for <linux-ide@archiver.kernel.org>; Mon,  7 Feb 2022 06:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244094AbiBGF7P (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 7 Feb 2022 00:59:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350082AbiBGDR0 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 6 Feb 2022 22:17:26 -0500
X-Greylist: delayed 61 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 19:17:25 PST
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40019C061A73
        for <linux-ide@vger.kernel.org>; Sun,  6 Feb 2022 19:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644203844; x=1675739844;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aTsgBI4Cz+RJ4Yn3w4NrVXmBgMpWMZItFE5CzDHNkA4=;
  b=Fq+ZfrJK1it7lY322LfRtRkW915NNBBxJc/eZlulzenP0y11eCnK44ZJ
   zJoBMReRso7UQB8Dq9X/X3crY9JupmO09T0wENTa08o69udy3+XzfZHvq
   us8hnms0E+3BkNqxlD8JQgbamfuOnzV8xPpmLe9eEBhmt3pNNLUV9NlZ8
   c8qexCcEF1BNV3V4QfA47HBtIgpFk3jXJ5T1SLWIUlQ1c56u+TnKjYD0K
   cchEM7yESiXBYKlNalzDkfMPWBq88Li1zKhf2fszhuWgTklYAC9+1i3SL
   fdZHoNtsuanEF01eOYqwBjMxvRFktoeiez5e79bqRuQaefGOXUFE5Ekwy
   A==;
X-IronPort-AV: E=Sophos;i="5.88,348,1635177600"; 
   d="scan'208";a="304196381"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Feb 2022 11:16:19 +0800
IronPort-SDR: wG5Spa0hLsayAnITK/RD99rmK3MYJabRe5UzzIgwblXVKY2L9mLsOr5VT2+C9Ioknyi7O/93KT
 5WhikuY8bOlZqpogpdOYR83B/XoLjRM7VNSqxSsauxRIqqK3NVEMoVCfAHEAIBVFUwiGWfiurq
 75SFCpg5I5mag/sditfTPkDIB3535kiwjrxRUuZCI4sRAZCf744MI8erxtEXImQDzvz8J3ArHh
 5EqRNtzc46Ei2EyIp8OzxTKWuQbsq0P+vREOtLhe7RURFbAgWUirdH31V6W3sdznRqj7qRBpQ3
 OW8ot167LYXbY/8i8JAXKJas
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2022 18:48:10 -0800
IronPort-SDR: dA5tgSFgjl7LVrvO2TOCFi1IJf9feP0nbu1xm6c/s85TJrHfmMs7Wn5oYbSZiggGG7TQuREMqx
 /33sq4xvq1fq28gj5N9UyMQDAO0+x5lOemndD2RAJt3k3djEUWyvnfoCvA7V6sJZBViGGWsdmF
 vVvyRqaB79UmgbZLm6NgfHCnDaEard521l4THiAVQrEvDyXNDzFQjsZ3z6UY9bxqudF56D5kQ4
 /DLR0Tn9qg6cMJBju2v6T3gqvpvucYrMnZCy0zXnYwmwoI8Q2bAHVXogFiJy8pdp8hwrerm/XQ
 1mo=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2022 19:16:19 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JsWWR1Wzvz1SHwl
        for <linux-ide@vger.kernel.org>; Sun,  6 Feb 2022 19:16:19 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1644203778;
         x=1646795779; bh=aTsgBI4Cz+RJ4Yn3w4NrVXmBgMpWMZItFE5CzDHNkA4=; b=
        i21gec+Xqsu+MfCIqWH4jPUdE1LMbqLhx+/D3eYQTHA9Xy4J9oKijry7E4OGMBK+
        NCbYYbLHpoalXvqPNYx2ikU8VRIxAWQCtsnp9o9kr80Yv/gpl4ekhyTd0BPeG1u8
        mgOfkBYPflFOErEnyNN/cIg2GrR6B33wZHY9vWt6OX9nQYBQ2zp8tSbhuRvTWv0Y
        EHSpvIbJPiSgrsylig6uEDnc1l7m7tOdU/8fsVapYL/DQfzZbZqI4tkpu16nKlFh
        WQSQs3CTJ0wG1qPIjKaDXGRJ+PXB3h2lYjTSmcQ2VTskVDYzRpr7fh3hfqqj/zH9
        yXA9xHn+wli9DUyFuj3+HQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id R_LIXzd1ZL-Q for <linux-ide@vger.kernel.org>;
        Sun,  6 Feb 2022 19:16:18 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JsWWQ1HY6z1Rwrw;
        Sun,  6 Feb 2022 19:16:17 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Cc:     Hannes Reinecke <hare@suse.de>
Subject: [PATCH] ata: libata-core: Fix ata_dev_config_cpr()
Date:   Mon,  7 Feb 2022 12:16:16 +0900
Message-Id: <20220207031616.944994-1-damien.lemoal@opensource.wdc.com>
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
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/ata/libata-core.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index e1b1dd215267..88125990861e 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2448,25 +2448,26 @@ static void ata_dev_config_cpr(struct ata_device =
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
-	if (err_mask)
+	err_mask =3D ata_read_log_page(dev, ATA_LOG_CONCURRENT_POSITIONING_RANG=
ES,
+				     0, buf, buf_len >> 9);
+	if (err_mask) {
+		ata_dev_err(dev,
+			    "Read Concurrent Positioning Ranges log failed\n");
 		goto out;
+	}
=20
 	nr_cpr =3D buf[0];
 	if (!nr_cpr)
--=20
2.34.1

