Return-Path: <SRS0=qhS8=33=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF14C04EB5
	for <linux-ide@archiver.kernel.org>; Fri,  7 Feb 2020 14:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A732D214AF
	for <linux-ide@archiver.kernel.org>; Fri,  7 Feb 2020 14:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="kZKJhpAQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727717AbgBGO27 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 7 Feb 2020 09:28:59 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:49637 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727738AbgBGO17 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 7 Feb 2020 09:27:59 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200207142758euoutp028fadb280ed34f078fe14c1cdcd7c98f4~xJQwsxWTR2563925639euoutp02Q
        for <linux-ide@vger.kernel.org>; Fri,  7 Feb 2020 14:27:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200207142758euoutp028fadb280ed34f078fe14c1cdcd7c98f4~xJQwsxWTR2563925639euoutp02Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1581085678;
        bh=rpIqGmG3FR1ApDaZ1z178dL1/bSoAJvtXn5Yc3BJS5Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kZKJhpAQkYGvHBiHq77ySLLoX7WM7jTONrsjOMbGdR8Oqx43xeeOMCKGuVzfI89/H
         Onq/FeV2D85TznE7844q48H7hSolOC1pxbwZRGWecwzYLnbMWr2pNWga4dzn30OZBs
         /MKRQ8pOhF7GMsw+bpB7TuPa/mUeO0T/Bj1gu1Rw=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200207142758eucas1p146a3f96cab0e721649cf44d41732e350~xJQwdYBpo0217502175eucas1p1B;
        Fri,  7 Feb 2020 14:27:58 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 21.D8.60698.EE37D3E5; Fri,  7
        Feb 2020 14:27:58 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200207142757eucas1p29eda5a5ab29dc59ea88eb2b9770bc71e~xJQwDfgAG0220502205eucas1p2v;
        Fri,  7 Feb 2020 14:27:57 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200207142757eusmtrp16f9c53cbd6d7805231ceb582c30f1e3e~xJQwC8Rqo0480004800eusmtrp1M;
        Fri,  7 Feb 2020 14:27:57 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-c3-5e3d73ee765e
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 4D.89.08375.DE37D3E5; Fri,  7
        Feb 2020 14:27:57 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200207142757eusmtip2ffee59d1780b106026a01c08e19f8ed8~xJQvfHI2j2997829978eusmtip2L;
        Fri,  7 Feb 2020 14:27:57 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH v2 13/26] ata: let compiler optimize out
 ata_dev_config_ncq() on non-SATA hosts
Date:   Fri,  7 Feb 2020 15:27:21 +0100
Message-Id: <20200207142734.8431-14-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200207142734.8431-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNKsWRmVeSWpSXmKPExsWy7djPc7rvim3jDP7dZLZYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRXDYpqTmZZalF+nYJXBmLlwQUfGSv2Ps8u4FxHlsXIyeHhICJ
        xKbbe1i6GLk4hARWMEo0PvnFCuF8YZRY9+IRI0iVkMBnRokVR+thOlbM62KCiC9nlDh0TROu
        of3QFbCxbAJWEhPbV4E1iwgoSPT8XskGUsQs8B5o0KS9LCAJYYFEiZfbDoBNYhFQlWh6/AvM
        5hWwldi7rZsRYpu8xNZvn1hBbE6g+Mcpf9kgagQlTs58AjaHGaimeetsZpAFEgKL2CX+PX7K
        DtHsInFy0h0oW1ji1fEtULaMxOnJPSwQDesYJf52vIDq3s4osXzyP2jQWEvcOfcLyOYAWqEp
        sX6XPkTYUWLe42MsIGEJAT6JG28FIY7gk5i0bTozRJhXoqNNCKJaTWLDsg1sMGu7dq5khrA9
        JCZseMM+gVFxFpJ3ZiF5ZxbC3gWMzKsYxVNLi3PTU4uN81LL9YoTc4tL89L1kvNzNzECk9Dp
        f8e/7mDc9yfpEKMAB6MSD2+Co02cEGtiWXFl7iFGCQ5mJRHePlXbOCHelMTKqtSi/Pii0pzU
        4kOM0hwsSuK8xotexgoJpCeWpGanphakFsFkmTg4pRoYc05qXj0T5mG49t6uC/ZeT2ezMsan
        PdG8IanTvjhvgcjKr2K9PeFf3107X1K/ZsbnSZkv0izXrEs6ubv6xusd0gbCz268XVsrPY35
        TPeh/OOWbe3pdtySbYfZHsQfd1+y4lOV0pa4J5XPd64z1Yz/u+DTy4zpYi1GduJbr9ke1/x1
        PXrDefVzt5VYijMSDbWYi4oTAWdDJm0+AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRmVeSWpSXmKPExsVy+t/xe7pvi23jDFZfUbVYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6
        djYpqTmZZalF+nYJehmLlwQUfGSv2Ps8u4FxHlsXIyeHhICJxIp5XUwgtpDAUkaJS/cLuhg5
        gOIyEsfXl0GUCEv8udYFVM4FVPKJUWLWorksIAk2ASuJie2rGEFsEQEFiZ7fK8GKmAW+Mkos
        ndTNDJIQFoiXePvqCtgyFgFViabHv8CW8QrYSuzd1s0IsUFeYuu3T6wgNidQ/OOUv2wQB9lI
        fH8/iR2iXlDi5MwnYIuZgeqbt85mnsAoMAtJahaS1AJGplWMIqmlxbnpucWGesWJucWleel6
        yfm5mxiBsbLt2M/NOxgvbQw+xCjAwajEw5vgaBMnxJpYVlyZe4hRgoNZSYS3T9U2Tog3JbGy
        KrUoP76oNCe1+BCjKdATE5mlRJPzgXGcVxJvaGpobmFpaG5sbmxmoSTO2yFwMEZIID2xJDU7
        NbUgtQimj4mDU6qBMex1zCKrHKPMtR7KC42nMIs7y9lGnvx96rVwo/7+o79n77Wf+tesRm/W
        BeWd28z+eV0K77krnSFt6RT5Xrj3VI+ZPsNyh4CMcm7Wi0sVQ9fp1DQsYtrBdrxAku3Ohfva
        XxK0xNbs0tP6zmIrvnXxOZFq0eBuQU/uKR+85zMp1hvN/SuifltHiaU4I9FQi7moOBEAYNzU
        06sCAAA=
X-CMS-MailID: 20200207142757eucas1p29eda5a5ab29dc59ea88eb2b9770bc71e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200207142757eucas1p29eda5a5ab29dc59ea88eb2b9770bc71e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200207142757eucas1p29eda5a5ab29dc59ea88eb2b9770bc71e
References: <20200207142734.8431-1-b.zolnierkie@samsung.com>
        <CGME20200207142757eucas1p29eda5a5ab29dc59ea88eb2b9770bc71e@eucas1p2.samsung.com>
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
index 408dee580f24..73727a7f295b 100644
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

