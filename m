Return-Path: <SRS0=c38X=4U=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C89C3F2E3
	for <linux-ide@archiver.kernel.org>; Tue,  3 Mar 2020 09:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 348A2205ED
	for <linux-ide@archiver.kernel.org>; Tue,  3 Mar 2020 09:39:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbgCCJjt (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 3 Mar 2020 04:39:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:47776 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727742AbgCCJjr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Tue, 3 Mar 2020 04:39:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BEF10B204;
        Tue,  3 Mar 2020 09:39:41 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 16/40] libata: drop DPRINTK() calls in reset
Date:   Tue,  3 Mar 2020 10:37:49 +0100
Message-Id: <20200303093813.18523-17-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200303093813.18523-1-hare@suse.de>
References: <20200303093813.18523-1-hare@suse.de>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Reset is now logged with tracepoints, so the DPRINTK() calls can
be dropped.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/ahci.c           |  7 -------
 drivers/ata/ahci_qoriq.c     |  4 ----
 drivers/ata/libahci.c        | 10 ----------
 drivers/ata/libata-core.c    |  7 -------
 drivers/ata/libata-sff.c     | 11 +----------
 drivers/ata/pata_octeon_cf.c |  2 --
 drivers/ata/sata_fsl.c       | 10 ----------
 drivers/ata/sata_rcar.c      |  4 ----
 drivers/ata/sata_sil24.c     |  3 ---
 9 files changed, 1 insertion(+), 57 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 66f3cf039ae2..58e2b8b36064 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -685,8 +685,6 @@ static int ahci_vt8251_hardreset(struct ata_link *link, unsigned int *class,
 	bool online;
 	int rc;
 
-	DPRINTK("ENTER\n");
-
 	hpriv->stop_engine(ap);
 
 	rc = sata_link_hardreset(link, sata_ehc_deb_timing(&link->eh_context),
@@ -694,8 +692,6 @@ static int ahci_vt8251_hardreset(struct ata_link *link, unsigned int *class,
 
 	hpriv->start_engine(ap);
 
-	DPRINTK("EXIT, rc=%d, class=%u\n", rc, *class);
-
 	/* vt8251 doesn't clear BSY on signature FIS reception,
 	 * request follow-up softreset.
 	 */
@@ -775,8 +771,6 @@ static int ahci_avn_hardreset(struct ata_link *link, unsigned int *class,
 	bool online;
 	int rc, i;
 
-	DPRINTK("ENTER\n");
-
 	hpriv->stop_engine(ap);
 
 	for (i = 0; i < 2; i++) {
@@ -814,7 +808,6 @@ static int ahci_avn_hardreset(struct ata_link *link, unsigned int *class,
 	if (online)
 		*class = ahci_dev_classify(ap);
 
-	DPRINTK("EXIT, rc=%d, class=%u\n", rc, *class);
 	return rc;
 }
 
diff --git a/drivers/ata/ahci_qoriq.c b/drivers/ata/ahci_qoriq.c
index a330307d3201..711cf94c3d08 100644
--- a/drivers/ata/ahci_qoriq.c
+++ b/drivers/ata/ahci_qoriq.c
@@ -96,8 +96,6 @@ static int ahci_qoriq_hardreset(struct ata_link *link, unsigned int *class,
 	int rc;
 	bool ls1021a_workaround = (qoriq_priv->type == AHCI_LS1021A);
 
-	DPRINTK("ENTER\n");
-
 	hpriv->stop_engine(ap);
 
 	/*
@@ -139,8 +137,6 @@ static int ahci_qoriq_hardreset(struct ata_link *link, unsigned int *class,
 
 	if (online)
 		*class = ahci_dev_classify(ap);
-
-	DPRINTK("EXIT, rc=%d, class=%u\n", rc, *class);
 	return rc;
 }
 
diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index c1bc973ecc16..1c6d98fab3a3 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -1391,8 +1391,6 @@ int ahci_do_softreset(struct ata_link *link, unsigned int *class,
 	bool fbs_disabled = false;
 	int rc;
 
-	DPRINTK("ENTER\n");
-
 	/* prepare for SRST (AHCI-1.1 10.4.1) */
 	rc = ahci_kick_engine(ap);
 	if (rc && rc != -EOPNOTSUPP)
@@ -1452,7 +1450,6 @@ int ahci_do_softreset(struct ata_link *link, unsigned int *class,
 	if (fbs_disabled)
 		ahci_enable_fbs(ap);
 
-	DPRINTK("EXIT, class=%u\n", *class);
 	return 0;
 
  fail:
@@ -1474,8 +1471,6 @@ static int ahci_softreset(struct ata_link *link, unsigned int *class,
 {
 	int pmp = sata_srst_pmp(link);
 
-	DPRINTK("ENTER\n");
-
 	return ahci_do_softreset(link, class, pmp, deadline, ahci_check_ready);
 }
 EXPORT_SYMBOL_GPL(ahci_do_softreset);
@@ -1505,8 +1500,6 @@ static int ahci_pmp_retry_softreset(struct ata_link *link, unsigned int *class,
 	int rc;
 	u32 irq_sts;
 
-	DPRINTK("ENTER\n");
-
 	rc = ahci_do_softreset(link, class, pmp, deadline,
 			       ahci_bad_pmp_check_ready);
 
@@ -1540,8 +1533,6 @@ int ahci_do_hardreset(struct ata_link *link, unsigned int *class,
 	struct ata_taskfile tf;
 	int rc;
 
-	DPRINTK("ENTER\n");
-
 	hpriv->stop_engine(ap);
 
 	/* clear D2H reception area to properly wait for D2H FIS */
@@ -1557,7 +1548,6 @@ int ahci_do_hardreset(struct ata_link *link, unsigned int *class,
 	if (*online)
 		*class = ahci_dev_classify(ap);
 
-	DPRINTK("EXIT, rc=%d, class=%u\n", rc, *class);
 	return rc;
 }
 EXPORT_SYMBOL_GPL(ahci_do_hardreset);
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 40e327e49905..329cc587eeab 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4070,8 +4070,6 @@ int sata_link_hardreset(struct ata_link *link, const unsigned long *timing,
 	u32 scontrol;
 	int rc;
 
-	DPRINTK("ENTER\n");
-
 	if (online)
 		*online = false;
 
@@ -4147,7 +4145,6 @@ int sata_link_hardreset(struct ata_link *link, const unsigned long *timing,
 			*online = false;
 		ata_link_err(link, "COMRESET failed (errno=%d)\n", rc);
 	}
-	DPRINTK("EXIT, rc=%d\n", rc);
 	return rc;
 }
 
@@ -4193,16 +4190,12 @@ void ata_std_postreset(struct ata_link *link, unsigned int *classes)
 {
 	u32 serror;
 
-	DPRINTK("ENTER\n");
-
 	/* reset complete, clear SError */
 	if (!sata_scr_read(link, SCR_ERROR, &serror))
 		sata_scr_write(link, SCR_ERROR, serror);
 
 	/* print link status */
 	sata_print_link_status(link);
-
-	DPRINTK("EXIT\n");
 }
 
 /**
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 939cda91c56d..25c10f3eef83 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -1946,8 +1946,6 @@ static int ata_bus_softreset(struct ata_port *ap, unsigned int devmask,
 {
 	struct ata_ioports *ioaddr = &ap->ioaddr;
 
-	DPRINTK("ata%u: bus reset via SRST\n", ap->print_id);
-
 	if (ap->ioaddr.ctl_addr) {
 		/* software reset.  causes dev0 to be selected */
 		iowrite8(ap->ctl, ioaddr->ctl_addr);
@@ -1985,8 +1983,6 @@ int ata_sff_softreset(struct ata_link *link, unsigned int *classes,
 	int rc;
 	u8 err;
 
-	DPRINTK("ENTER\n");
-
 	/* determine if device 0/1 are present */
 	if (ata_devchk(ap, 0))
 		devmask |= (1 << 0);
@@ -1997,7 +1993,6 @@ int ata_sff_softreset(struct ata_link *link, unsigned int *classes,
 	ap->ops->sff_dev_select(ap, 0);
 
 	/* issue bus reset */
-	DPRINTK("about to softreset, devmask=%x\n", devmask);
 	rc = ata_bus_softreset(ap, devmask, deadline);
 	/* if link is occupied, -ENODEV too is an error */
 	if (rc && (rc != -ENODEV || sata_scr_valid(link))) {
@@ -2012,7 +2007,6 @@ int ata_sff_softreset(struct ata_link *link, unsigned int *classes,
 		classes[1] = ata_sff_dev_classify(&link->device[1],
 						  devmask & (1 << 1), &err);
 
-	DPRINTK("EXIT, classes[0]=%u [1]=%u\n", classes[0], classes[1]);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(ata_sff_softreset);
@@ -2045,7 +2039,6 @@ int sata_sff_hardreset(struct ata_link *link, unsigned int *class,
 	if (online)
 		*class = ata_sff_dev_classify(link->device, 1, NULL);
 
-	DPRINTK("EXIT, class=%u\n", *class);
 	return rc;
 }
 EXPORT_SYMBOL_GPL(sata_sff_hardreset);
@@ -2075,10 +2068,8 @@ void ata_sff_postreset(struct ata_link *link, unsigned int *classes)
 		ap->ops->sff_dev_select(ap, 0);
 
 	/* bail out if no device is present */
-	if (classes[0] == ATA_DEV_NONE && classes[1] == ATA_DEV_NONE) {
-		DPRINTK("EXIT, no device\n");
+	if (classes[0] == ATA_DEV_NONE && classes[1] == ATA_DEV_NONE)
 		return;
-	}
 
 	/* set up device control */
 	if (ap->ops->sff_set_devctl || ap->ioaddr.ctl_addr) {
diff --git a/drivers/ata/pata_octeon_cf.c b/drivers/ata/pata_octeon_cf.c
index bd87476ab481..7c87168a1932 100644
--- a/drivers/ata/pata_octeon_cf.c
+++ b/drivers/ata/pata_octeon_cf.c
@@ -440,7 +440,6 @@ static int octeon_cf_softreset16(struct ata_link *link, unsigned int *classes,
 	int rc;
 	u8 err;
 
-	DPRINTK("about to softreset\n");
 	__raw_writew(ap->ctl, base + 0xe);
 	udelay(20);
 	__raw_writew(ap->ctl | ATA_SRST, base + 0xe);
@@ -455,7 +454,6 @@ static int octeon_cf_softreset16(struct ata_link *link, unsigned int *classes,
 
 	/* determine by signature whether we have ATA or ATAPI devices */
 	classes[0] = ata_sff_dev_classify(&link->device[0], 1, &err);
-	DPRINTK("EXIT, classes[0]=%u [1]=%u\n", classes[0], classes[1]);
 	return 0;
 }
 
diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index 0864c4fafa39..5d48e1d223fa 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -825,8 +825,6 @@ static int sata_fsl_hardreset(struct ata_link *link, unsigned int *class,
 	int i = 0;
 	unsigned long start_jiffies;
 
-	DPRINTK("in xx_hardreset\n");
-
 try_offline_again:
 	/*
 	 * Force host controller to go off-line, aborting current operations
@@ -941,10 +939,7 @@ static int sata_fsl_softreset(struct ata_link *link, unsigned int *class,
 	u8 *cfis;
 	u32 Serror;
 
-	DPRINTK("in xx_softreset\n");
-
 	if (ata_link_offline(link)) {
-		DPRINTK("PHY reports no device\n");
 		*class = ATA_DEV_NONE;
 		return 0;
 	}
@@ -957,8 +952,6 @@ static int sata_fsl_softreset(struct ata_link *link, unsigned int *class,
 	 * reached here, we can send a command to the target device
 	 */
 
-	DPRINTK("Sending SRST/device reset\n");
-
 	ata_tf_init(link->device, &tf);
 	cfis = (u8 *) &pp->cmdentry->cfis;
 
@@ -1030,8 +1023,6 @@ static int sata_fsl_softreset(struct ata_link *link, unsigned int *class,
 	 */
 	iowrite32(0x01, CC + hcr_base);	/* We know it will be cmd#0 always */
 
-	DPRINTK("SATA FSL : Now checking device signature\n");
-
 	*class = ATA_DEV_NONE;
 
 	/* Verify if SStatus indicates device presence */
@@ -1045,7 +1036,6 @@ static int sata_fsl_softreset(struct ata_link *link, unsigned int *class,
 
 		*class = sata_fsl_dev_classify(ap);
 
-		DPRINTK("class = %d\n", *class);
 		VPRINTK("ccreg = 0x%x\n", ioread32(hcr_base + CC));
 		VPRINTK("cereg = 0x%x\n", ioread32(hcr_base + CE));
 	}
diff --git a/drivers/ata/sata_rcar.c b/drivers/ata/sata_rcar.c
index 980aacdbcf3b..1b42be234761 100644
--- a/drivers/ata/sata_rcar.c
+++ b/drivers/ata/sata_rcar.c
@@ -323,8 +323,6 @@ static int sata_rcar_bus_softreset(struct ata_port *ap, unsigned long deadline)
 {
 	struct ata_ioports *ioaddr = &ap->ioaddr;
 
-	DPRINTK("ata%u: bus reset via SRST\n", ap->print_id);
-
 	/* software reset.  causes dev0 to be selected */
 	iowrite32(ap->ctl, ioaddr->ctl_addr);
 	udelay(20);
@@ -350,7 +348,6 @@ static int sata_rcar_softreset(struct ata_link *link, unsigned int *classes,
 		devmask |= 1 << 0;
 
 	/* issue bus reset */
-	DPRINTK("about to softreset, devmask=%x\n", devmask);
 	rc = sata_rcar_bus_softreset(ap, deadline);
 	/* if link is occupied, -ENODEV too is an error */
 	if (rc && (rc != -ENODEV || sata_scr_valid(link))) {
@@ -361,7 +358,6 @@ static int sata_rcar_softreset(struct ata_link *link, unsigned int *classes,
 	/* determine by signature whether we have ATA or ATAPI devices */
 	classes[0] = ata_sff_dev_classify(&link->device[0], devmask, &err);
 
-	DPRINTK("classes[0]=%u\n", classes[0]);
 	return 0;
 }
 
diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index 2373cf5d8d14..48e2b3ec2afd 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -653,8 +653,6 @@ static int sil24_softreset(struct ata_link *link, unsigned int *class,
 	const char *reason;
 	int rc;
 
-	DPRINTK("ENTER\n");
-
 	/* put the port into known state */
 	if (sil24_init_port(ap)) {
 		reason = "port not ready";
@@ -679,7 +677,6 @@ static int sil24_softreset(struct ata_link *link, unsigned int *class,
 	sil24_read_tf(ap, 0, &tf);
 	*class = ata_port_classify(ap, &tf);
 
-	DPRINTK("EXIT, class=%u\n", *class);
 	return 0;
 
  err:
-- 
2.16.4

