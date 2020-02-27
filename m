Return-Path: <SRS0=ljer=4P=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 749FEC11D3D
	for <linux-ide@archiver.kernel.org>; Thu, 27 Feb 2020 18:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50617246AD
	for <linux-ide@archiver.kernel.org>; Thu, 27 Feb 2020 18:23:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="sLdbj47s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729819AbgB0SXr (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 27 Feb 2020 13:23:47 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:59112 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730957AbgB0SWr (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 27 Feb 2020 13:22:47 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200227182246euoutp020c133933b3ffa27290f43438ff4993b2~3VXek3n-l0671406714euoutp02u
        for <linux-ide@vger.kernel.org>; Thu, 27 Feb 2020 18:22:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200227182246euoutp020c133933b3ffa27290f43438ff4993b2~3VXek3n-l0671406714euoutp02u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1582827766;
        bh=nVgKq7i5digEzGJhG6sYc3kv/LyJ4jBHJMQolppTodE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sLdbj47s26g00ET00RRh1ARMeWRkkw715Ig9b0kYLxEEAOdUj/OZtAnLK7Zp7Pt/8
         zX+SzfvKPuw9X+GyuUmtP2kbXJ+gnYGyLpdC79pzuh7OMNL8PVva+bhY/I+GVc+lwn
         vJ+35M17CEQjvSHSJABdPLnCd9BVk5lskyyo1+IY=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200227182246eucas1p176a11782ded9f0adc01bb9e984a21901~3VXeT3v9Q1937419374eucas1p16;
        Thu, 27 Feb 2020 18:22:46 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id E8.05.60698.6F8085E5; Thu, 27
        Feb 2020 18:22:46 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200227182245eucas1p22d7a52d7786fc8cdfa4dc898662ef087~3VXdz4VfI1553915539eucas1p2x;
        Thu, 27 Feb 2020 18:22:45 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200227182245eusmtrp1cd3979764d3bf312398e55ef0e48db18~3VXdzOXiE0110301103eusmtrp1d;
        Thu, 27 Feb 2020 18:22:45 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-00-5e5808f6327f
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 94.61.07950.5F8085E5; Thu, 27
        Feb 2020 18:22:45 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200227182245eusmtip233c90d1f0834e975d060d506d7d5791f~3VXdUiBaA3109031090eusmtip2s;
        Thu, 27 Feb 2020 18:22:45 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH v3 14/27] ata: let compiler optimize out
 ata_dev_config_ncq() on non-SATA hosts
Date:   Thu, 27 Feb 2020 19:22:13 +0100
Message-Id: <20200227182226.19188-15-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200227182226.19188-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHKsWRmVeSWpSXmKPExsWy7djP87rfOCLiDP6uZLFYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRXDYpqTmZZalF+nYJXBnXVzUxFXxkrzj56xNLA+M8ti5GTg4J
        AROJLx8+MncxcnEICaxglFh+t5UNwvnCKLHj2AxGCOczo8Tz9TfgWuY9/cEEkVjOKLHk23xW
        uJY5e2+BVbEJWElMbF/FCGKLCChI9PxeCTaXWeA9o8SKSXtZQBLCAokSLc9fghWxCKhKPOrr
        YAaxeQXsJM5dO8kIsU5eYuu3T6wgNidQ/EbfdjaIGkGJkzOfgM1hBqpp3job7AsJgVXsElc/
        nGaCaHaRaNl6AmqQsMSr41vYIWwZidOTe1ggGtYxSvzteAHVvR0YBpP/QX1qLXHn3C8gmwNo
        habE+l36EGFHiZu3Z7KDhCUE+CRuvBWEOIJPYtK26cwQYV6JjjYhiGo1iQ3LNrDBrO3auRKq
        xENiT0PCBEbFWUi+mYXkm1kIaxcwMq9iFE8tLc5NTy02zkst1ytOzC0uzUvXS87P3cQITEWn
        /x3/uoNx35+kQ4wCHIxKPLwLdoTHCbEmlhVX5h5ilOBgVhLh3fg1NE6INyWxsiq1KD++qDQn
        tfgQozQHi5I4r/Gil7FCAumJJanZqakFqUUwWSYOTqkGRjsW1+UBVnYRIsw1vz6tKFr3ue4H
        w4t9j6I8HR5J+u9/Pdvla2bQ9ls1wnOLfvRZnvu+8ehm05XXDy56bvVDOFasTjmi8ccas2fP
        ntv/Uut4MeFdpfLxcnWWQ35VIpNny/3aYxaqfupjw/9b8282HK241pFie75OeUa4xGPJiVJ7
        2mLz93/KZlNiKc5INNRiLipOBAAvcs3aQQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsVy+t/xe7pfOSLiDM5tVbBYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6
        djYpqTmZZalF+nYJehnXVzUxFXxkrzj56xNLA+M8ti5GTg4JAROJeU9/MHUxcnEICSxllNhy
        ZwNQggMoISNxfH0ZRI2wxJ9rXWwQNZ8YJV4v2csKkmATsJKY2L6KEcQWEVCQ6Pm9EqyIWeAr
        o8TSSd3MIAlhgXiJ9w+fgjWwCKhKPOrrAIvzCthJnLt2khFig7zE1m+fwGo4geI3+raDXSck
        YCvR1fGUEaJeUOLkzCcsIDYzUH3z1tnMExgFZiFJzUKSWsDItIpRJLW0ODc9t9hIrzgxt7g0
        L10vOT93EyMwYrYd+7llB2PXu+BDjAIcjEo8vB7bwuOEWBPLiitzDzFKcDArifBu/BoaJ8Sb
        klhZlVqUH19UmpNafIjRFOiJicxSosn5wGjOK4k3NDU0t7A0NDc2NzazUBLn7RA4GCMkkJ5Y
        kpqdmlqQWgTTx8TBKdXAaP714w6HrOSPb+b2Hc8U857zd+XNqWsYHnzK6/rfyqT75N+La3yS
        23umzlqtmjnTw1XnyWSrpVZmM/SNSzYfb/8Ss+jjrJRnJn7XuRKXbbp87uNupZ5PygIHLJ1/
        iXm7raw5FeU0YWb+7gO151cv37Pu94n+b7ztxnp3M86a6O+/JXi+qVCp6pESS3FGoqEWc1Fx
        IgCHHP4mrgIAAA==
X-CMS-MailID: 20200227182245eucas1p22d7a52d7786fc8cdfa4dc898662ef087
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200227182245eucas1p22d7a52d7786fc8cdfa4dc898662ef087
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200227182245eucas1p22d7a52d7786fc8cdfa4dc898662ef087
References: <20200227182226.19188-1-b.zolnierkie@samsung.com>
        <CGME20200227182245eucas1p22d7a52d7786fc8cdfa4dc898662ef087@eucas1p2.samsung.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Add !IS_ENABLED(CONFIG_SATA_HOST) to ata_dev_config_ncq() to allow
compiler to optimize out the function for non-SATA configs.

Code size savings on m68k arch using (modified) atari_defconfig:

   text    data     bss     dec     hex filename
before:
  37582     572      40   38194    9532 drivers/ata/libata-core.o
after:
  36462     572      40   37074    90d2 drivers/ata/libata-core.o

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/libata-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 0a56968e2e98..dcdb7fb46dbd 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2287,6 +2287,8 @@ static int ata_dev_config_ncq(struct ata_device *dev,
 		desc[0] = '\0';
 		return 0;
 	}
+	if (!IS_ENABLED(CONFIG_SATA_HOST))
+		return 0;
 	if (dev->horkage & ATA_HORKAGE_NONCQ) {
 		snprintf(desc, desc_sz, "NCQ (not used)");
 		return 0;
-- 
2.24.1

