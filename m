Return-Path: <SRS0=ljer=4P=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22AA2C11D3D
	for <linux-ide@archiver.kernel.org>; Thu, 27 Feb 2020 18:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDFBC246A6
	for <linux-ide@archiver.kernel.org>; Thu, 27 Feb 2020 18:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="X5ATL1j5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730962AbgB0SYS (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 27 Feb 2020 13:24:18 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:39721 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730910AbgB0SWo (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 27 Feb 2020 13:22:44 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200227182243euoutp01b99995b87eb12e4388aad5ebcc57d8b2~3VXbs3AE81368713687euoutp01P
        for <linux-ide@vger.kernel.org>; Thu, 27 Feb 2020 18:22:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200227182243euoutp01b99995b87eb12e4388aad5ebcc57d8b2~3VXbs3AE81368713687euoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1582827763;
        bh=tJ48AKGMQVayKWamKJWofb7IDsnosx3gaFQoe9qHSTg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X5ATL1j5WpMj4Z6zAS9m0eX200kXNhYw5VBiBlRmbChfGLcFAQezTM5vumGdOrRaN
         Tqp0ADBbR2WR90S9x6rZGT8Qrr0hwWZbYwbL2xqP5p6CrS/SvU0JVPp9hvff3OaNPL
         Dv0MmKgoQsqoZ9USP0lxyG5hoJ7aebx1CNe5ugM8=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200227182242eucas1p22ff7adcedfec82fa2593ea1806add861~3VXbVFnl-3197531975eucas1p2D;
        Thu, 27 Feb 2020 18:22:42 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 37.05.60698.2F8085E5; Thu, 27
        Feb 2020 18:22:42 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200227182242eucas1p1c1de818156ec670f4744725618375303~3VXbDrl6h0931609316eucas1p1B;
        Thu, 27 Feb 2020 18:22:42 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200227182242eusmtrp280560724e53da90bf2955bf47e82724e~3VXbDHNoG1813218132eusmtrp2l;
        Thu, 27 Feb 2020 18:22:42 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-fb-5e5808f206c0
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 2E.B1.08375.2F8085E5; Thu, 27
        Feb 2020 18:22:42 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200227182242eusmtip28529938d920fb2ef180a2ce721bcf571~3VXalDIyp3109031090eusmtip2q;
        Thu, 27 Feb 2020 18:22:42 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH v3 08/27] ata: optimize ata_scsi_rbuf[] size
Date:   Thu, 27 Feb 2020 19:22:07 +0100
Message-Id: <20200227182226.19188-9-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200227182226.19188-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLKsWRmVeSWpSXmKPExsWy7djPc7qfOCLiDE7eN7ZYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRXDYpqTmZZalF+nYJXBmrN11hKvjAXrHm3H/WBsaNbF2MnBwS
        AiYSjTv/sXcxcnEICaxglNizaA4rhPOFUeLq8h1QzmdGiaVzDjJ3MXKAtXxf5g0RX84ocfL/
        Ria4juZda9hB5rIJWElMbF/FCGKLCChI9PxeyQZSxCzwnlFixaS9LCAJYQEbie5p78GKWARU
        JTZ+28EGsoFXwFbi9S0jiPvkJbZ++8QKYnMK2Enc6NsOdjevgKDEyZlPwMYwA9U0b53NDDJf
        QmAVu8THvmYWiGYXiWunVrBD2MISr45vgbJlJP7vnM8E0bCOUeJvxwuo7u2MEssn/4MGjbXE
        nXO/wC5iFtCUWL9LHyLsKDFj3QZGSFDwSdx4KwhxBJ/EpG3ToSHEK9HRJgRRrSaxYdkGNpi1
        XTtXMkPYHhKTdj9hncCoOAvJO7OQvDMLYe8CRuZVjOKppcW56anFxnmp5XrFibnFpXnpesn5
        uZsYgYno9L/jX3cw7vuTdIhRgINRiYd3wY7wOCHWxLLiytxDjBIczEoivBu/hsYJ8aYkVlal
        FuXHF5XmpBYfYpTmYFES5zVe9DJWSCA9sSQ1OzW1ILUIJsvEwSnVwLgtdrOqr3DSpPPKll/n
        r+5fnsKyY6qsVrhxw+M0tidzXeVMNu2Ou8/+XDH1/aZJ8u4Nu65nJz7Rf810WHE7r4/aRb+f
        y7gcH6xhS988MfmKSKfRRp4QnR2qLw8GH9RaNXFT4ia5h8Ibv/Nr2RTb8JjpJcUuzzjFtel3
        JUvw0z+hwS8S34vrGCuxFGckGmoxFxUnAgDZLkwMQAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsVy+t/xe7qfOCLiDO5tU7ZYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6
        djYpqTmZZalF+nYJehmrN11hKvjAXrHm3H/WBsaNbF2MHBwSAiYS35d5dzFycQgJLGWU+LVp
        ARNEXEbi+PqyLkZOIFNY4s+1LjaImk+MEh3bb7CBJNgErCQmtq9iBLFFBBQken6vBCtiFvjK
        KLF0UjczSEJYwEaie9p7sCIWAVWJjd92gC3mFbCVeH3LCGKBvMTWb59YQWxOATuJG33bweYL
        AZV0dTwFa+UVEJQ4OfMJC4jNDFTfvHU28wRGgVlIUrOQpBYwMq1iFEktLc5Nzy021CtOzC0u
        zUvXS87P3cQIjJZtx35u3sF4aWPwIUYBDkYlHt4FO8LjhFgTy4orcw8xSnAwK4nwbvwaGifE
        m5JYWZValB9fVJqTWnyI0RToh4nMUqLJ+cBIziuJNzQ1NLewNDQ3Njc2s1AS5+0QOBgjJJCe
        WJKanZpakFoE08fEwSnVwChyLXeZQ7rw2WXiy1xYrKdW/4npeXx7ss0X7XKp64I7Ts95wqPT
        rHlm2r5DRfrtSw3ara38zTwtMzgUUqO9zXds/3GOTfSQz5dU9nL73zWfr2fPMrnKJG7VfF3Q
        OOCwUKrt+eM3TmvER79vfXngzumLHz3sW+ekr5h8JmLan/iLizr/J2h0uSixFGckGmoxFxUn
        AgAbjPDGrAIAAA==
X-CMS-MailID: 20200227182242eucas1p1c1de818156ec670f4744725618375303
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200227182242eucas1p1c1de818156ec670f4744725618375303
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200227182242eucas1p1c1de818156ec670f4744725618375303
References: <20200227182226.19188-1-b.zolnierkie@samsung.com>
        <CGME20200227182242eucas1p1c1de818156ec670f4744725618375303@eucas1p1.samsung.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Currently the maximum required size of the ata_scsi_rbuf[] is
576 bytes in ata_scsiop_inq_89() so modify ATA_SCSI_RBUF_SIZE
define accordingly.

Code size savings on m68k arch using (modified) atari_defconfig:

   text    data     bss     dec     hex filename
before:
  20782     105    4096   24983    6197 drivers/ata/libata-scsi.o
after:
  20782     105     576   21463    53d7 drivers/ata/libata-scsi.o

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/libata-scsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index cc8ba49275e7..b64b0b0dfb21 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -36,7 +36,7 @@
 #include "libata.h"
 #include "libata-transport.h"
 
-#define ATA_SCSI_RBUF_SIZE	4096
+#define ATA_SCSI_RBUF_SIZE	576
 
 static DEFINE_SPINLOCK(ata_scsi_rbuf_lock);
 static u8 ata_scsi_rbuf[ATA_SCSI_RBUF_SIZE];
-- 
2.24.1

