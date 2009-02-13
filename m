From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 04/06] sata_mv: implement mv_sff_check_status
Date: Fri, 13 Feb 2009 00:08:06 -0500
Message-ID: <49950036.50509@rtr.ca>
References: <4994FF3D.90904@rtr.ca> <4994FF7C.2050607@rtr.ca> <4994FFA9.7030300@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:35129 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750757AbZBMFII (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 13 Feb 2009 00:08:08 -0500
In-Reply-To: <4994FFA9.7030300@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Add a new mv_sff_check_status() function to sata_mv.
This is necessary for use with the upcoming "mv_qc_issue_fis()" patch,
but is being added separately here for easier code review.

When using command issue via the "mv_qc_issue_fis()" mechanism,
the initial ATA_BUSY bit does not show in the ATA status (shadow) register.
This can confuse libata!  So here we add a hook to fake ATA_BUSY
for that situation, until the first time a BUSY, DRQ, or ERR bit is seen.

Signed-off-by: Mark Lord <mlord@pobox.com>

--- old/drivers/ata/sata_mv.c	2009-02-12 22:25:34.000000000 -0500
+++ upstream/drivers/ata/sata_mv.c	2009-02-12 22:26:09.000000000 -0500
@@ -370,6 +370,7 @@
  	MV_PP_FLAG_NCQ_EN	= (1 << 1),	/* is EDMA set up for NCQ? */
  	MV_PP_FLAG_FBS_EN	= (1 << 2),	/* is EDMA set up for FBS? */
  	MV_PP_FLAG_DELAYED_EH	= (1 << 3),	/* delayed dev err handling */
+	MV_PP_FLAG_FAKE_ATA_BUSY = (1 << 4),	/* ignore initial ATA_DRDY */
  };

  #define IS_GEN_I(hpriv) ((hpriv)->hp_flags & MV_HP_GEN_I)
@@ -570,6 +571,7 @@
  static void mv_bmdma_start(struct ata_queued_cmd *qc);
  static void mv_bmdma_stop(struct ata_queued_cmd *qc);
  static u8   mv_bmdma_status(struct ata_port *ap);
+static u8 mv_sff_check_status(struct ata_port *ap);

  /* .sg_tablesize is (MV_MAX_SG_CT / 2) in the structures below
   * because we have to allow room for worst case splitting of
@@ -619,6 +621,7 @@
  	.softreset		= mv_softreset,
  	.error_handler		= mv_pmp_error_handler,

+ 	.sff_check_status	= mv_sff_check_status,
  	.sff_irq_clear		= mv_sff_irq_clear,
  	.check_atapi_dma	= mv_check_atapi_dma,
  	.bmdma_setup		= mv_bmdma_setup,
@@ -1284,7 +1287,8 @@

  	/* set up non-NCQ EDMA configuration */
  	cfg = EDMA_CFG_Q_DEPTH;		/* always 0x1f for *all* chips */
-	pp->pp_flags &= ~(MV_PP_FLAG_FBS_EN | MV_PP_FLAG_NCQ_EN);
+	pp->pp_flags &=
+	  ~(MV_PP_FLAG_FBS_EN | MV_PP_FLAG_NCQ_EN | MV_PP_FLAG_FAKE_ATA_BUSY);

  	if (IS_GEN_I(hpriv))
  		cfg |= (1 << 8);	/* enab config burst size mask */
@@ -1791,6 +1795,33 @@
  }

  /**
+ *	mv_sff_check_status - fetch device status, if valid
+ *	@ap: ATA port to fetch status from
+ *
+ *	When using command issue via mv_qc_issue_fis(),
+ *	the initial ATA_BUSY state does not show up in the
+ *	ATA status (shadow) register.  This can confuse libata!
+ *
+ *	So we have a hook here to fake ATA_BUSY for that situation,
+ *	until the first time a BUSY, DRQ, or ERR bit is seen.
+ *
+ *	The rest of the time, it simply returns the ATA status register.
+ */
+static u8 mv_sff_check_status(struct ata_port *ap)
+{
+	u8 stat = ioread8(ap->ioaddr.status_addr);
+	struct mv_port_priv *pp = ap->private_data;
+
+	if (pp->pp_flags & MV_PP_FLAG_FAKE_ATA_BUSY) {
+		if (stat & (ATA_BUSY | ATA_DRQ | ATA_ERR))
+			pp->pp_flags &= ~MV_PP_FLAG_FAKE_ATA_BUSY;
+		else
+			stat = ATA_BUSY;
+	}
+	return stat;
+}
+
+/**
   *      mv_qc_issue - Initiate a command to the host
   *      @qc: queued command to start
   *
@@ -1811,6 +1842,8 @@
  	u32 in_index;
  	unsigned int port_irqs;

+	pp->pp_flags &= ~MV_PP_FLAG_FAKE_ATA_BUSY; /* paranoia */
+
  	switch (qc->tf.protocol) {
  	case ATA_PROT_DMA:
  	case ATA_PROT_NCQ:
@@ -3037,6 +3070,8 @@

  	mv_reset_channel(hpriv, mmio, ap->port_no);
  	pp->pp_flags &= ~MV_PP_FLAG_EDMA_EN;
+	pp->pp_flags &=
+	  ~(MV_PP_FLAG_FBS_EN | MV_PP_FLAG_NCQ_EN | MV_PP_FLAG_FAKE_ATA_BUSY);

  	/* Workaround for errata FEr SATA#10 (part 2) */
  	do {
