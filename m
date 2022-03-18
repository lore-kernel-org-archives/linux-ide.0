Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9006BC433F5
	for <linux-ide@archiver.kernel.org>; Fri, 18 Mar 2022 09:03:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234168AbiCRJEh (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 18 Mar 2022 05:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbiCRJEe (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 18 Mar 2022 05:04:34 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F8C128647
        for <linux-ide@vger.kernel.org>; Fri, 18 Mar 2022 02:03:15 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id t1so9486373edc.3
        for <linux-ide@vger.kernel.org>; Fri, 18 Mar 2022 02:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kzNbrmBq7B5Hh8tYG2zqXd1T6UWdRgH6d3qCvlbpQjQ=;
        b=mPQc2ugMZiZgdLDWFgw6IiFPVAe6Nk4Q+z824Rdln9fZC6pdt1NrKWZXIMSdmdqLfE
         dg/+LT2m8p/QhqB1jQsrKIafWRJTCOTAeSMgFHpaH9+NTiCVw3nCAz/UEflYdO5dxjfB
         hiYMYAxUf8vA+LV65mRzs3Vna5KdekuuF5YXINnkgqIaxP1BX7IZSahKBpYawiRxLdxK
         12PTotSNKGx6lHdQ/+Ri8OK2KK5fdpmfFdqlx5YSp0Oxjl6SXWDb5RFuOa8nwtMTHtOH
         KW6HqwAnrNbHLkORLxEeb2AjNTVrQGcWAnOMjUNeN0gaPa+wvoGir0abj4JaL2Ly/2w8
         /izw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kzNbrmBq7B5Hh8tYG2zqXd1T6UWdRgH6d3qCvlbpQjQ=;
        b=wceAYAIKz1J+pC9b330a4CCEfqGxvv2/M7M6ErfGeEE5/XZyPD9e3xfA+Q+B6GyilI
         B9f4/5TvbQRUGn50cDYb476eRQHtWA6v+A5VEmWdvxpwGHRetGTYreNBAhZf+mripMGL
         1nF6Fno1uCLWpNZp1QtRSeyMnLM140hNkrUvp49J4B02nPy1GmYnwI5yuMSs5gtIjBvR
         34i0ss7Q03KPJb2vcgKWBqsy6sVo+WFDxkYZMd2x94sz2OTnG1O9Gl+EECMcEivdl0q5
         kR0/yZdjBVxE02Mx25BxNrwKXYmxgeI7TAbl4TY0WIlnqsC3+ImqQN5SGVrPfnVmLoM+
         vWWA==
X-Gm-Message-State: AOAM533f3tEau0BFbNrb35Wgh8GD+ab00lU6nVYns9ySsnK6IXKLs/gw
        YgGWVsutE/6FfeMoI1oOGnD/ezqJU7s=
X-Google-Smtp-Source: ABdhPJwIzQdXe6/lPU6JReLjwYR4OUJW4y9R3yRwTThx8e3rvpE47si1A+0Jkr8EIzhXDEubHUZt5g==
X-Received: by 2002:a05:6402:4249:b0:418:cda3:f57c with SMTP id g9-20020a056402424900b00418cda3f57cmr8215652edb.193.1647594193711;
        Fri, 18 Mar 2022 02:03:13 -0700 (PDT)
Received: from debian64.daheim (p5b0d7e2a.dip0.t-ipconnect.de. [91.13.126.42])
        by smtp.gmail.com with ESMTPSA id h30-20020a056402095e00b00412b81dd96esm3771937edz.29.2022.03.18.02.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 02:03:13 -0700 (PDT)
Received: from chuck by debian64.daheim with local (Exim 4.95)
        (envelope-from <chunkeey@gmail.com>)
        id 1nV8Vs-0003jA-Bf;
        Fri, 18 Mar 2022 10:03:12 +0100
From:   Christian Lamparter <chunkeey@gmail.com>
To:     linux-ide@vger.kernel.org
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/2] ata: sata_dwc_460ex: Fix crash due to OOB write
Date:   Fri, 18 Mar 2022 10:03:11 +0100
Message-Id: <ba068938e629eb1a8b423a54405233e685cedb78.1647594132.git.chunkeey@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

the driver uses libata's "tag" values from in various arrays.
Since the mentioned patch bumped the ATA_TAG_INTERNAL to 32,
the value of the SATA_DWC_QCMD_MAX needs to be bumped to 33.

Otherwise ATA_TAG_INTERNAL cause a crash like this:

| BUG: Kernel NULL pointer dereference at 0x00000000
| Faulting instruction address: 0xc03ed4b8
| Oops: Kernel access of bad area, sig: 11 [#1]
| BE PAGE_SIZE=4K PowerPC 44x Platform
| CPU: 0 PID: 362 Comm: scsi_eh_1 Not tainted 5.4.163 #0
| NIP:  c03ed4b8 LR: c03d27e8 CTR: c03ed36c
| REGS: cfa59950 TRAP: 0300   Not tainted  (5.4.163)
| MSR:  00021000 <CE,ME>  CR: 42000222  XER: 00000000
| DEAR: 00000000 ESR: 00000000
| GPR00: c03d27e8 cfa59a08 cfa55fe0 00000000 0fa46bc0 [...]
| [..]
| NIP [c03ed4b8] sata_dwc_qc_issue+0x14c/0x254
| LR [c03d27e8] ata_qc_issue+0x1c8/0x2dc
| Call Trace:
| [cfa59a08] [c003f4e0] __cancel_work_timer+0x124/0x194 (unreliable)
| [cfa59a78] [c03d27e8] ata_qc_issue+0x1c8/0x2dc
| [cfa59a98] [c03d2b3c] ata_exec_internal_sg+0x240/0x524
| [cfa59b08] [c03d2e98] ata_exec_internal+0x78/0xe0
| [cfa59b58] [c03d30fc] ata_read_log_page.part.38+0x1dc/0x204
| [cfa59bc8] [c03d324c] ata_identify_page_supported+0x68/0x130
| [...]

this is because sata_dwc_dma_xfer_complete() NULLs the
dma_pending's next neighbour "chan" (a *dma_chan struct) in
this '32' case right here (line ~735):
> hsdevp->dma_pending[tag] = SATA_DWC_DMA_PENDING_NONE;

Then the next time, a dma gets issued; dma_dwc_xfer_setup() passes
the NULL'd hsdevp->chan to the dmaengine_slave_config() which then
causes the crash.

Reported-by: ticerex (OpenWrt Forum)
Fixes: 28361c403683c ("libata: add extra internal command")
Cc: stable@kernel.org # 4.18+
Link: https://forum.openwrt.org/t/my-book-live-duo-reboot-loop/122464
Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
---
ticerex said when I've asked him about his real name+email for the patches:
"Please use my forum nick."
<https://forum.openwrt.org/t/my-book-live-duo-reboot-loop/122464/14>
(I know checkpatch.pl complains about that. But what can you do?)
---
 drivers/ata/sata_dwc_460ex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index bec33d781ae0..061b27584667 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -137,7 +137,7 @@ struct sata_dwc_device {
 #endif
 };
 
-#define SATA_DWC_QCMD_MAX	32
+#define SATA_DWC_QCMD_MAX	33
 
 struct sata_dwc_device_port {
 	struct sata_dwc_device	*hsdev;
-- 
2.35.1

