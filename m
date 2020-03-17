Return-Path: <SRS0=AjNr=5C=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCDB1C3F2CE
	for <linux-ide@archiver.kernel.org>; Tue, 17 Mar 2020 14:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A33B120735
	for <linux-ide@archiver.kernel.org>; Tue, 17 Mar 2020 14:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rWKgsf3t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgCQOpK (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 17 Mar 2020 10:45:10 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:40365 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbgCQOnr (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 17 Mar 2020 10:43:47 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200317144345euoutp025bff6c005ec302e06beb8ce35f25fb72~9Horu7e6R1583015830euoutp025
        for <linux-ide@vger.kernel.org>; Tue, 17 Mar 2020 14:43:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200317144345euoutp025bff6c005ec302e06beb8ce35f25fb72~9Horu7e6R1583015830euoutp025
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1584456226;
        bh=UZMkkZJmuwgJ9h/9xP12ngsc7guK8yGZ+GzMsUr26pA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rWKgsf3tf8FhQSF0nxgAK1M06/DxBmYYp+a9wlaBzueYOLF0Ua+gxJogLrZOMubj6
         aRaBTDKsdSOsvx+mOccuXpV4wM5vI0NoTu4szeue1xBj/V2s6TWxZmPZKf90m1lHuW
         IlWRkQZmo27WV9nAvPEMivK2vWqlWig2rUFd+Drk=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200317144345eucas1p2757b08e1ff651bb2ba49833c2be2b468~9HorTXQTZ0343903439eucas1p2L;
        Tue, 17 Mar 2020 14:43:45 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 9D.D3.61286.122E07E5; Tue, 17
        Mar 2020 14:43:45 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200317144345eucas1p1e67d48caa8629fedb301e776e34dc0c1~9Hoq_2DYv1084510845eucas1p1P;
        Tue, 17 Mar 2020 14:43:45 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200317144345eusmtrp241864ac45efed72590955417b5329dcd~9Hoq_SY5M0146401464eusmtrp2H;
        Tue, 17 Mar 2020 14:43:45 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-27-5e70e221a79e
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id C8.23.07950.122E07E5; Tue, 17
        Mar 2020 14:43:45 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200317144344eusmtip171322079b95fbe6e89e5aa11445b5e0f~9HoqbjhzK0973309733eusmtip1T;
        Tue, 17 Mar 2020 14:43:44 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH v4 08/27] ata: optimize ata_scsi_rbuf[] size
Date:   Tue, 17 Mar 2020 15:43:14 +0100
Message-Id: <20200317144333.2904-9-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200317144333.2904-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbSxVYRzfc8+55xw3V8eleSbzcrdqSWT14ShKL6sz1fLZ1tUtZxj30jne
        P8SSwpTSFt3LGOa6V7juvMua622yUmnykoZEGJW3FkWOw/j2e34vz+//f/YQiKxCbE+EqqMY
        Vq0Ml2MStLbjT89Rl7FIxbHiEXuqbDgTo6pyKsXUxGCziNKXtYuojvoxEdXbmItRuvFyhMpL
        ycZ9CbpBM4zTvW+iaXNrKqC7UpZRumkgCaMfVRsAvWBy9McDJN5BTHhoDMN6nL4hCWk2DGGR
        P/G4h6PrWBKowtKBBQHJE7Bv7hNIBxJCRpYC2J/bjQuHRQA777ZvKQsADjSZwXZkakYvFgQd
        gCsZ2p3I62d9It6FkSfhkweGzYQt6QwzVvUYb0LIHwCWZjWjvGBDesOXS7oNE0Gg5AG4kuPK
        09INei5vFBXanGDN8ryYxxakD+xrXcMEjzXsej6+6UE2PMk1WoS/H5IlOGwcmxQJ4QuwrOCF
        WMA2cLqzGhewA1xvyBcJgQoA/6V+30rXAah7urb1Nqfg57crGD8dQh6GlY0eAn0WvkqbQXka
        klawf9ZaGMIKZtVmIwIthan3ZYL7IDSWGLHt2vQGPSJgGk4adOAxcNHsWkezax3NTm8BQAzA
        jonmVMEM56lmYt05pYqLVge734pQmcDGL+pe65yvB0sfbpoBSQC5pZQwRipkYmUMF68yA0gg
        cltp0e0IhUwapIxPYNiIQDY6nOHMYD+Byu2kxwunrsvIYGUUE8YwkQy7rYoIC/skcC/kyhc5
        bSIj2ubH169SPedm870UAXaA8MMzk+/kmuLek0btyISjZvRX15Dp3TR7xOfrN789mNuUZWrg
        x4sLzYEKuoBztm1bRc8UWNU5xbdU/t5Xfknvlob5lxTu9fzraD2YyGpjwy77Jl47r/c6NGev
        SnAbdaKKxUVRDostcpQLUXq6Iiyn/A+GX8APQQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsVy+t/xu7qKjwriDM7dZLZYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6
        djYpqTmZZalF+nYJehl7V91mK/jAXtH78D9bA+NGti5GTg4JAROJl69XsnYxcnEICSxllDh7
        ZA5jFyMHUEJG4vj6MogaYYk/17rYIGo+MUpM/nyWGSTBJmAlMbF9FSOILSKgINHzeyVYEbPA
        V0aJpZO6wYqEBWwk9nxdDjaURUBV4tcMLZAwL1D43dyHLBAL5CW2fvvECmJzCthKXDv8D+w4
        IaCaF2/+M0HUC0qcnPkErJ4ZqL5562zmCYwCs5CkZiFJLWBkWsUoklpanJueW2ykV5yYW1ya
        l66XnJ+7iREYL9uO/dyyg7HrXfAhRgEORiUeXo4NBXFCrIllxZW5hxglOJiVRHgXF+bHCfGm
        JFZWpRblxxeV5qQWH2I0BfphIrOUaHI+MJbzSuINTQ3NLSwNzY3Njc0slMR5OwQOxggJpCeW
        pGanphakFsH0MXFwSjUwLmFet2PK26C7GnftLav3ujbkM02tqGCSDDY/1L9no12+1IJ1l/Tt
        sw6ey+l+HsZuNtfIylv30vf6/T8StnNPV9xsK/kwLj1o87ufF/Pfuxtd4m9l3ZHdfaT7U6fA
        j7LE4JnfWuouvZ8SG/HdbMLSV/PTmx2MTinp9HOUvbKd9/3MUadJNxXDlViKMxINtZiLihMB
        nkJBoq0CAAA=
X-CMS-MailID: 20200317144345eucas1p1e67d48caa8629fedb301e776e34dc0c1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200317144345eucas1p1e67d48caa8629fedb301e776e34dc0c1
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200317144345eucas1p1e67d48caa8629fedb301e776e34dc0c1
References: <20200317144333.2904-1-b.zolnierkie@samsung.com>
        <CGME20200317144345eucas1p1e67d48caa8629fedb301e776e34dc0c1@eucas1p1.samsung.com>
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
index 2a43eef97b87..7bdda82fe886 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -37,7 +37,7 @@
 #include "libata.h"
 #include "libata-transport.h"
 
-#define ATA_SCSI_RBUF_SIZE	4096
+#define ATA_SCSI_RBUF_SIZE	576
 
 static DEFINE_SPINLOCK(ata_scsi_rbuf_lock);
 static u8 ata_scsi_rbuf[ATA_SCSI_RBUF_SIZE];
-- 
2.24.1

