Return-Path: <SRS0=qhS8=33=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68AB0C35242
	for <linux-ide@archiver.kernel.org>; Fri,  7 Feb 2020 14:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35C5820838
	for <linux-ide@archiver.kernel.org>; Fri,  7 Feb 2020 14:29:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="QsOGyLt/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbgBGO3d (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 7 Feb 2020 09:29:33 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:59591 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727649AbgBGO14 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 7 Feb 2020 09:27:56 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200207142754euoutp0103ba3ea4e67f90f5faa88057c01eb17c~xJQs8VRRx2124721247euoutp01z
        for <linux-ide@vger.kernel.org>; Fri,  7 Feb 2020 14:27:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200207142754euoutp0103ba3ea4e67f90f5faa88057c01eb17c~xJQs8VRRx2124721247euoutp01z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1581085674;
        bh=Q/sdW1GzpO3lfP/7UDJtkNbSsnuksj8skfPe8g7FvUI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QsOGyLt/Vrd/hygb64qaSfV52qQu2xVdbNAecBSQfWXeLiCdPRrmD2IrggmP/h+7I
         0ITDJxvtYz2X6ctEyoFAfhg86PPlMkYrTDLbTMw2an1hbvXJpKvrvDqOEXbiyOMP+p
         OKxmzVoKgHYZXBbOZUAOBkASXov5khMsbCXGmTvU=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200207142754eucas1p11215543b82fc11d13ff6b9fcb9727ee9~xJQso1lCN2844428444eucas1p1c;
        Fri,  7 Feb 2020 14:27:54 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 2E.C8.60698.9E37D3E5; Fri,  7
        Feb 2020 14:27:53 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200207142753eucas1p14a54d1ac2335ec3e9ad66eb6b299fd76~xJQsUGcqy2644726447eucas1p15;
        Fri,  7 Feb 2020 14:27:53 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200207142753eusmtrp173b41494bcf29f194b11d8467ad8f064~xJQsTgeYq0480004800eusmtrp1_;
        Fri,  7 Feb 2020 14:27:53 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-b6-5e3d73e97a59
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id F8.89.08375.9E37D3E5; Fri,  7
        Feb 2020 14:27:53 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200207142753eusmtip264f5c74cca090ca71e25dff81439e29a~xJQrzpJ9i2997829978eusmtip2H;
        Fri,  7 Feb 2020 14:27:53 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH v2 05/26] ata: simplify ata_scsiop_inq_89()
Date:   Fri,  7 Feb 2020 15:27:13 +0100
Message-Id: <20200207142734.8431-6-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200207142734.8431-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNKsWRmVeSWpSXmKPExsWy7djP87ovi23jDCb9tbJYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRXDYpqTmZZalF+nYJXBlXpl9mL7jGX9FxrrSBcQVPFyMHh4SA
        icSKsyxdjFwcQgIrGCWW7ZrNCuF8YZRYNPE4E4TzmVHiafsPZpiOC7/LIeLLGSVaPq1lhOv4
        e+EZUBEnB5uAlcTE9lWMILaIgIJEz++VbCBFzALvGSVWTNrLApIQFrCW6FrxBKyBRUBV4tP6
        16wgNq+AjcT+Z7eZQGwJAXmJrd8+gcU5BWwlPk75ywZRIyhxcuYTsDnMQDXNW2czgyyQEFjG
        LvF8/hM2iGYXiZ6d91khbGGJV8e3sEPYMhKnJ/ewQDSsAzq74wVU93ZGieWT/0F1W0vcOfeL
        DeRpZgFNifW79CHCjhJLf25lgoQFn8SNt4IQR/BJTNo2HRpEvBIdbUIQ1WoSG5ZtYINZ27Vz
        JVSJh8TWF3oTGBVnIflmFpJvZiGsXcDIvIpRPLW0ODc9tdg4L7Vcrzgxt7g0L10vOT93EyMw
        CZ3+d/zrDsZ9f5IOMQpwMCrx8CY42sQJsSaWFVfmHmKU4GBWEuHtU7WNE+JNSaysSi3Kjy8q
        zUktPsQozcGiJM5rvOhlrJBAemJJanZqakFqEUyWiYNTqoFRP+j/oyDD6JBuz2n22vuZ/J4H
        zLVxStzw/LLX6TltLjvcf09p5rv5Yb/th66lR57rF/M/+VapZ8LiqDyr0rbP0MJysv2UGXuW
        zX738dcS3kb1yw2eXrP0TZ/saUzPPtS8RH6HUbRfkYTpv8+7hZuSUtaruj/jvahQ8f3ngbKH
        b6dM9cgxTnVTYinOSDTUYi4qTgQATAMrbD4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsVy+t/xe7ovi23jDLqOqVisvtvPZrFxxnpW
        i2e39jJZrFx9lMni2I5HTBaXd81hs1j+ZC2zxdzW6ewOHB47Z91l97h8ttTj0OEORo+Trd9Y
        PHbfbGDz6NuyitHj8ya5APYoPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9
        O5uU1JzMstQifbsEvYwr0y+zF1zjr+g4V9rAuIKni5GDQ0LAROLC7/IuRi4OIYGljBLvzqxm
        gojLSBxfX9bFyAlkCkv8udbFBlHziVHizeIeVpAEm4CVxMT2VYwgtoiAgkTP75VgRcwCXxkl
        lk7qZgZJCAtYS3SteAJmswioSnxa/xqsmVfARmL/s9tMEBvkJbZ++wQW5xSwlfg45S8biC0E
        VPP9/SR2iHpBiZMzn7CA2MxA9c1bZzNPYBSYhSQ1C0lqASPTKkaR1NLi3PTcYkO94sTc4tK8
        dL3k/NxNjMBo2Xbs5+YdjJc2Bh9iFOBgVOLhTXC0iRNiTSwrrsw9xCjBwawkwtunahsnxJuS
        WFmVWpQfX1Sak1p8iNEU6ImJzFKiyfnASM4riTc0NTS3sDQ0NzY3NrNQEuftEDgYIySQnliS
        mp2aWpBaBNPHxMEp1cAoFjafp7owjbvZ/ePmErG3D9b8UXsllDPBV+tneo/MPVumwikTVLoX
        maVWpsZ5ep57K6P4hC908+QXiU92Pzi0T3r9jcJfptY/Ekut/8o67bCyWiL+uFS7cteizRE9
        03/12bB9Cl5be/H7us8Ktac0qj7ofKwtWNW20f8J86n55sE9fEsU2d4psRRnJBpqMRcVJwIA
        nxyOqKwCAAA=
X-CMS-MailID: 20200207142753eucas1p14a54d1ac2335ec3e9ad66eb6b299fd76
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200207142753eucas1p14a54d1ac2335ec3e9ad66eb6b299fd76
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200207142753eucas1p14a54d1ac2335ec3e9ad66eb6b299fd76
References: <20200207142734.8431-1-b.zolnierkie@samsung.com>
        <CGME20200207142753eucas1p14a54d1ac2335ec3e9ad66eb6b299fd76@eucas1p1.samsung.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Initialize rbuf[] directly instead of using ata_tf_to_fis(). This
results in simpler and smaller code. It also allows separating
ata_tf_to_fis() into SATA specific libata part in the future.

Code size savings on m68k arch using (modified) atari_defconfig:

   text    data     bss     dec     hex filename
before:
  20824     105    4096   25025    61c1 drivers/ata/libata-scsi.o
after:
  20782     105    4096   24983    6197 drivers/ata/libata-scsi.o

Reviewed-by: Christoph Hellwig <hch@lst.de>
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

