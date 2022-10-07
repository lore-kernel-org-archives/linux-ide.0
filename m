Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74514C433F5
	for <linux-ide@archiver.kernel.org>; Fri,  7 Oct 2022 13:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbiJGNYJ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 7 Oct 2022 09:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiJGNX6 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 7 Oct 2022 09:23:58 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E614D77D3
        for <linux-ide@vger.kernel.org>; Fri,  7 Oct 2022 06:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1665149037; x=1696685037;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4E9FZ9FeVwvb2EyhaxI7xo4bg+HIs2B8lUXst2A2IXw=;
  b=bCyAdPhUmC+k3lgiSv4T/bFjBRJsg/MxhbfBOcFoWZOGzAHN2lH4cYMC
   hgf8495MID77ciVAkDEGHzsCCysePHDqXYohLnH8uKaOHIT2Il/zHOeeV
   ecWUx2k0/yy0OHGciuKmKXUvZ7OYjq+hhDRmFekfTZsusFKe1Y0ESrLgZ
   Z4n2F51c29GWqeCF2yBK46VbVMXK9KmOFu+RHDlDqYTNqtGgggPxbetOb
   a3l/wWXcFf0NA/RgLz5k95xFSgpv3KSOrX+Josu0F12sz0dVfySRbta4k
   x2NLhjwvtOHCPgBTF4oZi1VwPM9ORmFE77WF2BUpMvDdCnbh+S5XG6Yaj
   g==;
X-IronPort-AV: E=Sophos;i="5.95,166,1661788800"; 
   d="scan'208";a="213238168"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Oct 2022 21:23:57 +0800
IronPort-SDR: kQfJxKQwafnDukMycKHtUtTijJrLDRvOZKrOaeko3316rBKfv1O9owAijUM/nC4nOnhVqtLNHN
 EOHaPJuuvyEPIlTSjKOW+P7Cr0HG+TdR/6DABcb77n48GBpwlYpbHmLdsxDBEkg8vZdF8lx4bD
 BeStDeQEMygAxPAeg+/6E19vSE1DPaWDEQk4w3LBz0TD0jRU3zyo9TbYPEhoVHp1t1GdQ0HyIh
 dO8WLTnKty7jRh9edZh4RODznct25xxjEq1OnPIXUv4B2g/MnLByoLoMbxqB4YSmZJ9Hdjz5ZF
 a9c7iJY6QOCguvZI7P6GEQnR
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Oct 2022 05:38:07 -0700
IronPort-SDR: DP3TuFJ5oF3q/j4e1mvbDt4eStIlbE0nrfjBXQH3FX1sy4IAAt1XiG/knn3dfEpWEPuO6rCHCz
 yg2knV6RGEuSrWJNXefpUyOhrGYhkm50x+9JyxjJnSao9u+lWOM5xYNvNOl2+PY2SGU2/fyetS
 ydlDKl/fCOB6OdAygGIpVB3usDN6lQ2eXfzpMJijXj1EvlAaU9EPZB9x8oaE0jigcMTJVljiP6
 52ctdzATX+wZWXvB1TmZQURhLfTaDnWIdU2WxFVjEQZ91q0Fn9PKzZa41ax1AKcmJDps6QeH9s
 HA0=
WDCIronportException: Internal
Received: from unknown (HELO x1-carbon.wdc.com) ([10.225.164.69])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Oct 2022 06:23:55 -0700
From:   Niklas Cassel <niklas.cassel@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Mikael Pettersson <mikpelinux@gmail.com>
Cc:     john.garry@huawei.com, Niklas Cassel <niklas.cassel@wdc.com>,
        linux-ide@vger.kernel.org
Subject: [PATCH 2/4] ata: make use of ata_port_is_frozen() helper
Date:   Fri,  7 Oct 2022 15:23:38 +0200
Message-Id: <20221007132342.1590367-3-niklas.cassel@wdc.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221007132342.1590367-1-niklas.cassel@wdc.com>
References: <20221007132342.1590367-1-niklas.cassel@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Clean up the code by making use of the newly introduced
ata_port_is_frozen() helper function.

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 drivers/ata/libahci.c      |  6 +++---
 drivers/ata/libata-acpi.c  |  4 ++--
 drivers/ata/libata-core.c  |  4 ++--
 drivers/ata/libata-eh.c    | 21 ++++++++++-----------
 drivers/ata/libata-sata.c  |  2 +-
 drivers/ata/libata-scsi.c  |  2 +-
 drivers/ata/sata_nv.c      |  2 +-
 drivers/ata/sata_promise.c |  2 +-
 drivers/ata/sata_sx4.c     |  2 +-
 9 files changed, 22 insertions(+), 23 deletions(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 954386a2b500..399feb09d1ba 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -2106,7 +2106,7 @@ void ahci_error_handler(struct ata_port *ap)
 {
 	struct ahci_host_priv *hpriv = ap->host->private_data;
 
-	if (!(ap->pflags & ATA_PFLAG_FROZEN)) {
+	if (!ata_port_is_frozen(ap)) {
 		/* restart engine */
 		hpriv->stop_engine(ap);
 		hpriv->start_engine(ap);
@@ -2297,7 +2297,7 @@ static void ahci_pmp_attach(struct ata_port *ap)
 	 * Note that during initialization, the port is marked as
 	 * frozen since the irq handler is not yet registered.
 	 */
-	if (!(ap->pflags & ATA_PFLAG_FROZEN))
+	if (!ata_port_is_frozen(ap))
 		writel(pp->intr_mask, port_mmio + PORT_IRQ_MASK);
 }
 
@@ -2316,7 +2316,7 @@ static void ahci_pmp_detach(struct ata_port *ap)
 	pp->intr_mask &= ~PORT_IRQ_BAD_PMP;
 
 	/* see comment above in ahci_pmp_attach() */
-	if (!(ap->pflags & ATA_PFLAG_FROZEN))
+	if (!ata_port_is_frozen(ap))
 		writel(pp->intr_mask, port_mmio + PORT_IRQ_MASK);
 }
 
diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
index 61b4ccf88bf1..d36e71f475ab 100644
--- a/drivers/ata/libata-acpi.c
+++ b/drivers/ata/libata-acpi.c
@@ -992,7 +992,7 @@ int ata_acpi_on_devcfg(struct ata_device *dev)
 
  acpi_err:
 	/* ignore evaluation failure if we can continue safely */
-	if (rc == -EINVAL && !nr_executed && !(ap->pflags & ATA_PFLAG_FROZEN))
+	if (rc == -EINVAL && !nr_executed && !ata_port_is_frozen(ap))
 		return 0;
 
 	/* fail and let EH retry once more for unknown IO errors */
@@ -1007,7 +1007,7 @@ int ata_acpi_on_devcfg(struct ata_device *dev)
 	/* We can safely continue if no _GTF command has been executed
 	 * and port is not frozen.
 	 */
-	if (!nr_executed && !(ap->pflags & ATA_PFLAG_FROZEN))
+	if (!nr_executed && !ata_port_is_frozen(ap))
 		return 0;
 
 	return rc;
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 75b86913db1a..1cf326dd7c41 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1489,7 +1489,7 @@ static unsigned ata_exec_internal_sg(struct ata_device *dev,
 	spin_lock_irqsave(ap->lock, flags);
 
 	/* no internal command while frozen */
-	if (ap->pflags & ATA_PFLAG_FROZEN) {
+	if (ata_port_is_frozen(ap)) {
 		spin_unlock_irqrestore(ap->lock, flags);
 		return AC_ERR_SYSTEM;
 	}
@@ -4717,7 +4717,7 @@ void ata_qc_complete(struct ata_queued_cmd *qc)
 			return;
 		}
 
-		WARN_ON_ONCE(ap->pflags & ATA_PFLAG_FROZEN);
+		WARN_ON_ONCE(ata_port_is_frozen(ap));
 
 		/* read result TF if requested */
 		if (qc->flags & ATA_QCFLAG_RESULT_TF)
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 1b82283f4b49..00181e747932 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1406,7 +1406,7 @@ static void ata_eh_request_sense(struct ata_queued_cmd *qc)
 	struct ata_taskfile tf;
 	unsigned int err_mask;
 
-	if (qc->ap->pflags & ATA_PFLAG_FROZEN) {
+	if (ata_port_is_frozen(qc->ap)) {
 		ata_dev_warn(dev, "sense data available but port frozen\n");
 		return;
 	}
@@ -1588,7 +1588,7 @@ static unsigned int ata_eh_analyze_tf(struct ata_queued_cmd *qc)
 		break;
 
 	case ATA_DEV_ATAPI:
-		if (!(qc->ap->pflags & ATA_PFLAG_FROZEN)) {
+		if (!ata_port_is_frozen(qc->ap)) {
 			tmp = atapi_eh_request_sense(qc->dev,
 						qc->scsicmd->sense_buffer,
 						qc->result_tf.error >> 4);
@@ -1995,7 +1995,7 @@ static void ata_eh_link_autopsy(struct ata_link *link)
 		ehc->i.flags |= ATA_EHI_QUIET;
 
 	/* enforce default EH actions */
-	if (ap->pflags & ATA_PFLAG_FROZEN ||
+	if (ata_port_is_frozen(ap) ||
 	    all_err_mask & (AC_ERR_HSM | AC_ERR_TIMEOUT))
 		ehc->i.action |= ATA_EH_RESET;
 	else if (((eflags & ATA_EFLAG_IS_IO) && all_err_mask) ||
@@ -2237,7 +2237,7 @@ static void ata_eh_link_report(struct ata_link *link)
 		return;
 
 	frozen = "";
-	if (ap->pflags & ATA_PFLAG_FROZEN)
+	if (ata_port_is_frozen(ap))
 		frozen = " frozen";
 
 	if (ap->eh_tries < ATA_EH_MAX_TRIES)
@@ -2558,8 +2558,7 @@ int ata_eh_reset(struct ata_link *link, int classify,
 		if (reset && !(ehc->i.action & ATA_EH_RESET)) {
 			ata_for_each_dev(dev, link, ALL)
 				classes[dev->devno] = ATA_DEV_NONE;
-			if ((ap->pflags & ATA_PFLAG_FROZEN) &&
-			    ata_is_host_link(link))
+			if (ata_port_is_frozen(ap) && ata_is_host_link(link))
 				ata_eh_thaw_port(ap);
 			rc = 0;
 			goto out;
@@ -2717,7 +2716,7 @@ int ata_eh_reset(struct ata_link *link, int classify,
 	ap->pflags &= ~ATA_PFLAG_EH_PENDING;
 	spin_unlock_irqrestore(link->ap->lock, flags);
 
-	if (ap->pflags & ATA_PFLAG_FROZEN)
+	if (ata_port_is_frozen(ap))
 		ata_eh_thaw_port(ap);
 
 	/*
@@ -3224,7 +3223,7 @@ static int ata_eh_maybe_retry_flush(struct ata_device *dev)
 		if (err_mask & AC_ERR_DEV) {
 			qc->err_mask |= AC_ERR_DEV;
 			qc->result_tf = tf;
-			if (!(ap->pflags & ATA_PFLAG_FROZEN))
+			if (!ata_port_is_frozen(ap))
 				rc = 0;
 		}
 	}
@@ -3401,7 +3400,7 @@ static int ata_eh_skip_recovery(struct ata_link *link)
 		return 1;
 
 	/* thaw frozen port and recover failed devices */
-	if ((ap->pflags & ATA_PFLAG_FROZEN) || ata_link_nr_enabled(link))
+	if (ata_port_is_frozen(ap) || ata_link_nr_enabled(link))
 		return 0;
 
 	/* reset at least once if reset is requested */
@@ -3756,7 +3755,7 @@ int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
 		if (dev)
 			ata_eh_handle_dev_fail(dev, rc);
 
-		if (ap->pflags & ATA_PFLAG_FROZEN) {
+		if (ata_port_is_frozen(ap)) {
 			/* PMP reset requires working host port.
 			 * Can't retry if it's frozen.
 			 */
@@ -3930,7 +3929,7 @@ static void ata_eh_handle_port_suspend(struct ata_port *ap)
 	ap->pflags &= ~ATA_PFLAG_PM_PENDING;
 	if (rc == 0)
 		ap->pflags |= ATA_PFLAG_SUSPENDED;
-	else if (ap->pflags & ATA_PFLAG_FROZEN)
+	else if (ata_port_is_frozen(ap))
 		ata_port_schedule_eh(ap);
 
 	spin_unlock_irqrestore(ap->lock, flags);
diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index eef57d101ed1..60009ac03a8f 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -1420,7 +1420,7 @@ void ata_eh_analyze_ncq_error(struct ata_link *link)
 	int tag, rc;
 
 	/* if frozen, we can't do much */
-	if (ap->pflags & ATA_PFLAG_FROZEN)
+	if (ata_port_is_frozen(ap))
 		return;
 
 	/* is it NCQ device error? */
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index f3c64e796423..ccacaa5db936 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -642,7 +642,7 @@ static struct ata_queued_cmd *ata_scsi_qc_new(struct ata_device *dev,
 	struct ata_queued_cmd *qc;
 	int tag;
 
-	if (unlikely(ap->pflags & ATA_PFLAG_FROZEN))
+	if (unlikely(ata_port_is_frozen(ap)))
 		goto fail;
 
 	if (ap->flags & ATA_FLAG_SAS_HOST) {
diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index 7f14d0d31057..9b2d289e89e1 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -2185,7 +2185,7 @@ static void nv_swncq_host_interrupt(struct ata_port *ap, u16 fis)
 	if (!fis)
 		return;
 
-	if (ap->pflags & ATA_PFLAG_FROZEN)
+	if (ata_port_is_frozen(ap))
 		return;
 
 	if (fis & NV_SWNCQ_IRQ_HOTPLUG) {
diff --git a/drivers/ata/sata_promise.c b/drivers/ata/sata_promise.c
index b8465fef2ed2..9cd7d8b71361 100644
--- a/drivers/ata/sata_promise.c
+++ b/drivers/ata/sata_promise.c
@@ -817,7 +817,7 @@ static int pdc_sata_hardreset(struct ata_link *link, unsigned int *class,
 
 static void pdc_error_handler(struct ata_port *ap)
 {
-	if (!(ap->pflags & ATA_PFLAG_FROZEN))
+	if (!ata_port_is_frozen(ap))
 		pdc_reset_port(ap);
 
 	ata_sff_error_handler(ap);
diff --git a/drivers/ata/sata_sx4.c b/drivers/ata/sata_sx4.c
index 6ceec59cb291..ab70cbc78f96 100644
--- a/drivers/ata/sata_sx4.c
+++ b/drivers/ata/sata_sx4.c
@@ -855,7 +855,7 @@ static int pdc_softreset(struct ata_link *link, unsigned int *class,
 
 static void pdc_error_handler(struct ata_port *ap)
 {
-	if (!(ap->pflags & ATA_PFLAG_FROZEN))
+	if (!ata_port_is_frozen(ap))
 		pdc_reset_port(ap);
 
 	ata_sff_error_handler(ap);
-- 
2.37.3

