Return-Path: <SRS0=qhS8=33=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA6CC352A4
	for <linux-ide@archiver.kernel.org>; Fri,  7 Feb 2020 14:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A178121775
	for <linux-ide@archiver.kernel.org>; Fri,  7 Feb 2020 14:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="jy4WfOge"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbgBGO14 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 7 Feb 2020 09:27:56 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:49591 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727663AbgBGO14 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 7 Feb 2020 09:27:56 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200207142755euoutp02d339919e96fd8f70c84c9cfd1e2bfe8a~xJQtm2pV42687226872euoutp02E
        for <linux-ide@vger.kernel.org>; Fri,  7 Feb 2020 14:27:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200207142755euoutp02d339919e96fd8f70c84c9cfd1e2bfe8a~xJQtm2pV42687226872euoutp02E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1581085675;
        bh=k54coT1kqZaTfz06GsIjLFUEKc9qg0iR4MGAagEkR90=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jy4WfOgeWxQ0734eY0E/uHQsa2Mgzb5l2zOF4Rx2Y65GS+AvcZR/nC6oFGgGiSzlW
         yeofSzOyRQ9n/gyD8X0h7b55zoFcBIJ728m5pvqcBg7cOdzmeX8aBJjTt5czbJpJrY
         STv71ji/T4jzdAyX5pP87uCYFaQ+9mIeSMF8aFPE=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200207142754eucas1p2f85f8bdc5ea0ebf93d2e3e49b929725b~xJQtSkoeF3244632446eucas1p2p;
        Fri,  7 Feb 2020 14:27:54 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id CE.C8.60698.AE37D3E5; Fri,  7
        Feb 2020 14:27:54 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200207142754eucas1p1e7f756105a9187d394ad70d5d91aaa3b~xJQsx4Qfi0217502175eucas1p1-;
        Fri,  7 Feb 2020 14:27:54 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200207142754eusmtrp1d829bc8b962a6b22bc788c16540e1aee~xJQsxRYjG0480004800eusmtrp1-;
        Fri,  7 Feb 2020 14:27:54 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-b9-5e3d73eaf9f2
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 89.89.08375.AE37D3E5; Fri,  7
        Feb 2020 14:27:54 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200207142753eusmtip27242f8a7d3382b5e47d994bb50b72802~xJQsQflpP2944029440eusmtip2a;
        Fri,  7 Feb 2020 14:27:53 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH v2 06/26] ata: use COMMAND_LINE_SIZE for
 ata_force_param_buf[] size
Date:   Fri,  7 Feb 2020 15:27:14 +0100
Message-Id: <20200207142734.8431-7-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200207142734.8431-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLKsWRmVeSWpSXmKPExsWy7djPc7qvim3jDB5O0rJYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRXDYpqTmZZalF+nYJXBm7t99nLXjAW/Gn5TtLA+M+7i5GDg4J
        AROJln3sXYxcHEICKxglpn/uZoFwvjBKXLzylbmLkRPI+cwocfpAJogN0rBl7ylWiKLljBLn
        l19H6Hg8eQE7SBWbgJXExPZVjCC2iICCRM/vlWwgRcwC7xklVkzaywKSEBYIlZh06DyYzSKg
        KjF/yVkwm1fARqKlbxozxDp5ia3fPrGC2JwCthIfp/xlg6gRlDg58wlYPTNQTfPW2cwgCyQE
        VrFLXNu1mw2i2UViY+ckKFtY4tXxLewQtozE6ck9LBAN6xgl/na8gOreziixfPI/qA5riTvn
        frGBgolZQFNi/S59iLCjxOqXV5ghoccnceOtIMQRfBKTtk2HCvNKdLQJQVSrSWxYtoENZm3X
        zpVQf3lIzLs8gWkCo+IsJO/MQvLOLIS9CxiZVzGKp5YW56anFhvnpZbrFSfmFpfmpesl5+du
        YgQmotP/jn/dwbjvT9IhRgEORiUe3gRHmzgh1sSy4srcQ4wSHMxKIrx9qrZxQrwpiZVVqUX5
        8UWlOanFhxilOViUxHmNF72MFRJITyxJzU5NLUgtgskycXBKNTAWshb4u5z1yUqP1zvwTnLO
        teqfGQJZe+L9kxmyNukcucf7Y7bwuWpTNlaX5sts9YEq+5J4DVKi8240dSzKtK+LWSjZZGZm
        Z3stvcHNTWFec7DMsuVbotOlVM9pR3La8qfn7tFk7YxnZ4t4Fh54/m3wiUm3K3ez3IqbUqj9
        7qxvdtHGFaz2SizFGYmGWsxFxYkAFJUHiUADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsVy+t/xe7qvim3jDI7PZrVYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6
        djYpqTmZZalF+nYJehm7t99nLXjAW/Gn5TtLA+M+7i5GTg4JAROJLXtPsXYxcnEICSxllPi4
        /ih7FyMHUEJG4vj6MogaYYk/17rYIGo+MUqsfnaBCSTBJmAlMbF9FSOILSKgINHzeyVYEbPA
        V0aJpZO6mUESwgLBEs9PTwArYhFQlZi/5CwLiM0rYCPR0jeNGWKDvMTWb59YQWxOAVuJj1P+
        soHYQkA1399PYoeoF5Q4OfMJWC8zUH3z1tnMExgFZiFJzUKSWsDItIpRJLW0ODc9t9hQrzgx
        t7g0L10vOT93EyMwYrYd+7l5B+OljcGHGAU4GJV4eBMcbeKEWBPLiitzDzFKcDArifD2qdrG
        CfGmJFZWpRblxxeV5qQWH2I0BXpiIrOUaHI+MJrzSuINTQ3NLSwNzY3Njc0slMR5OwQOxggJ
        pCeWpGanphakFsH0MXFwSjUw1lh84ZKdwRBUv817EtPtqp0b1ulPKTq6bNP+RW/ZX3duPOTj
        IqE7m1f2iMPLFSVbf3094Rbuy3z49s+Z8pc2qO2bF+X2rXllzenykDCfqNd989n3d3ItOsC9
        3ix2lmfp/g81k2Q3M+34ySfpzJqU6798puDRC4wBS4sk886rVzUfkuqw3nTSRomlOCPRUIu5
        qDgRAJkqQLquAgAA
X-CMS-MailID: 20200207142754eucas1p1e7f756105a9187d394ad70d5d91aaa3b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200207142754eucas1p1e7f756105a9187d394ad70d5d91aaa3b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200207142754eucas1p1e7f756105a9187d394ad70d5d91aaa3b
References: <20200207142734.8431-1-b.zolnierkie@samsung.com>
        <CGME20200207142754eucas1p1e7f756105a9187d394ad70d5d91aaa3b@eucas1p1.samsung.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Use COMMAND_LINE_SIZE instead PAGE_SIZE for ata_force_param_buf[]
size as libata parameters buffer doesn't need to be bigger than
the command line buffer.

For many architectures this results in decreased libata-core.o
size (COMMAND_LINE_SIZE varies from 256 to 4096 while the minimum
PAGE_SIZE is 4096).

Code size savings on m68k arch using (modified) atari_defconfig:

   text    data     bss     dec     hex filename
before:
  41064    4413      40   45517    b1cd drivers/ata/libata-core.o
after:
  41064     573      40   41677    a2cd drivers/ata/libata-core.o

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/libata-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index fa36e3248039..9b824788d04f 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -52,6 +52,7 @@
 #include <linux/leds.h>
 #include <linux/pm_runtime.h>
 #include <linux/platform_device.h>
+#include <asm/setup.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/libata.h>
@@ -106,7 +107,7 @@ struct ata_force_ent {
 static struct ata_force_ent *ata_force_tbl;
 static int ata_force_tbl_size;
 
-static char ata_force_param_buf[PAGE_SIZE] __initdata;
+static char ata_force_param_buf[COMMAND_LINE_SIZE] __initdata;
 /* param_buf is thrown away after initialization, disallow read */
 module_param_string(force, ata_force_param_buf, sizeof(ata_force_param_buf), 0);
 MODULE_PARM_DESC(force, "Force ATA configurations including cable type, link speed and transfer mode (see Documentation/admin-guide/kernel-parameters.rst for details)");
-- 
2.24.1

