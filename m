Return-Path: <SRS0=dw68=3R=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7EF7C33CB3
	for <linux-ide@archiver.kernel.org>; Tue, 28 Jan 2020 13:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 997B324688
	for <linux-ide@archiver.kernel.org>; Tue, 28 Jan 2020 13:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="szMC7Ogm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgA1Nfr (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 28 Jan 2020 08:35:47 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:52331 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbgA1NeO (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 28 Jan 2020 08:34:14 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200128133413euoutp0278a81fec2ff2920713de7184775a2108~uEE_QQX802801628016euoutp02j
        for <linux-ide@vger.kernel.org>; Tue, 28 Jan 2020 13:34:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200128133413euoutp0278a81fec2ff2920713de7184775a2108~uEE_QQX802801628016euoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1580218453;
        bh=CoO3uiXQ9SOoUC43gpkI/o0SgbiP9y/CoSgqKowqa3M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=szMC7OgmtfTTzgt3op3Y0wZ8+1sAcQsJ4E2yeGIKVsekHiPkLaRlPBXEvaU8KyiEe
         cuVa4kr+2ux0pjg8/9K1wFuX8n7c8FC0JGTmbjk7dIDPIGK1lcrRPJarO6CXI9ebZQ
         aBEiN/C3l+oLQhEp62MCpmX1tKtGs/GeOKAqIrbg=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200128133412eucas1p1896acbca8bfb3ba2090734f7825d62ed~uEE_B4pHu0089200892eucas1p1y;
        Tue, 28 Jan 2020 13:34:12 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 96.DA.60698.458303E5; Tue, 28
        Jan 2020 13:34:12 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200128133412eucas1p258499338146481964e4c26ad3f1cbf14~uEE9hqm013204732047eucas1p2f;
        Tue, 28 Jan 2020 13:34:12 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200128133412eusmtrp250c08a0fc887bbe60db7c9134559c4d9~uEE9hGtEL0330103301eusmtrp2p;
        Tue, 28 Jan 2020 13:34:12 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-b1-5e3038544e75
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id FF.82.08375.458303E5; Tue, 28
        Jan 2020 13:34:12 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200128133411eusmtip20d9d3abfd59d6c33039f4b30c9b0e99e~uEE9Jc1Yr0657406574eusmtip2b;
        Tue, 28 Jan 2020 13:34:11 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH 05/28] ata: simplify ata_scsiop_inq_89()
Date:   Tue, 28 Jan 2020 14:33:20 +0100
Message-Id: <20200128133343.29905-6-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200128133343.29905-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBKsWRmVeSWpSXmKPExsWy7djPc7ohFgZxBhefG1isvtvPZrFxxnpW
        i2e39jJZHNvxiMni8q45bBZzW6ezO7B57Jx1l93j8tlSj0OHOxg9+rasYvT4vEkugDWKyyYl
        NSezLLVI3y6BK+P0lg/sBfP4K040LGZuYPzG3cXIySEhYCLx48Ztxi5GLg4hgRWMEuf3HGWB
        cL4wSvyd9ocdwvnMKLFr4VV2mJZr7TuYIRLLGSWePjvACtdybtYEFpAqNgEriYntqxhBbBEB
        BYme3yvZQIqYBdYwSqw63ASWEBawkNh54zRQgoODRUBV4tf+GJAwr4CtxP33L6G2yUts/faJ
        FaSEU8BOomevOUSJoMTJmU/AVjEDlTRvnQ12kIRAO7vExQ/3mSF6XST2nXzCBGELS7w6vgVq
        pozE/53zmSAa1gH92fECqns7o8Tyyf/YIKqsJe6c+wV2HLOApsT6XfogpoSAo8TR+6wQJp/E
        jbeCEDfwSUzaNp0ZIswr0dEmBDFDTWLDsg1sMFu7dq6EusxDYuOO26wTGBVnIflmFpJvZiGs
        XcDIvIpRPLW0ODc9tdg4L7Vcrzgxt7g0L10vOT93EyMwvZz+d/zrDsZ9f5IOMQpwMCrx8Doo
        GcQJsSaWFVfmHmKU4GBWEuHtZAIK8aYkVlalFuXHF5XmpBYfYpTmYFES5zVe9DJWSCA9sSQ1
        OzW1ILUIJsvEwSnVwCi0Te5BSnCxvZG91lE2ft4YQeW13ScDZr/skzVp0W8MNJDRe1AbsfQ+
        +5Pr997sSl32PYlLUPTT6vIZvxc4eqrnPJl/edVRnu2J9woqBc0aDgflfTefeuG/0Pb8UIn+
        Js0ve8q3zTo0X0A989V1b4fuVdbbPtU3PjtdwjAjJ1P+w/k9dk4Cq5RYijMSDbWYi4oTAXsK
        6FMrAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplkeLIzCtJLcpLzFFi42I5/e/4Pd0QC4M4gwXbBS1W3+1ns9g4Yz2r
        xbNbe5ksju14xGRxedccNou5rdPZHdg8ds66y+5x+Wypx6HDHYwefVtWMXp83iQXwBqlZ1OU
        X1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5egl3F6ywf2gnn8
        FScaFjM3MH7j7mLk5JAQMJG41r6DuYuRi0NIYCmjxI3W/axdjBxACRmJ4+vLIGqEJf5c62KD
        qPnEKDHrzllWkASbgJXExPZVjCC2iICCRM/vlWBFzAIbGCVe3fzCApIQFrCQ2HnjNBvIUBYB
        VYlf+2NAwrwCthL3379kh1ggL7H12yewvZwCdhI9e81BwkJAJevPPGWFKBeUODnzCdhEZqDy
        5q2zmScwCsxCkpqFJLWAkWkVo0hqaXFuem6xoV5xYm5xaV66XnJ+7iZGYBRsO/Zz8w7GSxuD
        DzEKcDAq8fDOUDGIE2JNLCuuzD3EKMHBrCTC28kEFOJNSaysSi3Kjy8qzUktPsRoCvTCRGYp
        0eR8YITmlcQbmhqaW1gamhubG5tZKInzdggcjBESSE8sSc1OTS1ILYLpY+LglGpgDDt2v6g7
        SffDejFNqW9LImdorZe1PJasUveALdumfcEy96OPt+ZYZr4X5TCT5n3mYHtHRVQue27giVvv
        7jFP+5ycwVZzQNBwr7eatGfJppc3o3WdlZRzXZZtCkuSmv5y7ZUVt9O4O5l4N0c65J2dkrA6
        RzO4UHrryTgzp+bpOi/fPs/z8GtVYinOSDTUYi4qTgQAgKB+xpgCAAA=
X-CMS-MailID: 20200128133412eucas1p258499338146481964e4c26ad3f1cbf14
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200128133412eucas1p258499338146481964e4c26ad3f1cbf14
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200128133412eucas1p258499338146481964e4c26ad3f1cbf14
References: <20200128133343.29905-1-b.zolnierkie@samsung.com>
        <CGME20200128133412eucas1p258499338146481964e4c26ad3f1cbf14@eucas1p2.samsung.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Initialize rbuf[] directly instead of using ata_tf_to_fis(). This
results in simpler and smaller code. It also allows separating
ata_tf_to_fis() into SATA specific libata part in the future.

Code size savings on m68k arch using atari_defconfig:

   text    data     bss     dec     hex filename
before:
  20824     105    4096   25025    61c1 drivers/ata/libata-scsi.o
after:
  20782     105    4096   24983    6197 drivers/ata/libata-scsi.o

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/libata-scsi.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 161e5d84bd82..cc8ba49275e7 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2356,10 +2356,6 @@ static unsigned int ata_scsiop_inq_83(struct ata_scsi_args *args, u8 *rbuf)
  */
 static unsigned int ata_scsiop_inq_89(struct ata_scsi_args *args, u8 *rbuf)
 {
-	struct ata_taskfile tf;
-
-	memset(&tf, 0, sizeof(tf));
-
 	rbuf[1] = 0x89;			/* our page code */
 	rbuf[2] = (0x238 >> 8);		/* page size fixed at 238h */
 	rbuf[3] = (0x238 & 0xff);
@@ -2368,14 +2364,14 @@ static unsigned int ata_scsiop_inq_89(struct ata_scsi_args *args, u8 *rbuf)
 	memcpy(&rbuf[16], "libata          ", 16);
 	memcpy(&rbuf[32], DRV_VERSION, 4);
 
-	/* we don't store the ATA device signature, so we fake it */
-
-	tf.command = ATA_DRDY;		/* really, this is Status reg */
-	tf.lbal = 0x1;
-	tf.nsect = 0x1;
-
-	ata_tf_to_fis(&tf, 0, 1, &rbuf[36]);	/* TODO: PMP? */
 	rbuf[36] = 0x34;		/* force D2H Reg FIS (34h) */
+	rbuf[37] = (1 << 7);		/* bit 7 indicates Command FIS */
+					/* TODO: PMP? */
+
+	/* we don't store the ATA device signature, so we fake it */
+	rbuf[38] = ATA_DRDY;		/* really, this is Status reg */
+	rbuf[40] = 0x1;
+	rbuf[48] = 0x1;
 
 	rbuf[56] = ATA_CMD_ID_ATA;
 
-- 
2.24.1

