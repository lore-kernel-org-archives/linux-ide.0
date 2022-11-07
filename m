Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D257EC43219
	for <linux-ide@archiver.kernel.org>; Mon,  7 Nov 2022 00:50:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbiKGAum (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 6 Nov 2022 19:50:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbiKGAui (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 6 Nov 2022 19:50:38 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB01AC742
        for <linux-ide@vger.kernel.org>; Sun,  6 Nov 2022 16:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667782232; x=1699318232;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iCGQuYuIA21oG69sabowShd8BAXIR6ZFcrUBS9czmYc=;
  b=cZVauWnCJqCRVGbKv8KzCyFpLH+FdbpkFEPsQFyR+fthpnwjv2AroFUy
   6SLBOt6jk+MUxCvJPJ1bXZSgYqEEDtqWMOtt0Uf+8q96tNsY8zKDwPj8W
   tUJwH1uXuNUu6YHVVVdnEm+CH2OEU7paHzKqMAVLpzorChZobibuXZJtB
   CuKY/sWFVuqtXm8+93Eozm46FUzf1hCNyeQSm9sT+viV724Ci4RH/Bprw
   2XUbv4tff1a9NtgGAqEcsRvZlMqZfuigXrvDCQdrRdptA8ZhQ4FTJnIke
   44OQnh5lqiDL6g/+kSvGzSHgi47zrfd3J0KeeQCzQoWUJ16xPIJnGCaiW
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,143,1665417600"; 
   d="scan'208";a="215958486"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Nov 2022 08:50:31 +0800
IronPort-SDR: e4d1TqeKXkS+Ftc7XaUfzAn2RNk9jlwmnqEx2b1TKrLv4GIHkUSMC3hb8gx9OcTm4UdJm8lXt4
 OkGNORnMyunqpk5jG/QWT/D32Ht+TYyKabbrAHRlJE3NefhROIP/1q5cIH5Q71j7ZRQg3ABom0
 GHWvUcQiqvrYVXGjotMWMPWY9F5hoIzGj6AnAnNbnDihWYhIePEGDW1+1O7MnlSxcYAYuz3m+Y
 D5xYzQ7oaTwfMOBoLAJDZIj57icbpKBt/Cpm58E5PUtF5GpXxKH6V2csWLau5r1KuZyWmNdWkC
 LZs=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Nov 2022 16:09:39 -0800
IronPort-SDR: Ey8jO8tJJRZmi1RpshpwK7apfT4rqWvK5QHYSZq6ShMEqb0eqXuGCCFtZJEdXj7WfC3MW2krhM
 nmJM0Z0oAPl+bNFnWGNgoObW7O0Z1YqreNDK3d44iarCYVSzIhpmdXtw4psVLYEEN7hgTtJiZS
 QADtcpwSntG4ggNA6+x/MGqowqu5PFcrEqVOY2b0hjUu6SndJ+kIas//NNX/j5GSHe+eNzBgH5
 BUdxF3O4JkSWQyHxPidjx/olvM+u28JbqsH7Z3cLNTtLWlp5zz3o/TT0Jnzua7gRT75VWk1F1R
 bGU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Nov 2022 16:50:32 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N5CMC1638z1Rwt8
        for <linux-ide@vger.kernel.org>; Sun,  6 Nov 2022 16:50:31 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1667782230; x=1670374231; bh=iCGQuYuIA21oG69sab
        owShd8BAXIR6ZFcrUBS9czmYc=; b=PYugiMKYF/TkkfKhf0uhh9WIpdqwAL0yFU
        XR8n252+5ISlpsyHOtknlKodo0FEfy03HM9zVhsBtN8lffZiIgIdHNUOrSzmNEgm
        lMTEPyMle+617doabt1oku+J33pctPSwnRs/3XTj2zsbyahB/aLmhZFv6fbmNcYv
        yfQvARiQcoSavA7rbN1S/XKA5ffWIdKXoaf/hfz9hLWco7MbxX0IcsQzuZyvIsG5
        /vvk/S1Y0WPzHeZwjqcFf92P22f7BMRYqxBgwMUswmuhFEo6qDX6NLOLMRfE9F0w
        4lthls3od17Rt87Hz/9ebjLoxwhmkrvO6jc9aNekpG0cIVKX9h7Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 03CxZHSewbci for <linux-ide@vger.kernel.org>;
        Sun,  6 Nov 2022 16:50:30 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N5CM91b6qz1RvTp;
        Sun,  6 Nov 2022 16:50:29 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v5 5/7] ata: libata: Fix FUA handling in ata_build_rw_tf()
Date:   Mon,  7 Nov 2022 09:50:19 +0900
Message-Id: <20221107005021.1327692-6-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221107005021.1327692-1-damien.lemoal@opensource.wdc.com>
References: <20221107005021.1327692-1-damien.lemoal@opensource.wdc.com>
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
Reviewed-by: Hannes Reinecke <hare@suse.de>
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

