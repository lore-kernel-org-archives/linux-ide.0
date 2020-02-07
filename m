Return-Path: <SRS0=qhS8=33=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD1F8C04EB5
	for <linux-ide@archiver.kernel.org>; Fri,  7 Feb 2020 14:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A58A1214AF
	for <linux-ide@archiver.kernel.org>; Fri,  7 Feb 2020 14:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ioGuU0OQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbgBGO3M (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 7 Feb 2020 09:29:12 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:49591 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727682AbgBGO17 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 7 Feb 2020 09:27:59 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200207142756euoutp02e581df4ebe78d3c47226ee1f8393184f~xJQu5JTiB2687426874euoutp02G
        for <linux-ide@vger.kernel.org>; Fri,  7 Feb 2020 14:27:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200207142756euoutp02e581df4ebe78d3c47226ee1f8393184f~xJQu5JTiB2687426874euoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1581085676;
        bh=sR8Dl7xuo2NIgOqAKFjRuE0ZugpxdrUgR9ezvr1JmxU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ioGuU0OQDcPMF9DRoH62EZM/Z8XncpSygCK6xN8QyOnTl0Z3kv0c4F4tPmxWQTDHI
         iZG+4rKf/cob//4LJHsRbB0lv5WY0AzQbu4fsu0gG3ouEre/VBoXhy9RWEWCxIY+Gs
         fobx/mgolirDLTitvdvDaSDypmVDvRuNAmQAyJ3s=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200207142756eucas1p15f045026d25655a680d555a846b0176c~xJQus_sD02611726117eucas1p1h;
        Fri,  7 Feb 2020 14:27:56 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id CD.15.61286.CE37D3E5; Fri,  7
        Feb 2020 14:27:56 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200207142755eucas1p2a47ef991c23f3b05baf24e00afb94c92~xJQuMNSU60410804108eucas1p2y;
        Fri,  7 Feb 2020 14:27:55 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200207142755eusmtrp18da3e3f32a11ef10fedbed109b6920b4~xJQuLnG390480004800eusmtrp1G;
        Fri,  7 Feb 2020 14:27:55 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-1d-5e3d73ec4336
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 9B.89.08375.BE37D3E5; Fri,  7
        Feb 2020 14:27:55 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200207142755eusmtip2d99f67055ec47ef2fb3d804ccca3c1b8~xJQtqiVp42997829978eusmtip2J;
        Fri,  7 Feb 2020 14:27:55 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH v2 09/26] ata: remove EXPORT_SYMBOL_GPL()s not used by
 modules
Date:   Fri,  7 Feb 2020 15:27:17 +0100
Message-Id: <20200207142734.8431-10-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200207142734.8431-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPKsWRmVeSWpSXmKPExsWy7djPc7pvim3jDJ4d47RYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRXDYpqTmZZalF+nYJXBk3FrxjKVgkW/Hu6Ev2BsaX4l2MnBwS
        AiYS32ZNZepi5OIQEljBKHF13X4o5wujxPzGOWwQzmdGib8nlzLDtPxe8YEdIrGcUeL6m5vM
        cC2PPj5jBKliE7CSmNi+CswWEVCQ6Pm9EmwUs8B7RokVk/aygCSEBQIk3t+bzAZiswioShxf
        tB1sBa+ArcTEhf9YIdbJS2z99gnM5gSKf5zylw2iRlDi5MwnYHOYgWqat84Gu0JCYBG7xNS7
        U1kgml0kji3ayA5hC0u8Or4FypaROD25hwWiYR3Qcx0voLq3M0osn/yPDaLKWuLOuV9ANgfQ
        Ck2J9bv0IcKOEs83dTCChCUE+CRuvBWEOIJPYtK26cwQYV6JjjYhiGo1iQ3LNrDBrO3auRIa
        jB4Sazb1Mk5gVJyF5J1ZSN6ZhbB3ASPzKkbx1NLi3PTUYsO81HK94sTc4tK8dL3k/NxNjMBk
        dPrf8U87GL9eSjrEKMDBqMTDm+BoEyfEmlhWXJl7iFGCg1lJhLdP1TZOiDclsbIqtSg/vqg0
        J7X4EKM0B4uSOK/xopexQgLpiSWp2ampBalFMFkmDk6pBsY1jdO+qIvcEyjuvSnx4OMeo2dX
        q0qOuVZ/3r+vdVVFgIGsct7JSNbVUllLz9xtiXrRcCOm98Q8ef4v9pO/bOphC/wyberkc+8u
        tN1NLW48N1U8/kzdnh9fcj53Gl06qLNp1mxjF6s9qzVbqzMedD88zGX3LvvAJ6XzF5OkZ3AX
        9t0XPXH05wQHJZbijERDLeai4kQACHZoCUIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsVy+t/xe7qvi23jDB5fUbFYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6
        djYpqTmZZalF+nYJehk3FrxjKVgkW/Hu6Ev2BsaX4l2MnBwSAiYSv1d8YAexhQSWMkpc/Z/R
        xcgBFJeROL6+DKJEWOLPtS62LkYuoJJPjBIvL31kA0mwCVhJTGxfxQhiiwgoSPT8XglWxCzw
        lVFi6aRuZpCEsICfRN+i7WA2i4CqxHEom1fAVmLiwn+sEBvkJbZ++wRmcwLFP075ywZxkI3E
        9/eT2CHqBSVOznzCAmIzA9U3b53NPIFRYBaS1CwkqQWMTKsYRVJLi3PTc4sN9YoTc4tL89L1
        kvNzNzEC42XbsZ+bdzBe2hh8iFGAg1GJhzfB0SZOiDWxrLgy9xCjBAezkghvn6ptnBBvSmJl
        VWpRfnxRaU5q8SFGU6AnJjJLiSbnA2M5ryTe0NTQ3MLS0NzY3NjMQkmct0PgYIyQQHpiSWp2
        ampBahFMHxMHp1QDox5PwAWF/1M/rBPZ3rLLJWpZ3r3nDteYNjvIK6X9y7xV0jNxR/VGYflY
        z6SbDbN7pRp+xirl2hcH+gk+MCm/+MhevSEy8Ljm/Q8uJxwe9J+92q+m1XFG/fv6zBjm63I8
        7oJus9Z85w8/esF07t3N273PyRxlFjfd43b59h8WwfPc/kuS8s+EKbEUZyQaajEXFScCAFtN
        A2qtAgAA
X-CMS-MailID: 20200207142755eucas1p2a47ef991c23f3b05baf24e00afb94c92
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200207142755eucas1p2a47ef991c23f3b05baf24e00afb94c92
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200207142755eucas1p2a47ef991c23f3b05baf24e00afb94c92
References: <20200207142734.8431-1-b.zolnierkie@samsung.com>
        <CGME20200207142755eucas1p2a47ef991c23f3b05baf24e00afb94c92@eucas1p2.samsung.com>
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
  21071     105    4096   25272    62b8 drivers/ata/libata-scsi.o
  17519      18       0   17537    4481 drivers/ata/libata-eh.o
after:
  39688     573      40   40301    9d6d drivers/ata/libata-core.o
  21040     105    4096   25241    6299 drivers/ata/libata-scsi.o
  17405      18       0   17423    440f drivers/ata/libata-eh.o

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/libata-core.c | 5 -----
 drivers/ata/libata-eh.c   | 4 ----
 drivers/ata/libata-scsi.c | 1 -
 3 files changed, 10 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index ad724602c47c..c41198bb9582 100644
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
index 321b5a1d610a..d549bd5b3d36 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -4535,7 +4535,6 @@ void ata_scsi_simulate(struct ata_device *dev, struct scsi_cmnd *cmd)
 
 	cmd->scsi_done(cmd);
 }
-EXPORT_SYMBOL_GPL(ata_scsi_simulate);
 
 int ata_scsi_add_hosts(struct ata_host *host, struct scsi_host_template *sht)
 {
-- 
2.24.1

