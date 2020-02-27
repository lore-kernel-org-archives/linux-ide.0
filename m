Return-Path: <SRS0=ljer=4P=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A69C11D3D
	for <linux-ide@archiver.kernel.org>; Thu, 27 Feb 2020 18:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECB39246A6
	for <linux-ide@archiver.kernel.org>; Thu, 27 Feb 2020 18:24:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="aqC01Nj6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729955AbgB0SYM (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 27 Feb 2020 13:24:12 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:39703 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730934AbgB0SWq (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 27 Feb 2020 13:22:46 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200227182245euoutp01967b9c02fdb06fcedac446f479384a66~3VXdVyEii1058810588euoutp01D
        for <linux-ide@vger.kernel.org>; Thu, 27 Feb 2020 18:22:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200227182245euoutp01967b9c02fdb06fcedac446f479384a66~3VXdVyEii1058810588euoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1582827765;
        bh=cJKTgNSJbDoQZHyeL1x+FdaJUqVKgMmO2qQKsp7fgTM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aqC01Nj668ZWukuVExCIKyrDN7eWGXlJqSaAuMJyN49ollKcxbWgNqMWpdxXlbl6g
         /YwjJRjuSM2ku9Z8szk57Mzh6KGFSaLOJwv/4fo2AVsHCop7HOFYP9f241iLVpw7lw
         XzowZZQ4gmV3NyYLvxcjZ3gt1LfeAd8E+MneVuWk=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200227182244eucas1p18fab46c4dfe4899bf4b895e11ff29083~3VXdAa7CG1308213082eucas1p16;
        Thu, 27 Feb 2020 18:22:44 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 58.05.60698.4F8085E5; Thu, 27
        Feb 2020 18:22:44 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200227182244eucas1p1e8e9e9567acda2a8cd02844685b6b12a~3VXcgCyUH0931609316eucas1p1C;
        Thu, 27 Feb 2020 18:22:44 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200227182244eusmtrp28c92a4b30c01416be6d4fb4a1f6e0e11~3VXcfhAqy1813218132eusmtrp2o;
        Thu, 27 Feb 2020 18:22:44 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-ff-5e5808f42d1a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 7F.B1.08375.4F8085E5; Thu, 27
        Feb 2020 18:22:44 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200227182243eusmtip241b5fea44ecd07f9f482402b97e2697b~3VXb-FQpT1203512035eusmtip2O;
        Thu, 27 Feb 2020 18:22:43 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH v3 11/27] ata: fix CodingStyle issues in PATA timings code
Date:   Thu, 27 Feb 2020 19:22:10 +0100
Message-Id: <20200227182226.19188-12-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200227182226.19188-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHKsWRmVeSWpSXmKPExsWy7djP87pfOCLiDF42aVisvtvPZrFxxnpW
        i2e39jJZrFx9lMni2I5HTBaXd81hs1j+ZC2zxdzW6ewOHB47Z91l97h8ttTj0OEORo+Trd9Y
        PHbfbGDz6NuyitHj8ya5APYoLpuU1JzMstQifbsErowLj18wFXyWrlh7fg1LA+MJsS5GTg4J
        AROJy89fMHYxcnEICaxglDj06wQzhPOFUeLYgRNsEM5nRom2lp2sMC2NzxdBJZYzSlzY1MwG
        19J1dDJYFZuAlcTE9lWMILaIgIJEz++VYEXMAu8ZJVZM2ssCkhAW8JI4MncSO4jNIqAq8Xrp
        aWYQm1fATmLHhfWMEOvkJbZ++wQ2lBMofqNvOxtEjaDEyZlPwOYwA9U0b50NdriEwCp2ie6D
        R4AcDiDHReLWpnyIOcISr45vYYewZST+75zPBFG/jlHib8cLqObtjBLLJ/9jg6iylrhz7hcb
        yCBmAU2J9bv0IcKOEq2TZjFBzOeTuPFWEOIGPolJ26ZDreWV6GgTgqhWk9iwbAMbzNqunSuZ
        IWwPia3r1jFPYFScheSbWUi+mYWwdwEj8ypG8dTS4tz01GLjvNRyveLE3OLSvHS95PzcTYzA
        VHT63/GvOxj3/Uk6xCjAwajEw7tgR3icEGtiWXFl7iFGCQ5mJRHejV9D44R4UxIrq1KL8uOL
        SnNSiw8xSnOwKInzGi96GSskkJ5YkpqdmlqQWgSTZeLglGpgXK3P4S0W1bc354NYX+zVysUN
        F8J3921yP6Z3RivbWP+4isfPZfaa0b/E2W237Y774xv6eve3xgMtV8KeP9flFXyyKPvkQe7G
        hSY7r8d+qZbs3ttV92LC2q45thbutstfRvP+my4e+dq+puqHnt0Km5U75m999+nJwjc3Hhnd
        XvNq8X2Jpkne25VYijMSDbWYi4oTAUwabUlBAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsVy+t/xe7pfOCLiDO5cZLZYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6
        djYpqTmZZalF+nYJehkXHr9gKvgsXbH2/BqWBsYTYl2MnBwSAiYSjc8XsXUxcnEICSxllJjw
        oYWxi5EDKCEjcXx9GUSNsMSfa11QNZ8YJb7sv8MMkmATsJKY2L6KEcQWEVCQ6Pm9EqyIWeAr
        o8TSSd1gRcICXhJH5k5iB7FZBFQlXi89DRbnFbCT2HFhPSPEBnmJrd8+sYLYnEDxG33b2UBs
        IQFbia6Op4wQ9YISJ2c+YQGxmYHqm7fOZp7AKDALSWoWktQCRqZVjCKppcW56bnFhnrFibnF
        pXnpesn5uZsYgRGz7djPzTsYL20MPsQowMGoxMO7YEd4nBBrYllxZe4hRgkOZiUR3o1fQ+OE
        eFMSK6tSi/Lji0pzUosPMZoCPTGRWUo0OR8YzXkl8YamhuYWlobmxubGZhZK4rwdAgdjhATS
        E0tSs1NTC1KLYPqYODilGhh7Z+0+9m6T1wrHPZq2k69P9S1/uP/aeQGnxFSWb0cdnz+tK1jz
        fv2if4lXvJP51vdem1DJblrazXxDZ8Y1CZ8L7OZ+8wIub/z8lWvBrhC1uTk250wuaKmwicvn
        Ppe6svu5VQ3f0Wi+Ktk/Z/Vj5+ZJiJ8+75YxPyLGI7l49eZ/izwuRf09IPZCiaU4I9FQi7mo
        OBEAbr2rsK4CAAA=
X-CMS-MailID: 20200227182244eucas1p1e8e9e9567acda2a8cd02844685b6b12a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200227182244eucas1p1e8e9e9567acda2a8cd02844685b6b12a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200227182244eucas1p1e8e9e9567acda2a8cd02844685b6b12a
References: <20200227182226.19188-1-b.zolnierkie@samsung.com>
        <CGME20200227182244eucas1p1e8e9e9567acda2a8cd02844685b6b12a@eucas1p1.samsung.com>
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

