Return-Path: <SRS0=dw68=3R=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB12BC2D0DB
	for <linux-ide@archiver.kernel.org>; Tue, 28 Jan 2020 13:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4EE62468A
	for <linux-ide@archiver.kernel.org>; Tue, 28 Jan 2020 13:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="KT0pxhiM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgA1Nfk (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 28 Jan 2020 08:35:40 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:58897 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbgA1NeP (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 28 Jan 2020 08:34:15 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200128133413euoutp01264b56a73ead9967f8acc8718b2517df~uEE_dQMGw0325703257euoutp01H
        for <linux-ide@vger.kernel.org>; Tue, 28 Jan 2020 13:34:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200128133413euoutp01264b56a73ead9967f8acc8718b2517df~uEE_dQMGw0325703257euoutp01H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1580218453;
        bh=/11LmSbFfdh3lGOnCOAUTninvk6Wt0TVSztP/3TorhE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KT0pxhiMNCHLgGsB1CL1eK0LpJF4Gn4LbD17e8c2rejGyOhE2Vw2j7zctWl/A82Ix
         mnfKQ0mBGCC3Pq3RHnpbS3DFzPf1Cd3ngkRepepVPgqauV6DBWLQ80inNRMgDpeY0A
         HN1R2XqW2HG2D/F16ITnVH32qIdmj4pbSEY96wqU=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200128133413eucas1p20925a186899017da2847ee4496b75234~uEE_M0CL13103131031eucas1p2j;
        Tue, 28 Jan 2020 13:34:13 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id CF.4A.60679.458303E5; Tue, 28
        Jan 2020 13:34:13 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200128133412eucas1p2e5e3e29ea554bf57c1f2cc05b3d2d3a8~uEE9ybhBt3103131031eucas1p2g;
        Tue, 28 Jan 2020 13:34:12 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200128133412eusmtrp2364ffdb82b445e49ba0247723586887f~uEE9x1s9h0330003300eusmtrp2s;
        Tue, 28 Jan 2020 13:34:12 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-40-5e303854459c
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 60.92.08375.458303E5; Tue, 28
        Jan 2020 13:34:12 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200128133412eusmtip2d5453687e98874aad5186544fdac3a11~uEE9dRBFR0657106571eusmtip2d;
        Tue, 28 Jan 2020 13:34:12 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH 06/28] ata: use COMMAND_LINE_SIZE for ata_force_param_buf[]
 size
Date:   Tue, 28 Jan 2020 14:33:21 +0100
Message-Id: <20200128133343.29905-7-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200128133343.29905-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBKsWRmVeSWpSXmKPExsWy7djPc7qhFgZxBhf8LFbf7Wez2DhjPavF
        s1t7mSyO7XjEZHF51xw2i7mt09kd2Dx2zrrL7nH5bKnHocMdjB59W1YxenzeJBfAGsVlk5Ka
        k1mWWqRvl8CVMeX1QuaCFbwVD6adY29g7OHuYuTkkBAwkVj44wRLFyMXh5DACkaJw3/nQjlf
        GCUWrPoC5XxmlNjV9JgdpmXOnK3sEInljBIXN05gg2s5M7WDDaSKTcBKYmL7KkYQW0RAQaLn
        90qwImaBNYwSqw43gSWEBYIkrk1+BmazCKhKXLhxghXE5hWwlbj7fxMLxDp5ia3fPgHFOTg4
        BewkevaaQ5QISpyc+QSshBmopHnrbGaI8nZ2idknyyFsF4lr244yQtjCEq+Ob4H6QEbi/875
        TCD3SAisY5T42/GCGcLZziixfPI/Nogqa4k7536xgSxmFtCUWL9LHyLsKHFp/mGweyQE+CRu
        vBWEuIFPYtK26cwQYV6JjjYhiGo1iQ3LNrDBrO3auRLqTA+JQ1vvsExgVJyF5JtZSL6ZhbB3
        ASPzKkbx1NLi3PTUYqO81HK94sTc4tK8dL3k/NxNjMD0cvrf8S87GHf9STrEKMDBqMTDO0PF
        IE6INbGsuDL3EKMEB7OSCG8nE1CINyWxsiq1KD++qDQntfgQozQHi5I4r/Gil7FCAumJJanZ
        qakFqUUwWSYOTqkGxtk8NxkNzBWDsuZfm7Vi0qpcnybTyJptl1PvdQbYMk5r9G7vlWxwl1KS
        CHzXcCZfWTDsmVukvMC5qUt3Vv2V//jkWVQ630Hx3uVSRw5KqsSeuKOtZ+xRYTj31dxpan+m
        2EevPfzCP5b1xw3Znv1y8xrzs+Td583MPfFrf/SR6RuX6MYmTxf+qsRSnJFoqMVcVJwIACC9
        tpcrAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjkeLIzCtJLcpLzFFi42I5/e/4Pd0QC4M4g5f7VS1W3+1ns9g4Yz2r
        xbNbe5ksju14xGRxedccNou5rdPZHdg8ds66y+5x+Wypx6HDHYwefVtWMXp83iQXwBqlZ1OU
        X1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5eglzHl9ULmghW8
        FQ+mnWNvYOzh7mLk5JAQMJGYM2crexcjF4eQwFJGibYZD5m7GDmAEjISx9eXQdQIS/y51sUG
        UfOJUWJ200ZWkASbgJXExPZVjCC2iICCRM/vlWBFzAIbGCVe3fzCApIQFgiQ+HHsIDuIzSKg
        KnHhxgmwZl4BW4m7/zexQGyQl9j67RMryGJOATuJnr3mIGEhoJL1Z55ClQtKnJz5BKycGai8
        eets5gmMArOQpGYhSS1gZFrFKJJaWpybnltsqFecmFtcmpeul5yfu4kRGAfbjv3cvIPx0sbg
        Q4wCHIxKPLwzVAzihFgTy4orcw8xSnAwK4nwdjIBhXhTEiurUovy44tKc1KLDzGaAv0wkVlK
        NDkfGKN5JfGGpobmFpaG5sbmxmYWSuK8HQIHY4QE0hNLUrNTUwtSi2D6mDg4pRoYxYOanljp
        vlm285nmhER300e7WFsqrz0+PFn+TNmD5e6bnHZbrZn6R1qp+0Dd+755Z+37J/y+9H975E9R
        O16FWxldL9Va3kbPmc14fdrqonMNqQd0Co7x/l9/KI/dz2XSz/e+YnlKu7MKzP/Xv+uQYl3V
        fcq/Mf3VN19pv9cdoit+Xw1+IsAjpsRSnJFoqMVcVJwIAIu27pWZAgAA
X-CMS-MailID: 20200128133412eucas1p2e5e3e29ea554bf57c1f2cc05b3d2d3a8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200128133412eucas1p2e5e3e29ea554bf57c1f2cc05b3d2d3a8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200128133412eucas1p2e5e3e29ea554bf57c1f2cc05b3d2d3a8
References: <20200128133343.29905-1-b.zolnierkie@samsung.com>
        <CGME20200128133412eucas1p2e5e3e29ea554bf57c1f2cc05b3d2d3a8@eucas1p2.samsung.com>
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

Code size savings on m68k arch using atari_defconfig:

   text    data     bss     dec     hex filename
before:
  41064    4413      40   45517    b1cd drivers/ata/libata-core.o
after:
  41064     573      40   41677    a2cd drivers/ata/libata-core.o

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

