Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43779C433FE
	for <linux-ide@archiver.kernel.org>; Mon,  7 Feb 2022 05:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbiBGF6O (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 7 Feb 2022 00:58:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237955AbiBGEJu (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 6 Feb 2022 23:09:50 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF4E4C061A73
        for <linux-ide@vger.kernel.org>; Sun,  6 Feb 2022 20:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644206989; x=1675742989;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Hh1z18OyVta4Mp612gkt5jiCsT3Ayzj32QuTGjSwW2M=;
  b=kO8pkrflt5OPWDwDw0lXS9x43QLOSGGhrJpNkETq+x2hzfhOFHAcEFpf
   WBUIyJ+fhSSO9ypH8LMtcLPfPIqvqh/i2tVH0q1eK9OsKR+e8whKOlBRo
   9ncbX7E2lcGLIv1uBg+j+vnOFU8PdyR34lbMyYxc6JqSSdylyjZ/Yh6wb
   mdOV9O9gedp0OjMQhNQnUb6eLIXfxCQuHk1psfdtSkYHx2rDNNn3svfcf
   sF/u6zATc3na0/GQp7YEGRK29q/j1z0tUhnOItIGM2dZISIywVGp2Bh7x
   tVBW8pU3rCkLQKfAgcRtYYmS6kYvOKH2CavOv/7QW52VBR5ZmGnhqy8Ds
   w==;
X-IronPort-AV: E=Sophos;i="5.88,348,1635177600"; 
   d="scan'208";a="197110092"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Feb 2022 12:09:48 +0800
IronPort-SDR: xLBs+ZYq7saFU/fJu9TtPwIwPMt4848AEXB/JteO/SRcQrGN297S0Mlpsc8goMQ/KerBNvS4oN
 OBABm2mJ9uSoHteu8qxxsQHjvS0ZkudtMFl5pgxww/1Laff2rSQm4r2XphL5czSfy4UtlfXPQz
 JC8h+wsfuJc5j9bvI0PtpiNs35RP/UStN36SJ1McjivBZarA6phdhcbaqkX8dxXuHAqb8vaK3Y
 Mt/1Kz2j3GVEqO4HdPpQJv5kTcIYDicEJ1X1l7gh8A8E8PxCkfhY5aREmzh7TkHSDRqWjNGBM4
 dEErtFeepaMQ9E4S+2VxULs5
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2022 19:42:50 -0800
IronPort-SDR: 38lTJlyogcM1iv7KwsFUtJ2q69Ickiva8qt8XhdrYLA9eWvT0MhZga2549x5PwQHb10wgTyTk7
 ZDzyv5G/nvP73vKUCM+4rYsZIP+heIBonQFfEvML0pgyKRdaHLjIhMKAGjnkbtZbBiTMtCwSmR
 ELpUEe7qKC08hg61FA9WzVeIrtiPggjFLtLjFy97/VrESJMC4Rn8XNr5wk+Ilxj4ywWx6XijIl
 INMhdLSzjEWDFo6tHWO5cOpJVwD2K9epnc+TnUY4bu4ko9ZH1QYo/5kpGu4rBmPlurWSTm/S/7
 7Ms=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2022 20:09:48 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JsXj842cDz1SVnx
        for <linux-ide@vger.kernel.org>; Sun,  6 Feb 2022 20:09:48 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1644206988;
         x=1646798989; bh=Hh1z18OyVta4Mp612gkt5jiCsT3Ayzj32QuTGjSwW2M=; b=
        pNJoK+1+gRZ+Zf5DUrBUQ9LECLzFOZCUoCOwvC5UtGnPaO9nmGT/OPl/r9cvu1HC
        VgqlsxCMwkv2zFHV+VZTrqxrnNw3vkk4B2oaDLfY3yXLz+3pBOz11JPDfrT4Cfvo
        3d+HlN0s/GiRRLs3Yb6OBLHsT+3iPV9keXbRHe9o5nbIoeMSR126qPu7ue60olLu
        D773VZgRyq/vpxwnHZS9Q5/ZD4JNteg8ryin1c3sqmq+5MMk8P9iQUoHBeOUC+Jb
        8fQqW5hH2/HsCjlpgsUXMYXl4Wcx4N9UrdKIpjMObHsSXIm2eTqyR22i2aqfIr2e
        z2MKwoMMZJFJK0UBNCDTng==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8EJwTa0kS5ZU for <linux-ide@vger.kernel.org>;
        Sun,  6 Feb 2022 20:09:48 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JsXj73xKNz1Rwrw;
        Sun,  6 Feb 2022 20:09:47 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Cc:     Hannes Reinecke <hare@suse.de>
Subject: [PATCH v2] ata: libata-core: Fix ata_dev_config_cpr()
Date:   Mon,  7 Feb 2022 13:09:45 +0900
Message-Id: <20220207040945.950886-1-damien.lemoal@opensource.wdc.com>
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
Changes from v1:
* Removed error message in case of ata_read_log_page() error: that
  function already prints a message in case of failure.

 drivers/ata/libata-core.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

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
--=20
2.34.1

