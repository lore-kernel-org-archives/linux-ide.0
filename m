Return-Path: <SRS0=AjNr=5C=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 647CFC3F2CE
	for <linux-ide@archiver.kernel.org>; Tue, 17 Mar 2020 14:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BEAE20735
	for <linux-ide@archiver.kernel.org>; Tue, 17 Mar 2020 14:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="pbMLljv6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbgCQOpQ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 17 Mar 2020 10:45:16 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:40387 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbgCQOnq (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 17 Mar 2020 10:43:46 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200317144345euoutp021460fb50af686d5702d871300c902a45~9HorL1UWE1583015830euoutp024
        for <linux-ide@vger.kernel.org>; Tue, 17 Mar 2020 14:43:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200317144345euoutp021460fb50af686d5702d871300c902a45~9HorL1UWE1583015830euoutp024
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1584456225;
        bh=6VttQ0IlrXC4aeJTjQyE6AsN/qgIpjsiq2ye4fls0fo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pbMLljv6UBwSDUV3DTdJ9rfhOBXXWo6FF7U2bF/ImbydJFK6Gh/ht3HwUsm1kev4f
         wKndhPXL/hiSCBkFh32KITPp8kdHFwAjvpZpf33cSQQnvIAqJrAl5R+4IVSlQ4gMc9
         SGi6MrJBA7LVXUGbDkVYQCCxtt08LisDmA0dvOAY=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200317144344eucas1p1af76b642fa60400ff7cb1c14d707789d~9HoqyqyUt1081810818eucas1p1d;
        Tue, 17 Mar 2020 14:43:44 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id A0.E9.60698.022E07E5; Tue, 17
        Mar 2020 14:43:44 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200317144344eucas1p12dbd070e54e16a364b58b1c591216ebd~9Hoqf1VuV0879108791eucas1p1i;
        Tue, 17 Mar 2020 14:43:44 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200317144344eusmtrp28cc9ce86a6815faab2843616fba8fa0d~9HoqfLOBC0146401464eusmtrp2G;
        Tue, 17 Mar 2020 14:43:44 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-e0-5e70e2205877
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id FA.D4.08375.022E07E5; Tue, 17
        Mar 2020 14:43:44 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200317144343eusmtip1c7ad93898618234b568d555aaf65e6df~9HopwNfm50538205382eusmtip1K;
        Tue, 17 Mar 2020 14:43:43 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH v4 07/27] ata: optimize struct ata_force_param size
Date:   Tue, 17 Mar 2020 15:43:13 +0100
Message-Id: <20200317144333.2904-8-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200317144333.2904-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNKsWRmVeSWpSXmKPExsWy7djPc7oKjwriDK5tM7dYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRXDYpqTmZZalF+nYJXBnPz21nKfjPU/Fy4i32BsbFXF2MnBwS
        AiYST7deYuti5OIQEljBKPH40DwmCOcLo8SpO+3sEM5nRokDjQtYYFqW3PvHBGILCSxnlGi5
        FArX0TVrKSNIgk3ASmJi+yowW0RAQaLn90qwHcwC7xklVkzaCzZJWMBZYvvcxUArODhYBFQl
        Xu32AgnzCthI3Nm+iw1imbzE1m+fWEFsTgFbiWuH/7FB1AhKnJz5BGwMM1BN89bZzCDzJQRW
        sUt8Xv+THaLZReL4ze+MELawxKvjW6DiMhL/d85ngmhYxyjxt+MFVPd2Ronlk/9BrbaWuHPu
        FxvIdcwCmhLrd+mDmBICjhLr5glCmHwSN94KQtzAJzFp23RmiDCvREebEMQMNYkNyzawwWzt
        2rkSqsRD4vIZmwmMirOQPDMLyTOzELYuYGRexSieWlqcm55abJyXWq5XnJhbXJqXrpecn7uJ
        EZiETv87/nUH474/SYcYBTgYlXh4EzYVxAmxJpYVV+YeYpTgYFYS4V1cmB8nxJuSWFmVWpQf
        X1Sak1p8iFGag0VJnNd40ctYIYH0xJLU7NTUgtQimCwTB6dUA2P4HHbjG3via97GlJ6s+bBR
        9PGR1QWH77FfEHIvyPmx+mFFrMXbcH2JfXpyXWni9a2LrYXVX+14a+XqxsG6/kL1RKd7FhPf
        ff+wqdRjnT6jF3OTKoP5HskPmWFPIl/qdzJO+b6xJf/cbF6RjvIH01p1P57++OwHd9uT9iPR
        jIXad0KvBD/b3q/EUpyRaKjFXFScCAAxxHdsPgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsVy+t/xu7oKjwriDJpmKFisvtvPZrFxxnpW
        i2e39jJZrFx9lMni2I5HTBaXd81hs1j+ZC2zxdzW6ewOHB47Z91l97h8ttTj0OEORo+Trd9Y
        PHbfbGDz6NuyitHj8ya5APYoPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9
        O5uU1JzMstQifbsEvYzn57azFPznqXg58RZ7A+Niri5GTg4JAROJJff+MYHYQgJLGSXunE7o
        YuQAistIHF9fBlEiLPHnWhdbFyMXUMknRon9P7exgCTYBKwkJravYgSxRQQUJHp+rwQrYhb4
        yiixdFI3M0hCWMBZYvvcxewgQ1kEVCVe7fYCCfMK2Ejc2b6LDWKBvMTWb59YQWxOAVuJa4f/
        sUHcYyPx4s1/Joh6QYmTM5+A7WUGqm/eOpt5AqPALCSpWUhSCxiZVjGKpJYW56bnFhvqFSfm
        Fpfmpesl5+duYgRGy7ZjPzfvYLy0MfgQowAHoxIPL8eGgjgh1sSy4srcQ4wSHMxKIryLC/Pj
        hHhTEiurUovy44tKc1KLDzGaAv0wkVlKNDkfGMl5JfGGpobmFpaG5sbmxmYWSuK8HQIHY4QE
        0hNLUrNTUwtSi2D6mDg4pRoYE2Orup7LWczgftGmyZs1ZzeTyuRXUe6HShwVJ/4IVFbSUbfu
        Wi/bXHT9pKNNh9Hfk0GstVPlxV7O2H4yRsjV6on9id9HArfPTLt8rkOYQ/myzByue7Z716sL
        MQRyTpPeEdd0Mbj0b8xTrk+FZjf38G35NjONs0zrdVG6UJ7ca5/g4PC58rxKLMUZiYZazEXF
        iQAUDlEbrAIAAA==
X-CMS-MailID: 20200317144344eucas1p12dbd070e54e16a364b58b1c591216ebd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200317144344eucas1p12dbd070e54e16a364b58b1c591216ebd
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200317144344eucas1p12dbd070e54e16a364b58b1c591216ebd
References: <20200317144333.2904-1-b.zolnierkie@samsung.com>
        <CGME20200317144344eucas1p12dbd070e54e16a364b58b1c591216ebd@eucas1p1.samsung.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Optimize struct ata_force_param size by:
- using u8 for cbl and spd_limit fields
- using u16 for lflags field

Code size savings on m68k arch using (modified) atari_defconfig:

   text    data     bss     dec     hex filename
before:
  41064     573      40   41677    a2cd drivers/ata/libata-core.o
after:
  40654     573      40   41267    a133 drivers/ata/libata-core.o

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/libata-core.c | 6 +++---
 include/linux/libata.h    | 1 +
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 0c9ac46d3109..9660c1af5156 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -90,12 +90,12 @@ atomic_t ata_print_id = ATOMIC_INIT(0);
 
 struct ata_force_param {
 	const char	*name;
-	unsigned int	cbl;
-	int		spd_limit;
+	u8		cbl;
+	u8		spd_limit;
 	unsigned long	xfer_mask;
 	unsigned int	horkage_on;
 	unsigned int	horkage_off;
-	unsigned int	lflags;
+	u16		lflags;
 };
 
 struct ata_force_ent {
diff --git a/include/linux/libata.h b/include/linux/libata.h
index fe8a360b4956..c6d94e40ca73 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -163,6 +163,7 @@ enum {
 	ATA_DEV_NONE		= 11,	/* no device */
 
 	/* struct ata_link flags */
+	/* NOTE: struct ata_force_param currently stores lflags in u16 */
 	ATA_LFLAG_NO_HRST	= (1 << 1), /* avoid hardreset */
 	ATA_LFLAG_NO_SRST	= (1 << 2), /* avoid softreset */
 	ATA_LFLAG_ASSUME_ATA	= (1 << 3), /* assume ATA class */
-- 
2.24.1

