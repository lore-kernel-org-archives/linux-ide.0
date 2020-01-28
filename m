Return-Path: <SRS0=dw68=3R=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C69DC2D0DB
	for <linux-ide@archiver.kernel.org>; Tue, 28 Jan 2020 13:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05F4E2468C
	for <linux-ide@archiver.kernel.org>; Tue, 28 Jan 2020 13:35:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="C8KFg6ms"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgA1Nfk (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 28 Jan 2020 08:35:40 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:58904 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbgA1NeP (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 28 Jan 2020 08:34:15 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200128133413euoutp01452fe035593bc271b895cfa66a7848e6~uEE_zVZXo0195601956euoutp01D
        for <linux-ide@vger.kernel.org>; Tue, 28 Jan 2020 13:34:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200128133413euoutp01452fe035593bc271b895cfa66a7848e6~uEE_zVZXo0195601956euoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1580218453;
        bh=WgiqNiMKzYYraoDM/81Lk3NsaiaSgCDlNANUSgsx2Cs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C8KFg6msx7pX5QwA87s4l8ZUrRyWfjIt1q2IN8MO1By7lkSsGwXjyo1Kwx0FIngA+
         2ksNnsnMv6S+3lg3Tkh+QfOYmGWPmSzSVxJde/aLQii4fApZsMi/R5xbsf5EM5dDAn
         Nl4ZmYp6gccwzwP3FuvNrm6X3PnSobIxx1JVCjg8=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200128133413eucas1p1ee52dd69b2a3296cfc1224f4cfb93a5f~uEE_T0Cj_0713407134eucas1p1o;
        Tue, 28 Jan 2020 13:34:13 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 27.DA.60698.558303E5; Tue, 28
        Jan 2020 13:34:13 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200128133412eucas1p1b1b4f025e4c0e6ae6e7a95e9832880dd~uEE_Fd0MN0680006800eucas1p1o;
        Tue, 28 Jan 2020 13:34:12 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200128133412eusmtrp2af521830eee15acd42e790211573297c~uEE_E6ZZl0330103301eusmtrp2r;
        Tue, 28 Jan 2020 13:34:12 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-b3-5e303855c394
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id D0.92.08375.458303E5; Tue, 28
        Jan 2020 13:34:12 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200128133412eusmtip2e44d1d71d5683aea480ef39bd56ffeca~uEE9w7Kmr0685506855eusmtip2U;
        Tue, 28 Jan 2020 13:34:12 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH 07/28] ata: optimize struct ata_force_param size
Date:   Tue, 28 Jan 2020 14:33:22 +0100
Message-Id: <20200128133343.29905-8-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200128133343.29905-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRmVeSWpSXmKPExsWy7djP87qhFgZxBn+aeSxW3+1ns9g4Yz2r
        xbNbe5ksju14xGRxedccNou5rdPZHdg8ds66y+5x+Wypx6HDHYwefVtWMXp83iQXwBrFZZOS
        mpNZllqkb5fAlbH76Ff2guM8Fbvu/GJrYPzI2cXIySEhYCKxseklSxcjF4eQwApGiUnfZjFB
        OF8YJTacW8YI4XxmlFj+eDYbTEv73S9QLcsZJc7fvMAM17Llyhx2kCo2ASuJie2rGEFsEQEF
        iZ7fK9lAipgF1jBKrDrcBJYQFnCQ+Da1gxnEZhFQlWhbexJsBa+ArUTzu/8sEOvkJbZ++8Ta
        xcjBwSlgJ9Gz1xyiRFDi5MwnYCXMQCXNW2eDHSEh0M0ucerERXaQegkBF4nmNfoQY4QlXh3f
        wg5hy0j83zmfCaJ+HaPE344XUM3bgf6c/A/qT2uJO+d+sYEMYhbQlFi/C2qQo8T8v2dYIObz
        Sdx4KwhxA5/EpG3TmSHCvBIdbUIQ1WoSG5ZtYINZ27VzJTOE7SGxecMU1gmMirOQfDMLyTez
        EPYuYGRexSieWlqcm55abJyXWq5XnJhbXJqXrpecn7uJEZhgTv87/nUH474/SYcYBTgYlXh4
        HZQM4oRYE8uKK3MPMUpwMCuJ8HYyAYV4UxIrq1KL8uOLSnNSiw8xSnOwKInzGi96GSskkJ5Y
        kpqdmlqQWgSTZeLglGpg5NCwmMVUIN93ZPfEMyvjWKaXfjM6Oekat0FQzfXuNslXeWaKx6YV
        ciQanHgQ59tjZrXA7uGtTTcenxR/Zq290aHBuK97h/vil//rn7PmPbddVPvPquPnh9ULDIR+
        fXJy7N92a+Yz8X81VrMW3e+bksnx8d2fDUE3j4jOmSHWUyreGKXZcYTHSomlOCPRUIu5qDgR
        AHO+rcosAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjkeLIzCtJLcpLzFFi42I5/e/4Pd0QC4M4g8OPLC1W3+1ns9g4Yz2r
        xbNbe5ksju14xGRxedccNou5rdPZHdg8ds66y+5x+Wypx6HDHYwefVtWMXp83iQXwBqlZ1OU
        X1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5egl7H76Ff2guM8
        Fbvu/GJrYPzI2cXIySEhYCLRfvcLSxcjF4eQwFJGidenP7F3MXIAJWQkjq8vg6gRlvhzrYsN
        ouYTo0TH4zmsIAk2ASuJie2rGEFsEQEFiZ7fK8GKmAU2MEq8ugkylZNDWMBB4tvUDmYQm0VA
        VaJt7Uk2EJtXwFai+d1/FogN8hJbv31iBVnMKWAn0bPXHCQsBFSy/sxTVohyQYmTM5+AlTMD
        lTdvnc08gVFgFpLULCSpBYxMqxhFUkuLc9Nziw31ihNzi0vz0vWS83M3MQLjYNuxn5t3MF7a
        GHyIUYCDUYmHd4aKQZwQa2JZcWXuIUYJDmYlEd5OJqAQb0piZVVqUX58UWlOavEhRlOgHyYy
        S4km5wNjNK8k3tDU0NzC0tDc2NzYzEJJnLdD4GCMkEB6YklqdmpqQWoRTB8TB6dUA2Nvxp8d
        LqJ713Zy3ihL2938dVKN5tlLQativ4Tfbdzw8mjrpBPzNAWbZojGJ7Qafje4uLV1S3BxQE1S
        8VP5up8H/lW/Wco2WWcmz8fyJwoXPVRVHh7bVy+gMiWv/7HgKqF3h3s6s/2ZXOsLE5qF5147
        rXPwxQtHBwZ1ppslT243ex80CD6+eYoSS3FGoqEWc1FxIgBb0bthmQIAAA==
X-CMS-MailID: 20200128133412eucas1p1b1b4f025e4c0e6ae6e7a95e9832880dd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200128133412eucas1p1b1b4f025e4c0e6ae6e7a95e9832880dd
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200128133412eucas1p1b1b4f025e4c0e6ae6e7a95e9832880dd
References: <20200128133343.29905-1-b.zolnierkie@samsung.com>
        <CGME20200128133412eucas1p1b1b4f025e4c0e6ae6e7a95e9832880dd@eucas1p1.samsung.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Optimize struct ata_force_param size by:
- using u8 for cbl and spd_limit fields
- using u16 for lflags field

Code size savings on m68k arch using atari_defconfig:

   text    data     bss     dec     hex filename
before:
  41064     573      40   41677    a2cd drivers/ata/libata-core.o
after:
  40654     573      40   41267    a133 drivers/ata/libata-core.o

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/libata-core.c | 6 +++---
 include/linux/libata.h    | 1 +
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 9b824788d04f..47703c8ba0e6 100644
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
index 2a9d50b0e219..dc162cca63a4 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -176,6 +176,7 @@ enum {
 	ATA_DEV_NONE		= 11,	/* no device */
 
 	/* struct ata_link flags */
+	/* NOTE: struct ata_force_param currently stores lflags in u16 */
 	ATA_LFLAG_NO_HRST	= (1 << 1), /* avoid hardreset */
 	ATA_LFLAG_NO_SRST	= (1 << 2), /* avoid softreset */
 	ATA_LFLAG_ASSUME_ATA	= (1 << 3), /* assume ATA class */
-- 
2.24.1

