Return-Path: <SRS0=AjNr=5C=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28498C3F2CE
	for <linux-ide@archiver.kernel.org>; Tue, 17 Mar 2020 14:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0073F20735
	for <linux-ide@archiver.kernel.org>; Tue, 17 Mar 2020 14:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="TOCYziIZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbgCQOo7 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 17 Mar 2020 10:44:59 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:40416 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbgCQOns (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 17 Mar 2020 10:43:48 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200317144347euoutp02e6ffb482ec1c4d93be94f183f6b639a0~9HotHzaM51539915399euoutp02T
        for <linux-ide@vger.kernel.org>; Tue, 17 Mar 2020 14:43:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200317144347euoutp02e6ffb482ec1c4d93be94f183f6b639a0~9HotHzaM51539915399euoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1584456227;
        bh=sF5n74fceBslUd5JxOicMt/MMNq8pwy4hbNI3C7Yneo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TOCYziIZ+QEAwvdBWmULy4KhzEbDlc+U7TOgJRsX/hk+KcijsdZhXAH6NZ+LRPZZH
         ElbZfl4QTkWzznaQDNrz0OfaMCw2vEUN3EgsEvyIhd3A70RXdD3h0GwckW0vOXNc5V
         TvZor+jFZ5b0kaoNFU1JjUYCo3XqN1q+8AuQ0rYs=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200317144347eucas1p2c9867b0c6e554d8ecdbcac81e4e8f169~9Hos1lKgm3190831908eucas1p2i;
        Tue, 17 Mar 2020 14:43:47 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id B2.E9.60698.322E07E5; Tue, 17
        Mar 2020 14:43:47 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200317144346eucas1p201a88e2eb094f1a246d0eb541541131f~9HosXCj-v0133401334eucas1p2b;
        Tue, 17 Mar 2020 14:43:46 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200317144346eusmtrp2583b1e6962ff71f0b08925981c48ea27~9HosWdJYb0146401464eusmtrp2K;
        Tue, 17 Mar 2020 14:43:46 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-e7-5e70e2232124
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 0D.D4.08375.222E07E5; Tue, 17
        Mar 2020 14:43:46 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200317144346eusmtip1c2d10c9cd78c9bdb7d41a3d3ba941eff~9Hor2ztkb0973309733eusmtip1U;
        Tue, 17 Mar 2020 14:43:46 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH v4 11/27] ata: fix CodingStyle issues in PATA timings code
Date:   Tue, 17 Mar 2020 15:43:17 +0100
Message-Id: <20200317144333.2904-12-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200317144333.2904-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDKsWRmVeSWpSXmKPExsWy7djPc7rKjwriDL4cYLdYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRXDYpqTmZZalF+nYJXBk9uy+wFXyWrnjwt7yB8YRYFyMnh4SA
        icTz1ltMILaQwApGiYtfqrsYuYDsL4wS1y5fYodwPjNK/P+0mhWm4+qml+wQHcsZJeYf4oXr
        6O34zAySYBOwkpjYvooRxBYRUJDo+b2SDaSIWeA9o8SKSXtZQBLCAl4Sh3ZOBbNZBFQlvh5c
        A9bAK2ArsWj7XDaIbfISW799AtvMCRS/dvgfG0SNoMTJmU/AepmBapq3zmYGWSAhsIpdYs6y
        v8wQzS4S+/5cZ4ewhSVeHd8CZctI/N85nwmiYR2jxN+OF1Dd2xkllk/+B7XaWuLOuV9ANgfQ
        Ck2J9bv0IcKOEsdWHWIHCUsI8EnceCsIcQSfxKRt05khwrwSHW1CENVqEhuWbWCDWdu1cyXU
        aR4Shy4eZ53AqDgLyTuzkLwzC2HvAkbmVYziqaXFuempxcZ5qeV6xYm5xaV56XrJ+bmbGIFp
        6PS/4193MO77k3SIUYCDUYmHN2FTQZwQa2JZcWXuIUYJDmYlEd7FhflxQrwpiZVVqUX58UWl
        OanFhxilOViUxHmNF72MFRJITyxJzU5NLUgtgskycXBKNTCenb1sS9Pj9S2RN76e/T5b1mlz
        +dJ9hW6X596em+4Y+znH5K7xruz2Cc7B+593KZ60FImIOcLc9J7zza2/Fm6HvX6fv3L4tpID
        P9u++Zp9yYJmZoaXuD86NKw2f72dqdbjzl877Xx1M9sgFb0tvd4uKZMOMDvqc29j3NIjlex4
        Jnmxx9rLsj1KLMUZiYZazEXFiQDKhqjOPwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsVy+t/xu7pKjwriDM4+VLBYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6
        djYpqTmZZalF+nYJehk9uy+wFXyWrnjwt7yB8YRYFyMnh4SAicTVTS/Zuxi5OIQEljJKLHt9
        jKWLkQMoISNxfH0ZRI2wxJ9rXWwQNZ8YJV4vmc0GkmATsJKY2L6KEcQWEVCQ6Pm9EqyIWeAr
        o8TSSd3MIAlhAS+JQzunsoDYLAKqEl8PrgFr4BWwlVi0fS4bxAZ5ia3fPrGC2JxA8WuH/4HF
        hQRsJF68+c8EUS8ocXLmE7A5zED1zVtnM09gFJiFJDULSWoBI9MqRpHU0uLc9NxiQ73ixNzi
        0rx0veT83E2MwHjZduzn5h2MlzYGH2IU4GBU4uHl2FAQJ8SaWFZcmXuIUYKDWUmEd3FhfpwQ
        b0piZVVqUX58UWlOavEhRlOgJyYyS4km5wNjOa8k3tDU0NzC0tDc2NzYzEJJnLdD4GCMkEB6
        YklqdmpqQWoRTB8TB6dUA6Nl4cqYXEavxLsMtyq9XLkcv7TEPir4fy3L0ETh26ec7fciU/KO
        PLLY/dMh0/1vYc7sYsP1wSc+ujiaVGSV7xKrCT0cV/B9HlPDVYbP27n4fL9vO6rWr7g8/X23
        9FnXY0sFbq3cvlxq3cqm8Gmbcu/Pspxk21f348sEkb+Mftd+lz2Js7I4yKXEUpyRaKjFXFSc
        CAA+joTgrQIAAA==
X-CMS-MailID: 20200317144346eucas1p201a88e2eb094f1a246d0eb541541131f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200317144346eucas1p201a88e2eb094f1a246d0eb541541131f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200317144346eucas1p201a88e2eb094f1a246d0eb541541131f
References: <20200317144333.2904-1-b.zolnierkie@samsung.com>
        <CGME20200317144346eucas1p201a88e2eb094f1a246d0eb541541131f@eucas1p2.samsung.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

* fix the overly long line in ata_timing_quantize()

* use standard kernel CodingStyle in ata_timing_merge()

* do not use assignment in if condition in ata_timing_compute()

* fix non-standard comment style in ata_timing_compute()

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/libata-core.c | 42 +++++++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index e4df091fdcde..52d32c88b854 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3263,7 +3263,8 @@ static const struct ata_timing ata_timing[] = {
 #define ENOUGH(v, unit)		(((v)-1)/(unit)+1)
 #define EZ(v, unit)		((v)?ENOUGH(((v) * 1000), unit):0)
 
-static void ata_timing_quantize(const struct ata_timing *t, struct ata_timing *q, int T, int UT)
+static void ata_timing_quantize(const struct ata_timing *t,
+				struct ata_timing *q, int T, int UT)
 {
 	q->setup	= EZ(t->setup,       T);
 	q->act8b	= EZ(t->act8b,       T);
@@ -3279,15 +3280,24 @@ static void ata_timing_quantize(const struct ata_timing *t, struct ata_timing *q
 void ata_timing_merge(const struct ata_timing *a, const struct ata_timing *b,
 		      struct ata_timing *m, unsigned int what)
 {
-	if (what & ATA_TIMING_SETUP  ) m->setup   = max(a->setup,   b->setup);
-	if (what & ATA_TIMING_ACT8B  ) m->act8b   = max(a->act8b,   b->act8b);
-	if (what & ATA_TIMING_REC8B  ) m->rec8b   = max(a->rec8b,   b->rec8b);
-	if (what & ATA_TIMING_CYC8B  ) m->cyc8b   = max(a->cyc8b,   b->cyc8b);
-	if (what & ATA_TIMING_ACTIVE ) m->active  = max(a->active,  b->active);
-	if (what & ATA_TIMING_RECOVER) m->recover = max(a->recover, b->recover);
-	if (what & ATA_TIMING_DMACK_HOLD) m->dmack_hold = max(a->dmack_hold, b->dmack_hold);
-	if (what & ATA_TIMING_CYCLE  ) m->cycle   = max(a->cycle,   b->cycle);
-	if (what & ATA_TIMING_UDMA   ) m->udma    = max(a->udma,    b->udma);
+	if (what & ATA_TIMING_SETUP)
+		m->setup = max(a->setup, b->setup);
+	if (what & ATA_TIMING_ACT8B)
+		m->act8b = max(a->act8b, b->act8b);
+	if (what & ATA_TIMING_REC8B)
+		m->rec8b = max(a->rec8b, b->rec8b);
+	if (what & ATA_TIMING_CYC8B)
+		m->cyc8b = max(a->cyc8b, b->cyc8b);
+	if (what & ATA_TIMING_ACTIVE)
+		m->active = max(a->active, b->active);
+	if (what & ATA_TIMING_RECOVER)
+		m->recover = max(a->recover, b->recover);
+	if (what & ATA_TIMING_DMACK_HOLD)
+		m->dmack_hold = max(a->dmack_hold, b->dmack_hold);
+	if (what & ATA_TIMING_CYCLE)
+		m->cycle = max(a->cycle, b->cycle);
+	if (what & ATA_TIMING_UDMA)
+		m->udma = max(a->udma, b->udma);
 }
 EXPORT_SYMBOL_GPL(ata_timing_merge);
 
@@ -3318,8 +3328,8 @@ int ata_timing_compute(struct ata_device *adev, unsigned short speed,
 	/*
 	 * Find the mode.
 	 */
-
-	if (!(s = ata_timing_find_mode(speed)))
+	s = ata_timing_find_mode(speed);
+	if (!s)
 		return -EINVAL;
 
 	memcpy(t, s, sizeof(*s));
@@ -3375,9 +3385,11 @@ int ata_timing_compute(struct ata_device *adev, unsigned short speed,
 		t->recover = t->cycle - t->active;
 	}
 
-	/* In a few cases quantisation may produce enough errors to
-	   leave t->cycle too low for the sum of active and recovery
-	   if so we must correct this */
+	/*
+	 * In a few cases quantisation may produce enough errors to
+	 * leave t->cycle too low for the sum of active and recovery
+	 * if so we must correct this.
+	 */
 	if (t->active + t->recover > t->cycle)
 		t->cycle = t->active + t->recover;
 
-- 
2.24.1

