Return-Path: <SRS0=ljer=4P=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 245E5C35E1C
	for <linux-ide@archiver.kernel.org>; Thu, 27 Feb 2020 18:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01A9F246A8
	for <linux-ide@archiver.kernel.org>; Thu, 27 Feb 2020 18:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="JaULjhI3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730884AbgB0SYY (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 27 Feb 2020 13:24:24 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:39704 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730885AbgB0SWn (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 27 Feb 2020 13:22:43 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200227182242euoutp017e5b33bcc2362ddf070a5d36e1f39750~3VXai0J031216412164euoutp01k
        for <linux-ide@vger.kernel.org>; Thu, 27 Feb 2020 18:22:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200227182242euoutp017e5b33bcc2362ddf070a5d36e1f39750~3VXai0J031216412164euoutp01k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1582827762;
        bh=Q/sdW1GzpO3lfP/7UDJtkNbSsnuksj8skfPe8g7FvUI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JaULjhI35ItKiznmywzmvWdrxzBzkESrzlQTbP4HEpkdLBk3hNMVQrZTm7iQeCQ23
         IPBzTvOphPFgXIcEvAQWatvASbVUafFxoOOLbc5SZtnu/DKOYmyIQPLQF7an0bZL2e
         a4hKHD4F7Aog6+RXF9sk+v9h0D84GsckXWaOKhdc=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200227182241eucas1p1e30e7591ff1def90b6e228056d13d573~3VXaThzhQ1207712077eucas1p1E;
        Thu, 27 Feb 2020 18:22:41 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 16.05.60698.1F8085E5; Thu, 27
        Feb 2020 18:22:41 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200227182241eucas1p10cf24570346137befa34c6fd800db058~3VXZtinTR1392413924eucas1p18;
        Thu, 27 Feb 2020 18:22:41 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200227182241eusmtrp190676733202c73dbd29d7d7cfe302218~3VXZs5IRC0185901859eusmtrp1e;
        Thu, 27 Feb 2020 18:22:41 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-f7-5e5808f174d1
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 12.61.07950.1F8085E5; Thu, 27
        Feb 2020 18:22:41 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200227182240eusmtip21d0aeb9f86818d881f43357d6c5e6850~3VXZPh8xp2149421494eusmtip2G;
        Thu, 27 Feb 2020 18:22:40 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH v3 05/27] ata: simplify ata_scsiop_inq_89()
Date:   Thu, 27 Feb 2020 19:22:04 +0100
Message-Id: <20200227182226.19188-6-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200227182226.19188-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLKsWRmVeSWpSXmKPExsWy7djPc7ofOSLiDGZ/1LdYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRXDYpqTmZZalF+nYJXBlXpl9mL7jGX9FxrrSBcQVPFyMnh4SA
        icSJv9+YQWwhgRWMElv2cncxcgHZXxglNnxsYIdwPjNKzN71lBWmY+O9GawQieWMEksn7GCC
        a3n6/hTYLDYBK4mJ7asYQWwRAQWJnt8r2UCKmAXeM0qsmLSXBSQhLGAtcW32TbAGFgFViYb+
        DWA2r4CtxPMf91gg1slLbP32CWw1p4CdxI2+7WwQNYISJ2c+AathBqpp3jqbGWSBhMAydom9
        Lw4zQTS7SPy4+JgZwhaWeHV8CzuELSNxenIPC0TDOkaJvx0voLq3M0osn/yPDaLKWuLOuV9A
        NgfQCk2J9bv0IcKOEkeOnmcGCUsI8EnceCsIcQSfxKRt06HCvBIdbUIQ1WoSG5ZtYINZ27Vz
        JdQ5HhJHF19mm8CoOAvJO7OQvDMLYe8CRuZVjOKppcW56anFxnmp5XrFibnFpXnpesn5uZsY
        gYno9L/jX3cw7vuTdIhRgINRiYd3wY7wOCHWxLLiytxDjBIczEoivBu/hsYJ8aYkVlalFuXH
        F5XmpBYfYpTmYFES5zVe9DJWSCA9sSQ1OzW1ILUIJsvEwSnVwKjpfWiRgNSXd1Xzzqw858Ms
        FD/h9tR3LH+PLFFty2n+qSh1N/PtP5njG/2ZF94SW+krfu2JxxFr2dSaEJV7zPdnnbFJO3PV
        L3dRb6GC7BXNGXO/HU4/IRiyo7S7xFk0+N/zCzfP1i9fwG0ou/hJKvdKr+6X/LquChaz4qTX
        MbyJLb29bs8RhiAlluKMREMt5qLiRABgEbhDQAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsVy+t/xe7ofOSLiDN4tZ7NYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6
        djYpqTmZZalF+nYJehlXpl9mL7jGX9FxrrSBcQVPFyMnh4SAicTGezNYuxi5OIQEljJKTH+8
        FsjhAErISBxfXwZRIyzx51oXG0TNJ0aJlUseM4Mk2ASsJCa2r2IEsUUEFCR6fq8EK2IW+Moo
        sXRSN1iRsIC1xLXZN8FsFgFViYb+DWA2r4CtxPMf91ggNshLbP32iRXE5hSwk7jRt50NxBYC
        qunqeMoIUS8ocXLmE7B6ZqD65q2zmScwCsxCkpqFJLWAkWkVo0hqaXFuem6xkV5xYm5xaV66
        XnJ+7iZGYLxsO/Zzyw7GrnfBhxgFOBiVeHg9toXHCbEmlhVX5h5ilOBgVhLh3fg1NE6INyWx
        siq1KD++qDQntfgQoynQExOZpUST84GxnFcSb2hqaG5haWhubG5sZqEkztshcDBGSCA9sSQ1
        OzW1ILUIpo+Jg1OqgdHsiZGCrdrsa7YzDt5ZfW653aafN9KnyVZavn/HuvKWoZtMyuye+4d/
        Vp2xqL4rtjJfpd9J7meMtXtnntabmH4rznNxN9TNAjXydsZl73QU3L/1v3kX0+x+33N/187h
        U92ou/O5WFXvhKuzj/jenbn5zoZrqYbHY5StL183TWlsOvDk3eMnu/4osRRnJBpqMRcVJwIA
        lb8mj60CAAA=
X-CMS-MailID: 20200227182241eucas1p10cf24570346137befa34c6fd800db058
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200227182241eucas1p10cf24570346137befa34c6fd800db058
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200227182241eucas1p10cf24570346137befa34c6fd800db058
References: <20200227182226.19188-1-b.zolnierkie@samsung.com>
        <CGME20200227182241eucas1p10cf24570346137befa34c6fd800db058@eucas1p1.samsung.com>
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

