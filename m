Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F22C433FE
	for <linux-ide@archiver.kernel.org>; Fri,  5 Nov 2021 07:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EECA61139
	for <linux-ide@archiver.kernel.org>; Fri,  5 Nov 2021 07:31:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbhKEHdu (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 5 Nov 2021 03:33:50 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:37532 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbhKEHdu (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 5 Nov 2021 03:33:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1636097470; x=1667633470;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=h9n3EHbfXKqnr9J456kMjBttTETFr1YZQT/w+e22F1E=;
  b=NdZoDqVX9ozcefzC26HnhpYfrO7F6JgurtFMbohHVcplSIVB+vMyaNqt
   BWPfYn4m8jpzGgNCy7pSjfpGujMTHxGZsg9A1LKEPK9vJgk1DPUl8pH0H
   0k3uzu4+RRIYvac/YYhadCmS7cltWjUVbqnBIxTVbuE8Aeqtejau6/Nh5
   YxUXoIMax0WnMpNGCoYB5/44mSGjJTF5Zosb2Tbb2fNbfRqzvx2oIFORw
   e0uaUEBmk+qj4Pf0iAexkxSQo5YcVrpYeATU9wHTY629h/oD2/UubcQgd
   j3/U3i1Ck768f1XqeD83y+IzsIvsx3f3KMkcQRKIMPMCC8koJEBtMOcvY
   Q==;
X-IronPort-AV: E=Sophos;i="5.87,210,1631548800"; 
   d="scan'208";a="189578095"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 05 Nov 2021 15:31:09 +0800
IronPort-SDR: dJP59NddwwjY1lb9OTy0lM4r2B84tRpMA9os748ffkMAXS/fTGY4+T2eD0E2UvJu8UgQhTdX8o
 JId7waFe2cWMtPkGen2E19jUDbtiCHDEbCSZw1ouHiSe/vmg5msDBWj8FFg1622GMbtP8hoIgl
 SfRlYy9+WTPB7iOQmDpicn0aImdUHjZZmfSagAbCIVZeu9OYDqDsB8/zLfS8gDwN95uE3hqwGz
 FhoaOveGfBjnUhhqHUO5evkFL2LdhW8Y6r+eMNPG36UUBBAfoNK24hZwAVk6PLBZAiZFEIMHNr
 G77ii8fulWLziRemEZ4EWnZl
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2021 00:06:28 -0700
IronPort-SDR: 4eR+EH3tNXVovZJO/IJYtpF/NHjsmlGwN4KsMl6H1PTQImzhzfxaomVYkzY+3TPy2OrfV/Kbjq
 /4ON+BRgVw1vqITMhWwYwigcVEjhgRURYljrOL751uICfO++T7NDGNy52SFlKpLtYDjLz4yMDt
 IS06Ahoh6WsEEfXa2bHVfg7FoL5KLP36VrIspExgXNZ/DJPx1NpMOLNC6yLl10c+5mbQ+LMfpA
 Q4z+whLwNNtnAfH3SjDTnVYYp6Pm7eL0/3HUOvDs+Dxx/q3i1s/hvhP7Mh0lP9YVqM9GYs3Auj
 Od0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2021 00:31:11 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Hlsct5Bj9z1RtVn
        for <linux-ide@vger.kernel.org>; Fri,  5 Nov 2021 00:31:10 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1636097470;
         x=1638689471; bh=h9n3EHbfXKqnr9J456kMjBttTETFr1YZQT/w+e22F1E=; b=
        OLs6oro/Oy4k8WozjNIeJ0Cyozuz4Pn3Bkmps4Nt6SjDs4AbBsY1bbcg29rLyiBZ
        jFli4S6oH1EoszK2m7DsjLYVx67g4sK3fwFw/cb2k452azgSQ9i6VMlm+oPPSsEd
        4Bbg/TYuVN7nodTTtqJWbos7JHFKwlBLGLfrsB17C+9zfL/4oHUoovIR3eJV9s10
        GSResVa1ucME+PzxAURQVC+6kyypF/5e0+4Z957YJPa1WqD2A5Oc3u4/brSFk+aJ
        JkLHIwibPvMMrT4XoP5xPGPIho4FU3/hUapAvs44vOabT/OmKxtUKLMbziySLQz4
        Uzp6s9ao0ou2NUCVy7fgiA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id INCjnxNI6Ikf for <linux-ide@vger.kernel.org>;
        Fri,  5 Nov 2021 00:31:10 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Hlscs4cr6z1RtVl;
        Fri,  5 Nov 2021 00:31:09 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH] libata: fix read log timeout value
Date:   Fri,  5 Nov 2021 16:31:06 +0900
Message-Id: <20211105073106.422623-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Some ATA drives are very slow to respond to READ_LOG_EXT and
READ_LOG_DMA_EXT commands issued from ata_dev_configure() when the
device is revalidated right after resuming a system or inserting the
ATA adapter driver (e.g. ahci). The default 5s timeout
(ATA_EH_CMD_DFL_TIMEOUT) used for these commands is too short, causing
errors during the device configuration. Ex:

...
ata9: SATA max UDMA/133 abar m524288@0x9d200000 port 0x9d200400 irq 209
ata9: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
ata9.00: ATA-9: XXX  XXXXXXXXXXXXXXX, XXXXXXXX, max UDMA/133
ata9.00: qc timeout (cmd 0x2f)
ata9.00: Read log page 0x00 failed, Emask 0x4
ata9.00: Read log page 0x00 failed, Emask 0x40
ata9.00: NCQ Send/Recv Log not supported
ata9.00: Read log page 0x08 failed, Emask 0x40
ata9.00: 27344764928 sectors, multi 16: LBA48 NCQ (depth 32), AA
ata9.00: Read log page 0x00 failed, Emask 0x40
ata9.00: ATA Identify Device Log not supported
ata9.00: failed to set xfermode (err_mask=3D0x40)
ata9: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
ata9.00: configured for UDMA/133
...

The timeoutout error causes a soft reset of the drive link, followed in
most cases by a successful revalidation as that give enough time to the
drive to become fully ready to quickly process the read log commands.
However, in some cases, this also fails resulting in the device being
dropped.

Fix this by using adding the ata_eh_revalidate_timeouts entries for the
READ_LOG_EXT and READ_LOG_DMA_EXT commands. This defines a timeout
increased to 15s, retriable one time.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/ata/libata-eh.c | 8 ++++++++
 include/linux/libata.h  | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index bf9c4b6c5c3d..1d4a6f1e88cd 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -93,6 +93,12 @@ static const unsigned long ata_eh_identify_timeouts[] =
=3D {
 	ULONG_MAX,
 };
=20
+static const unsigned long ata_eh_revalidate_timeouts[] =3D {
+	15000,	/* Some drives are slow to read log pages when waking-up */
+	15000,  /* combined time till here is enough even for media access */
+	ULONG_MAX,
+};
+
 static const unsigned long ata_eh_flush_timeouts[] =3D {
 	15000,	/* be generous with flush */
 	15000,  /* ditto */
@@ -129,6 +135,8 @@ static const struct ata_eh_cmd_timeout_ent
 ata_eh_cmd_timeout_table[ATA_EH_CMD_TIMEOUT_TABLE_SIZE] =3D {
 	{ .commands =3D CMDS(ATA_CMD_ID_ATA, ATA_CMD_ID_ATAPI),
 	  .timeouts =3D ata_eh_identify_timeouts, },
+	{ .commands =3D CMDS(ATA_CMD_READ_LOG_EXT, ATA_CMD_READ_LOG_DMA_EXT),
+	  .timeouts =3D ata_eh_revalidate_timeouts, },
 	{ .commands =3D CMDS(ATA_CMD_READ_NATIVE_MAX, ATA_CMD_READ_NATIVE_MAX_E=
XT),
 	  .timeouts =3D ata_eh_other_timeouts, },
 	{ .commands =3D CMDS(ATA_CMD_SET_MAX, ATA_CMD_SET_MAX_EXT),
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 236ec689056a..0ab8d9594541 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -394,7 +394,7 @@ enum {
 	/* This should match the actual table size of
 	 * ata_eh_cmd_timeout_table in libata-eh.c.
 	 */
-	ATA_EH_CMD_TIMEOUT_TABLE_SIZE =3D 6,
+	ATA_EH_CMD_TIMEOUT_TABLE_SIZE =3D 7,
=20
 	/* Horkage types. May be set by libata or controller on drives
 	   (some horkage may be drive/controller pair dependent */
--=20
2.31.1

