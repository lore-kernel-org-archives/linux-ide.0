Return-Path: <SRS0=qhS8=33=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A13ECC2BA83
	for <linux-ide@archiver.kernel.org>; Fri,  7 Feb 2020 14:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DE1620838
	for <linux-ide@archiver.kernel.org>; Fri,  7 Feb 2020 14:29:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qnNMNDAu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbgBGO3a (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 7 Feb 2020 09:29:30 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:59630 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727705AbgBGO15 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 7 Feb 2020 09:27:57 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200207142756euoutp015fbeb9f6b13420e61220476bba1fdce4~xJQvInySO2084620846euoutp01L
        for <linux-ide@vger.kernel.org>; Fri,  7 Feb 2020 14:27:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200207142756euoutp015fbeb9f6b13420e61220476bba1fdce4~xJQvInySO2084620846euoutp01L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1581085676;
        bh=8qblVHgZQdH7DspEPS2zqxLjyU4sy8NDZsuweya/gac=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qnNMNDAupUeYn7NtCKVpSLvYBZCMJ1CXG6HaUqA1apSITbTS1IrW6zOjbXZfPfGBP
         ju/QsbtBnzyUWNEGaaYIi+oqY5AA2s8NGBAJ+YxUapkT2PHjVCCYhnnLJvxNlZW0de
         XvyIjCldwgmeDSQYw6pP8rsXkYnvBXVhhg8Bbk00=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200207142756eucas1p129b389017fe20ac346fc3aa1b4ae9757~xJQuzbuyh2644726447eucas1p19;
        Fri,  7 Feb 2020 14:27:56 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id CD.4D.60679.CE37D3E5; Fri,  7
        Feb 2020 14:27:56 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200207142756eucas1p14021b9f9dac98434feeb5ba094b8a8c3~xJQukjQVS0218002180eucas1p1N;
        Fri,  7 Feb 2020 14:27:56 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200207142756eusmtrp236eb205bf1c00a29bf50ea81acd0f2ff~xJQuj8gxX1102911029eusmtrp2-;
        Fri,  7 Feb 2020 14:27:56 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-75-5e3d73ec33ad
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 1F.C5.07950.CE37D3E5; Fri,  7
        Feb 2020 14:27:56 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200207142755eusmtip29ab1cb3b63d8fdb3cf5f5883fe3f1288~xJQuH0Dvg3155831558eusmtip2D;
        Fri,  7 Feb 2020 14:27:55 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH v2 10/26] ata: fix CodingStyle issues in PATA timings code
Date:   Fri,  7 Feb 2020 15:27:18 +0100
Message-Id: <20200207142734.8431-11-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200207142734.8431-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLKsWRmVeSWpSXmKPExsWy7djPc7pvim3jDD4eEbFYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRXDYpqTmZZalF+nYJXBkb30xnKfgsXbH06zSmBsYTYl2MnBwS
        AiYSyw9OYupi5OIQEljBKHH0wWIWkISQwBdGiV/LgyHsz4wSX6e7wzT86LnIDtGwnFHi7LfJ
        jBAOUMOcpddZQarYBKwkJravYgSxRQQUJHp+r2QDKWIWeM8osWLSXrAVwgJeEpMOtrGB2CwC
        qhLXX51lArF5BWwldjbcYoZYJy+x9dsnsKGcQPGPU/6yQdQISpyc+QRsDjNQTfPW2cwgCyQE
        VrFLzHxxnBWi2UXi7f0LULawxKvjW9ghbBmJ/zvnM0E0rGOU+NvxAqp7O6PE8sn/2CCqrCXu
        nPsFZHMArdCUWL9LHyLsKDFt53VmkLCEAJ/EjbeCEEfwSUzaNh0qzCvR0SYEUa0msWHZBjaY
        tV07V0L95SFx+NhWpgmMirOQvDMLyTuzEPYuYGRexSieWlqcm55abJSXWq5XnJhbXJqXrpec
        n7uJEZiITv87/mUH464/SYcYBTgYlXh4Exxt4oRYE8uKK3MPMUpwMCuJ8Pap2sYJ8aYkVlal
        FuXHF5XmpBYfYpTmYFES5zVe9DJWSCA9sSQ1OzW1ILUIJsvEwSnVwJip9iYs8ENhNWtPyX+P
        nUVKSh0KjS+fe5x9GVx/qfn7yh0F1ztTXv+bcFBe0LM+lm/pjH8nTnKKBEsvs9L83yvpEJau
        fUlxoYi3bEPtuX9zypVdT2n2N13Lr5fV+9P7Wt/BQ2bt21qRe5P+Pjy5u0yqJJCBM23ezEjr
        J66hgUF1OWYvO6+aKbEUZyQaajEXFScCAGNWXQxAAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsVy+t/xe7pvim3jDE5uY7VYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6
        djYpqTmZZalF+nYJehkb30xnKfgsXbH06zSmBsYTYl2MnBwSAiYSP3ousncxcnEICSxllPiz
        /ApLFyMHUEJG4vj6MogaYYk/17rYIGo+MUps+PCFHSTBJmAlMbF9FSOILSKgINHzeyVYEbPA
        V0aJpZO6mUESwgJeEpMOtrGB2CwCqhLXX51lArF5BWwldjbcYobYIC+x9dsnVhCbEyj+ccpf
        sHohARuJ7+8nsUPUC0qcnPmEBcRmBqpv3jqbeQKjwCwkqVlIUgsYmVYxiqSWFuem5xYb6RUn
        5haX5qXrJefnbmIERsy2Yz+37GDsehd8iFGAg1GJhzfB0SZOiDWxrLgy9xCjBAezkghvn6pt
        nBBvSmJlVWpRfnxRaU5q8SFGU6AnJjJLiSbnA6M5ryTe0NTQ3MLS0NzY3NjMQkmct0PgYIyQ
        QHpiSWp2ampBahFMHxMHp1QDY+ZLm6OH3D7KZkVIPGn117f4F8z60sx/mcBvtYAZRsK+x3/4
        /critQyTemv5rGJu9mSF3wsmzwjXiNF+o9m0Soe7/0Rqq+47++o1+Zn2Lzwfz5O/8vSnGYNc
        1/WDFrcNXRxe/bPIFTb7XrxAc1NWcUFKV8TMrYt588MX/5v7RKdu7uwAxnn9SizFGYmGWsxF
        xYkAGa3pAa4CAAA=
X-CMS-MailID: 20200207142756eucas1p14021b9f9dac98434feeb5ba094b8a8c3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200207142756eucas1p14021b9f9dac98434feeb5ba094b8a8c3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200207142756eucas1p14021b9f9dac98434feeb5ba094b8a8c3
References: <20200207142734.8431-1-b.zolnierkie@samsung.com>
        <CGME20200207142756eucas1p14021b9f9dac98434feeb5ba094b8a8c3@eucas1p1.samsung.com>
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
index c41198bb9582..31363220aa24 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3251,7 +3251,8 @@ static const struct ata_timing ata_timing[] = {
 #define ENOUGH(v, unit)		(((v)-1)/(unit)+1)
 #define EZ(v, unit)		((v)?ENOUGH(((v) * 1000), unit):0)
 
-static void ata_timing_quantize(const struct ata_timing *t, struct ata_timing *q, int T, int UT)
+static void ata_timing_quantize(const struct ata_timing *t,
+				struct ata_timing *q, int T, int UT)
 {
 	q->setup	= EZ(t->setup,       T);
 	q->act8b	= EZ(t->act8b,       T);
@@ -3267,15 +3268,24 @@ static void ata_timing_quantize(const struct ata_timing *t, struct ata_timing *q
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
 
@@ -3306,8 +3316,8 @@ int ata_timing_compute(struct ata_device *adev, unsigned short speed,
 	/*
 	 * Find the mode.
 	 */
-
-	if (!(s = ata_timing_find_mode(speed)))
+	s = ata_timing_find_mode(speed);
+	if (!s)
 		return -EINVAL;
 
 	memcpy(t, s, sizeof(*s));
@@ -3363,9 +3373,11 @@ int ata_timing_compute(struct ata_device *adev, unsigned short speed,
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

