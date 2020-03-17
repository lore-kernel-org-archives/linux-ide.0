Return-Path: <SRS0=AjNr=5C=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E189C18E5B
	for <linux-ide@archiver.kernel.org>; Tue, 17 Mar 2020 14:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1142205ED
	for <linux-ide@archiver.kernel.org>; Tue, 17 Mar 2020 14:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="LIxLeR+F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgCQOpV (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 17 Mar 2020 10:45:21 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:40368 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbgCQOnp (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 17 Mar 2020 10:43:45 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200317144344euoutp02939dcddc1ec877c6f0567d801d913b83~9HoqG8alQ1583015830euoutp022
        for <linux-ide@vger.kernel.org>; Tue, 17 Mar 2020 14:43:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200317144344euoutp02939dcddc1ec877c6f0567d801d913b83~9HoqG8alQ1583015830euoutp022
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1584456224;
        bh=ZLC1RjnwuwfcgR6tUnpiv/m8KrZ8t3tzSCuOcP6lX18=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LIxLeR+FbqINi5rFaQmI7V3GONEp8D+8+Bx0d63oonDC2ha6YNqjb0i+kBmVoEVOl
         K0YvGgyF6G2C2Y9ta1qhWz9u7Rx0iFwhZ/ZFJXqfSou+wI8TiLUmGr6dhjmyBQsYN6
         sUJDShOvD0BiPYL9pm+CAFBsKUy21GfibEU4y6AA=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200317144343eucas1p29297af2462b214e099ba094c8a401f6f~9Hop2IKvP2986029860eucas1p2l;
        Tue, 17 Mar 2020 14:43:43 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 1C.D3.61286.F12E07E5; Tue, 17
        Mar 2020 14:43:43 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200317144343eucas1p2aeb55b3deca6702b7c7128fe7775b708~9HopSe-0U0133401334eucas1p2Z;
        Tue, 17 Mar 2020 14:43:43 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200317144343eusmtrp295a1d2ea75544007f2d862055b3ff322~9HopRuaRG0146401464eusmtrp2D;
        Tue, 17 Mar 2020 14:43:43 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-21-5e70e21ff174
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 3A.D4.08375.F12E07E5; Tue, 17
        Mar 2020 14:43:43 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200317144342eusmtip1c26064d6f736c7f936098d5036deaf1c~9Hoo2OKXv0973309733eusmtip1S;
        Tue, 17 Mar 2020 14:43:42 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH v4 05/27] ata: simplify ata_scsiop_inq_89()
Date:   Tue, 17 Mar 2020 15:43:11 +0100
Message-Id: <20200317144333.2904-6-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200317144333.2904-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDKsWRmVeSWpSXmKPExsWy7djPc7ryjwriDKa2WlisvtvPZrFxxnpW
        i2e39jJZrFx9lMni2I5HTBaXd81hs1j+ZC2zxdzW6ewOHB47Z91l97h8ttTj0OEORo+Trd9Y
        PHbfbGDz6NuyitHj8ya5APYoLpuU1JzMstQifbsEroydS1uYC67xV/w9OZGpgXEFTxcjJ4eE
        gInEhW2L2LoYuTiEBFYwSlzovcYO4XxhlDjT1soE4XxmlJi56gAzTMv5za2MILaQwHJGiYt3
        rOA6zj47A5ZgE7CSmNi+CswWEVCQ6Pm9EmwHs8B7RokVk/aygCSEBawlln89xQRiswioSrzu
        bwOKc3DwCthI/DwaA7FMXmLrt0+sIDangK3EtcP/2EBsXgFBiZMzn4CNYQaqad46mxlkvoTA
        OnaJx5deMUI0u0jcXtfIDmELS7w6vgXKlpH4v3M+E1QDo8TfjhdQ3dsZJZZPhlghAXTdnXO/
        2EAuYhbQlFi/Sx/ElBBwlNjZKgth8knceCsIcQOfxKRt05khwrwSHW1CEDPUJDYs28AGs7Vr
        50poGHpIXNm0kn0Co+IsJN/MQvLNLIS1CxiZVzGKp5YW56anFhvmpZbrFSfmFpfmpesl5+du
        YgSmodP/jn/awfj1UtIhRgEORiUeXo4NBXFCrIllxZW5hxglOJiVRHgXF+bHCfGmJFZWpRbl
        xxeV5qQWH2KU5mBREuc1XvQyVkggPbEkNTs1tSC1CCbLxMEp1cDofNvXY9nDrfaGXV/Wa5VI
        KtwzyjX09a0pWFe1u+L7GQvu3l7mBlbLrEM5Gjfa2pgmrnnUkRjyiKdVsOxeedrUvvlb/fXM
        93M86Pq3YJO3ywmnqxLrct0ECyR40nWdl9YtEeLf+CDscnFS6U25pY03//xX8r5x8Lbe3Bc8
        Fiu4dv7+f9VIfaoSS3FGoqEWc1FxIgBqGCyxPwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsVy+t/xu7ryjwriDGZNEbZYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6
        djYpqTmZZalF+nYJehk7l7YwF1zjr/h7ciJTA+MKni5GTg4JAROJ85tbGbsYuTiEBJYySjxc
        3szexcgBlJCROL6+DKJGWOLPtS42EFtI4BOjxPaJ/CA2m4CVxMT2VYwgtoiAgkTP75VsIHOY
        Bb4ySiyd1M0MkhAWsJZY/vUUE4jNIqAq8bq/jQVkPq+AjcTPozEQ8+Ultn77xApicwrYSlw7
        /A9ql43Eizf/wVp5BQQlTs58wgJiMwPVN2+dzTyBUWAWktQsJKkFjEyrGEVSS4tz03OLDfWK
        E3OLS/PS9ZLzczcxAqNl27Gfm3cwXtoYfIhRgINRiYeXY0NBnBBrYllxZe4hRgkOZiUR3sWF
        +XFCvCmJlVWpRfnxRaU5qcWHGE2BfpjILCWanA+M5LySeENTQ3MLS0NzY3NjMwslcd4OgYMx
        QgLpiSWp2ampBalFMH1MHJxSDYwcLxh2zroQqHyycKdAzWY33sv7vpVqSx7dUllkFyjywrBW
        6F7zkXlXFmrZLruwW3RhX43m6rLAr3+3ckTNfd84P+Lh/rl/V6x5OtG+oSYiecePV+6nPYR5
        srL+SsV7hE/51OA2eZna54XWd9xdG4t2bZMMD1ohfEnA5fxr9tUXtBeLN+lY7vRXYinOSDTU
        Yi4qTgQAbM0cL6wCAAA=
X-CMS-MailID: 20200317144343eucas1p2aeb55b3deca6702b7c7128fe7775b708
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200317144343eucas1p2aeb55b3deca6702b7c7128fe7775b708
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200317144343eucas1p2aeb55b3deca6702b7c7128fe7775b708
References: <20200317144333.2904-1-b.zolnierkie@samsung.com>
        <CGME20200317144343eucas1p2aeb55b3deca6702b7c7128fe7775b708@eucas1p2.samsung.com>
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
index 7ef21e282061..2a43eef97b87 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2350,10 +2350,6 @@ static unsigned int ata_scsiop_inq_83(struct ata_scsi_args *args, u8 *rbuf)
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
@@ -2362,14 +2358,14 @@ static unsigned int ata_scsiop_inq_89(struct ata_scsi_args *args, u8 *rbuf)
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

