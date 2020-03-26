Return-Path: <SRS0=jBxd=5L=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7254C2D0ED
	for <linux-ide@archiver.kernel.org>; Thu, 26 Mar 2020 16:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC9712073E
	for <linux-ide@archiver.kernel.org>; Thu, 26 Mar 2020 16:00:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="tde1AqY7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbgCZQAD (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 26 Mar 2020 12:00:03 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:52637 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728461AbgCZP6o (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 26 Mar 2020 11:58:44 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200326155843euoutp02a55234ebd14cb6e426f284f3666135ce~-5dsv-v2S0032300323euoutp02n
        for <linux-ide@vger.kernel.org>; Thu, 26 Mar 2020 15:58:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200326155843euoutp02a55234ebd14cb6e426f284f3666135ce~-5dsv-v2S0032300323euoutp02n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585238323;
        bh=ysgEdo9XebnXhbcjjAesZ87JzNw6hdR+CiYzzMFUriA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tde1AqY7BauG/WJPhUOBlCyxzRSN8d9syFZWGquNt72/3eQ/Jzk+VM+kqGP94tRhF
         963WHbYZGu+dLjMtHQvVnGCqpQGLIb3qte5Nkj2NkUyzvJk9oUAlXqTUA2o4dc54FK
         G+5tgTi2xyt3Y7O6E7b86dmbLi4HWG5oJiQANz2w=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200326155843eucas1p13e1d94945ea51ecf874626588d063115~-5dsgKc-92821328213eucas1p1v;
        Thu, 26 Mar 2020 15:58:43 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id CC.F5.61286.331DC7E5; Thu, 26
        Mar 2020 15:58:43 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200326155842eucas1p1aa92a260749305a13bebcd7999fd801b~-5dsS-gB82821828218eucas1p1v;
        Thu, 26 Mar 2020 15:58:42 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200326155842eusmtrp1ac353618e775754154a85ea23478188c~-5dsSc9OX2090020900eusmtrp1i;
        Thu, 26 Mar 2020 15:58:42 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-c4-5e7cd133281e
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 7B.5A.08375.231DC7E5; Thu, 26
        Mar 2020 15:58:42 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200326155842eusmtip195c31d1cb4c163551709cadfaaa76789~-5dr56S100452404524eusmtip1M;
        Thu, 26 Mar 2020 15:58:42 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH v5 11/27] ata: fix CodingStyle issues in PATA timings code
Date:   Thu, 26 Mar 2020 16:58:06 +0100
Message-Id: <20200326155822.19400-12-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200326155822.19400-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHKsWRmVeSWpSXmKPExsWy7djPc7rGF2viDO61cVisvtvPZrFxxnpW
        i2e39jJZrFx9lMni2I5HTBaXd81hs1j+ZC2zxdzW6ewOHB47Z91l97h8ttTj0OEORo+Trd9Y
        PHbfbGDz6NuyitHj8ya5APYoLpuU1JzMstQifbsEroyFW04xFyyQqZh66xpLA+MHsS5GTg4J
        AROJbR+/MHUxcnEICaxglJi34zAjhPOFUWL25KnsEM5nRomfT46yw7ScatjECpFYziix6MMJ
        ZriWJb8es4FUsQlYSUxsX8UIYosIKEj0/F7JBlLELPCeUWLFpL0sIAlhAS+JFX8mgDWwCKhK
        nNy+AWwFr4CdxNrXN5gh1slLbP32iRXE5gSKL183nxmiRlDi5MwnYHOYgWqat84Gu0JCYBW7
        xO7Nx4Be4gByXCT2XraHmCMs8er4FqgXZCROT+5hgahfxyjxt+MFVPN2Ronlk/+xQVRZS9w5
        94sNZBCzgKbE+l36EGFHic0vtzNDzOeTuPFWEOIGPolJ26ZDhXklOtqEIKrVJDYs28AGs7Zr
        50qotzwk9p28yT6BUXEWkm9mIflmFsLeBYzMqxjFU0uLc9NTiw3zUsv1ihNzi0vz0vWS83M3
        MQJT0el/xz/tYPx6KekQowAHoxIPr0ZLTZwQa2JZcWXuIUYJDmYlEd6nkUAh3pTEyqrUovz4
        otKc1OJDjNIcLErivMaLXsYKCaQnlqRmp6YWpBbBZJk4OKUaGNd8DHy9zMDphta2qxovjNhv
        uudKJ6pUaOy+lZuUes9oie2iF6G8lf1aWq+szM9qK//1uJWwPO+XzwSPSedzH/QsO3BV8mLX
        hD6ffRteMv09rZq7tOSumn8ld8XlVsnJpdWHYg6tLI2VbbxxaF1Br6Xpaatuz2M+zhcmHjdO
        erDm7pXmhw81UpRYijMSDbWYi4oTAfcoMWZBAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsVy+t/xu7pGF2viDM79NrVYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6
        djYpqTmZZalF+nYJehkLt5xiLlggUzH11jWWBsYPYl2MnBwSAiYSpxo2sXYxcnEICSxllDh8
        7w6QwwGUkJE4vr4MokZY4s+1LjaImk+MEp/uT2EHSbAJWElMbF/FCGKLCChI9PxeCVbELPCV
        UWLppG5mkISwgJfEij8T2EBsFgFViZPbN4A18wrYSax9fYMZYoO8xNZvn1hBbE6g+PJ188Hi
        QgK2Eou/fGCCqBeUODnzCQuIzQxU37x1NvMERoFZSFKzkKQWMDKtYhRJLS3OTc8tNtQrTswt
        Ls1L10vOz93ECIyYbcd+bt7BeGlj8CFGAQ5GJR5ejZaaOCHWxLLiytxDjBIczEoivE8jgUK8
        KYmVValF+fFFpTmpxYcYTYGemMgsJZqcD4zmvJJ4Q1NDcwtLQ3Njc2MzCyVx3g6BgzFCAumJ
        JanZqakFqUUwfUwcnFINjFMXithZfb/tuq/w1exjnmeslU4XXWYvLn971OPlx1cl3K8mbp7V
        qX5YYtm+X/bR9nf+7szZ+3gh2/oTfc2f1Vg/6qWkRv/3sd/is+rJq/uvBFWtTLjaCx2+bD/x
        p/CzoM/vbDeFrwYsVr8yde8V7fSZf3nOw1mr7q9dXbTK8ceyCYy6JlfCO5SUWIozEg21mIuK
        EwGuO9fhrgIAAA==
X-CMS-MailID: 20200326155842eucas1p1aa92a260749305a13bebcd7999fd801b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200326155842eucas1p1aa92a260749305a13bebcd7999fd801b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200326155842eucas1p1aa92a260749305a13bebcd7999fd801b
References: <20200326155822.19400-1-b.zolnierkie@samsung.com>
        <CGME20200326155842eucas1p1aa92a260749305a13bebcd7999fd801b@eucas1p1.samsung.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

* fix the overly long line in ata_timing_quantize()

* use standard kernel CodingStyle in ata_timing_merge()

* do not use assignment in if condition in ata_timing_compute()

* fix non-standard comment style in ata_timing_compute()

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/libata-core.c | 42 +++++++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 2ec1a49388ee..acdcedcb3d10 100644
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

