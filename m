Return-Path: <SRS0=qhS8=33=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D1FC3F68F
	for <linux-ide@archiver.kernel.org>; Fri,  7 Feb 2020 14:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F4F021775
	for <linux-ide@archiver.kernel.org>; Fri,  7 Feb 2020 14:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="d4oYFauT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbgBGO3N (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 7 Feb 2020 09:29:13 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:59624 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727697AbgBGO16 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 7 Feb 2020 09:27:58 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200207142755euoutp01b6ea6f497fed3a58b5f59ebe5a2f2a11~xJQtyWUmK2241722417euoutp01D
        for <linux-ide@vger.kernel.org>; Fri,  7 Feb 2020 14:27:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200207142755euoutp01b6ea6f497fed3a58b5f59ebe5a2f2a11~xJQtyWUmK2241722417euoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1581085675;
        bh=h5ZIp9wzF/jW1YiDgAzae3UvQ+FaqA+XwooHReWPNMQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d4oYFauT7rG8sVtGVt77LfQw+dEGpC5Dg9xaoKG2WSGgVxFlsFjhCPSNPsqGNPLoL
         pVSDBwluL8cqK1tbqeGOPA7V2FBIbz1n7EFi6T1m3rve7qsC+SDp2HoUBkKqvy/OdV
         Ox+C+dvIMN2dj6BAm3TTIB6YsGHvu5qMpKL90ALY=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200207142754eucas1p200e5c9e480a6647ded33886bbfa10526~xJQtegH7l2441424414eucas1p2a;
        Fri,  7 Feb 2020 14:27:54 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 6F.C8.60698.AE37D3E5; Fri,  7
        Feb 2020 14:27:54 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200207142754eucas1p14ee8569d843c7aa03f8a3cfb7dd50056~xJQtJ-Vy-0218702187eucas1p1T;
        Fri,  7 Feb 2020 14:27:54 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200207142754eusmtrp1b2c856113fde8cc9d88c0330ea1dd433~xJQtJWN4T0480004800eusmtrp1C;
        Fri,  7 Feb 2020 14:27:54 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-ba-5e3d73ea5050
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 5A.89.08375.AE37D3E5; Fri,  7
        Feb 2020 14:27:54 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200207142754eusmtip2f524e57a3f0f7113108550a68b5ecae3~xJQst-tlT3155831558eusmtip2B;
        Fri,  7 Feb 2020 14:27:54 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH v2 07/26] ata: optimize struct ata_force_param size
Date:   Fri,  7 Feb 2020 15:27:15 +0100
Message-Id: <20200207142734.8431-8-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200207142734.8431-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHKsWRmVeSWpSXmKPExsWy7djP87qvim3jDKY/MrFYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRXDYpqTmZZalF+nYJXBkHZz1mLvjPU7H22zTWBsbFXF2MnBwS
        AiYS5yf+Ze5i5OIQEljBKHH7TQ87hPOFUaLn/0smCOczo8SZ6VtYYFrebdsGVbWcUaKp7wAb
        XEvjhclMIFVsAlYSE9tXMYLYIgIKEj2/V4IVMQu8Z5RYMWkv2ChhAWeJW92v2UBsFgFVid4j
        59hBbF4BG4lLZ64zQayTl9j67RMriM0pYCvxccpfNogaQYmTM5+AzWEGqmneOpsZon4Vu8T5
        D+wQtovE+80boOYIS7w6vgUqLiNxenIPC8hBEgLrGCX+drxghnC2M0osn/yPDaLKWuLOuV9A
        NgfQBk2J9bv0IcKOErd+3mIBCUsI8EnceCsIcQOfxKRt05khwrwSHW1CENVqEhuWbWCDWdu1
        cyXUmR4S0/Z8ZJvAqDgLyTezkHwzC2HvAkbmVYziqaXFuempxcZ5qeV6xYm5xaV56XrJ+bmb
        GIGp6PS/4193MO77k3SIUYCDUYmHN8HRJk6INbGsuDL3EKMEB7OSCG+fqm2cEG9KYmVValF+
        fFFpTmrxIUZpDhYlcV7jRS9jhQTSE0tSs1NTC1KLYLJMHJxSDYxzHgTvWCksunTpm5Mbz/kv
        Twie9CtiKoN95cpli9INZT4cu7nmhPOm0GxpkwJF/cjQyZenxhzbt1udR3Xi1n3Mq28aL+Ct
        maziIzEn5wGT4APXllIn2cTPrMfPvj05tehV93sGVtOW6Na9+TtM5VxunnrEGKT8SW8m303V
        KZ+SNxY86P2eKnlciaU4I9FQi7moOBEA747aWkEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsVy+t/xe7qvim3jDH5OUrZYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6
        djYpqTmZZalF+nYJehkHZz1mLvjPU7H22zTWBsbFXF2MnBwSAiYS77ZtY+9i5OIQEljKKHFr
        xlaWLkYOoISMxPH1ZRA1whJ/rnWxQdR8YpT4vOspI0iCTcBKYmL7KjBbREBBouf3SrAiZoGv
        jBJLJ3UzgySEBZwlbnW/ZgOxWQRUJXqPnGMHsXkFbCQunbnOBLFBXmLrt0+sIDangK3Exyl/
        weqFgGq+v58EVS8ocXLmExYQmxmovnnrbOYJjAKzkKRmIUktYGRaxSiSWlqcm55bbKhXnJhb
        XJqXrpecn7uJERgx24793LyD8dLG4EOMAhyMSjy8CY42cUKsiWXFlbmHGCU4mJVEePtUbeOE
        eFMSK6tSi/Lji0pzUosPMZoCPTGRWUo0OR8YzXkl8YamhuYWlobmxubGZhZK4rwdAgdjhATS
        E0tSs1NTC1KLYPqYODilGhgdv/tF8+9VL3l3ket2UxT37uCPy77dTT5iejbZPVIwn13hUNrl
        ectXVgpmhhX8Z8jwkDr1bx/TZ2Nz83vSDDNmRiZszqtPfFavy3fg/xSeW3Z3qvsPHOLW2TVf
        /4He4i/XrrYs9ni4/rN5EMPbyH9Cixf/2FTF/FrvTihXj/3CCENO4esfd3xUYinOSDTUYi4q
        TgQA1vhSkq4CAAA=
X-CMS-MailID: 20200207142754eucas1p14ee8569d843c7aa03f8a3cfb7dd50056
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200207142754eucas1p14ee8569d843c7aa03f8a3cfb7dd50056
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200207142754eucas1p14ee8569d843c7aa03f8a3cfb7dd50056
References: <20200207142734.8431-1-b.zolnierkie@samsung.com>
        <CGME20200207142754eucas1p14ee8569d843c7aa03f8a3cfb7dd50056@eucas1p1.samsung.com>
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
index 86f4022c9b17..a3b14cafb2d5 100644
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

