Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 662B5FA373D
	for <linux-ide@archiver.kernel.org>; Mon, 31 Oct 2022 02:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbiJaC1H (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 30 Oct 2022 22:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiJaC1G (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 30 Oct 2022 22:27:06 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2CCBC14
        for <linux-ide@vger.kernel.org>; Sun, 30 Oct 2022 19:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667183222; x=1698719222;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UJ2YDLRMJY8D+U3UMEWNGFNsOs4kdiG/fA81vw5BF8c=;
  b=F0Y7ZTHRQAyNRxJJILWfpNw8ium1fzgNobEbD/PVkJkVqeizvS6P/t9B
   MnZQ8/IOAYmLG/FYbvCCRk6sPJvNDCzyNpvG4KA9q8RIW2UmdzRXpu/sY
   H5IYX2chZqLJf41Pf6N5jq7a0BputqMw0E/liCl5+ao4hH1Ct/dZ13od5
   d+HjGQKEU8xP0i85hjD5ehE4kClvSz2QwyUJD9O3m+ccaLY3c5Y+iJFAS
   fF21IXHM9Yb8A83LP0aF6CDflk7qM968JQiEhnR8cSeF8C66/Bf6HzpAl
   LHNYzXn6zlYJBe7ogqTNqWSuf2+/ngU7KsaYSRU/azO5ZxC6T7M/WW1pl
   w==;
X-IronPort-AV: E=Sophos;i="5.95,227,1661788800"; 
   d="scan'208";a="327200437"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 31 Oct 2022 10:27:02 +0800
IronPort-SDR: vCfMwR8hh+B2XwgDwVjUegVuxNVjmaiVMCiGqFQXRix0BCgitQBSMHuVZvS5q4qX9n6V3zNmeh
 nEEwy+T5pKYqy8c56kF/1qePMlILAifM/rfTh3JMcqgqvQbJC0uAFIpAMdy1WKjNnWz5O+ZKrK
 4kVlvznoLrR3Vlkfj5TqV8CC4dPSaP6MqDt+1/bSQhQoLvmptqo1UFGeCjOMHHNIBocemP3SgV
 n6AfGLUzelRyamqaE9N3K0WkO/LbBse5p4IF6eVbDWgatZfYeQKj6IDl040RedgdAMKmzsCAxh
 NQBhLUmxv1FeJK7dBTrh0dfg
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Oct 2022 18:40:35 -0700
IronPort-SDR: 4az0AAVGaRqAKp35b2W5U4LkMEWq7pyn23aJXtBETTm4T6FSqBibd9mG+Haa1xLp3keNpYzRUg
 q8vP2Q+CWskxrlTQlIS1R4bmehCXR32YEnHzmCJP58FpxpYBLHW3MC+sJRt1/Y/mWvXj4245w9
 XsjsPf34lGKutooxqul3Sya48UJmrgxrtE0g1VOgYKB5yQI2K/lO8EIrbqc5/S6pjpd3nVyCh8
 wWScpGp6j0b0mmiPryt65yxXdIv3qF/TIW4aNYZnSK+HHXsRRvp8dKjpPRHUiNXZKOUFCgov8J
 Nso=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Oct 2022 19:27:02 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N0xqn0gwjz1Rwrq
        for <linux-ide@vger.kernel.org>; Sun, 30 Oct 2022 19:27:01 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1667183220; x=1669775221; bh=UJ2YDLRMJY8D+U3UME
        WNGFNsOs4kdiG/fA81vw5BF8c=; b=cmZ63uJkzDV7lgEHkwKPHe+XFV0x6y2rTq
        hs335ahY5DSJK6IWZXx0qfdphA6HfsXuPqoGfIWDJuqKU6PDjCwGHsW2j/j41uXj
        E7aqFH4lry1303R0jp84QxbGcIAq6Wemg4Ld+A4c9OQzq2zYKovbx6yILOvDohEG
        KkhLsmLGfwGYDOeRw9EQProREzzXaVtVeij0/42t98nvM7i43SEHKVoRNaaPEvST
        vwlpe8CHBOaygHtfshIVBjo++qI+6xDCx2PwPV5b9Z8We1WOWKFiAWW9wczm4UC7
        kc2Vui1Qya9F5QhKO31S4PHfvxFyMbk9YzxB5Zpm47zHiajWf4fA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 6DINvFPaaikz for <linux-ide@vger.kernel.org>;
        Sun, 30 Oct 2022 19:27:00 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N0xqk2sT1z1RvTr;
        Sun, 30 Oct 2022 19:26:56 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH v4 5/7] ata: libata: Fix FUA handling in ata_build_rw_tf()
Date:   Mon, 31 Oct 2022 11:26:40 +0900
Message-Id: <20221031022642.352794-6-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221031022642.352794-1-damien.lemoal@opensource.wdc.com>
References: <20221031022642.352794-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

If a user issues a write command with the FUA bit set for a device with
NCQ support disabled (that is, the device queue depth was set to 1), the
LBA 48 command WRITE DMA FUA EXT must be used. However,
ata_build_rw_tf() ignores this and first tests if LBA 28 can be used
based on the write command sector and number of blocks. That is, for
small FUA writes at low LBAs, ata_rwcmd_protocol() will cause the write
to fail.

Fix this by preventing the use of LBA 28 for any FUA write request.

Given that the WRITE MULTI FUA EXT command is marked as obsolete iin the
ATA specification since ACS-3 (published in 2013), remove the
ATA_CMD_WRITE_MULTI_FUA_EXT command from the ata_rw_cmds array.

Finally, since the block layer should never issue a FUA read
request, warn in ata_build_rw_tf() if we see such request.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/ata/libata-core.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 30adae16efff..83bea8591b08 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -552,7 +552,7 @@ static const u8 ata_rw_cmds[] =3D {
 	0,
 	0,
 	0,
-	ATA_CMD_WRITE_MULTI_FUA_EXT,
+	0,
 	/* pio */
 	ATA_CMD_PIO_READ,
 	ATA_CMD_PIO_WRITE,
@@ -693,6 +693,10 @@ int ata_build_rw_tf(struct ata_queued_cmd *qc, u64 b=
lock, u32 n_block,
 	tf->flags |=3D ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
 	tf->flags |=3D tf_flags;
=20
+	/* We should never get a FUA read */
+	WARN_ON_ONCE((tf->flags & ATA_TFLAG_FUA) &&
+		     !(tf->flags & ATA_TFLAG_WRITE));
+
 	if (ata_ncq_enabled(dev)) {
 		/* yay, NCQ */
 		if (!lba_48_ok(block, n_block))
@@ -727,7 +731,8 @@ int ata_build_rw_tf(struct ata_queued_cmd *qc, u64 bl=
ock, u32 n_block,
 	} else if (dev->flags & ATA_DFLAG_LBA) {
 		tf->flags |=3D ATA_TFLAG_LBA;
=20
-		if (lba_28_ok(block, n_block)) {
+		/* We need LBA48 for FUA writes */
+		if (!(tf->flags & ATA_TFLAG_FUA) && lba_28_ok(block, n_block)) {
 			/* use LBA28 */
 			tf->device |=3D (block >> 24) & 0xf;
 		} else if (lba_48_ok(block, n_block)) {
@@ -742,9 +747,10 @@ int ata_build_rw_tf(struct ata_queued_cmd *qc, u64 b=
lock, u32 n_block,
 			tf->hob_lbah =3D (block >> 40) & 0xff;
 			tf->hob_lbam =3D (block >> 32) & 0xff;
 			tf->hob_lbal =3D (block >> 24) & 0xff;
-		} else
+		} else {
 			/* request too large even for LBA48 */
 			return -ERANGE;
+		}
=20
 		if (unlikely(!ata_set_rwcmd_protocol(dev, tf)))
 			return -EINVAL;
--=20
2.38.1

