Return-Path: <SRS0=AjNr=5C=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F7CC4CECE
	for <linux-ide@archiver.kernel.org>; Tue, 17 Mar 2020 14:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAEE5206EC
	for <linux-ide@archiver.kernel.org>; Tue, 17 Mar 2020 14:44:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="NR+RSAZ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgCQOoz (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 17 Mar 2020 10:44:55 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:45951 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbgCQOnt (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 17 Mar 2020 10:43:49 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200317144348euoutp01cd411f5d85ee9bcd459aa90950c0d67d~9HotvSyqd2268822688euoutp01k
        for <linux-ide@vger.kernel.org>; Tue, 17 Mar 2020 14:43:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200317144348euoutp01cd411f5d85ee9bcd459aa90950c0d67d~9HotvSyqd2268822688euoutp01k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1584456228;
        bh=c6Hoay4ozj91PgNTOAbzxBYgELGyyNqR8R/651RleYs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NR+RSAZ74yPeugKCmPWrYFB7oFcqK0uO0LioMgg0m/QlvdDjw7kQDs1cS1vbEBoB3
         GXnGKrVrygn5JzdXlgJ299MsEatJJ8g7yAxdie3uAz7igHvmHKDcrSYPtLPnmSIJT1
         4Fu1BYFHumMxlF3M5s5b3a4+FgCMRUNtsNUXtk10=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200317144347eucas1p1bc688a9894dff81063e97f32d1b395ac~9Hotcg-xK1081810818eucas1p1h;
        Tue, 17 Mar 2020 14:43:47 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id FF.D3.61286.322E07E5; Tue, 17
        Mar 2020 14:43:47 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200317144347eucas1p293ab462ec3d4990f380f9d652195cdb4~9HotOLn2p0343503435eucas1p2N;
        Tue, 17 Mar 2020 14:43:47 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200317144347eusmtrp29e6a04b150c6f2d04e383507085180ed~9HotNgQT30146401464eusmtrp2N;
        Tue, 17 Mar 2020 14:43:47 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-2d-5e70e22388a4
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id AB.23.07950.322E07E5; Tue, 17
        Mar 2020 14:43:47 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200317144347eusmtip1861518d99f4321bcc76801c19c4a65f7~9HoswkunM0973009730eusmtip1W;
        Tue, 17 Mar 2020 14:43:47 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH v4 13/27] ata: add CONFIG_SATA_HOST=n version of
 ata_ncq_enabled()
Date:   Tue, 17 Mar 2020 15:43:19 +0100
Message-Id: <20200317144333.2904-14-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200317144333.2904-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHKsWRmVeSWpSXmKPExsWy7djP87rKjwriDH5u0rdYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRXDYpqTmZZalF+nYJXBnLD65nLFjIVdH3cSFjA+Mz9i5GTg4J
        AROJx9dbGbsYuTiEBFYwSjz9O40ZwvnCKDH32FkmCOczo8SN/kNsMC0bzq1nBrGFBJYzSvya
        XADXsW/rDUaQBJuAlcTE9lVgtoiAgkTP75VsIEXMAu8ZJVZM2ssCkhAWCJH4N/kT2CQWAVWJ
        OZ3XwRp4BWwlvm56xgqxTV5i67dPYDYnUPza4X9sEDWCEidnPgGbwwxU07x1NtjdEgLL2CXO
        zP/JAtHsIrF4ZxuULSzx6vgWqK9lJP7vnM8E0bCOUeJvxwuo7u2MEssn/4N61FrizrlfQDYH
        0ApNifW79CHCjhI7rk1kAQlLCPBJ3HgrCHEEn8SkbdOZIcK8Eh1tQhDVahIblm1gg1nbtXMl
        M4TtIfHi0FLWCYyKs5C8MwvJO7MQ9i5gZF7FKJ5aWpybnlpsmJdarlecmFtcmpeul5yfu4kR
        mIpO/zv+aQfj10tJhxgFOBiVeHg5NhTECbEmlhVX5h5ilOBgVhLhXVyYHyfEm5JYWZValB9f
        VJqTWnyIUZqDRUmc13jRy1ghgfTEktTs1NSC1CKYLBMHp1QDY2wOO4tu1guJ4M+ekvJNrCei
        tk3svGi76cWKGxfexvkffFkp6l7D0ySebDfh4Mqqo5L9jzaxO0l/5xFpmcS13Vc1w27hXKU4
        57dVGlcZjxlI7HzZefTG6ev/Gd4qinCo91tPEKpYsXnne7/nNru1ZXc8CunZMndRy8OlraJW
        P1bcnsbhqWbpoMRSnJFoqMVcVJwIAArW0ORBAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsVy+t/xu7rKjwriDJp/y1msvtvPZrFxxnpW
        i2e39jJZrFx9lMni2I5HTBaXd81hs1j+ZC2zxdzW6ewOHB47Z91l97h8ttTj0OEORo+Trd9Y
        PHbfbGDz6NuyitHj8ya5APYoPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9
        O5uU1JzMstQifbsEvYzlB9czFizkquj7uJCxgfEZexcjJ4eEgInEhnPrmUFsIYGljBKNjQJd
        jBxAcRmJ4+vLIEqEJf5c62LrYuQCKvnEKNH6/DdYPZuAlcTE9lWMILaIgIJEz++VYEXMAl8Z
        JZZO6gYrEhYIkvjXt5MFxGYRUJWY03kdrIFXwFbi66ZnrBAb5CW2fvsEZnMCxa8d/scGcZCN
        xIs3/5kg6gUlTs58AjaHGai+eets5gmMArOQpGYhSS1gZFrFKJJaWpybnltspFecmFtcmpeu
        l5yfu4kRGC/bjv3csoOx613wIUYBDkYlHl6ODQVxQqyJZcWVuYcYJTiYlUR4FxfmxwnxpiRW
        VqUW5ccXleakFh9iNAV6YiKzlGhyPjCW80riDU0NzS0sDc2NzY3NLJTEeTsEDsYICaQnlqRm
        p6YWpBbB9DFxcEo1MB7bMXFZ0rnf6nuCrh29w2IrdPymOvuv9RmZmdNOBR/QvOiQ4xDb78C7
        7nP7ms6Nf+okL09fPiM506v0+fl/HSLNu/b+ZV98qykul+/km8UeehselXGXzV++SEaRt2BF
        3PZJvauzf/atl95d8tDW+P6R31wrq1u19sZdMDWZan6IzXM1S7xxXbESS3FGoqEWc1FxIgDg
        qPZlrQIAAA==
X-CMS-MailID: 20200317144347eucas1p293ab462ec3d4990f380f9d652195cdb4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200317144347eucas1p293ab462ec3d4990f380f9d652195cdb4
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200317144347eucas1p293ab462ec3d4990f380f9d652195cdb4
References: <20200317144333.2904-1-b.zolnierkie@samsung.com>
        <CGME20200317144347eucas1p293ab462ec3d4990f380f9d652195cdb4@eucas1p2.samsung.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

When CONFIG_SATA_HOST=n there are no NCQ capable host drivers
built so it is safe to hardwire ata_ncq_enabled() to always
return zero.

Code size savings on m68k arch using (modified) atari_defconfig:

   text    data     bss     dec     hex filename
before:
  37820     572      40   38432    9620 drivers/ata/libata-core.o
  21040     105     576   21721    54d9 drivers/ata/libata-scsi.o
  17405      18       0   17423    440f drivers/ata/libata-eh.o
after:
  37582     572      40   38194    9532 drivers/ata/libata-core.o
  20702     105     576   21383    5387 drivers/ata/libata-scsi.o
  17353      18       0   17371    43db drivers/ata/libata-eh.o

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 include/linux/libata.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/libata.h b/include/linux/libata.h
index 9ad072b6d007..b1b3e5e0a301 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1623,6 +1623,8 @@ extern struct ata_device *ata_dev_next(struct ata_device *dev,
  */
 static inline int ata_ncq_enabled(struct ata_device *dev)
 {
+	if (!IS_ENABLED(CONFIG_SATA_HOST))
+		return 0;
 	return (dev->flags & (ATA_DFLAG_PIO | ATA_DFLAG_NCQ_OFF |
 			      ATA_DFLAG_NCQ)) == ATA_DFLAG_NCQ;
 }
-- 
2.24.1

