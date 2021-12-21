Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8CE2C4167B
	for <linux-ide@archiver.kernel.org>; Tue, 21 Dec 2021 07:22:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234980AbhLUHWp (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 21 Dec 2021 02:22:45 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:52534 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbhLUHWm (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 21 Dec 2021 02:22:42 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B648B212CC;
        Tue, 21 Dec 2021 07:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1640071361; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/goK895/jbioplGiAZO0GnwgQb//5nFkvVN3ty5OhQA=;
        b=kBYfjOrhrQhU9NrRcyw4fabO6EKayt0M+PbaSg1TfikuFmvse2if4vE8T1/NV4IXfE7Ps7
        7pf04/8ozBEVhxetcWrcBl1/isyYg2nrz33RI4tQ1Zm6HRW22qmGZfOrcddhNw9wqXFoZN
        +q5UM2QMI0UtHxkajsMk+KNDx4W2O0s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1640071361;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/goK895/jbioplGiAZO0GnwgQb//5nFkvVN3ty5OhQA=;
        b=6Xvj7tfPGFpCmtx9e2dxc/fqno+oqaiFChAsPYr9MNQKL41trFv5dlMItx24pKlLXGAkZR
        R5bihgyrYXvaD9DA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id B07F6A3B8A;
        Tue, 21 Dec 2021 07:22:41 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id ADCAC519237E; Tue, 21 Dec 2021 08:22:41 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 06/68] libata: add reset tracepoints
Date:   Tue, 21 Dec 2021 08:20:29 +0100
Message-Id: <20211221072131.46673-7-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211221072131.46673-1-hare@suse.de>
References: <20211221072131.46673-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

To follow the flow of control we should be using tracepoints, as
they will tie in with the actual I/O flow and deliver a better
overview about what it happening.
This patch adds tracepoints for hard reset, soft reset, and postreset
and adds them in the libata-eh control flow.
With that we can drop the reset DPRINTK calls in the various drivers.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/ahci.c            |  7 ---
 drivers/ata/ahci_qoriq.c      |  4 --
 drivers/ata/libahci.c         | 10 ----
 drivers/ata/libata-core.c     |  4 --
 drivers/ata/libata-eh.c       | 21 ++++++--
 drivers/ata/libata-sff.c      | 11 +---
 drivers/ata/pata_octeon_cf.c  |  2 -
 drivers/ata/sata_fsl.c        | 10 ----
 drivers/ata/sata_rcar.c       |  4 --
 drivers/ata/sata_sil24.c      |  3 --
 include/trace/events/libata.h | 96 +++++++++++++++++++++++++++++++++++
 11 files changed, 115 insertions(+), 57 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index d5bed24a52ba..3939afeca388 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -700,8 +700,6 @@ static int ahci_vt8251_hardreset(struct ata_link *link, unsigned int *class,
 	bool online;
 	int rc;
 
-	DPRINTK("ENTER\n");
-
 	hpriv->stop_engine(ap);
 
 	rc = sata_link_hardreset(link, sata_ehc_deb_timing(&link->eh_context),
@@ -709,8 +707,6 @@ static int ahci_vt8251_hardreset(struct ata_link *link, unsigned int *class,
 
 	hpriv->start_engine(ap);
 
-	DPRINTK("EXIT, rc=%d, class=%u\n", rc, *class);
-
 	/* vt8251 doesn't clear BSY on signature FIS reception,
 	 * request follow-up softreset.
 	 */
@@ -790,8 +786,6 @@ static int ahci_avn_hardreset(struct ata_link *link, unsigned int *class,
 	bool online;
 	int rc, i;
 
-	DPRINTK("ENTER\n");
-
 	hpriv->stop_engine(ap);
 
 	for (i = 0; i < 2; i++) {
@@ -829,7 +823,6 @@ static int ahci_avn_hardreset(struct ata_link *link, unsigned int *class,
 	if (online)
 		*class = ahci_dev_classify(ap);
 
-	DPRINTK("EXIT, rc=%d, class=%u\n", rc, *class);
 	return rc;
 }
 
diff --git a/drivers/ata/ahci_qoriq.c b/drivers/ata/ahci_qoriq.c
index 5b46fc9aeb4a..bf5b388bd4e0 100644
--- a/drivers/ata/ahci_qoriq.c
+++ b/drivers/ata/ahci_qoriq.c
@@ -103,8 +103,6 @@ static int ahci_qoriq_hardreset(struct ata_link *link, unsigned int *class,
 	int rc;
 	bool ls1021a_workaround = (qoriq_priv->type == AHCI_LS1021A);
 
-	DPRINTK("ENTER\n");
-
 	hpriv->stop_engine(ap);
 
 	/*
@@ -146,8 +144,6 @@ static int ahci_qoriq_hardreset(struct ata_link *link, unsigned int *class,
 
 	if (online)
 		*class = ahci_dev_classify(ap);
-
-	DPRINTK("EXIT, rc=%d, class=%u\n", rc, *class);
 	return rc;
 }
 
diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index b7b460560a92..b6f674a1fddc 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -1415,8 +1415,6 @@ int ahci_do_softreset(struct ata_link *link, unsigned int *class,
 	bool fbs_disabled = false;
 	int rc;
 
-	DPRINTK("ENTER\n");
-
 	/* prepare for SRST (AHCI-1.1 10.4.1) */
 	rc = ahci_kick_engine(ap);
 	if (rc && rc != -EOPNOTSUPP)
@@ -1476,7 +1474,6 @@ int ahci_do_softreset(struct ata_link *link, unsigned int *class,
 	if (fbs_disabled)
 		ahci_enable_fbs(ap);
 
-	DPRINTK("EXIT, class=%u\n", *class);
 	return 0;
 
  fail:
@@ -1498,8 +1495,6 @@ static int ahci_softreset(struct ata_link *link, unsigned int *class,
 {
 	int pmp = sata_srst_pmp(link);
 
-	DPRINTK("ENTER\n");
-
 	return ahci_do_softreset(link, class, pmp, deadline, ahci_check_ready);
 }
 EXPORT_SYMBOL_GPL(ahci_do_softreset);
@@ -1529,8 +1524,6 @@ static int ahci_pmp_retry_softreset(struct ata_link *link, unsigned int *class,
 	int rc;
 	u32 irq_sts;
 
-	DPRINTK("ENTER\n");
-
 	rc = ahci_do_softreset(link, class, pmp, deadline,
 			       ahci_bad_pmp_check_ready);
 
@@ -1564,8 +1557,6 @@ int ahci_do_hardreset(struct ata_link *link, unsigned int *class,
 	struct ata_taskfile tf;
 	int rc;
 
-	DPRINTK("ENTER\n");
-
 	hpriv->stop_engine(ap);
 
 	/* clear D2H reception area to properly wait for D2H FIS */
@@ -1581,7 +1572,6 @@ int ahci_do_hardreset(struct ata_link *link, unsigned int *class,
 	if (*online)
 		*class = ahci_dev_classify(ap);
 
-	DPRINTK("EXIT, rc=%d, class=%u\n", rc, *class);
 	return rc;
 }
 EXPORT_SYMBOL_GPL(ahci_do_hardreset);
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 0517a3a17507..f23776e4a2ab 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3656,16 +3656,12 @@ void ata_std_postreset(struct ata_link *link, unsigned int *classes)
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
 EXPORT_SYMBOL_GPL(ata_std_postreset);
 
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 1d4a6f1e88cd..043a1c846f2c 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2596,12 +2596,19 @@ int ata_eh_reset(struct ata_link *link, int classify,
 
 		/* mark that this EH session started with reset */
 		ehc->last_reset = jiffies;
-		if (reset == hardreset)
+		if (reset == hardreset) {
 			ehc->i.flags |= ATA_EHI_DID_HARDRESET;
-		else
+			trace_ata_link_hardreset_begin(link, classes, deadline);
+		} else {
 			ehc->i.flags |= ATA_EHI_DID_SOFTRESET;
+			trace_ata_link_softreset_begin(link, classes, deadline);
+		}
 
 		rc = ata_do_reset(link, reset, classes, deadline, true);
+		if (reset == hardreset)
+			trace_ata_link_hardreset_end(link, classes, rc);
+		else
+			trace_ata_link_softreset_end(link, classes, rc);
 		if (rc && rc != -EAGAIN) {
 			failed_link = link;
 			goto fail;
@@ -2615,8 +2622,11 @@ int ata_eh_reset(struct ata_link *link, int classify,
 				ata_link_info(slave, "hard resetting link\n");
 
 			ata_eh_about_to_do(slave, NULL, ATA_EH_RESET);
+			trace_ata_slave_hardreset_begin(slave, classes,
+							deadline);
 			tmp = ata_do_reset(slave, reset, classes, deadline,
 					   false);
+			trace_ata_slave_hardreset_end(slave, classes, tmp);
 			switch (tmp) {
 			case -EAGAIN:
 				rc = -EAGAIN;
@@ -2644,7 +2654,9 @@ int ata_eh_reset(struct ata_link *link, int classify,
 			}
 
 			ata_eh_about_to_do(link, NULL, ATA_EH_RESET);
+			trace_ata_link_softreset_begin(link, classes, deadline);
 			rc = ata_do_reset(link, reset, classes, deadline, true);
+			trace_ata_link_softreset_end(link, classes, rc);
 			if (rc) {
 				failed_link = link;
 				goto fail;
@@ -2698,8 +2710,11 @@ int ata_eh_reset(struct ata_link *link, int classify,
 	 */
 	if (postreset) {
 		postreset(link, classes);
-		if (slave)
+		trace_ata_link_postreset(link, classes, rc);
+		if (slave) {
 			postreset(slave, classes);
+			trace_ata_slave_postreset(slave, classes, rc);
+		}
 	}
 
 	/*
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index a119fabe0919..4cc7c0606e06 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -1956,8 +1956,6 @@ static int ata_bus_softreset(struct ata_port *ap, unsigned int devmask,
 {
 	struct ata_ioports *ioaddr = &ap->ioaddr;
 
-	DPRINTK("ata%u: bus reset via SRST\n", ap->print_id);
-
 	if (ap->ioaddr.ctl_addr) {
 		/* software reset.  causes dev0 to be selected */
 		iowrite8(ap->ctl, ioaddr->ctl_addr);
@@ -1995,8 +1993,6 @@ int ata_sff_softreset(struct ata_link *link, unsigned int *classes,
 	int rc;
 	u8 err;
 
-	DPRINTK("ENTER\n");
-
 	/* determine if device 0/1 are present */
 	if (ata_devchk(ap, 0))
 		devmask |= (1 << 0);
@@ -2007,7 +2003,6 @@ int ata_sff_softreset(struct ata_link *link, unsigned int *classes,
 	ap->ops->sff_dev_select(ap, 0);
 
 	/* issue bus reset */
-	DPRINTK("about to softreset, devmask=%x\n", devmask);
 	rc = ata_bus_softreset(ap, devmask, deadline);
 	/* if link is occupied, -ENODEV too is an error */
 	if (rc && (rc != -ENODEV || sata_scr_valid(link))) {
@@ -2022,7 +2017,6 @@ int ata_sff_softreset(struct ata_link *link, unsigned int *classes,
 		classes[1] = ata_sff_dev_classify(&link->device[1],
 						  devmask & (1 << 1), &err);
 
-	DPRINTK("EXIT, classes[0]=%u [1]=%u\n", classes[0], classes[1]);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(ata_sff_softreset);
@@ -2055,7 +2049,6 @@ int sata_sff_hardreset(struct ata_link *link, unsigned int *class,
 	if (online)
 		*class = ata_sff_dev_classify(link->device, 1, NULL);
 
-	DPRINTK("EXIT, class=%u\n", *class);
 	return rc;
 }
 EXPORT_SYMBOL_GPL(sata_sff_hardreset);
@@ -2085,10 +2078,8 @@ void ata_sff_postreset(struct ata_link *link, unsigned int *classes)
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
index b5a3f710d76d..cdc95eb2b2cb 100644
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
index 7504d9fbff2a..8aace70e8826 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -827,8 +827,6 @@ static int sata_fsl_hardreset(struct ata_link *link, unsigned int *class,
 	int i = 0;
 	unsigned long start_jiffies;
 
-	DPRINTK("in xx_hardreset\n");
-
 try_offline_again:
 	/*
 	 * Force host controller to go off-line, aborting current operations
@@ -943,10 +941,7 @@ static int sata_fsl_softreset(struct ata_link *link, unsigned int *class,
 	u8 *cfis;
 	u32 Serror;
 
-	DPRINTK("in xx_softreset\n");
-
 	if (ata_link_offline(link)) {
-		DPRINTK("PHY reports no device\n");
 		*class = ATA_DEV_NONE;
 		return 0;
 	}
@@ -959,8 +954,6 @@ static int sata_fsl_softreset(struct ata_link *link, unsigned int *class,
 	 * reached here, we can send a command to the target device
 	 */
 
-	DPRINTK("Sending SRST/device reset\n");
-
 	ata_tf_init(link->device, &tf);
 	cfis = (u8 *) &pp->cmdentry->cfis;
 
@@ -1032,8 +1025,6 @@ static int sata_fsl_softreset(struct ata_link *link, unsigned int *class,
 	 */
 	iowrite32(0x01, CC + hcr_base);	/* We know it will be cmd#0 always */
 
-	DPRINTK("SATA FSL : Now checking device signature\n");
-
 	*class = ATA_DEV_NONE;
 
 	/* Verify if SStatus indicates device presence */
@@ -1047,7 +1038,6 @@ static int sata_fsl_softreset(struct ata_link *link, unsigned int *class,
 
 		*class = sata_fsl_dev_classify(ap);
 
-		DPRINTK("class = %d\n", *class);
 		VPRINTK("ccreg = 0x%x\n", ioread32(hcr_base + CC));
 		VPRINTK("cereg = 0x%x\n", ioread32(hcr_base + CE));
 	}
diff --git a/drivers/ata/sata_rcar.c b/drivers/ata/sata_rcar.c
index 44b0ed8f6bb8..9005833ab02f 100644
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
index 7e9c1945dc81..2fef6ce93f07 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -656,8 +656,6 @@ static int sil24_softreset(struct ata_link *link, unsigned int *class,
 	const char *reason;
 	int rc;
 
-	DPRINTK("ENTER\n");
-
 	/* put the port into known state */
 	if (sil24_init_port(ap)) {
 		reason = "port not ready";
@@ -682,7 +680,6 @@ static int sil24_softreset(struct ata_link *link, unsigned int *class,
 	sil24_read_tf(ap, 0, &tf);
 	*class = ata_port_classify(ap, &tf);
 
-	DPRINTK("EXIT, class=%u\n", *class);
 	return 0;
 
  err:
diff --git a/include/trace/events/libata.h b/include/trace/events/libata.h
index ab69434e2329..ec2a350d1aca 100644
--- a/include/trace/events/libata.h
+++ b/include/trace/events/libata.h
@@ -132,6 +132,22 @@
 		ata_protocol_name(ATAPI_PROT_PIO),	\
 		ata_protocol_name(ATAPI_PROT_DMA))
 
+#define ata_class_name(class)	{ class, #class }
+#define show_class_name(val)				\
+	__print_symbolic(val,				\
+		ata_class_name(ATA_DEV_UNKNOWN),	\
+		ata_class_name(ATA_DEV_ATA),		\
+		ata_class_name(ATA_DEV_ATA_UNSUP),	\
+		ata_class_name(ATA_DEV_ATAPI),		\
+		ata_class_name(ATA_DEV_ATAPI_UNSUP),	\
+		ata_class_name(ATA_DEV_PMP),		\
+		ata_class_name(ATA_DEV_PMP_UNSUP),	\
+		ata_class_name(ATA_DEV_SEMB),		\
+		ata_class_name(ATA_DEV_SEMB_UNSUP),	\
+		ata_class_name(ATA_DEV_ZAC),		\
+		ata_class_name(ATA_DEV_ZAC_UNSUP),	\
+		ata_class_name(ATA_DEV_NONE))
+
 const char *libata_trace_parse_status(struct trace_seq*, unsigned char);
 #define __parse_status(s) libata_trace_parse_status(p, s)
 
@@ -329,6 +345,86 @@ TRACE_EVENT(ata_eh_link_autopsy_qc,
 		  __parse_eh_err_mask(__entry->eh_err_mask))
 );
 
+DECLARE_EVENT_CLASS(ata_link_reset_begin_template,
+
+	TP_PROTO(struct ata_link *link, unsigned int *class, unsigned long deadline),
+
+	TP_ARGS(link, class, deadline),
+
+	TP_STRUCT__entry(
+		__field( unsigned int,	ata_port )
+		__array( unsigned int,	class, 2 )
+		__field( unsigned long,	deadline )
+	),
+
+	TP_fast_assign(
+		__entry->ata_port	= link->ap->print_id;
+		memcpy(__entry->class, class, 2);
+		__entry->deadline	= deadline;
+	),
+
+	TP_printk("ata_port=%u deadline=%lu classes=[%s,%s]",
+		  __entry->ata_port, __entry->deadline,
+		  show_class_name(__entry->class[0]),
+		  show_class_name(__entry->class[1]))
+);
+
+DEFINE_EVENT(ata_link_reset_begin_template, ata_link_hardreset_begin,
+	     TP_PROTO(struct ata_link *link, unsigned int *class, unsigned long deadline),
+	     TP_ARGS(link, class, deadline));
+
+DEFINE_EVENT(ata_link_reset_begin_template, ata_slave_hardreset_begin,
+	     TP_PROTO(struct ata_link *link, unsigned int *class, unsigned long deadline),
+	     TP_ARGS(link, class, deadline));
+
+DEFINE_EVENT(ata_link_reset_begin_template, ata_link_softreset_begin,
+	     TP_PROTO(struct ata_link *link, unsigned int *class, unsigned long deadline),
+	     TP_ARGS(link, class, deadline));
+
+DECLARE_EVENT_CLASS(ata_link_reset_end_template,
+
+	TP_PROTO(struct ata_link *link, unsigned int *class, int rc),
+
+	TP_ARGS(link, class, rc),
+
+	TP_STRUCT__entry(
+		__field( unsigned int,	ata_port )
+		__array( unsigned int,	class, 2 )
+		__field( int,		rc	)
+	),
+
+	TP_fast_assign(
+		__entry->ata_port	= link->ap->print_id;
+		memcpy(__entry->class, class, 2);
+		__entry->rc		= rc;
+	),
+
+	TP_printk("ata_port=%u rc=%d class=[%s,%s]",
+		  __entry->ata_port, __entry->rc,
+		  show_class_name(__entry->class[0]),
+		  show_class_name(__entry->class[1]))
+);
+
+DEFINE_EVENT(ata_link_reset_end_template, ata_link_hardreset_end,
+	     TP_PROTO(struct ata_link *link, unsigned int *class, int rc),
+	     TP_ARGS(link, class, rc));
+
+DEFINE_EVENT(ata_link_reset_end_template, ata_slave_hardreset_end,
+	     TP_PROTO(struct ata_link *link, unsigned int *class, int rc),
+	     TP_ARGS(link, class, rc));
+
+DEFINE_EVENT(ata_link_reset_end_template, ata_link_softreset_end,
+	     TP_PROTO(struct ata_link *link, unsigned int *class, int rc),
+	     TP_ARGS(link, class, rc));
+
+DEFINE_EVENT(ata_link_reset_end_template, ata_link_postreset,
+	     TP_PROTO(struct ata_link *link, unsigned int *class, int rc),
+	     TP_ARGS(link, class, rc));
+
+DEFINE_EVENT(ata_link_reset_end_template, ata_slave_postreset,
+	     TP_PROTO(struct ata_link *link, unsigned int *class, int rc),
+	     TP_ARGS(link, class, rc));
+
 #endif /*  _TRACE_LIBATA_H */
 
 /* This part must be outside protection */
-- 
2.29.2

