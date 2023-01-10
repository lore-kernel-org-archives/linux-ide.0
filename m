Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E39C67871
	for <linux-ide@archiver.kernel.org>; Tue, 10 Jan 2023 13:27:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232828AbjAJN1i (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 10 Jan 2023 08:27:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232892AbjAJN1P (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 10 Jan 2023 08:27:15 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477DEB1C9
        for <linux-ide@vger.kernel.org>; Tue, 10 Jan 2023 05:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673357235; x=1704893235;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AyibMIs0Fjq5vJZru9dnT2TmnjplSYQ6SuX8E1ANMNo=;
  b=oJo6LSXRkVgxGMZaCopCad67evri6i+bfcfulpQdmtxJKPpys0zxUojh
   mI9ais3PdE9fJpJqBcfPJudO3iMK39AeQFU5C1kiDHqvVj5gB9c7sJBKE
   n9oKnbNmYz0joCVTMsIJp2JZhcsCQS65sJVrWyBhClgcWahBeGK/vSUNc
   4oD+ALjnGSsx5mZGjR9Q8m3mqoEfU/36hRsN8ISSTMLtyaK7KI4E1TRQS
   OY4mPfUq1bZ0gQ25wF2IEkgLEkswPg8GvhIt2D7wMlOI2TgSAnSd3QA6e
   p/+/xcuO6F4zOF9/eOdMHjWzKWf7Tj6KhkcvLShFwkeDKneDL8CHImJUg
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,315,1665417600"; 
   d="scan'208";a="220321118"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jan 2023 21:27:15 +0800
IronPort-SDR: OAF972JQEAvOoo4C2bNwO1wgrG8uDxa6ZM9vXIfBHFayCO3Tot+dKal/EmDc1H6rTIdexDimj1
 /zsblNGNDZb+Pgqtiee56y8hSwDCGTiAuYgl+UsmeX/fIWyd3wR+MVl53zGeFT9rBt2jrBxBMz
 55ONWHIp432nqOdBZXp2i3lRCQ3rsjlnRVGztQrvvVWG4zYl6vSiUVAA9BE7UKc9RsLOgMO0hs
 dqwKTtO5TbYuh5Q55TY0l1jPdPEZs45z3I1rt+o80XF5qiklz1/F9LAMoN3WgRLiu5iDHl3XM6
 qjs=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jan 2023 04:39:20 -0800
IronPort-SDR: DLFg2mYcOXpwASchpx2CuFL33VIlCJJTLwbbNKoPtBaD+Z43wYMyKThPJrGAwRP5ezkB4aQqk8
 vZQ1grSjl0U+oyvrbSlIafoU/t8FisaZG0wEtQvZi9ykq3BsJ12nWhRt3P6xNZLx4KEs19/Dfl
 pehukfy5A3NVQIgSrcYdGCfhWbe/84ePaFkcDNvLr3n/d9HWJEA9AHQgkD2CVffQOIpHnLm2Bc
 763rOEr0bNTRO44tX+IiNSQqvu24mE+nDI87uz/ru4ZLv7c10H83WmE5g+u0rN/PMKCY6zk3+f
 tro=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jan 2023 05:27:15 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Nrs6p5mGfz1Rwrq
        for <linux-ide@vger.kernel.org>; Tue, 10 Jan 2023 05:27:14 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1673357234; x=1675949235; bh=AyibMIs0Fjq5vJZru9
        dnT2TmnjplSYQ6SuX8E1ANMNo=; b=kwhU8ly1QXkOf6LeGbbDIHZPOn02lIKfKw
        JHefJq12srTjZ+cdiqh3zJBO37YOPDQfuhr5tohlXk67KY6TischBOkFJOVGJr51
        7MZ3la2ij4acIDzkyzK/alIK6aj40O7hOyHqBq6jpye+OMj7AEqCS1Of3nhA7VYZ
        4KCYO6j6DCSy6czohxw7kXwZKrFaWrtB458Cg5UkutkkPAdRmxbQQ3r0EGuewRpY
        ocnbsxjLB4hyIeAyhNmbFErwba3q4/jwh8Q2zxYCgPo2Vuy8Mx6TPFFhmWQyplLv
        YeAyVwtbcs7AKkAMagd4AQ6SDS1+wUZ9XLgQ4SmWC1Wxb4mv4yiA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 0VMM2RCb1zQl for <linux-ide@vger.kernel.org>;
        Tue, 10 Jan 2023 05:27:14 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Nrs6n3X06z1RvTp;
        Tue, 10 Jan 2023 05:27:13 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v9 1/6] block: add a sanity check for non-write flush/fua bios
Date:   Tue, 10 Jan 2023 22:27:05 +0900
Message-Id: <20230110132710.252015-2-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230110132710.252015-1-damien.lemoal@opensource.wdc.com>
References: <20230110132710.252015-1-damien.lemoal@opensource.wdc.com>
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
Reviewed-by: Niklas Cassel <niklas.cassel@wdc.com>
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

