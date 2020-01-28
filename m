Return-Path: <SRS0=dw68=3R=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98CA9C33CB2
	for <linux-ide@archiver.kernel.org>; Tue, 28 Jan 2020 13:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7043224686
	for <linux-ide@archiver.kernel.org>; Tue, 28 Jan 2020 13:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hfj5AkmD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbgA1NeR (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 28 Jan 2020 08:34:17 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:58904 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbgA1NeQ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 28 Jan 2020 08:34:16 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200128133415euoutp0136806a5c1998f62a40e2a48f75fe0c3c~uEFACubP60189001890euoutp01K
        for <linux-ide@vger.kernel.org>; Tue, 28 Jan 2020 13:34:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200128133415euoutp0136806a5c1998f62a40e2a48f75fe0c3c~uEFACubP60189001890euoutp01K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1580218455;
        bh=wpx4TLvxtzogQETiS4e9c/g9SsM92c85oTXZs5jViAI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hfj5AkmDYLmmLDUTbS5auyrA+cAIS/YPvoKwVE46fzTSz2CMDjYhjmrwmIEo5crIY
         VdXxvnurYw5Wfl29jB8bFtv1o+XRjKQlyjLnAhhjk6PbzwcgFyFLcbc4edtaBf32qi
         s1iiP9G6K/ZU8t/AaQrUyCLPS/pfEyKtM+rHK2JY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200128133414eucas1p279a5e9b876f0f3b1705ed35a19b4a088~uEE-03qPM3248732487eucas1p2Z;
        Tue, 28 Jan 2020 13:34:14 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 7D.CA.61286.658303E5; Tue, 28
        Jan 2020 13:34:14 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200128133414eucas1p1c69ee66d4799a5aea22561b42ab73e11~uEE-Y4uLG1375113751eucas1p1F;
        Tue, 28 Jan 2020 13:34:14 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200128133414eusmtrp29879237e06f2b9be32471836e32f0638~uEE-YV7lK0330003300eusmtrp2w;
        Tue, 28 Jan 2020 13:34:14 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-7c-5e303856b750
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 12.92.08375.658303E5; Tue, 28
        Jan 2020 13:34:14 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200128133414eusmtip281ce51848b3413606a30e0434311f388~uEE-Dkagk0657406574eusmtip2d;
        Tue, 28 Jan 2020 13:34:13 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH 11/28] ata: add CONFIG_SATA_HOST=n version of
 ata_ncq_enabled()
Date:   Tue, 28 Jan 2020 14:33:26 +0100
Message-Id: <20200128133343.29905-12-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200128133343.29905-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsWy7djP87phFgZxBl/P6lusvtvPZrFxxnpW
        i2e39jJZHNvxiMni8q45bBZzW6ezO7B57Jx1l93j8tlSj0OHOxg9+rasYvT4vEkugDWKyyYl
        NSezLLVI3y6BK6Nr82fWgqdcFX8mXmRtYFzA0cXIySEhYCLR/LabtYuRi0NIYAWjxPnzv1kg
        nC+MEi/+/YDKfGaU2DKllRWm5fLsr1BVyxklDjyczgTXsmvzBjaQKjYBK4mJ7asYQWwRAQWJ
        nt8r2UCKmAXWMEqsOtwElhAWCJRY1XGfHcRmEVCVOLzuCNgKXgE7iT+bnjBBrJOX2PrtE1Cc
        g4MTKN6z1xyiRFDi5MwnLCA2M1BJ89bZzCDzJQTa2SWe3V/CDtHrIvHr50YoW1ji1fEtULaM
        xP+d85kgGtYxSvzteAHVvZ1RYvnkf2wQVdYSd879YgPZzCygKbF+lz5E2FGif1M/M0hYQoBP
        4sZbQYgj+CQmbZsOFeaV6GgTgqhWk9iwbAMbzNqunSuZIWwPiW0bVjFPYFScheSdWUjemYWw
        dwEj8ypG8dTS4tz01GLDvNRyveLE3OLSvHS95PzcTYzAFHP63/FPOxi/Xko6xCjAwajEwztD
        xSBOiDWxrLgy9xCjBAezkghvJxNQiDclsbIqtSg/vqg0J7X4EKM0B4uSOK/xopexQgLpiSWp
        2ampBalFMFkmDk6pBsZqxTflRQ1rnh3fn3N6vc/Xpd0d21++nl58MDWfoTYzaqZSm0znAz3Z
        ynU8y4/VHexYtW63XnDIsSTxJJeEdYef1v5nibOLu7JqV/uXhlS1tmqNDaeKzrfv0dit2uIY
        kzwv6eVx3a7p/RX8JhbhSUdbbP5XnneYP9Wu+OMm4bfFHo85VrFu2K7EUpyRaKjFXFScCACY
        WX7jLQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplkeLIzCtJLcpLzFFi42I5/e/4Pd0wC4M4g0drRSxW3+1ns9g4Yz2r
        xbNbe5ksju14xGRxedccNou5rdPZHdg8ds66y+5x+Wypx6HDHYwefVtWMXp83iQXwBqlZ1OU
        X1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5egl9G1+TNrwVOu
        ij8TL7I2MC7g6GLk5JAQMJG4PPsrSxcjF4eQwFJGiXcTl7F1MXIAJWQkjq8vg6gRlvhzrYsN
        xBYS+MQo0XLKHcRmE7CSmNi+ihHEFhFQkOj5vZINZA6zwAZGiVc3v7CAJIQF/CWmXm1lBrFZ
        BFQlDq87wgpi8wrYSfzZ9IQJYoG8xNZvn1hB9nICxXv2mkPsspVYf+YpVLmgxMmZT8BGMgOV
        N2+dzTyBUWAWktQsJKkFjEyrGEVSS4tz03OLDfWKE3OLS/PS9ZLzczcxAqNg27Gfm3cwXtoY
        fIhRgINRiYd3hopBnBBrYllxZe4hRgkOZiUR3k4moBBvSmJlVWpRfnxRaU5q8SFGU6AfJjJL
        iSbnAyM0ryTe0NTQ3MLS0NzY3NjMQkmct0PgYIyQQHpiSWp2ampBahFMHxMHp1QDo76HxpV/
        iXNy1NT0lX/HR76euXFm+6Z9Nj/uKZ5+uKxwV2LyTra4ToYLwTXpC4V+lRSVVU7cuj7ziXJb
        5DofJkahzrd+03svTU5SXbO+3dshdtmGK2tjAzN7K/b1Oqps8Jr85bBDi2gy84lbm/k283mv
        2OjD53SsM2l6jOq1pb4nLzcfjfp9XYmlOCPRUIu5qDgRAAjPcIyYAgAA
X-CMS-MailID: 20200128133414eucas1p1c69ee66d4799a5aea22561b42ab73e11
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200128133414eucas1p1c69ee66d4799a5aea22561b42ab73e11
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200128133414eucas1p1c69ee66d4799a5aea22561b42ab73e11
References: <20200128133343.29905-1-b.zolnierkie@samsung.com>
        <CGME20200128133414eucas1p1c69ee66d4799a5aea22561b42ab73e11@eucas1p1.samsung.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

When CONFIG_SATA_HOST=n there are no NCQ capable host drivers
built so it is safe to hardwire ata_ncq_enabled() to always
return zero.

Code size savings on m68k arch using atari_defconfig:

   text    data     bss     dec     hex filename
before:
  37820     572      40   38432    9620 drivers/ata/libata-core.o
  21040     105    4096   25241    6299 drivers/ata/libata-scsi.o
  17405      18       0   17423    440f drivers/ata/libata-eh.o
after:
  37582     572      40   38194    9532 drivers/ata/libata-core.o
  20702     105    4096   24903    6147 drivers/ata/libata-scsi.o
  17353      18       0   17371    43db drivers/ata/libata-eh.o

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 include/linux/libata.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/libata.h b/include/linux/libata.h
index 79953c6d769c..5b7bed18f56e 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1633,8 +1633,12 @@ extern struct ata_device *ata_dev_next(struct ata_device *dev,
  */
 static inline int ata_ncq_enabled(struct ata_device *dev)
 {
+#ifdef CONFIG_SATA_HOST
 	return (dev->flags & (ATA_DFLAG_PIO | ATA_DFLAG_NCQ_OFF |
 			      ATA_DFLAG_NCQ)) == ATA_DFLAG_NCQ;
+#else
+	return 0;
+#endif
 }
 
 static inline bool ata_fpdma_dsm_supported(struct ata_device *dev)
-- 
2.24.1

