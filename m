Return-Path: <SRS0=jBxd=5L=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF36C2D0E5
	for <linux-ide@archiver.kernel.org>; Thu, 26 Mar 2020 16:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04ADD2073E
	for <linux-ide@archiver.kernel.org>; Thu, 26 Mar 2020 16:00:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hYaAooai"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbgCZQAO (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 26 Mar 2020 12:00:14 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:58881 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728390AbgCZP6n (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 26 Mar 2020 11:58:43 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200326155841euoutp01166e430a58de15202abefdce09cbac40~-5drC53Wa2877928779euoutp014
        for <linux-ide@vger.kernel.org>; Thu, 26 Mar 2020 15:58:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200326155841euoutp01166e430a58de15202abefdce09cbac40~-5drC53Wa2877928779euoutp014
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585238321;
        bh=uB5REbM6qvTdR0z875YicVsRld+jLQkopqUIKDFj8Ic=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hYaAooaiRH04Dns9lDdo8przfK3rweWdri2O6SIkLPxtxsENeOySTYvLaMNVjkAtU
         b8AKcBiQ9BjH7nQEYD7huwpQZdpiYgYHCzu4hjwseOLJocf7V7BSl2E79gkHI+6biH
         1oHkMJPpa0U0oou+K32i18Elf67VMbbpWDWp1/4Y=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200326155841eucas1p29ae176fd61985ce6b00a5d1c22b159c9~-5dqtWQUI2253722537eucas1p2W;
        Thu, 26 Mar 2020 15:58:41 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 33.E9.60679.131DC7E5; Thu, 26
        Mar 2020 15:58:41 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200326155840eucas1p2861601dc1c971a2baade72b03baee9f0~-5dqVsn7f2633426334eucas1p2S;
        Thu, 26 Mar 2020 15:58:40 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200326155840eusmtrp185466e05b23bafa395a79485444b1263~-5dqVJyU72090020900eusmtrp1b;
        Thu, 26 Mar 2020 15:58:40 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-c2-5e7cd131eaa0
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id B8.5A.08375.031DC7E5; Thu, 26
        Mar 2020 15:58:40 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200326155840eusmtip108d84caafd650e558db4bc09649afec7~-5dp7KxMr0765307653eusmtip1j;
        Thu, 26 Mar 2020 15:58:40 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH v5 06/27] ata: use COMMAND_LINE_SIZE for
 ata_force_param_buf[] size
Date:   Thu, 26 Mar 2020 16:58:01 +0100
Message-Id: <20200326155822.19400-7-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200326155822.19400-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNKsWRmVeSWpSXmKPExsWy7djP87qGF2viDLoXc1qsvtvPZrFxxnpW
        i2e39jJZrFx9lMni2I5HTBaXd81hs1j+ZC2zxdzW6ewOHB47Z91l97h8ttTj0OEORo+Trd9Y
        PHbfbGDz6NuyitHj8ya5APYoLpuU1JzMstQifbsErowdDctZCx7wVhzsiWlg3MfdxcjJISFg
        IrGofQVbFyMXh5DACkaJF/cbmEASQgJfGCVmPNGBSHxmlFixqYkJpqPvTC9Ux3JGic8/XrFD
        OEAdkxfeYQSpYhOwkpjYvgrMFhFQkOj5vRKsg1ngPdCoSXtZQBLCAqESvxu3s4PYLAKqEle2
        twE1cHDwCthKfPgmALFNXmLrt0+sIDangJ3E8nXzmUFsXgFBiZMzn4CNYQaqad46mxlkvoTA
        MnaJH2+fsoDMkRBwkdi5lRNijrDEq+Nb2CFsGYnTk3tYIOrXMUr87XgB1bydUWL55H9sEFXW
        EnfO/WIDGcQsoCmxfpc+RNhRovPZE6j5fBI33gpC3MAnMWnbdGaIMK9ER5sQRLWaxIZlG9hg
        1nbtXMkMYXtIHLlzmHUCo+IsJN/MQvLNLIS9CxiZVzGKp5YW56anFhvlpZbrFSfmFpfmpesl
        5+duYgQmodP/jn/ZwbjrT9IhRgEORiUeXo2Wmjgh1sSy4srcQ4wSHMxKIrxPI4FCvCmJlVWp
        RfnxRaU5qcWHGKU5WJTEeY0XvYwVEkhPLEnNTk0tSC2CyTJxcEo1MDJVWUTrHQ3WTn51Wj3y
        +2GNWrk5U5g0ZthmHGa+d/XIe9UHl9bKtGWwxUw5aZK1rqkw0r7hsaKCktPvLmbR5dsEThY/
        PuLpondlY1z9pU0CwXOXRK1YoPHLi+vlxv8HTgj4zFw/+Wnq6oxnj+Y2d+32Ofdj4xWRrBfL
        mtmPusX37X2QvyiNxUKJpTgj0VCLuag4EQDWDst0PgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsVy+t/xu7oGF2viDH6f1rNYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6
        djYpqTmZZalF+nYJehk7GpazFjzgrTjYE9PAuI+7i5GTQ0LARKLvTC9bFyMXh5DAUkaJ7jOL
        mLoYOYASMhLH15dB1AhL/LnWBVXziVHi7f71jCAJNgEriYntq8BsEQEFiZ7fK8GKmAW+Mkos
        ndTNDJIQFgiWuHZxIROIzSKgKnFlexsjyAJeAVuJD98EIBbIS2z99okVxOYUsJNYvm4+WKsQ
        UMniLx/AWnkFBCVOznzCAmIzA9U3b53NPIFRYBaS1CwkqQWMTKsYRVJLi3PTc4sN9YoTc4tL
        89L1kvNzNzECo2XbsZ+bdzBe2hh8iFGAg1GJh1ejpSZOiDWxrLgy9xCjBAezkgjv00igEG9K
        YmVValF+fFFpTmrxIUZToB8mMkuJJucDIzmvJN7Q1NDcwtLQ3Njc2MxCSZy3Q+BgjJBAemJJ
        anZqakFqEUwfEwenVANjsXHz76siap7cWWyTf21ti2D5tt+IIavUZ9f1MFGnNfZLhJf+vjTH
        9bBp15abxzZeKyw6H6XycvUjnhWedr5rFghJdLuJztp/W3pxQ4VduQP7d9ac+YYOf0o7izal
        3+Jvced9r60i/bqzLmRN76dlxzYc9O46yOGz9YTJtDWq4Wza9bwbDJWUWIozEg21mIuKEwGg
        1iWNrAIAAA==
X-CMS-MailID: 20200326155840eucas1p2861601dc1c971a2baade72b03baee9f0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200326155840eucas1p2861601dc1c971a2baade72b03baee9f0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200326155840eucas1p2861601dc1c971a2baade72b03baee9f0
References: <20200326155822.19400-1-b.zolnierkie@samsung.com>
        <CGME20200326155840eucas1p2861601dc1c971a2baade72b03baee9f0@eucas1p2.samsung.com>
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

