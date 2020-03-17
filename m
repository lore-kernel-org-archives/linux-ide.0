Return-Path: <SRS0=AjNr=5C=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42EDFC4CECE
	for <linux-ide@archiver.kernel.org>; Tue, 17 Mar 2020 14:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BBB4206EC
	for <linux-ide@archiver.kernel.org>; Tue, 17 Mar 2020 14:43:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hocDEjmP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgCQOnu (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 17 Mar 2020 10:43:50 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:40405 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbgCQOns (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 17 Mar 2020 10:43:48 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200317144347euoutp02ebb802ded961836974e9ef7f489f09d8~9Hos3US8P1539915399euoutp02S
        for <linux-ide@vger.kernel.org>; Tue, 17 Mar 2020 14:43:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200317144347euoutp02ebb802ded961836974e9ef7f489f09d8~9Hos3US8P1539915399euoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1584456227;
        bh=oy/p9fzaAcyCLXLjGVXpJdB3/7eka9TGQ/vlbsdueDk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hocDEjmP3qb4M7EyCBTTvhKPu6YGT8gMvT6JCP9Gan09JwmnGJRyxfr7Doe6ls409
         XySObul7g7oUVy1DHnBptMtzSOURF4/jHDdF3O1MX+2LHHsfAr3Vsv8z/UIMHHv+IM
         3y0er/hZt/gAA8I3uwgyE03w4Vqo89K1sePss1Gc=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200317144346eucas1p145d97531baac4b9b29339a43503081e7~9HosVrJCH1084410844eucas1p1S;
        Tue, 17 Mar 2020 14:43:46 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id C1.E9.60698.222E07E5; Tue, 17
        Mar 2020 14:43:46 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200317144346eucas1p2d1e330410bd3482ce01c98db40d5612b~9Hor-dv5b0133301333eucas1p2j;
        Tue, 17 Mar 2020 14:43:46 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200317144346eusmtrp2061635c062071393e56b89b90faa642f~9Hor_lbb-0147801478eusmtrp26;
        Tue, 17 Mar 2020 14:43:46 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-e5-5e70e22284d9
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 7C.D4.08375.222E07E5; Tue, 17
        Mar 2020 14:43:46 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200317144345eusmtip182568f50a1031c454f258f8cb3709275~9HoratHaJ0970009700eusmtip1V;
        Tue, 17 Mar 2020 14:43:45 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH v4 10/27] ata: remove EXPORT_SYMBOL_GPL()s not used by
 modules
Date:   Tue, 17 Mar 2020 15:43:16 +0100
Message-Id: <20200317144333.2904-11-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200317144333.2904-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLKsWRmVeSWpSXmKPExsWy7djP87pKjwriDLq2qlisvtvPZrFxxnpW
        i2e39jJZrFx9lMni2I5HTBaXd81hs1j+ZC2zxdzW6ewOHB47Z91l97h8ttTj0OEORo+Trd9Y
        PHbfbGDz6NuyitHj8ya5APYoLpuU1JzMstQifbsErowTlz8wF/TKVmw8so6xgfGqeBcjJ4eE
        gInE1t/r2LoYuTiEBFYwSpydM5kRwvnCKPF44Q1mCOczo8SnC+/ZYFoOtM+CqlrOKHGiawYT
        XEvD3d9MIFVsAlYSE9tXMYLYIgIKEj2/V4ItYRZ4zyixYtJeFpCEsECAxL1D15lBbBYBVYnt
        J3tYQWxeAVuJo/Mb2CHWyUts/fYJLM4JFL92+B8bRI2gxMmZT8DmMAPVNG+dzQxRv4pdYl2H
        AoTtInH76kOouLDEq+NboGbKSPzfOR/sagmBdYwSfzteMEM42xkllk/+B/WotcSdc7+AbA6g
        DZoS63fpg5gSAo4SK6e4QJh8EjfeCkKcwCcxadt0Zogwr0RHmxDEDDWJDcs2sMFs7dq5Euoa
        D4k5554zTmBUnIXkmVlInpmFsHYBI/MqRvHU0uLc9NRi47zUcr3ixNzi0rx0veT83E2MwER0
        +t/xrzsY9/1JOsQowMGoxMObsKkgTog1say4MvcQowQHs5II7+LC/Dgh3pTEyqrUovz4otKc
        1OJDjNIcLErivMaLXsYKCaQnlqRmp6YWpBbBZJk4OKUaGHvuGRry+XdIvG3UObzinCdz0Wk9
        Hel5t5pvv+tmOrax8U5HxvvVs28GL47okTCZ1HZl+9PCGZE+crUXVV87T3y/6fE/Fj5hX3eD
        o7kZ7EfeJy26/4WRmXHJp8y9h0QMHP9f29zFPe3d+0KentAX3/b9FtQxvJK389f0Oq+Xi7fw
        b5uTK9xtk6TEUpyRaKjFXFScCABfZIY4QAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsVy+t/xu7pKjwriDHZdY7dYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6
        djYpqTmZZalF+nYJehknLn9gLuiVrdh4ZB1jA+NV8S5GTg4JAROJA+2zGEFsIYGljBLrbid0
        MXIAxWUkjq8vgygRlvhzrYuti5ELqOQTo8S8Wc9YQBJsAlYSE9tXgfWKCChI9PxeCVbELPCV
        UWLppG5mkISwgJ/EhC/nmUBsFgFVie0ne1hBbF4BW4mj8xvYITbIS2z99gkszgkUv3b4HxvE
        QTYSL978Z4KoF5Q4OfMJ2GJmoPrmrbOZJzAKzEKSmoUktYCRaRWjSGppcW56brGhXnFibnFp
        Xrpecn7uJkZgvGw79nPzDsZLG4MPMQpwMCrx8HJsKIgTYk0sK67MPcQowcGsJMK7uDA/Tog3
        JbGyKrUoP76oNCe1+BCjKdATE5mlRJPzgbGcVxJvaGpobmFpaG5sbmxmoSTO2yFwMEZIID2x
        JDU7NbUgtQimj4mDU6qBUettTGnxAa9vRi+3ONyunCX8Pktfx89GbKHgHu1vkoKmcyo+TN+1
        2fNV5LSX+/0ef/gVzqcUf/zBoqoVmsfnXSp4zx5m8/lp9N6Sjss2TCtdviYsfuZ76MTbx73C
        z49e9jqhyNE5b8Wy2ecXcG9lnJx3wkxu29yLskbnvXv1w6L3fKiy5izS26vEUpyRaKjFXFSc
        CADlk5CPrQIAAA==
X-CMS-MailID: 20200317144346eucas1p2d1e330410bd3482ce01c98db40d5612b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200317144346eucas1p2d1e330410bd3482ce01c98db40d5612b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200317144346eucas1p2d1e330410bd3482ce01c98db40d5612b
References: <20200317144333.2904-1-b.zolnierkie@samsung.com>
        <CGME20200317144346eucas1p2d1e330410bd3482ce01c98db40d5612b@eucas1p2.samsung.com>
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
index dae625fc5e8a..e4df091fdcde 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -80,7 +80,6 @@ const struct ata_port_operations ata_base_port_ops = {
 	.sched_eh		= ata_std_sched_eh,
 	.end_eh			= ata_std_end_eh,
 };
-EXPORT_SYMBOL_GPL(ata_base_port_ops);
 
 const struct ata_port_operations sata_port_ops = {
 	.inherits		= &ata_base_port_ops,
@@ -899,7 +898,6 @@ void ata_unpack_xfermask(unsigned long xfer_mask, unsigned long *pio_mask,
 	if (udma_mask)
 		*udma_mask = (xfer_mask & ATA_MASK_UDMA) >> ATA_SHIFT_UDMA;
 }
-EXPORT_SYMBOL_GPL(ata_unpack_xfermask);
 
 static const struct ata_xfer_ent {
 	int shift, bits;
@@ -3437,7 +3435,6 @@ u8 ata_timing_cycle2mode(unsigned int xfer_shift, int cycle)
 
 	return last_mode;
 }
-EXPORT_SYMBOL_GPL(ata_timing_cycle2mode);
 
 /**
  *	ata_down_xfermask_limit - adjust dev xfer masks downward
@@ -5058,7 +5055,6 @@ void ata_sg_init(struct ata_queued_cmd *qc, struct scatterlist *sg,
 	qc->n_elem = n_elem;
 	qc->cursg = qc->sg;
 }
-EXPORT_SYMBOL_GPL(ata_sg_init);
 
 #ifdef CONFIG_HAS_DMA
 
@@ -6158,7 +6154,6 @@ void ata_host_get(struct ata_host *host)
 {
 	kref_get(&host->kref);
 }
-EXPORT_SYMBOL_GPL(ata_host_get);
 
 void ata_host_put(struct ata_host *host)
 {
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 827d437d8cb4..3b8d276b5107 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1212,7 +1212,6 @@ void ata_eh_thaw_port(struct ata_port *ap)
 
 	trace_ata_port_thaw(ap);
 }
-EXPORT_SYMBOL_GPL(ata_eh_thaw_port);
 
 static void ata_eh_scsidone(struct scsi_cmnd *scmd)
 {
@@ -1247,7 +1246,6 @@ void ata_eh_qc_complete(struct ata_queued_cmd *qc)
 	scmd->retries = scmd->allowed;
 	__ata_eh_qc_complete(qc);
 }
-EXPORT_SYMBOL_GPL(ata_eh_qc_complete);
 
 /**
  *	ata_eh_qc_retry - Tell midlayer to retry an ATA command after EH
@@ -1267,7 +1265,6 @@ void ata_eh_qc_retry(struct ata_queued_cmd *qc)
 		scmd->allowed++;
 	__ata_eh_qc_complete(qc);
 }
-EXPORT_SYMBOL_GPL(ata_eh_qc_retry);
 
 /**
  *	ata_dev_disable - disable ATA device
@@ -4044,7 +4041,6 @@ void ata_do_eh(struct ata_port *ap, ata_prereset_fn_t prereset,
 
 	ata_eh_finish(ap);
 }
-EXPORT_SYMBOL_GPL(ata_do_eh);
 
 /**
  *	ata_std_error_handler - standard error handler
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 2b0262aa3bcc..2bf1376bc027 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -4522,7 +4522,6 @@ void ata_scsi_simulate(struct ata_device *dev, struct scsi_cmnd *cmd)
 
 	cmd->scsi_done(cmd);
 }
-EXPORT_SYMBOL_GPL(ata_scsi_simulate);
 
 int ata_scsi_add_hosts(struct ata_host *host, struct scsi_host_template *sht)
 {
-- 
2.24.1

