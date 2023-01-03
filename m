Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42373C54EBC
	for <linux-ide@archiver.kernel.org>; Tue,  3 Jan 2023 05:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232623AbjACFWW (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 3 Jan 2023 00:22:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236860AbjACFVs (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 3 Jan 2023 00:21:48 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAAADD109
        for <linux-ide@vger.kernel.org>; Mon,  2 Jan 2023 21:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1672723176; x=1704259176;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+E4oIDMFHlNO3TqaQKpEd8queFQgBiehnHqMC1+BKZc=;
  b=Dr7JvB8Ko8fil57SqXFdiJgWklKS2jR/L8/JxeA2A2xFGgA0Z5gA6vP7
   z2DGPy0NUjZ0EFsQWlAzah51DW4R1jSuyxA0sCuqe6v/XRYTYG5Jd/MPx
   Ek8aWMT5WhQkoY8PGOhhD36bvpW8cOdZyTAhrSUTxzyp5HYwVFVti0vj6
   owfQKDpxLpjJE3MTigluxdbGWqNLQz0CzUKQJIAplS7QONGF7mFlMS/p5
   NahV/mSE6cbrdd1cOx9ZxkoJ4csUwsbAq7ShsUp51f6Ki2fRoyDSK7I+c
   DMZQPZek9sPcTYXkL9KG9td67IkyU/qecGYJERjquGLOjymhXkNJX3q1W
   A==;
X-IronPort-AV: E=Sophos;i="5.96,295,1665417600"; 
   d="scan'208";a="218126869"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 03 Jan 2023 13:19:35 +0800
IronPort-SDR: G3MXIEO80MBYaV53hZqr2raVDEXPrHPIZiZ+aTRtrhw3E5zPLCaeqMzw6B6GvJZxhnIs2SMLVy
 BUKtpjpc21GYACDWS1kXkJ9K6WxiteZK58CcfOVG8xQE1aWUnRPGaLdLtnviGO1WxfciL5cg5k
 eVeo9WdC8lWxKQ22U2kYwjjCZlDXu8lMGI//voognpID9WNa7a/t10++CerGArJL6LSAYUAWEG
 fLvtivWeKQDVJ2Mkf41I3v0OIWkKUxUWWn0OdNwNqFntdflC7LjvCQ7SHtyEdrHWM/tB4bSjlr
 zdk=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Jan 2023 20:31:50 -0800
IronPort-SDR: FUXEmvwu89vJDTLUkcDBmXTWioBtpsSXKfThM5wcnjl7hXFyBc3To12CpglN1GJDFnUzjAyebj
 GeoONmiMOOYS7oj6CAs2tJ1tEwWMce2hCOqnM534smSVeofXgD6fSFR6U1cLvGQULDKOn5KPiQ
 p51HtMED6yniBP4+35lPEzAXKG94klELRJ3l9EMpGHs6coWMOmN4BT1Vh1BHSxdw4lzO2DBcC3
 bV78//JU7iW5Ec9vS013E9yiwtes6Z6Re1OBFhwbM5oQgX15Qw1kgTuGlEOp8Upox7eFeYAQLW
 NFs=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Jan 2023 21:19:36 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NmLdM4TK1z1Rwtm
        for <linux-ide@vger.kernel.org>; Mon,  2 Jan 2023 21:19:35 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1672723174; x=1675315175; bh=+E4oIDMFHlNO3TqaQK
        pEd8queFQgBiehnHqMC1+BKZc=; b=GWUKzovw+nMdlKC6Xv+cP+4osYHHQkakEM
        mA2ojxu+1hQE/Br0W34pUQMV/h36f22R+krMr9Hq5nJLmsepolcIdaloNOmKvDYp
        HgBxPRAvZSKWKRBpPzQJalRVGmAHKlSq0tdR2MkGGSNM2WZnxtQsDvYGhot4LA2E
        O62kkg+Xb+NcFk/sHrcBaTzGrgzHONw36c/k2Rgeyg01vib8eOzVoSqg+S/4FBQw
        Q9cFvsOIAf+FGHPYA8OzJaBP/FbjdtjZbXyaDl/zDqpCXAfwXiPBm3xlXjOikUhB
        ExvZ4RcBbNk+FhEkKEMzjAjRX9J/BvyA6MAD7V2N4QBQlPngQkYw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id oH7Rs5e2ok_U for <linux-ide@vger.kernel.org>;
        Mon,  2 Jan 2023 21:19:34 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NmLdK45gjz1RvTp;
        Mon,  2 Jan 2023 21:19:33 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
        Niklas Cassel <niklas.cassel@wdc.com>
Subject: [PATCH v7 5/7] ata: libata: Fix FUA handling in ata_build_rw_tf()
Date:   Tue,  3 Jan 2023 14:19:22 +0900
Message-Id: <20230103051924.233796-6-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230103051924.233796-1-damien.lemoal@opensource.wdc.com>
References: <20230103051924.233796-1-damien.lemoal@opensource.wdc.com>
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
index 30adae16efff..2b66fe529d81 100644
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

