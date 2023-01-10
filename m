Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58286C63797
	for <linux-ide@archiver.kernel.org>; Tue, 10 Jan 2023 13:15:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233891AbjAJNPa (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 10 Jan 2023 08:15:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238532AbjAJNPO (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 10 Jan 2023 08:15:14 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE6756898
        for <linux-ide@vger.kernel.org>; Tue, 10 Jan 2023 05:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673356512; x=1704892512;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K+DjrBoMp8r4GmO2ND7jZ/tYn6dWl8LN/Wiw9iXU22w=;
  b=aNeKXF73ncKhaHU+jl46s6Rh3m1Cn55zTna4nGk2eUWdticPLnnQjh5T
   IfrJ0nKOmGaLQbKVGI3CjuyNIf/FSKm1JoyWqqoQqkoMbZi3DuV6jQXXZ
   V+Mvbb2YofLlnwSwtec52VIoDf87sCf8iLTJB0nLbkUReP4MaRPcN5WLp
   kaWsu7ioWuYjYkrMu5ZVtW3hHjeyL7dX2UNJLA77+KWk8KIQIHEoXfh18
   DPG1UoiQJRa6o1CPa1IQDl738ih+h0EFLA3S1LxfMxeGuWzh93lhFxhkH
   eDmUzXJJO/tMrYUxlDFuRLHGJQwnq+1PQJhWidFOhXM1yRLpyCAZNkRyo
   g==;
X-IronPort-AV: E=Sophos;i="5.96,315,1665417600"; 
   d="scan'208";a="324740899"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jan 2023 21:15:12 +0800
IronPort-SDR: K+8SdlM7kzpsLoQdj65yt2/9cMfYA6YZC6NNL8n4uhXbQbSZcrUa4qGQS4lE3L6fViCnExSSA5
 9swbycNgou5ndLj1zHgYMiRqhaCvaVXpdr3wWqR90Kive00uao81arrJ+Rvr/GEIFPa0uz5BSP
 Nk0BtH57TqUWsGRTJbvI3BASqYFe1kzRSc7bEC2EZiYQvi3Zv8eU11jyCamXs0UK6nsgA1qd8s
 g+arCKs89MERTTkAVZanESh9GPFaCN7p+7TY5t4SnRAHrmK76LVDF2sCn82pFh5SnWe+ap0dBH
 oSc=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jan 2023 04:27:17 -0800
IronPort-SDR: alVEQYvCymEYbrYAsoHJ/7UekOJh67zKMqxMKp08osb7cvoSt986/4Ij4nl6LPDrzx21cETOWe
 nj3fDawHLpkBqsld2ZsAaS24iSncGS38q1InxntNIaFiUc76WobpEpKFMVYD0Y/vM/ClahcsPw
 d2PWePASn1JiyA6gzLxwj+OnBBMIDuo0rk1QXXsWWWwtsGeYWA7r+qOaVSkROFdcwBwcAPfj4h
 5WuHe0HZYpfvq0MrG3Xnj05btPf6pZV8T1bTIDvNGf6y7+RluJKQ+b8mE3iUIhSxiIlwq6g6dP
 pRw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jan 2023 05:15:12 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Nrrrw0p93z1Rwrq
        for <linux-ide@vger.kernel.org>; Tue, 10 Jan 2023 05:15:12 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1673356511; x=1675948512; bh=K+DjrBoMp8r4GmO2ND
        7jZ/tYn6dWl8LN/Wiw9iXU22w=; b=VS/YA3zsPC6bO1OTx1gumSfe9r2u3EDVh/
        I6HmKPuODGnKnIvxq1YWaeNmZ4Cj5KCFIRmpBr2p5kJDHpospZOXjFJ11tX3yqpl
        +gUOO+o/isvEv9UuJFk1BOoGKGemhVCrQVK2QLF7MATrhVeGyQB8N0Lq1eS95s+/
        +IBb9OTM4MuE3zyd1oBKBsc3xx/7bivwv6v9SPLWM/R2vScp2bUMDdZyS9j9gaID
        OuEdlCYoev6TEgevNcb0tWKw3r6aW/TATI0bVU2Wn/icFhRIIDMpyc7Ml8XGuGqj
        FhQPb8FOQl0X122D07LhgUShlCNgKzF97etBSFIYBB9xqk8UY9Sw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id fMgQLgtj7av5 for <linux-ide@vger.kernel.org>;
        Tue, 10 Jan 2023 05:15:11 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Nrrrt50pbz1RvTr;
        Tue, 10 Jan 2023 05:15:10 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v8 5/6] ata: libata: Fix FUA handling in ata_build_rw_tf()
Date:   Tue, 10 Jan 2023 22:15:02 +0900
Message-Id: <20230110131503.251712-6-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230110131503.251712-1-damien.lemoal@opensource.wdc.com>
References: <20230110131503.251712-1-damien.lemoal@opensource.wdc.com>
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

Given that the WRITE MULTI FUA EXT command is marked as obsolete in the
ATA specification since ACS-3 (published in 2013), remove the
ATA_CMD_WRITE_MULTI_FUA_EXT command from the ata_rw_cmds array.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 drivers/ata/libata-core.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index d25a53a873dc..ac88376f095a 100644
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
@@ -727,7 +727,8 @@ int ata_build_rw_tf(struct ata_queued_cmd *qc, u64 bl=
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
@@ -742,9 +743,10 @@ int ata_build_rw_tf(struct ata_queued_cmd *qc, u64 b=
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
2.39.0

