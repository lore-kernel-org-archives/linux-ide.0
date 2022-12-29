Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF0FC4332F
	for <linux-ide@archiver.kernel.org>; Thu, 29 Dec 2022 17:00:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233651AbiL2RAc (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 29 Dec 2022 12:00:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233604AbiL2RAV (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 29 Dec 2022 12:00:21 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77B410046
        for <linux-ide@vger.kernel.org>; Thu, 29 Dec 2022 09:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1672333220; x=1703869220;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Z1/60qVJ74xQpZ73JO2WWSgrPUxpRHWg/OfH98FyPlw=;
  b=dD8SlVyL2fAkMqJxRug5pdRsDyVgntW8yEFgVkfa/8vajoSoOWPskALg
   YQuHeferc4Gg9nXkaEpXUnejNF2O68tIDSsRE34BDEsLkHGPv/5ARiLI+
   ta6HXYcctZAn/C1pYbYapcPfQF69lGffMvdlSs3B95OWYvZhIRnoSwX3+
   G9zw3W/GV/tkaZVnaCQhpbQRewY/F0ozSDsWr/YXBGl570VDOlNCzuCWc
   Z7JRK+TBqIBeZqj8fXuWyFcBQPXEsQXM3g8aLILs+X2wMt+tmHKMYz90s
   LtH4Lo6GjLuen5f2e+rUUdrJwaUA7yaihlqhgiGS1qRabdZpszvLpZcVf
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,284,1665417600"; 
   d="scan'208";a="323990985"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Dec 2022 01:00:20 +0800
IronPort-SDR: NzPDB8x7zs5J2veP+f69THCfnnwMRQ2uZWek8H/U9j8AOobW/mqs7H9e+tjOKWCOCqI83oV7rR
 RhDxtO4M0AecTo80yrtbIvN6KavAmKkhD0MaDdHO7IUJj5T0hbt2lbk/YuLGybrZ0qzgr4WMOc
 kk0sGZn1Dty3FzbLon3TJFwHavhf4erIurNmMUyRvWy/61fgqI9gDs7Pv7rmheAklbFJDLWNYH
 zWUByyy8xDX6dkt5JE942XkN5BP3n5AFNqMGk0pUy6eFXXCsu+X22M/yA/hETAS9UqpevtF+a5
 MXk=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Dec 2022 08:18:24 -0800
IronPort-SDR: Ued5lY+sWwKNVFW1P7pc1DfKtCU392xq81ciydrb7/TyKG9WCJRlDimoXRk1p5fHhsEqnO6b9t
 jw1tN7BRuSyRj/4eX87lmEJDnYRUK3pclQ3Qh7mY6248Iot8XwtbZJkxS/oN9Wq4Dn13kE38FM
 q7UR2PLHMRlcLg8tnkvK/RfJ8F0bQyCZl6+0qsMtIJGSinSkuj4+Gp0BcjoXeEm4jhzpcfkNfu
 v2HUSHcjFiU5XiHpSKg6FPGsDgEwzIhvQzSKlSyQp0j4WCZuffbPUwAQSx90eD3UA345dujWGD
 /WE=
WDCIronportException: Internal
Received: from unknown (HELO x1-carbon.lan) ([10.225.164.9])
  by uls-op-cesaip02.wdc.com with ESMTP; 29 Dec 2022 09:00:20 -0800
From:   Niklas Cassel <niklas.cassel@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Niklas Cassel <niklas.cassel@wdc.com>, linux-ide@vger.kernel.org
Subject: [PATCH v2 3/7] ata: libata: read the shared status for successful NCQ commands once
Date:   Thu, 29 Dec 2022 17:59:59 +0100
Message-Id: <20221229170005.49118-4-niklas.cassel@wdc.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221229170005.49118-1-niklas.cassel@wdc.com>
References: <20221229170005.49118-1-niklas.cassel@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Currently, the status is being read for each QC, inside
ata_qc_complete(), which means that QCs being completed by
ata_qc_complete_multiple() (i.e. multiple QCs completed during a single
interrupt), can have different status and error bits set. This is
because the FIS Receive Area will get updated as soon as the HBA
receives a new FIS from the device in the NCQ case.

Here is an example of the problem:
ata14.00: ata_qc_complete_multiple: done_mask: 0x180000
qc tag: 19 cmd: 0x61 flags: 0x11b err_mask: 0x0 tf->status: 0x40
qc tag: 20 cmd: 0x61 flags: 0x11b err_mask: 0x0 tf->status: 0x43

A print in ata_qc_complete_multiple(), shows that done_mask is: 0x180000
which means that tag 19 and 20 were completed. Another print in
ata_qc_complete(), after the call to fill_result_tf(), shows that tag 19
and 20 have different status values, even though they were completed in
the same ata_qc_complete_multiple() call.

If PMP is not enabled, simply read the status and error once, before
calling ata_qc_complete() for each QC. Without PMP, we know that all QCs
must share the same status and error values.

If PMP is enabled, we also read the status before calling
ata_qc_complete(), however, we still read the status for each QC, since
the QCs can belong to different PMP links (which means that the QCs
does not necessarily share the same status and error values).

Do all this by introducing the new port operation .qc_ncq_fill_rtf. If
set, this operation is called in ata_qc_complete_multiple() to set the
result tf for all completed QCs signaled by the last SDB FIS received.

QCs that have their result tf filled are marked with the new flag
ATA_QCFLAG_RTF_FILLED so that any later execution of the qc_fill_rtf
port operation does nothing (e.g. when called from ata_qc_complete()).

Co-developed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 drivers/ata/libahci.c     | 90 +++++++++++++++++++++++++++++++++++++--
 drivers/ata/libata-sata.c |  3 ++
 include/linux/libata.h    |  2 +
 3 files changed, 92 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 0167aac25c34..e5d67eb46f3c 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -56,6 +56,7 @@ static ssize_t ahci_transmit_led_message(struct ata_port *ap, u32 state,
 static int ahci_scr_read(struct ata_link *link, unsigned int sc_reg, u32 *val);
 static int ahci_scr_write(struct ata_link *link, unsigned int sc_reg, u32 val);
 static void ahci_qc_fill_rtf(struct ata_queued_cmd *qc);
+static void ahci_qc_ncq_fill_rtf(struct ata_port *ap, u64 done_mask);
 static int ahci_port_start(struct ata_port *ap);
 static void ahci_port_stop(struct ata_port *ap);
 static enum ata_completion_errors ahci_qc_prep(struct ata_queued_cmd *qc);
@@ -157,6 +158,7 @@ struct ata_port_operations ahci_ops = {
 	.qc_prep		= ahci_qc_prep,
 	.qc_issue		= ahci_qc_issue,
 	.qc_fill_rtf		= ahci_qc_fill_rtf,
+	.qc_ncq_fill_rtf	= ahci_qc_ncq_fill_rtf,
 
 	.freeze			= ahci_freeze,
 	.thaw			= ahci_thaw,
@@ -2058,6 +2060,13 @@ static void ahci_qc_fill_rtf(struct ata_queued_cmd *qc)
 	struct ahci_port_priv *pp = qc->ap->private_data;
 	u8 *rx_fis = pp->rx_fis;
 
+	/*
+	 * rtf may already be filled (e.g. for successful NCQ commands).
+	 * If that is the case, we have nothing to do.
+	 */
+	if (qc->flags & ATA_QCFLAG_RTF_FILLED)
+		return;
+
 	if (pp->fbs_enabled)
 		rx_fis += qc->dev->link->pmp * AHCI_RX_FIS_SZ;
 
@@ -2071,6 +2080,9 @@ static void ahci_qc_fill_rtf(struct ata_queued_cmd *qc)
 	    !(qc->flags & ATA_QCFLAG_EH)) {
 		ata_tf_from_fis(rx_fis + RX_FIS_PIO_SETUP, &qc->result_tf);
 		qc->result_tf.status = (rx_fis + RX_FIS_PIO_SETUP)[15];
+		qc->flags |= ATA_QCFLAG_RTF_FILLED;
+		return;
+	}
 
 	/*
 	 * For NCQ commands, we never get a D2H FIS, so reading the D2H Register
@@ -2080,13 +2092,85 @@ static void ahci_qc_fill_rtf(struct ata_queued_cmd *qc)
 	 * instead. However, the SDB FIS does not contain the LBA, so we can't
 	 * use the ata_tf_from_fis() helper.
 	 */
-	} else if (ata_is_ncq(qc->tf.protocol)) {
+	if (ata_is_ncq(qc->tf.protocol)) {
 		const u8 *fis = rx_fis + RX_FIS_SDB;
 
+		/*
+		 * Successful NCQ commands have been filled already.
+		 * A failed NCQ command will read the status here.
+		 * (Note that a failed NCQ command will get a more specific
+		 * error when reading the NCQ Command Error log.)
+		 */
 		qc->result_tf.status = fis[2];
 		qc->result_tf.error = fis[3];
-	} else
-		ata_tf_from_fis(rx_fis + RX_FIS_D2H_REG, &qc->result_tf);
+		qc->flags |= ATA_QCFLAG_RTF_FILLED;
+		return;
+	}
+
+	ata_tf_from_fis(rx_fis + RX_FIS_D2H_REG, &qc->result_tf);
+	qc->flags |= ATA_QCFLAG_RTF_FILLED;
+}
+
+static void ahci_qc_ncq_fill_rtf(struct ata_port *ap, u64 done_mask)
+{
+	struct ahci_port_priv *pp = ap->private_data;
+	const u8 *fis;
+
+	/* No outstanding commands. */
+	if (!ap->qc_active)
+		return;
+
+	/*
+	 * FBS not enabled, so read status and error once, since they are shared
+	 * for all QCs.
+	 */
+	if (!pp->fbs_enabled) {
+		u8 status, error;
+
+		/* No outstanding NCQ commands. */
+		if (!pp->active_link->sactive)
+			return;
+
+		fis = pp->rx_fis + RX_FIS_SDB;
+		status = fis[2];
+		error = fis[3];
+
+		while (done_mask) {
+			struct ata_queued_cmd *qc;
+			unsigned int tag = __ffs64(done_mask);
+
+			qc = ata_qc_from_tag(ap, tag);
+			if (qc && ata_is_ncq(qc->tf.protocol)) {
+				qc->result_tf.status = status;
+				qc->result_tf.error = error;
+				qc->flags |= ATA_QCFLAG_RTF_FILLED;
+			}
+			done_mask &= ~(1ULL << tag);
+		}
+
+		return;
+	}
+
+	/*
+	 * FBS enabled, so read the status and error for each QC, since the QCs
+	 * can belong to different PMP links. (Each PMP link has its own FIS
+	 * Receive Area.)
+	 */
+	while (done_mask) {
+		struct ata_queued_cmd *qc;
+		unsigned int tag = __ffs64(done_mask);
+
+		qc = ata_qc_from_tag(ap, tag);
+		if (qc && ata_is_ncq(qc->tf.protocol)) {
+			fis = pp->rx_fis;
+			fis += qc->dev->link->pmp * AHCI_RX_FIS_SZ;
+			fis += RX_FIS_SDB;
+			qc->result_tf.status = fis[2];
+			qc->result_tf.error = fis[3];
+			qc->flags |= ATA_QCFLAG_RTF_FILLED;
+		}
+		done_mask &= ~(1ULL << tag);
+	}
 }
 
 static void ahci_freeze(struct ata_port *ap)
diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index 908f35acee1e..f3e7396e3191 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -655,6 +655,9 @@ int ata_qc_complete_multiple(struct ata_port *ap, u64 qc_active)
 		return -EINVAL;
 	}
 
+	if (ap->ops->qc_ncq_fill_rtf)
+		ap->ops->qc_ncq_fill_rtf(ap, done_mask);
+
 	while (done_mask) {
 		struct ata_queued_cmd *qc;
 		unsigned int tag = __ffs64(done_mask);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 8483d8300ea3..f54e02dadc6f 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -200,6 +200,7 @@ enum {
 	/* struct ata_queued_cmd flags */
 	ATA_QCFLAG_ACTIVE	= (1 << 0), /* cmd not yet ack'd to scsi lyer */
 	ATA_QCFLAG_DMAMAP	= (1 << 1), /* SG table is DMA mapped */
+	ATA_QCFLAG_RTF_FILLED	= (1 << 2), /* result TF has been filled */
 	ATA_QCFLAG_IO		= (1 << 3), /* standard IO command */
 	ATA_QCFLAG_RESULT_TF	= (1 << 4), /* result TF requested */
 	ATA_QCFLAG_CLEAR_EXCL	= (1 << 5), /* clear excl_link on completion */
@@ -877,6 +878,7 @@ struct ata_port_operations {
 	enum ata_completion_errors (*qc_prep)(struct ata_queued_cmd *qc);
 	unsigned int (*qc_issue)(struct ata_queued_cmd *qc);
 	void (*qc_fill_rtf)(struct ata_queued_cmd *qc);
+	void (*qc_ncq_fill_rtf)(struct ata_port *ap, u64 done_mask);
 
 	/*
 	 * Configuration and exception handling
-- 
2.38.1

