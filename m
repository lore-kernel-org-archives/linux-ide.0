Return-Path: <SRS0=jBxd=5L=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A7C7C2D0F0
	for <linux-ide@archiver.kernel.org>; Thu, 26 Mar 2020 16:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 251F22073E
	for <linux-ide@archiver.kernel.org>; Thu, 26 Mar 2020 16:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="N6X/7v5N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbgCZQAQ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 26 Mar 2020 12:00:16 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:58869 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728366AbgCZP6m (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 26 Mar 2020 11:58:42 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200326155841euoutp01041178e21751d42cfb8731f16c453d16~-5dqjyrkm2919829198euoutp01p
        for <linux-ide@vger.kernel.org>; Thu, 26 Mar 2020 15:58:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200326155841euoutp01041178e21751d42cfb8731f16c453d16~-5dqjyrkm2919829198euoutp01p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585238321;
        bh=170iWNmnr3i7M39o2VQVu8h/OTq2bGaLLR0CAOcn+sE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N6X/7v5Nv1M+/3dPbtauTVT8biYaEFlUtNbR1N+0IHSMiMzIk8gfDke1l2i9Qqdcl
         3MgmBV4juQT/Gyd5NlBg6wwwLTD4QGxfTj5A4moxF6MJ0+EstKAWDdN9PTg4T2INdU
         GADFWhEbxJ7ro/XITmJVxsy8utOXRfB2hmxFbCU8=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200326155840eucas1p14f2bc523ec464b80a0ee8fbbd2489857~-5dqWNJG00544705447eucas1p1w;
        Thu, 26 Mar 2020 15:58:40 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 3B.F5.61286.031DC7E5; Thu, 26
        Mar 2020 15:58:40 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200326155840eucas1p1fd8d2a9a30f2f97dbf4a78258191c624~-5dp95qb72821928219eucas1p1s;
        Thu, 26 Mar 2020 15:58:40 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200326155840eusmtrp19e09566b17f92d8029e3706c1b6eee7b~-5dp9SouO2091520915eusmtrp1B;
        Thu, 26 Mar 2020 15:58:40 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-ba-5e7cd1308549
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 28.5A.08375.031DC7E5; Thu, 26
        Mar 2020 15:58:40 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200326155839eusmtip134997e1151395abd8e6bcfdc6a31c82c~-5dpixMFx1572315723eusmtip1q;
        Thu, 26 Mar 2020 15:58:39 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH v5 05/27] ata: simplify ata_scsiop_inq_89()
Date:   Thu, 26 Mar 2020 16:58:00 +0100
Message-Id: <20200326155822.19400-6-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200326155822.19400-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDKsWRmVeSWpSXmKPExsWy7djPc7oGF2viDC48NrRYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRXDYpqTmZZalF+nYJXBkTVxoXXOOvWNZ+ia2BcQVPFyMnh4SA
        icTB7nmMXYxcHEICKxgl2nZ0sEM4Xxgllvz+ywLhfGaUePdhEQtMy4y1p5hBbCGB5YwSqxeU
        wXV8XH2OHSTBJmAlMbF9FSOILSKgINHzeyUbSBGzwHtGiRWT9oJNEhawllj4cxUriM0ioCpx
        9/lVoKkcHLwCthJfTllBLJOX2PrtE1gJp4CdxPJ188EW8woISpyc+QRsDDNQTfPW2cwg8yUE
        lrFLPG5dwQbR7CJxbfJOZghbWOLV8S3sELaMxOnJPSwQDesYJf52vIDq3s4osXzyP6hua4k7
        536xgVzELKApsX6XPkTYUeJcO8hmDiCbT+LGW0GII/gkJm2bzgwR5pXoaBOCqFaT2LBsAxvM
        2q6dK6HO8ZCYt7WVaQKj4iwk78xC8s4shL0LGJlXMYqnlhbnpqcWG+allusVJ+YWl+al6yXn
        525iBKah0/+Of9rB+PVS0iFGAQ5GJR5ejZaaOCHWxLLiytxDjBIczEoivE8jgUK8KYmVValF
        +fFFpTmpxYcYpTlYlMR5jRe9jBUSSE8sSc1OTS1ILYLJMnFwSjUwJiVMfH6W7Zx36KES1kCv
        7Q9DE3R19tc1XbsyU6P+UKEzR0j4uc9z9N5ekFn2Z4a140WVCCmFrm9+l/5c33C3zV6poH8+
        +3/ng5ys8f3PKpljK1+fdNPO0FF/pV7F1WY8t//gvQMbmW8G6zF/NV9S96WhWfDrnYlhQaZ7
        NzlfTpjg5+HkeWmpEktxRqKhFnNRcSIAzCXZxT8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsVy+t/xu7oGF2viDBrXiVmsvtvPZrFxxnpW
        i2e39jJZrFx9lMni2I5HTBaXd81hs1j+ZC2zxdzW6ewOHB47Z91l97h8ttTj0OEORo+Trd9Y
        PHbfbGDz6NuyitHj8ya5APYoPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9
        O5uU1JzMstQifbsEvYyJK40LrvFXLGu/xNbAuIKni5GTQ0LARGLG2lPMXYxcHEICSxkl5vy7
        DeRwACVkJI6vL4OoEZb4c62LDaLmE6PExoM/2EASbAJWEhPbVzGC2CICChI9v1eCFTELfGWU
        WDqpmxkkISxgLbHw5ypWEJtFQFXi7vOrYAt4BWwlvpyyglggL7H12yewEk4BO4nl6+aDtQoB
        lSz+8oEJxOYVEJQ4OfMJC4jNDFTfvHU28wRGgVlIUrOQpBYwMq1iFEktLc5Nzy021CtOzC0u
        zUvXS87P3cQIjJZtx35u3sF4aWPwIUYBDkYlHl6Nlpo4IdbEsuLK3EOMEhzMSiK8TyOBQrwp
        iZVVqUX58UWlOanFhxhNgX6YyCwlmpwPjOS8knhDU0NzC0tDc2NzYzMLJXHeDoGDMUIC6Ykl
        qdmpqQWpRTB9TBycUg2M4eYPL/mv2PjCY+qt3yIJzTOUlocxX533WPVr8XHrW+7d73+/XS0s
        +t/qhe7Zk997M65Mj+H98Wbhn97jGpvO/nRrFritveitjFpDw/U97dxxiZG1O0W7X+TFPnBL
        l2ObUdZqHCAftPmivM/Vq8t5Jh1ev9fBqX7y9TI5rjz+Z01Rzlabc3TvK7EUZyQaajEXFScC
        ALgj4RisAgAA
X-CMS-MailID: 20200326155840eucas1p1fd8d2a9a30f2f97dbf4a78258191c624
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200326155840eucas1p1fd8d2a9a30f2f97dbf4a78258191c624
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200326155840eucas1p1fd8d2a9a30f2f97dbf4a78258191c624
References: <20200326155822.19400-1-b.zolnierkie@samsung.com>
        <CGME20200326155840eucas1p1fd8d2a9a30f2f97dbf4a78258191c624@eucas1p1.samsung.com>
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
index 005c6f2f7d21..0912acb82b80 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2357,10 +2357,6 @@ static unsigned int ata_scsiop_inq_83(struct ata_scsi_args *args, u8 *rbuf)
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
@@ -2369,14 +2365,14 @@ static unsigned int ata_scsiop_inq_89(struct ata_scsi_args *args, u8 *rbuf)
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

