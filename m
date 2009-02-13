From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 06/06] sata_mv: implement mv_qc_issue_fis() for errata workaround
Date: Fri, 13 Feb 2009 00:09:35 -0500
Message-ID: <4995008F.4060809@rtr.ca>
References: <4994FF3D.90904@rtr.ca> <4994FF7C.2050607@rtr.ca> <4994FFA9.7030300@rtr.ca> <49950036.50509@rtr.ca> <49950068.9040705@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:46607 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750768AbZBMFJh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 13 Feb 2009 00:09:37 -0500
In-Reply-To: <49950068.9040705@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Implement direct FIS transmission via mv_qc_issue_fis().
This is initially needed to work around NCQ errata,
whereby the READ_LOG_EXT command sometimes fails
when issued in the traditional (sff) fashion.

Portions of this code will likely be reused for
implementation of the target mode feature later on.

Signed-off-by: Mark Lord <mlord@pobox.com>

--- old/drivers/ata/sata_mv.c	2009-02-12 22:38:24.000000000 -0500
+++ upstream/drivers/ata/sata_mv.c	2009-02-12 22:47:59.000000000 -0500
@@ -1822,6 +1822,105 @@
  }

  /**
+ *	mv_send_fis - Send a FIS, using the "Vendor-Unique FIS" register
+ *	@fis: fis to be sent
+ *	@nwords: number of 32-bit words in the fis
+ */
+static unsigned int mv_send_fis(struct ata_port *ap, u32 *fis, int nwords)
+{
+	void __iomem *port_mmio = mv_ap_base(ap);
+	u32 ifctl, old_ifctl, ifstat;
+	int i, timeout = 200, final_word = nwords - 1;
+
+	/* Initiate FIS transmission mode */
+	old_ifctl = readl(port_mmio + SATA_IFCTL_OFS);
+	ifctl = 0x100 | (old_ifctl & 0xf);
+	writelfl(ifctl, port_mmio + SATA_IFCTL_OFS);
+
+	/* Send all words of the FIS except for the final word */
+	for (i = 0; i < final_word; ++i)
+		writel(fis[i], port_mmio + VENDOR_UNIQUE_FIS_OFS);
+
+	/* Flag end-of-transmission, and then send the final word */
+	writelfl(ifctl | 0x200, port_mmio + SATA_IFCTL_OFS);
+	writelfl(fis[final_word], port_mmio + VENDOR_UNIQUE_FIS_OFS);
+
+	/*
+	 * Wait for FIS transmission to complete.
+	 * This typically takes just a single iteration.
+	 */
+	do {
+		ifstat = readl(port_mmio + SATA_IFSTAT_OFS);
+	} while (!(ifstat & 0x1000) && --timeout);
+
+	/* Restore original port configuration */
+	writelfl(old_ifctl, port_mmio + SATA_IFCTL_OFS);
+
+	/* See if it worked */
+	if ((ifstat & 0x3000) != 0x1000) {
+		ata_port_printk(ap, KERN_WARNING,
+				"%s transmission error, ifstat=%08x\n",
+				__func__, ifstat);
+		return AC_ERR_OTHER;
+	}
+	return 0;
+}
+
+/**
+ *	mv_qc_issue_fis - Issue a command directly as a FIS
+ *	@qc: queued command to start
+ *
+ *	Note that the ATA shadow registers are not updated
+ *	after command issue, so the device will appear "READY"
+ *	if polled, even while it is BUSY processing the command.
+ *
+ *	So we use a status hook to fake ATA_BUSY until the drive changes state.
+ *
+ *	Note: we don't get updated shadow regs on *completion*
+ *	of non-data commands. So avoid sending them via this function,
+ *	as they will appear to have completed immediately.
+ *
+ *	GEN_IIE has special registers that we could get the result tf from,
+ *	but earlier chipsets do not.  For now, we ignore those registers.
+ */
+static unsigned int mv_qc_issue_fis(struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+	struct mv_port_priv *pp = ap->private_data;
+	struct ata_link *link = qc->dev->link;
+	u32 fis[5];
+	int err = 0;
+
+	ata_tf_to_fis(&qc->tf, link->pmp, 1, (void *)fis);
+	err = mv_send_fis(ap, fis, sizeof(fis) / sizeof(fis[0]));
+	if (err)
+		return err;
+
+	switch (qc->tf.protocol) {
+	case ATAPI_PROT_PIO:
+		pp->pp_flags |= MV_PP_FLAG_FAKE_ATA_BUSY;
+		/* fall through */
+	case ATAPI_PROT_NODATA:
+		ap->hsm_task_state = HSM_ST_FIRST;
+		break;
+	case ATA_PROT_PIO:
+		pp->pp_flags |= MV_PP_FLAG_FAKE_ATA_BUSY;
+		if (qc->tf.flags & ATA_TFLAG_WRITE)
+			ap->hsm_task_state = HSM_ST_FIRST;
+		else
+			ap->hsm_task_state = HSM_ST;
+		break;
+	default:
+		ap->hsm_task_state = HSM_ST_LAST;
+		break;
+	}
+
+	if (qc->tf.flags & ATA_TFLAG_POLLING)
+		ata_pio_queue_task(ap, qc, 0);
+	return 0;
+}
+
+/**
   *      mv_qc_issue - Initiate a command to the host
   *      @qc: queued command to start
   *
@@ -1896,6 +1995,23 @@
  	mv_stop_edma(ap);
  	mv_clear_and_enable_port_irqs(ap, mv_ap_base(ap), port_irqs);
  	mv_pmp_select(ap, qc->dev->link->pmp);
+
+	if (qc->tf.command == ATA_CMD_READ_LOG_EXT) {
+		struct mv_host_priv *hpriv = ap->host->private_data;
+		/*
+		 * Workaround for 88SX60x1 FEr SATA#25 (part 2).
+		 *
+		 * After any NCQ error, the READ_LOG_EXT command
+		 * from libata-eh *must* use mv_qc_issue_fis().
+		 * Otherwise it might fail, due to chip errata.
+		 *
+		 * Rather than special-case it, we'll just *always*
+		 * use this method here for READ_LOG_EXT, making for
+		 * easier testing.
+		 */
+		if (IS_GEN_II(hpriv))
+			return mv_qc_issue_fis(qc);
+	}
  	return ata_sff_qc_issue(qc);
  }

