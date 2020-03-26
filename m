Return-Path: <SRS0=jBxd=5L=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF9BC2D0E5
	for <linux-ide@archiver.kernel.org>; Thu, 26 Mar 2020 16:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFE442078E
	for <linux-ide@archiver.kernel.org>; Thu, 26 Mar 2020 16:00:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ffp2+PUd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbgCZQAH (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 26 Mar 2020 12:00:07 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:58904 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728466AbgCZP6o (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 26 Mar 2020 11:58:44 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200326155842euoutp01c7b081086578415eb01f375508f9d418~-5drl7QS62877928779euoutp017
        for <linux-ide@vger.kernel.org>; Thu, 26 Mar 2020 15:58:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200326155842euoutp01c7b081086578415eb01f375508f9d418~-5drl7QS62877928779euoutp017
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585238322;
        bh=l5IgQ4ltG81TrQ9RCf6yeTDqu8xPm425WXsmFH9AT7U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ffp2+PUdhOSrJvK50YkvDatFR/uyYJHI8S9IRBMyHvwOZ1cx1rrNhYWXu26W+ua0r
         FOc5u+fW1X8Sq/jFgjhSF4TgvL4Kh6xqySIzTrNGQwfnahLtBlctuRt3u/Un6LuDEH
         oNGfxLMdxIFFFLuNJ5x4jvZHz+FdzIgFU7hFLJ9g=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200326155841eucas1p154d76ffd5718befbaa3ce61c4a39aa69~-5drXe-5B0138201382eucas1p1E;
        Thu, 26 Mar 2020 15:58:41 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id B1.F7.60698.131DC7E5; Thu, 26
        Mar 2020 15:58:41 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200326155841eucas1p29ed1b37ca4364f205c6404ed978aa007~-5drFkVtr2255222552eucas1p2H;
        Thu, 26 Mar 2020 15:58:41 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200326155841eusmtrp1002e3c73302391fbf568638951a66ddd~-5drE3KMz2090020900eusmtrp1d;
        Thu, 26 Mar 2020 15:58:41 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-8d-5e7cd1310ffc
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id E9.5A.08375.131DC7E5; Thu, 26
        Mar 2020 15:58:41 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200326155841eusmtip1c89d85a98396ac92b5c4657e922ad9f6~-5dqrJv2I0490504905eusmtip1Q;
        Thu, 26 Mar 2020 15:58:41 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH v5 08/27] ata: optimize ata_scsi_rbuf[] size
Date:   Thu, 26 Mar 2020 16:58:03 +0100
Message-Id: <20200326155822.19400-9-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200326155822.19400-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPKsWRmVeSWpSXmKPExsWy7djPc7qGF2viDE4uM7FYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRXDYpqTmZZalF+nYJXBkrm54zFczlqJj04hh7A+NNti5GTg4J
        AROJG9f+sXYxcnEICaxglDiz/AoThPOFUeJ2x0M2COczo8ThhZsZYVqmfV7MDpFYziix9Pw1
        RriWjm2LmUCq2ASsJCa2rwLrEBFQkOj5vRJsFLPAe0aJFZP2soAkhAVsJJ78W80KYrMIqEq8
        3/0SrJlXwFbi/rbZrBDr5CW2fvsEZnMK2EksXzefGaJGUOLkzCdgc5iBapq3zmYGWSAhsIpd
        4mXDYxaIZheJt90/oGxhiVfHt7BD2DISpyf3sEA0rGOU+NvxAqp7O6PE8sn/oIFjLXHn3C8g
        mwNohabE+l36EGFHiW9NW5lBwhICfBI33gpCHMEnMWnbdKgwr0RHmxBEtZrEhmUb2GDWdu1c
        yQxhe0hcO9LLNoFRcRaSd2YheWcWwt4FjMyrGMVTS4tz01OLjfNSy/WKE3OLS/PS9ZLzczcx
        ApPR6X/Hv+5g3Pcn6RCjAAejEg9vQ1tNnBBrYllxZe4hRgkOZiUR3qeRQCHelMTKqtSi/Pii
        0pzU4kOM0hwsSuK8xotexgoJpCeWpGanphakFsFkmTg4pRoY9xl0Par7teNZ0Fkru46LW2ud
        uOZYMG2vXnWf9T6HjzSz1BEnX/YPOxSZ93rGLDab4Ltsr3H5roSpkQf2fg8rjtLZy6Lqli1t
        Kqp+9Wfi25lNP2/WBv4T9y0z3Ht73SkW2/hPdTO/Z8x8MUX1wKNGy+/36vfa+PPn3VHO2yja
        qqXZeHJ3aOolJZbijERDLeai4kQAT9uir0IDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsVy+t/xu7qGF2viDA5+UbFYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6
        djYpqTmZZalF+nYJehkrm54zFczlqJj04hh7A+NNti5GTg4JAROJaZ8Xs3cxcnEICSxllNh9
        5TtrFyMHUEJG4vj6MogaYYk/17rYIGo+MUpcnf+aHSTBJmAlMbF9FSOILSKgINHzeyVYEbPA
        V0aJpZO6mUESwgI2Ek/+rWYFsVkEVCXe737JBGLzCthK3N82mxVig7zE1m+fwGxOATuJ5evm
        g/UKAdUs/vIBql5Q4uTMJywgNjNQffPW2cwTGAVmIUnNQpJawMi0ilEktbQ4Nz232FCvODG3
        uDQvXS85P3cTIzBith37uXkH46WNwYcYBTgYlXh4NVpq4oRYE8uKK3MPMUpwMCuJ8D6NBArx
        piRWVqUW5ccXleakFh9iNAV6YiKzlGhyPjCa80riDU0NzS0sDc2NzY3NLJTEeTsEDsYICaQn
        lqRmp6YWpBbB9DFxcEo1ME6/eYPbyLFFqbpj6p/5fo2+8aUCOUJmxWK/r8TZT413ExBqPF96
        oqVm+6HdqbMuFEf/ZCp5wHCg+/jBCCs+61DJG2fkA+9YrVfIfRf/+FpaDfOSS1bnWGfHzZkb
        Y9dyf+raK/t4f/nX+e/mKHw5kcf/6IPlcrPXb1fbI9P1oH62xIrt2bP+ySixFGckGmoxFxUn
        AgAcUmyirgIAAA==
X-CMS-MailID: 20200326155841eucas1p29ed1b37ca4364f205c6404ed978aa007
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200326155841eucas1p29ed1b37ca4364f205c6404ed978aa007
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200326155841eucas1p29ed1b37ca4364f205c6404ed978aa007
References: <20200326155822.19400-1-b.zolnierkie@samsung.com>
        <CGME20200326155841eucas1p29ed1b37ca4364f205c6404ed978aa007@eucas1p2.samsung.com>
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

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/libata-scsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 0912acb82b80..c2b8428dfb94 100644
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

