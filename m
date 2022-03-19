Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73602C433F5
	for <linux-ide@archiver.kernel.org>; Sat, 19 Mar 2022 20:11:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244081AbiCSUMg (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 19 Mar 2022 16:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244089AbiCSUMc (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 19 Mar 2022 16:12:32 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE9E19A541
        for <linux-ide@vger.kernel.org>; Sat, 19 Mar 2022 13:11:09 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id o10so4190298ejd.1
        for <linux-ide@vger.kernel.org>; Sat, 19 Mar 2022 13:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vYidddzTunnBxMOLkYraRbf3+tJgtp3XkxflIW1opKA=;
        b=qiEj6MCke7N7auVGp6iTfhRRo7ReERjt9bpvQWVNo+GLkHjh5bN6CFBp0af8MpvXa3
         mNbmjxPWg81YH5VNyIppZxch5QWUz2t25ys2ItqN/Hxrs+aG9OyyZ6nP2ytBlMeZMZI0
         L5K1ThPCS2DJi0cMdOSI5bSB/x5cVT+z+IU3UM3HQTJNEkc3by93T8grXwEQfgRTnJHK
         7iuIVTz4fY9TtCuvQJ6kZNdT4eqyumvN3RR2QdWPK3JoTWXtAQc9dPqh3cI4toGwwAnD
         uSlKbwzPIEmQ7mm1NAOYdyUxvl8mjaMLMm8F01YHOZR3cUArszWQW/MRA6nZp4u8DAld
         m9gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vYidddzTunnBxMOLkYraRbf3+tJgtp3XkxflIW1opKA=;
        b=TYw07kjC7tMv3vinVINwXmG7io/qSRz5nCLvgKDnMi27KvaiOQKNwHIR03Y2HG/jVt
         jNWJPmRuGcEqUaCUSNIDtG5wb5gt75SK/hawWNRPEZnVi3RceUHCI7NQgZyDRkd9QdmO
         QH4XClWyGl20Mh4+Sn7l9esON/M+CAEoq01HQs4eyVL4wyuj2FWaA7jiHgfPWf4U7jie
         QLIpTxCPnG8c7rkibrov2Ng2kBJLOWN9tuqjk46CJTDdK/1a7Wq8ryKPTZnjaDgQxpfo
         0rAUWiipbFveJ3ytQBqGUWaAUWoQivyYWHzqWtbcLQd86JuUqEu9B9UPJRjoBV1kupmA
         JujQ==
X-Gm-Message-State: AOAM530dB2b4tLkGCVNCcs+oF7qJrP6eraeuRwJljsrtYV+yYPbhdUFg
        JivEEvIRjr9QQ6jUEF6RtLBweUxa2fA=
X-Google-Smtp-Source: ABdhPJz44Y5BnHFARUJTyS5yEqWmYTT3HE9Rpl14PnHbXLQKW0xIYblNudvWFsZZtv736J2xuWw59g==
X-Received: by 2002:a17:906:58d2:b0:6da:b635:fbf3 with SMTP id e18-20020a17090658d200b006dab635fbf3mr14046906ejs.40.1647720667492;
        Sat, 19 Mar 2022 13:11:07 -0700 (PDT)
Received: from debian64.daheim (p4fd09f18.dip0.t-ipconnect.de. [79.208.159.24])
        by smtp.gmail.com with ESMTPSA id d7-20020a50cd47000000b004187eacb4d6sm5977174edj.37.2022.03.19.13.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Mar 2022 13:11:06 -0700 (PDT)
Received: from chuck by debian64.daheim with local (Exim 4.95)
        (envelope-from <chunkeey@gmail.com>)
        id 1nVfPk-0007mw-0P;
        Sat, 19 Mar 2022 21:11:04 +0100
From:   Christian Lamparter <chunkeey@gmail.com>
To:     linux-ide@vger.kernel.org
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/2] ata: sata_dwc_460ex: Fix crash due to OOB write
Date:   Sat, 19 Mar 2022 21:11:02 +0100
Message-Id: <47b12037459a0df1748dac7440c0f5030e5c3ef4.1647720651.git.chunkeey@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

the driver uses libata's "tag" values from in various arrays.
Since the mentioned patch bumped the ATA_TAG_INTERNAL to 32,
the value of the SATA_DWC_QCMD_MAX needs to account for that.

Otherwise ATA_TAG_INTERNAL usage cause similar crashes like
this as reported by Tice Rex on the OpenWrt Forum and
reproduced (with symbols) here:

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

This is because sata_dwc_dma_xfer_complete() NULLs the
dma_pending's next neighbour "chan" (a *dma_chan struct) in
this '32' case right here (line ~735):
> hsdevp->dma_pending[tag] = SATA_DWC_DMA_PENDING_NONE;

Then the next time, a dma gets issued; dma_dwc_xfer_setup() passes
the NULL'd hsdevp->chan to the dmaengine_slave_config() which then
causes the crash.

With this patch, SATA_DWC_QCMD_MAX is now set to ATA_MAX_QUEUE + 1.
This avoids the OOB. But please note, there was a worthwhile discussion
on what ATA_TAG_INTERNAL and ATA_MAX_QUEUE is. And why there should not
be a "fake" 33 command-long queue size.

Ideally, the dw driver should account for the ATA_TAG_INTERNAL.
In Damien Le Moal's words: "... having looked at the driver, it
is a bigger change than just faking a 33rd "tag" that is in fact
not a command tag at all."

Fixes: 28361c403683c ("libata: add extra internal command")
Cc: stable@kernel.org # 4.18+
BugLink: https://github.com/openwrt/openwrt/issues/9505
Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
---
v1 -> v2: replaced '33' magic value (Damien)
	  Dropped (invalid) Reported-by (Damien)
	  Proper BugLink (Andy - OpenWrt's github issue tracker)
---
 drivers/ata/sata_dwc_460ex.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index bec33d781ae0..e3263e961045 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -137,7 +137,11 @@ struct sata_dwc_device {
 #endif
 };
 
-#define SATA_DWC_QCMD_MAX	32
+/*
+ * Allow one extra special slot for commands and DMA management
+ * to account for libata internal commands.
+ */
+#define SATA_DWC_QCMD_MAX	(ATA_MAX_QUEUE + 1)
 
 struct sata_dwc_device_port {
 	struct sata_dwc_device	*hsdev;
-- 
2.35.1

