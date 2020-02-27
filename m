Return-Path: <SRS0=ljer=4P=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E8B4C35E1C
	for <linux-ide@archiver.kernel.org>; Thu, 27 Feb 2020 18:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CD93246AA
	for <linux-ide@archiver.kernel.org>; Thu, 27 Feb 2020 18:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="dDHk/b8K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730918AbgB0SYR (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 27 Feb 2020 13:24:17 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:59063 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730921AbgB0SWp (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 27 Feb 2020 13:22:45 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200227182244euoutp02ae8370bd84743aa0a33b548922cb68e0~3VXcoTh6K0716607166euoutp02k
        for <linux-ide@vger.kernel.org>; Thu, 27 Feb 2020 18:22:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200227182244euoutp02ae8370bd84743aa0a33b548922cb68e0~3VXcoTh6K0716607166euoutp02k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1582827764;
        bh=DmiQIHRs0Sj/qPkKGLi4Wv869R3WF9XQSaupM7kP8/A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dDHk/b8K7ibPdLhm9hQH0F3zJZn16sE5bo30sQRXz388E8NFjyymTQL+KI2RXVi01
         itRHwCptNy9WfnxZGWxRFHewBD35qIA3a3Nx7id3OcdtkQ/nZN+o5tuuGpOcV8lI+L
         hjJg8UGLRye5w77xWXXb3WPptk6bjwQtyOSM6V+4=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200227182243eucas1p206ec7abf23652cc3a51dd7e0f34d07f3~3VXcQsxAC2012220122eucas1p2d;
        Thu, 27 Feb 2020 18:22:43 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id C7.05.60698.3F8085E5; Thu, 27
        Feb 2020 18:22:43 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200227182243eucas1p2d95b61a6a3941ffd3bbead3a6ff4a813~3VXcCi3-s3198431984eucas1p2C;
        Thu, 27 Feb 2020 18:22:43 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200227182243eusmtrp161b587978fbfd0e17577b9e4148a1d7e~3VXcB5hvT0110301103eusmtrp1c;
        Thu, 27 Feb 2020 18:22:43 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-fc-5e5808f331cd
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 73.61.07950.3F8085E5; Thu, 27
        Feb 2020 18:22:43 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200227182243eusmtip2f1d8aa5d75d67e4452454f9fc4735311~3VXbjBDyV3109031090eusmtip2r;
        Thu, 27 Feb 2020 18:22:43 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH v3 10/27] ata: remove EXPORT_SYMBOL_GPL()s not used by
 modules
Date:   Thu, 27 Feb 2020 19:22:09 +0100
Message-Id: <20200227182226.19188-11-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200227182226.19188-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPKsWRmVeSWpSXmKPExsWy7djP87qfOSLiDF4fN7VYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRXDYpqTmZZalF+nYJXBlbZi1lLlgkWzG57TBTA+Nz8S5GTg4J
        AROJXZ1H2boYuTiEBFYwSnyYe5cZwvnCKNFz7zs7hPOZUWLmjFVMMC0N999BVS1nlPi34CE7
        XMuC+b/AqtgErCQmtq9iBLFFBBQken6vBFvCLPCeUWLFpL0sIAlhgQCJ3Q2vwIpYBFQl5pyZ
        C9bMK2AnceHMHDaIdfISW799YgWxOYHiN/q2s0HUCEqcnPkEbA4zUE3z1tlgJ0kIrGKXePT0
        KQtEs4vEr4vroWxhiVfHt7BD2DISpyf3sEA0rGOU+NvxAqp7O6PE8sn/oFZbS9w59wvI5gBa
        oSmxfpc+RNhRYv6F6YwgYQkBPokbbwUhjuCTmLRtOjNEmFeio00IolpNYsOyDWwwa7t2rmSG
        sD0k/n74wDaBUXEWkndmIXlnFsLeBYzMqxjFU0uLc9NTi43zUsv1ihNzi0vz0vWS83M3MQKT
        0el/x7/uYNz3J+kQowAHoxIP74Id4XFCrIllxZW5hxglOJiVRHg3fg2NE+JNSaysSi3Kjy8q
        zUktPsQozcGiJM5rvOhlrJBAemJJanZqakFqEUyWiYNTqoHRu3jJtQNH2De/U1/PU7Gv60/c
        kT/nFZ9s1Gl9F/t6jfi3HeeOvjt3YZmGq4vNjxAG22/FPZk/mi6f1JhadDavIvVbksbRCV/3
        y7jekl6cOynz2ucL354Iuwb07Nc3Yl0bpM82mT8+WLGjiL3c/zrHw3Ur3TnMX+juljx6Y9Wt
        pPyVtSxzi49cUmIpzkg01GIuKk4EAKtY2TJCAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsVy+t/xe7qfOSLiDFoXKFusvtvPZrFxxnpW
        i2e39jJZrFx9lMni2I5HTBaXd81hs1j+ZC2zxdzW6ewOHB47Z91l97h8ttTj0OEORo+Trd9Y
        PHbfbGDz6NuyitHj8ya5APYoPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9
        O5uU1JzMstQifbsEvYwts5YyFyySrZjcdpipgfG5eBcjJ4eEgIlEw/13zF2MXBxCAksZJd5c
        +cnaxcgBlJCROL6+DKJGWOLPtS42iJpPjBKr961nAUmwCVhJTGxfxQhiiwgoSPT8XglWxCzw
        lVFi6aRuZpCEsICfxLHnW5hAbBYBVYk5Z+aC2bwCdhIXzsxhg9ggL7H12ydWEJsTKH6jbztY
        XEjAVqKr4ykjRL2gxMmZT8AWMwPVN2+dzTyBUWAWktQsJKkFjEyrGEVSS4tz03OLjfSKE3OL
        S/PS9ZLzczcxAiNm27GfW3Ywdr0LPsQowMGoxMPrsS08Tog1say4MvcQowQHs5II78avoXFC
        vCmJlVWpRfnxRaU5qcWHGE2BnpjILCWanA+M5rySeENTQ3MLS0NzY3NjMwslcd4OgYMxQgLp
        iSWp2ampBalFMH1MHJxSDYzM28Q0bXfP9Z9qeyCpfoWlGMeR2WLJnokzU7vX6onX3vXNdt3n
        6ywtcerc7SN32tmO933ds/YnS96V2psCE/9wMvJYuUj3Xyo5/k/CqEJu2RE25Tbx3csnKiut
        PMJkcivo1oI3es2P1J82veWeKm26OGpfR8PkpUtCuvRWxX9NurzM7XbZ9A4lluKMREMt5qLi
        RAD1Lb8KrgIAAA==
X-CMS-MailID: 20200227182243eucas1p2d95b61a6a3941ffd3bbead3a6ff4a813
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200227182243eucas1p2d95b61a6a3941ffd3bbead3a6ff4a813
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200227182243eucas1p2d95b61a6a3941ffd3bbead3a6ff4a813
References: <20200227182226.19188-1-b.zolnierkie@samsung.com>
        <CGME20200227182243eucas1p2d95b61a6a3941ffd3bbead3a6ff4a813@eucas1p2.samsung.com>
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
index a779ea57f3ad..b8e41c8e6395 100644
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

