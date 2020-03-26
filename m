Return-Path: <SRS0=jBxd=5L=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E571C2D0EE
	for <linux-ide@archiver.kernel.org>; Thu, 26 Mar 2020 16:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 639352076A
	for <linux-ide@archiver.kernel.org>; Thu, 26 Mar 2020 16:00:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="pv2B1PCg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728781AbgCZQAD (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 26 Mar 2020 12:00:03 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:58909 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728485AbgCZP6o (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 26 Mar 2020 11:58:44 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200326155843euoutp01e3ffed9d154bacd1dc09511a7f318387~-5dsmMViF3025530255euoutp01F
        for <linux-ide@vger.kernel.org>; Thu, 26 Mar 2020 15:58:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200326155843euoutp01e3ffed9d154bacd1dc09511a7f318387~-5dsmMViF3025530255euoutp01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585238323;
        bh=DmQLdWd5TyEjK/Vf3whxhNsEqaJ2x5ztiuAlx9675mQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pv2B1PCgcmByEv/S0lzHMguykBjmD05ni0rXuPuNcNj3rMf6Uy238cHuHi5QbLkpY
         K4xgqekggDxekOy8Y92y+jA+L5Vse1Um36AV7BBYZJ8RoAsD56ne2oaMBhxOrtnWpw
         xrzUkBgn85JWfQ0Dz/eHxuw7DOZerDui72m6/ECQ=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200326155842eucas1p2e14321acc5f925d34631444191a6ff3d~-5dsUeCwK3015130151eucas1p2w;
        Thu, 26 Mar 2020 15:58:42 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 03.F7.60698.231DC7E5; Thu, 26
        Mar 2020 15:58:42 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200326155842eucas1p23d6b95d066eaf1a86e04935641015af6~-5dr6rUlO2633426334eucas1p2W;
        Thu, 26 Mar 2020 15:58:42 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200326155842eusmtrp16e442a21f731bdaff3f997bcd456180d~-5dr5K99A2091520915eusmtrp1H;
        Thu, 26 Mar 2020 15:58:42 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-92-5e7cd132b4f4
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 7A.CA.07950.231DC7E5; Thu, 26
        Mar 2020 15:58:42 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200326155842eusmtip117c474b6e7eba63a078c620d2b024c9f~-5drgJVKU1572015720eusmtip1X;
        Thu, 26 Mar 2020 15:58:42 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH v5 10/27] ata: remove EXPORT_SYMBOL_GPL()s not used by
 modules
Date:   Thu, 26 Mar 2020 16:58:05 +0100
Message-Id: <20200326155822.19400-11-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200326155822.19400-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLKsWRmVeSWpSXmKPExsWy7djP87pGF2viDBZtsrBYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRXDYpqTmZZalF+nYJXBkv/lxgKlgkW/Hqwmn2Bsbn4l2MnBwS
        AiYSk1bPYO5i5OIQEljBKNHXuI0JwvnCKDHh50Mo5zOjxJHHN1i6GDnAWi7ddIeIL2eUWHvi
        B0LH2o032UHmsglYSUxsX8UIYosIKEj0/F7JBlLELPCeUWLFpL0sIAlhgQCJyz8+MYNMZRFQ
        lVg6gRMkzCtgJ7H/4VxmiPvkJbZ++8QKYnMCxZevm88MUSMocXLmE7AxzEA1zVtng/0gIbCM
        XeLuqQlMEM0uEgf/X2OHsIUlXh3fAmXLSJye3MMC0bCOUeJvxwuo7u2MEssn/2ODqLKWuHPu
        FxvIdcwCmhLrd+lDhB0lJs34ygQJCj6JG28FIY7gk5i0bTozRJhXoqNNCKJaTWLDsg1sMGu7
        dq6E+stDYtPuOywTGBVnIXlnFpJ3ZiHsXcDIvIpRPLW0ODc9tdg4L7Vcrzgxt7g0L10vOT93
        EyMwEZ3+d/zrDsZ9f5IOMQpwMCrx8Da01cQJsSaWFVfmHmKU4GBWEuF9GgkU4k1JrKxKLcqP
        LyrNSS0+xCjNwaIkzmu86GWskEB6YklqdmpqQWoRTJaJg1OqgbH3wqNTu9W/O1V5v399/fX7
        8/NrVzZfV816ui16ugDX6nnfEwvzJuwwmDo/9S3LifkZTuIVLi8kXTOLi/fuWz/Pa+nPmvsW
        dwvepP/+8u2KrgrjwcWBc20e8QY12/zh2Gqmalpsb8RhdlZcZ4fvs8+NcRc+n8xiPbRlw/ee
        q5/f/BM5d/JSk2OjEktxRqKhFnNRcSIA8nUMmUADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsVy+t/xu7pGF2viDHb/lbVYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6
        djYpqTmZZalF+nYJehkv/lxgKlgkW/Hqwmn2Bsbn4l2MHBwSAiYSl266dzFycQgJLGWUWL9s
        CxtEXEbi+PqyLkZOIFNY4s+1LjaImk+MEtOfTWAFSbAJWElMbF/FCGKLCChI9PxeCVbELPCV
        UWLppG5mkISwgJ/E1ZtNjCBDWQRUJZZO4AQJ8wrYSex/OJcZYoG8xNZvn8BmcgLFl6+bDxYX
        ErCVWPzlAxNEvaDEyZlPWEBsZqD65q2zmScwCsxCkpqFJLWAkWkVo0hqaXFuem6xkV5xYm5x
        aV66XnJ+7iZGYLRsO/Zzyw7GrnfBhxgFOBiVeHg1WmrihFgTy4orcw8xSnAwK4nwPo0ECvGm
        JFZWpRblxxeV5qQWH2I0BfphIrOUaHI+MJLzSuINTQ3NLSwNzY3Njc0slMR5OwQOxggJpCeW
        pGanphakFsH0MXFwSjUwWt5WqHQ5E9HKyvz/GktHYlTT2ZzLwrm7t9qbRm2+P3djyfTYZ7P+
        xGqelH3yuV7rV6/L3NAwtX+Ff71nKOfNiw5YJnn6Qu2eDMffC188fK3AvfCmboxHyNtXnkV2
        3qsPMM8PaBH86XNoy7NKZu70iA4NmXV9yV3fr5SIGMTKVaU971y8v/OwEktxRqKhFnNRcSIA
        WVXqwqwCAAA=
X-CMS-MailID: 20200326155842eucas1p23d6b95d066eaf1a86e04935641015af6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200326155842eucas1p23d6b95d066eaf1a86e04935641015af6
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200326155842eucas1p23d6b95d066eaf1a86e04935641015af6
References: <20200326155822.19400-1-b.zolnierkie@samsung.com>
        <CGME20200326155842eucas1p23d6b95d066eaf1a86e04935641015af6@eucas1p2.samsung.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Remove EXPORT_SYMBOL_GPL()s for functions used only by
the core libata code.

Code size savings on m68k arch using (modified) atari_defconfig:

   text    data     bss     dec     hex filename
before:
  39838     573      40   40451    9e03 drivers/ata/libata-core.o
  21071     105     576   21752    54f8 drivers/ata/libata-scsi.o
  17519      18       0   17537    4481 drivers/ata/libata-eh.o
after:
  39688     573      40   40301    9d6d drivers/ata/libata-core.o
  21040     105     576   21721    54d9 drivers/ata/libata-scsi.o
  17405      18       0   17423    440f drivers/ata/libata-eh.o

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/libata-core.c | 5 -----
 drivers/ata/libata-eh.c   | 4 ----
 drivers/ata/libata-scsi.c | 1 -
 3 files changed, 10 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index dc48e983ccdb..2ec1a49388ee 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -80,7 +80,6 @@ const struct ata_port_operations ata_base_port_ops = {
 	.sched_eh		= ata_std_sched_eh,
 	.end_eh			= ata_std_end_eh,
 };
-EXPORT_SYMBOL_GPL(ata_base_port_ops);
 
 const struct ata_port_operations sata_port_ops = {
 	.inherits		= &ata_base_port_ops,
@@ -902,7 +901,6 @@ void ata_unpack_xfermask(unsigned long xfer_mask, unsigned long *pio_mask,
 	if (udma_mask)
 		*udma_mask = (xfer_mask & ATA_MASK_UDMA) >> ATA_SHIFT_UDMA;
 }
-EXPORT_SYMBOL_GPL(ata_unpack_xfermask);
 
 static const struct ata_xfer_ent {
 	int shift, bits;
@@ -3425,7 +3423,6 @@ u8 ata_timing_cycle2mode(unsigned int xfer_shift, int cycle)
 
 	return last_mode;
 }
-EXPORT_SYMBOL_GPL(ata_timing_cycle2mode);
 
 /**
  *	ata_down_xfermask_limit - adjust dev xfer masks downward
@@ -5051,7 +5048,6 @@ void ata_sg_init(struct ata_queued_cmd *qc, struct scatterlist *sg,
 	qc->n_elem = n_elem;
 	qc->cursg = qc->sg;
 }
-EXPORT_SYMBOL_GPL(ata_sg_init);
 
 #ifdef CONFIG_HAS_DMA
 
@@ -6157,7 +6153,6 @@ void ata_host_get(struct ata_host *host)
 {
 	kref_get(&host->kref);
 }
-EXPORT_SYMBOL_GPL(ata_host_get);
 
 void ata_host_put(struct ata_host *host)
 {
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 1d231cfab26f..04275f4c8d36 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1215,7 +1215,6 @@ void ata_eh_thaw_port(struct ata_port *ap)
 
 	DPRINTK("ata%u port thawed\n", ap->print_id);
 }
-EXPORT_SYMBOL_GPL(ata_eh_thaw_port);
 
 static void ata_eh_scsidone(struct scsi_cmnd *scmd)
 {
@@ -1250,7 +1249,6 @@ void ata_eh_qc_complete(struct ata_queued_cmd *qc)
 	scmd->retries = scmd->allowed;
 	__ata_eh_qc_complete(qc);
 }
-EXPORT_SYMBOL_GPL(ata_eh_qc_complete);
 
 /**
  *	ata_eh_qc_retry - Tell midlayer to retry an ATA command after EH
@@ -1270,7 +1268,6 @@ void ata_eh_qc_retry(struct ata_queued_cmd *qc)
 		scmd->allowed++;
 	__ata_eh_qc_complete(qc);
 }
-EXPORT_SYMBOL_GPL(ata_eh_qc_retry);
 
 /**
  *	ata_dev_disable - disable ATA device
@@ -4041,7 +4038,6 @@ void ata_do_eh(struct ata_port *ap, ata_prereset_fn_t prereset,
 
 	ata_eh_finish(ap);
 }
-EXPORT_SYMBOL_GPL(ata_do_eh);
 
 /**
  *	ata_std_error_handler - standard error handler
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 24024e728296..ae63ef7adcb9 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -4536,7 +4536,6 @@ void ata_scsi_simulate(struct ata_device *dev, struct scsi_cmnd *cmd)
 
 	cmd->scsi_done(cmd);
 }
-EXPORT_SYMBOL_GPL(ata_scsi_simulate);
 
 int ata_scsi_add_hosts(struct ata_host *host, struct scsi_host_template *sht)
 {
-- 
2.24.1

