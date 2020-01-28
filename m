Return-Path: <SRS0=dw68=3R=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C3CC2D0DB
	for <linux-ide@archiver.kernel.org>; Tue, 28 Jan 2020 13:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E30CB22522
	for <linux-ide@archiver.kernel.org>; Tue, 28 Jan 2020 13:35:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rzq5epKh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgA1NeQ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 28 Jan 2020 08:34:16 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:52353 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbgA1NeP (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 28 Jan 2020 08:34:15 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200128133414euoutp02e57d554a99cfaad68ea1fdc51cfb155e~uEE-aahw02862028620euoutp026
        for <linux-ide@vger.kernel.org>; Tue, 28 Jan 2020 13:34:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200128133414euoutp02e57d554a99cfaad68ea1fdc51cfb155e~uEE-aahw02862028620euoutp026
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1580218454;
        bh=YvXBNHY+8yH0MLPg1IfQRsk9QA/9ErQStYmSCxwTyY4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rzq5epKhh3hmdDR+TcLsS9T4QpybId/1Ili714oQAmxDzGAxJk23prU/gzPcba7Lq
         rPz00zU9OQcg1ewJNKxK3NdHSImV67jbrncT/uGc0ehnCpg1tc16KBa7ROz/K9LmVC
         eb2QBgpfXptHOb6HhG8OM34ZuR6fEEOvkegGIcv0=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200128133414eucas1p154c78b12f3047e87c493bc32b2c8c75d~uEE-CgCWO1369913699eucas1p1Q;
        Tue, 28 Jan 2020 13:34:14 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id C0.5A.60679.558303E5; Tue, 28
        Jan 2020 13:34:13 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200128133413eucas1p1725ccae03fb5aba49f0e0cef798da9d6~uEE_vLL-K0096700967eucas1p1A;
        Tue, 28 Jan 2020 13:34:13 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200128133413eusmtrp2cbc5876973ff5f09eba9408c566d00e5~uEE_uoHWd0330003300eusmtrp2v;
        Tue, 28 Jan 2020 13:34:13 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-43-5e30385540b4
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 51.92.08375.558303E5; Tue, 28
        Jan 2020 13:34:13 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200128133413eusmtip2244283b159be6c5e2b198a60a9d4da73~uEE_baEVU0685506855eusmtip2V;
        Tue, 28 Jan 2020 13:34:13 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH 09/28] ata: remove EXPORT_SYMBOL_GPL()s not used by modules
Date:   Tue, 28 Jan 2020 14:33:24 +0100
Message-Id: <20200128133343.29905-10-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200128133343.29905-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGKsWRmVeSWpSXmKPExsWy7djP87qhFgZxBt0zrSxW3+1ns9g4Yz2r
        xbNbe5ksju14xGRxedccNou5rdPZHdg8ds66y+5x+Wypx6HDHYwefVtWMXp83iQXwBrFZZOS
        mpNZllqkb5fAlTGno6zglUzF/HmaDYzbxbsYOTkkBEwk7i7bzNLFyMUhJLCCUeJ6Vx+U84VR
        4t2ED1DOZ0aJR892McO0PJ/1lREisRyo5eluRpAEWMus68kgNpuAlcTE9lVgcREBBYme3yvZ
        QBqYBdYwSqw63ASWEBbwlpjfuhJsKouAqsTKHZdZQGxeATuJfd1LmCC2yUts/faJtYuRg4MT
        KN6z1xyiRFDi5MwnYOXMQCXNW2czg8yXEGhmlzhz4DBUr4vE08UboK4Wlnh1fAs7hC0j8X/n
        fCaIhnWMEn87XkB1b2eUWD75HxtElbXEnXO/2EA2MwtoSqzfpQ8RdpR4Mvk4C0hYQoBP4sZb
        QYgj+CQmbZvODBHmlehoE4KoVpPYsGwDG8zarp0roUo8JM4vVZzAqDgLyTezkHwzC2HtAkbm
        VYziqaXFuempxUZ5qeV6xYm5xaV56XrJ+bmbGIGp5fS/4192MO76k3SIUYCDUYmHd4aKQZwQ
        a2JZcWXuIUYJDmYlEd5OJqAQb0piZVVqUX58UWlOavEhRmkOFiVxXuNFL2OFBNITS1KzU1ML
        UotgskwcnFINjBum6nIkO35RCxLl3DXDQOu988t5bXbqbZyzJIsmc6vM7Q0Wi/vSaD7hTYEM
        j/OrBRZL5tRUXKmbEi5x53ei2Md2T+fZaU3hcoq/+uM3WhoaBHK3XnYqFp3U3d/VtCeNWzq/
        Q6X8uH+j6MVNPjrX3s2a+d/8Unjf0mt3viz4K7k/MOPD4sAlSizFGYmGWsxFxYkAASlETSkD
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphkeLIzCtJLcpLzFFi42I5/e/4Pd1QC4M4g7ZFGhar7/azWWycsZ7V
        4tmtvUwWx3Y8YrK4vGsOm8Xc1unsDmweO2fdZfe4fLbU49DhDkaPvi2rGD0+b5ILYI3SsynK
        Ly1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQy5jTUVbwSqZi
        /jzNBsbt4l2MnBwSAiYSz2d9Zexi5OIQEljKKLH0Sj9TFyMHUEJG4vj6MogaYYk/17rYIGo+
        MUq8mP2PBSTBJmAlMbF9FSOILSKgINHzeyVYEbPABkaJVze/gBUJC3hLzG9dyQxiswioSqzc
        cRkszitgJ7GvewkTxAZ5ia3fPrGCLOYEivfsNQcJCwnYSqw/85QVolxQ4uTMJ2CtzEDlzVtn
        M09gFJiFJDULSWoBI9MqRpHU0uLc9NxiQ73ixNzi0rx0veT83E2MwBjYduzn5h2MlzYGH2IU
        4GBU4uGdoWIQJ8SaWFZcmXuIUYKDWUmEt5MJKMSbklhZlVqUH19UmpNafIjRFOiHicxSosn5
        wPjMK4k3NDU0t7A0NDc2NzazUBLn7RA4GCMkkJ5YkpqdmlqQWgTTx8TBKdXAKD/7VMyySxWT
        df0j4q5wTDlnNNO8fGnrniObxe/JMRo1HC8umytpZ6JoF8H15WWu1EzD6xwSB/fJc5VMiTW0
        OL/00Z9PAevXyMxQj+Y4U7YoakfED+W8qbznHm7KUqp6cfer95vNUR+fBhouzow+meeilv4j
        6ltFo3jX+ur3rX+qXxrKzdj7XImlOCPRUIu5qDgRAGSvj+iXAgAA
X-CMS-MailID: 20200128133413eucas1p1725ccae03fb5aba49f0e0cef798da9d6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200128133413eucas1p1725ccae03fb5aba49f0e0cef798da9d6
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200128133413eucas1p1725ccae03fb5aba49f0e0cef798da9d6
References: <20200128133343.29905-1-b.zolnierkie@samsung.com>
        <CGME20200128133413eucas1p1725ccae03fb5aba49f0e0cef798da9d6@eucas1p1.samsung.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Remove EXPORT_SYMBOL_GPL()s for functions used only by
the core libata code.

Code size savings on m68k arch using atari_defconfig:

   text    data     bss     dec     hex filename
before:
  39838     573      40   40451    9e03 drivers/ata/libata-core.o
  21071     105    4096   25272    62b8 drivers/ata/libata-scsi.o
  17519      18       0   17537    4481 drivers/ata/libata-eh.o
after:
  39688     573      40   40301    9d6d drivers/ata/libata-core.o
  21040     105    4096   25241    6299 drivers/ata/libata-scsi.o
  17405      18       0   17423    440f drivers/ata/libata-eh.o

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

