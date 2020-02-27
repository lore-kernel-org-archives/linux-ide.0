Return-Path: <SRS0=ljer=4P=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEDC2C35E17
	for <linux-ide@archiver.kernel.org>; Thu, 27 Feb 2020 18:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AE0E246B4
	for <linux-ide@archiver.kernel.org>; Thu, 27 Feb 2020 18:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rm4ZZpbC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730914AbgB0SWo (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 27 Feb 2020 13:22:44 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:39705 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730888AbgB0SWn (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 27 Feb 2020 13:22:43 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200227182242euoutp017e389cb6f59718046513cd26757d8858~3VXajapFn1217012170euoutp01i
        for <linux-ide@vger.kernel.org>; Thu, 27 Feb 2020 18:22:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200227182242euoutp017e389cb6f59718046513cd26757d8858~3VXajapFn1217012170euoutp01i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1582827762;
        bh=uB5REbM6qvTdR0z875YicVsRld+jLQkopqUIKDFj8Ic=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rm4ZZpbCLtiv8nV4Y4hcEWxjZSZTB6xv0+MPGNBp2bb4Bpp4EfX+v4HgMNOWAem00
         zKihWseg8iYIU/ifBOT/Hq9sENTOXNbnmajzLA96nskXkomyyVn5luHJJIYqk6hOI5
         AA6u9TUy35bdAAUIu0DiU+zJkj15tPXaq3Yx0s1s=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200227182241eucas1p1b0eb9b8dd3c20c00b44b42f124adc09f~3VXaZi9Tn1935419354eucas1p1s;
        Thu, 27 Feb 2020 18:22:41 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id A6.05.60698.1F8085E5; Thu, 27
        Feb 2020 18:22:41 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200227182241eucas1p12ef86c45356afb2230871d84dab04431~3VXaLBd7_0494604946eucas1p1E;
        Thu, 27 Feb 2020 18:22:41 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200227182241eusmtrp2d961943d6d4c976d9b59643739a53861~3VXaKe6rO1813218132eusmtrp2k;
        Thu, 27 Feb 2020 18:22:41 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-f8-5e5808f193be
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 9D.B1.08375.1F8085E5; Thu, 27
        Feb 2020 18:22:41 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200227182241eusmtip2420239d8521ab9102f55c9103b7b9a45~3VXZrovrl1203512035eusmtip2N;
        Thu, 27 Feb 2020 18:22:41 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH v3 06/27] ata: use COMMAND_LINE_SIZE for
 ata_force_param_buf[] size
Date:   Thu, 27 Feb 2020 19:22:05 +0100
Message-Id: <20200227182226.19188-7-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200227182226.19188-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHKsWRmVeSWpSXmKPExsWy7djPc7ofOSLiDK78N7VYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRXDYpqTmZZalF+nYJXBk7GpazFjzgrTjYE9PAuI+7i5GTQ0LA
        RKL3+if2LkYuDiGBFYwSnc/OM0E4Xxgldt26xwLhfGaUeLt1ITtMS+eFt8wQieWMEvc272WG
        a3nx4QojSBWbgJXExPZVYLaIgIJEz++VbCBFzALvGSVWTNrLApIQFgiVaHx+FcxmEVCV+NkP
        0cArYCtx4fwmJoh18hJbv31iBbE5BewkbvRtZ4OoEZQ4OfMJWC8zUE3z1tlgV0gILGOXOPB9
        ARtEs4vErO2LGCFsYYlXx7dA/SAj8X/nfCaIhnWMEn87XkB1b2eUWD75H1S3tcSdc7+AbA6g
        FZoS63fpQ4QdJX6cuMgOEpYQ4JO48VYQ4gg+iUnbpjNDhHklOtqEIKrVJDYs28AGs7Zr50pm
        CNtDYvn1G8wTGBVnIXlnFpJ3ZiHsXcDIvIpRPLW0ODc9tdg4L7Vcrzgxt7g0L10vOT93EyMw
        FZ3+d/zrDsZ9f5IOMQpwMCrx8C7YER4nxJpYVlyZe4hRgoNZSYR349fQOCHelMTKqtSi/Pii
        0pzU4kOM0hwsSuK8xotexgoJpCeWpGanphakFsFkmTg4pRoYbRY+Nv6s+q35tmHA54oQ0Uk3
        FHJYeVLmHxYRVFN4JVdu+lr6Z+vNxZ92vixY9rLB7uxcdl6+ip8PmPb63rg++6SPZOkewTUF
        PuVnWSOWfJD77Wsvsvct1/rO2IMfDyybdW5nb8Zhoc0VPf4rgzfs21A49UKLiYdLfehRVq4f
        T3aFaPJuurLtnBJLcUaioRZzUXEiACwAzK9BAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsVy+t/xe7ofOSLiDKY9V7ZYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6
        djYpqTmZZalF+nYJehk7GpazFjzgrTjYE9PAuI+7i5GTQ0LARKLzwlvmLkYuDiGBpYwSzx88
        AHI4gBIyEsfXl0HUCEv8udbFBmILCXxilGj9rwpiswlYSUxsX8UIYosIKEj0/F7JBjKHWeAr
        o8TSSd3MIAlhgWCJqTP+ghWxCKhK/OyHaOAVsJW4cH4TE8QCeYmt3z6xgticAnYSN/q2Qy2z
        lejqeApVLyhxcuYTFhCbGai+eets5gmMArOQpGYhSS1gZFrFKJJaWpybnltsqFecmFtcmpeu
        l5yfu4kRGC3bjv3cvIPx0sbgQ4wCHIxKPLwLdoTHCbEmlhVX5h5ilOBgVhLh3fg1NE6INyWx
        siq1KD++qDQntfgQoynQExOZpUST84GRnFcSb2hqaG5haWhubG5sZqEkztshcDBGSCA9sSQ1
        OzW1ILUIpo+Jg1OqgdFguczfC2VGskGP/gVrJHTuPFNww68gTize50nSat3EbyktyZlR7TkM
        V2bW592Pcr7rMkNtSsRH1i1Pw71mttwM2MeldiLS9aiAgnLDp8SPdyVsZzw783ryrpvPpp04
        vSbhCGssi3OGqlnY1ublIcK7Nl41z4me3y8mcmN2kHL6zryTDwvumSmxFGckGmoxFxUnAgCg
        +iEsrAIAAA==
X-CMS-MailID: 20200227182241eucas1p12ef86c45356afb2230871d84dab04431
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200227182241eucas1p12ef86c45356afb2230871d84dab04431
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200227182241eucas1p12ef86c45356afb2230871d84dab04431
References: <20200227182226.19188-1-b.zolnierkie@samsung.com>
        <CGME20200227182241eucas1p12ef86c45356afb2230871d84dab04431@eucas1p1.samsung.com>
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
index 4991f9d5def8..a9a8762448aa 100644
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

