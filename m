Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C07C54EBE
	for <linux-ide@archiver.kernel.org>; Tue, 10 Jan 2023 13:15:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238569AbjAJNPY (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 10 Jan 2023 08:15:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238515AbjAJNPL (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 10 Jan 2023 08:15:11 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F54C5831A
        for <linux-ide@vger.kernel.org>; Tue, 10 Jan 2023 05:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673356510; x=1704892510;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R873OM2Ku7NzjIV4vPevY+ELpWrUMJedKCQYFLdggVk=;
  b=JzTsZE3Rw5rU4dm5lCXNVfuH4qJ/FTpqf5LusD0FJQh2WddcgKwogrMr
   JrMNNYJwbgSCWXLOahisWVQMOW49pFJoy92yvfCuckj1cOP3ZbclXwenI
   jqe4frjBeW7tB+IJjKsFa4Z06Yg+fZv2/NEN6bf6N4WjWmfi8HXuCdJF7
   ea8+V2zMmDdtg1nH7cSur4rYWEYIOZmCy/SpWNS7bTOE3u91ct9tJQ1f0
   VGv5MyH1ZpdCkOSsXkKa4HW+L+Wr/Liu4tPEio81B7RUXnkkjycnmbTIj
   Gqs7dOTL7fPFhJMAWoB8TNIPtTSApFGUGNXJQY7hWclebpl6zp0Njf+uD
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,315,1665417600"; 
   d="scan'208";a="220320516"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jan 2023 21:15:07 +0800
IronPort-SDR: IOuwZVXprjZJJpAyRq6Zwl/sYNOWNbfOdsz4XpeTWyYzhrtlOF7+odIItZ7HT0cjG2M/ISuWlz
 vGRzdgB6NKaODiN1DYFoXF79ZGVityyrJBM/WtTzVbIBrIUmt2trIr23vpfQwGb1flXsyYIpN/
 hhIOeIMWd0eiC/ecHhwcaUzg7eGO68+7LFCXAAA9Ueo8GgEAbHnfjBerUwjOlBgxZYpfbeIZnC
 fFjqL1P6AKIeLZMn7zqpoxJ01S/hKJEqiEc3dqZuBVsf9LPIxPDWQcIRLJkteQrvgAVJMxJv29
 g5Y=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jan 2023 04:27:13 -0800
IronPort-SDR: +J2lB/4wZsdPZK5K7LI7NoJ3XpXEvlI0MiWOPs711rmG0QjpTFQ6gbOi3Cwvij7aUKYpCdww70
 nvajFDX4ZnDQ5VI9ZycGmXu0HER73P8iMQJd66L0abWDSdMCvZjnZTsSECqiBTYGv9EJdHHrnE
 ZKKbhsLUxjefa2dSbLswPk4ggOJna6goxYlRgrX86t4GCxmx975jkJdxUzwzyneZI3chpsRuu3
 xw3JD5U9VJxKwG4DfsSGFtS8B2lDSM7jec3FOHBWAkWbeHEnbngpv52Xk7HXoagT3qNT9QS9HX
 7Ho=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jan 2023 05:15:08 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Nrrrq2Hckz1Rwrq
        for <linux-ide@vger.kernel.org>; Tue, 10 Jan 2023 05:15:07 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1673356506; x=1675948507; bh=R873OM2Ku7NzjIV4vP
        evY+ELpWrUMJedKCQYFLdggVk=; b=fRYATrjqhGCPOlTpKcTI1UA+B88729kzk/
        KqQLV9weSPXsWm/3E+o0aXWKaQsduikm9fKn6slVbRWe59FhA4osdyCJwBO9DJpU
        sCc7gbfGVAYnhpaBNYbN+/+FtDspSmt4hxtXx9GXE6dzieavy0Qy2JebFY9ZYlQk
        cC474WHVoEPkdc3vvXUP6i6LcILDWTLWrQild3LYQaNZzy60CsaTGgNHpmPkuaAZ
        2jQw+7zJqwgRSHfXfT7wBEG+l6JgUuyhaS0GfcroaaGLJZtZhHWkGjUv9yPY8xSr
        Hk/RB8c5XcZdLAEmhm3BYwgB/Xa7WNvS1Z50GCfeSoQdGcyWdovw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id yECCjzxOtgml for <linux-ide@vger.kernel.org>;
        Tue, 10 Jan 2023 05:15:06 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Nrrrp0FYNz1RvTp;
        Tue, 10 Jan 2023 05:15:05 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v8 1/6] block: add a sanity check for non-write flush/fua bios
Date:   Tue, 10 Jan 2023 22:14:58 +0900
Message-Id: <20230110131503.251712-2-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230110131503.251712-1-damien.lemoal@opensource.wdc.com>
References: <20230110131503.251712-1-damien.lemoal@opensource.wdc.com>
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

