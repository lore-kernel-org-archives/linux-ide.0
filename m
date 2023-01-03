Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F14C3DA7D
	for <linux-ide@archiver.kernel.org>; Tue,  3 Jan 2023 05:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbjACFWY (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 3 Jan 2023 00:22:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236829AbjACFVo (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 3 Jan 2023 00:21:44 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336ACF7E
        for <linux-ide@vger.kernel.org>; Mon,  2 Jan 2023 21:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1672723171; x=1704259171;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R873OM2Ku7NzjIV4vPevY+ELpWrUMJedKCQYFLdggVk=;
  b=bNuDOhz2TI1JLCoSMOGWixpmv28CjSQVCIWMDzGVIruFD0byRqDVUDG5
   SYfQbNlyKjE7RvHsgJfakmQbFGkOeevF1BYR/yUPs94LtPQ0K+e59doho
   gMururgp0UTJowUsfknsWQ8O3vRPRrCATXtFzESejudiTTGz2Llxrw4O/
   iml9+gu7lDMEw8XZW665WRQ8tgGl4/QZWwBSauFFdv4j5AZahPWBv0g8+
   lSWVsrCy3XfonPstnimwPrjbBuytv2PJmtY7PS6UVUq4G7AlHs53FAul8
   wKKyH/AnbKUKgDH5lxRIExnWa5lKS07f7EC/p0+IiQ5TbN8iA/3QJodxq
   g==;
X-IronPort-AV: E=Sophos;i="5.96,295,1665417600"; 
   d="scan'208";a="219794868"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 03 Jan 2023 13:19:29 +0800
IronPort-SDR: 8AomDAjtrRw0rNqOkd5x+9nrtAP9K1LluvKnENDtJ/GC0AZfTSO/LPyjO20/obXWzDJAzrHQAE
 syzZ5FYk/VVl7iRrwXulB6mGyuErGlFzUqnlydA9KOgL6/5howRhHj1IH72bMN68Fdwa6wmy+J
 86WBXZnyVCaBQ5N4cKwhfrAVPFvV9RFM9zHrZeb+HP+FJnCY/Fo8Dz7VYjPLWJSnaqisv/Vcdx
 lYotC6hJ9DXiTNIELK2aXlUcQTYp9Z5NP4OOLLIhNCRcJf0r6MbCophQ/R/LAbEexaIDYK6WA+
 hLA=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Jan 2023 20:31:43 -0800
IronPort-SDR: 1MggyRwYvjE5orSyqF6O3CXeNpG37WXTfj5elpfjMBfev31B6uo6Sqmx5j+mJb/EnwVuncrZxf
 GbPK9/2ekDhXUDS9dh5+vrCYPfSvuWBrvyaZOe9IbPxXCSP5r2xvM1b+2TdsAV9SXU2Mqzc0ev
 RbIXoMAR8+rQWNLKFVk4vGRwdHVog8DKPx3ESZtVi5gPzVvKrQam2z0ZtgHxyql8AwWmw94Nkt
 fW8bekHL+SinReOLfVM5sWcV7IAs7azTeTVQuOhv0/8PXviEQub9pwPTqmYpAQTH1i481VApIy
 O1M=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Jan 2023 21:19:30 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NmLdF260bz1Rwrq
        for <linux-ide@vger.kernel.org>; Mon,  2 Jan 2023 21:19:29 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1672723168; x=1675315169; bh=R873OM2Ku7NzjIV4vP
        evY+ELpWrUMJedKCQYFLdggVk=; b=GjhKCpuUc2dwqJB5cOCKH/1VAchRQj7SER
        VlhZDRjptBaswUhjHaWhZpJ6zPNAdNmOmt8g/OUvtMYmmFqbG/lIX6aiRsAqj2Z6
        bCsbYzUjGAxXdRxmgbWIkvsU2UeizkILrwwasdXuTUUXGn5xC/PLxrBgcYTCem8t
        w/sZu9Us2T1LEAk8iPVb1drgMgpxOo4AYSfX73npFng2/PmEhc9bCndKYE6DTsQl
        x2jTg1p92KCVCXp91bMfBqN6Qv344UbKTYi0ywL3GcvT73RjeuWIeTmfSdRiGxKu
        eFoM5NC9ncL5eD+ny8h2Vl89DRONbP9UTqldxWdOAQ/T+VfQFaFA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 0nzrbsOIFr6o for <linux-ide@vger.kernel.org>;
        Mon,  2 Jan 2023 21:19:28 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NmLdC4qmSz1RvTp;
        Mon,  2 Jan 2023 21:19:27 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
        Niklas Cassel <niklas.cassel@wdc.com>
Subject: [PATCH v7 1/7] block: add a sanity check for non-write flush/fua bios
Date:   Tue,  3 Jan 2023 14:19:18 +0900
Message-Id: <20230103051924.233796-2-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230103051924.233796-1-damien.lemoal@opensource.wdc.com>
References: <20230103051924.233796-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

From: Christoph Hellwig <hch@infradead.org>

Check that the PREFUSH and FUA flags are only set on write bios,
given that the flush state machine expects that.

[Damien] The check is also extended to REQ_OP_ZONE_APPEND operations as
these are data write operations used by btrfs and zonefs and may also
have the REQ_FUA bit set.

Reported-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 block/blk-core.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 9321767470dc..c644aac498ef 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -744,12 +744,16 @@ void submit_bio_noacct(struct bio *bio)
 	 * Filter flush bio's early so that bio based drivers without flush
 	 * support don't have to worry about them.
 	 */
-	if (op_is_flush(bio->bi_opf) &&
-	    !test_bit(QUEUE_FLAG_WC, &q->queue_flags)) {
-		bio->bi_opf &=3D ~(REQ_PREFLUSH | REQ_FUA);
-		if (!bio_sectors(bio)) {
-			status =3D BLK_STS_OK;
+	if (op_is_flush(bio->bi_opf)) {
+		if (WARN_ON_ONCE(bio_op(bio) !=3D REQ_OP_WRITE &&
+				 bio_op(bio) !=3D REQ_OP_ZONE_APPEND))
 			goto end_io;
+		if (!test_bit(QUEUE_FLAG_WC, &q->queue_flags)) {
+			bio->bi_opf &=3D ~(REQ_PREFLUSH | REQ_FUA);
+			if (!bio_sectors(bio)) {
+				status =3D BLK_STS_OK;
+				goto end_io;
+			}
 		}
 	}
=20
--=20
2.39.0

