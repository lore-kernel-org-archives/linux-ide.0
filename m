Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFBD3D7D86
	for <linux-ide@vger.kernel.org>; Thu, 21 May 2026 17:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779384864; cv=none; b=dXr9FUZ+rPK+nUd9fFNvbUB8J06wB9DqkRhAz50WL2hoNqYheIw4OM77VgGTIbL3ctMCKnUUNjuKr7mtoXidGrdsjDPr32T17QNg8ZGcYse5LENDPMvdj6kdQwbNOvHHeC95eFvDad9GOPLPhcP6cLk+v+rttT9djzmXPWqP4cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779384864; c=relaxed/simple;
	bh=RXcakbhUFYqTXotko7WWc1N4CTVR2pMJ00BBZ92cQWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N7Qq7geSYhxgYRNYAi2+XkDPOv/kQTwHFxCiHdH4Ca7vY1SN5daZZjwjBUBdH2A+IQIVDIGE9EPZcn1AxPPdaBBCUojFJCJEucUskH0bQ2PzwcDk6YQCP/cxI2+8bTrSLUbld0XSExGtksX5I/O5NRy3KdXFofgMN5N76xl/dZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=XZCBPv3w; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="XZCBPv3w"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gLwWf4bv4z1XM0pS;
	Thu, 21 May 2026 17:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1779384847; x=1781976848; bh=j0ARp
	dq9uWLG0IVpGJp2OuXst3F6eAwwgVOmqa8wwqU=; b=XZCBPv3whAiDu5H47poJI
	Yr6SDG7SVFSgSE+GPQXL8h10WmpYDqHifoUyXs/mwZ5pN0UZtu6vh1xEA+23GTxm
	D+EsnIiJAKIRc6gqGQKVI6d3w5h2hnS1MTQVy2b12nn3A0400uMoBuw+0okAbW0v
	o1xyzZK5hrBiF0ymqtqcl8cMbsavAdhILHgk/lZutoT/4lVkAV7eVA057pz7c6Lp
	6ikhSdtRm5rgVuDq/izJ6s+K4GDI4DW9VL1AnHnbj7qKuld8/uPq9zzMw+etnwcP
	9U25wOFx+qoXNgT30Xom0qmFkZXZXoYvrDtHihWVM+MLcX7kad/aPYdVaEDhGVIb
	g==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id CyPr-Y151E-1; Thu, 21 May 2026 17:34:07 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gLwWK08l8z1XM0p8;
	Thu, 21 May 2026 17:34:04 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Marco Elver <elver@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Mikael Pettersson <mikpelinux@gmail.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	John Garry <john.g.garry@oracle.com>,
	Jason Yan <yanaijie@huawei.com>,
	Kees Cook <kees@kernel.org>
Subject: [PATCH v2 4/9] ata: libata: Pass the ATA port argument directly to ata_qc_complete()
Date: Thu, 21 May 2026 10:33:32 -0700
Message-ID: <20260521173347.2079560-5-bvanassche@acm.org>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
In-Reply-To: <20260521173347.2079560-1-bvanassche@acm.org>
References: <20260521173347.2079560-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Prepare for adding lock context annotations that refer to the ATA port
argument (ap). No functionality has been changed.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/ata/libata-core.c     | 5 ++---
 drivers/ata/libata-eh.c       | 2 +-
 drivers/ata/libata-sata.c     | 2 +-
 drivers/ata/libata-sff.c      | 4 ++--
 drivers/ata/pdc_adma.c        | 4 ++--
 drivers/ata/sata_dwc_460ex.c  | 2 +-
 drivers/ata/sata_fsl.c        | 2 +-
 drivers/ata/sata_inic162x.c   | 2 +-
 drivers/ata/sata_promise.c    | 2 +-
 drivers/ata/sata_qstor.c      | 5 +++--
 drivers/ata/sata_sx4.c        | 6 +++---
 drivers/scsi/libsas/sas_ata.c | 2 +-
 include/linux/libata.h        | 2 +-
 13 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 5caae9a2aca3..307ab48fe04c 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5024,9 +5024,8 @@ static void ata_verify_xfer(struct ata_queued_cmd *=
qc)
  *	LOCKING:
  *	spin_lock_irqsave(host lock)
  */
-void ata_qc_complete(struct ata_queued_cmd *qc)
+void ata_qc_complete(struct ata_port *ap, struct ata_queued_cmd *qc)
 {
-	struct ata_port *ap =3D qc->ap;
 	struct ata_device *dev =3D qc->dev;
 	struct ata_eh_info *ehi =3D &dev->link->eh_info;
=20
@@ -5232,7 +5231,7 @@ void ata_qc_issue(struct ata_queued_cmd *qc)
 sys_err:
 	qc->err_mask |=3D AC_ERR_SYSTEM;
 err:
-	ata_qc_complete(qc);
+	ata_qc_complete(ap, qc);
 }
=20
 /**
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 7826162bb8db..ed724bd45529 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1058,7 +1058,7 @@ static int ata_do_link_abort(struct ata_port *ap, s=
truct ata_link *link)
 	ata_qc_for_each_with_internal(ap, qc, tag) {
 		if (qc && (!link || qc->dev->link =3D=3D link)) {
 			qc->flags |=3D ATA_QCFLAG_EH;
-			ata_qc_complete(qc);
+			ata_qc_complete(ap, qc);
 			nr_aborted++;
 		}
 	}
diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index 5e5be6bbf32a..0428fe022f3f 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -786,7 +786,7 @@ int ata_qc_complete_multiple(struct ata_port *ap, u64=
 qc_active)
=20
 		qc =3D ata_qc_from_tag(ap, tag);
 		if (qc) {
-			ata_qc_complete(qc);
+			ata_qc_complete(ap, qc);
 			nr_done++;
 		}
 		done_mask &=3D ~(1ULL << tag);
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 785b6e371abf..38226ed51bb5 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -890,13 +890,13 @@ static void ata_hsm_qc_complete(struct ata_queued_c=
md *qc, int in_wq)
 		if (qc) {
 			if (likely(!(qc->err_mask & AC_ERR_HSM))) {
 				ata_sff_irq_on(ap);
-				ata_qc_complete(qc);
+				ata_qc_complete(ap, qc);
 			} else
 				ata_port_freeze(ap);
 		}
 	} else {
 		if (likely(!(qc->err_mask & AC_ERR_HSM)))
-			ata_qc_complete(qc);
+			ata_qc_complete(ap, qc);
 		else
 			ata_port_freeze(ap);
 	}
diff --git a/drivers/ata/pdc_adma.c b/drivers/ata/pdc_adma.c
index 17a5a59861c3..b8f7633537c1 100644
--- a/drivers/ata/pdc_adma.c
+++ b/drivers/ata/pdc_adma.c
@@ -415,7 +415,7 @@ static inline unsigned int adma_intr_pkt(struct ata_h=
ost *host)
 				qc->err_mask |=3D AC_ERR_OTHER;
=20
 			if (!qc->err_mask)
-				ata_qc_complete(qc);
+				ata_qc_complete(ap, qc);
 			else {
 				struct ata_eh_info *ehi =3D &ap->link.eh_info;
 				ata_ehi_clear_desc(ehi);
@@ -457,7 +457,7 @@ static inline unsigned int adma_intr_mmio(struct ata_=
host *host)
 			pp->state =3D adma_state_idle;
 			qc->err_mask |=3D ac_err_mask(status);
 			if (!qc->err_mask)
-				ata_qc_complete(qc);
+				ata_qc_complete(ap, qc);
 			else {
 				struct ata_eh_info *ehi =3D &ap->link.eh_info;
 				ata_ehi_clear_desc(ehi);
diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 64cb544903d8..169cfd85f0e6 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -758,7 +758,7 @@ static int sata_dwc_qc_complete(struct ata_port *ap, =
struct ata_queued_cmd *qc)
 	mask =3D (~(qcmd_tag_to_mask(tag)));
 	hsdev->sactive_queued =3D hsdev->sactive_queued & mask;
 	hsdev->sactive_issued =3D hsdev->sactive_issued & mask;
-	ata_qc_complete(qc);
+	ata_qc_complete(ap, qc);
 	return 0;
 }
=20
diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index be829fcc584d..ce6f50b8e38c 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -1264,7 +1264,7 @@ static void sata_fsl_host_intr(struct ata_port *ap)
 			 ioread32(hcr_base + CC));
=20
 		if (qc) {
-			ata_qc_complete(qc);
+			ata_qc_complete(ap, qc);
 		}
 	} else {
 		/* Spurious Interrupt!! */
diff --git a/drivers/ata/sata_inic162x.c b/drivers/ata/sata_inic162x.c
index 46a8c20daf18..ccfb863f018f 100644
--- a/drivers/ata/sata_inic162x.c
+++ b/drivers/ata/sata_inic162x.c
@@ -407,7 +407,7 @@ static void inic_host_intr(struct ata_port *ap)
 			     (ATA_DF | ATA_ERR)))
 			qc->err_mask |=3D AC_ERR_DEV;
=20
-		ata_qc_complete(qc);
+		ata_qc_complete(ap, qc);
 		return;
 	}
=20
diff --git a/drivers/ata/sata_promise.c b/drivers/ata/sata_promise.c
index 2a005aede123..18d1eda69a4a 100644
--- a/drivers/ata/sata_promise.c
+++ b/drivers/ata/sata_promise.c
@@ -890,7 +890,7 @@ static unsigned int pdc_host_intr(struct ata_port *ap=
,
 	case ATAPI_PROT_DMA:
 	case ATAPI_PROT_NODATA:
 		qc->err_mask |=3D ac_err_mask(ata_wait_idle(ap));
-		ata_qc_complete(qc);
+		ata_qc_complete(ap, qc);
 		handled =3D 1;
 		break;
 	default:
diff --git a/drivers/ata/sata_qstor.c b/drivers/ata/sata_qstor.c
index cfb9b5b61cd7..9967a5b62643 100644
--- a/drivers/ata/sata_qstor.c
+++ b/drivers/ata/sata_qstor.c
@@ -329,12 +329,13 @@ static unsigned int qs_qc_issue(struct ata_queued_c=
md *qc)
=20
 static void qs_do_or_die(struct ata_queued_cmd *qc, u8 status)
 {
+	struct ata_port *ap =3D qc->ap;
+
 	qc->err_mask |=3D ac_err_mask(status);
=20
 	if (!qc->err_mask) {
-		ata_qc_complete(qc);
+		ata_qc_complete(ap, qc);
 	} else {
-		struct ata_port    *ap  =3D qc->ap;
 		struct ata_eh_info *ehi =3D &ap->link.eh_info;
=20
 		ata_ehi_clear_desc(ehi);
diff --git a/drivers/ata/sata_sx4.c b/drivers/ata/sata_sx4.c
index 0986ebd1eb4e..607e8c34b813 100644
--- a/drivers/ata/sata_sx4.c
+++ b/drivers/ata/sata_sx4.c
@@ -672,7 +672,7 @@ static inline unsigned int pdc20621_host_intr(struct =
ata_port *ap,
 				readl(mmio + 0x104), readl(mmio + PDC_HDMA_CTLSTAT));
 			/* get drive status; clear intr; complete txn */
 			qc->err_mask |=3D ac_err_mask(ata_wait_idle(ap));
-			ata_qc_complete(qc);
+			ata_qc_complete(ap, qc);
 			pdc20621_pop_hdma(qc);
 		}
=20
@@ -711,7 +711,7 @@ static inline unsigned int pdc20621_host_intr(struct =
ata_port *ap,
 				readl(mmio + 0x104), readl(mmio + PDC_HDMA_CTLSTAT));
 			/* get drive status; clear intr; complete txn */
 			qc->err_mask |=3D ac_err_mask(ata_wait_idle(ap));
-			ata_qc_complete(qc);
+			ata_qc_complete(ap, qc);
 			pdc20621_pop_hdma(qc);
 		}
 		handled =3D 1;
@@ -722,7 +722,7 @@ static inline unsigned int pdc20621_host_intr(struct =
ata_port *ap,
 		status =3D ata_sff_busy_wait(ap, ATA_BUSY | ATA_DRQ, 1000);
 		ata_port_dbg(ap, "BUS_NODATA (drv_stat 0x%X)\n", status);
 		qc->err_mask |=3D ac_err_mask(status);
-		ata_qc_complete(qc);
+		ata_qc_complete(ap, qc);
 		handled =3D 1;
=20
 	} else {
diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.=
c
index 61368e55bf86..eb69d2c7f4b6 100644
--- a/drivers/scsi/libsas/sas_ata.c
+++ b/drivers/scsi/libsas/sas_ata.c
@@ -145,7 +145,7 @@ static void sas_ata_task_done(struct sas_task *task)
 	}
=20
 	qc->lldd_task =3D NULL;
-	ata_qc_complete(qc);
+	ata_qc_complete(ap, qc);
 	spin_unlock_irqrestore(ap->lock, flags);
=20
 qc_already_gone:
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 5c085ef4eda7..2cfd8f79ac2b 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1203,7 +1203,7 @@ extern void ata_id_c_string(const u16 *id, unsigned=
 char *s,
 			    unsigned int ofs, unsigned int len);
 extern unsigned int ata_do_dev_read_id(struct ata_device *dev,
 				       struct ata_taskfile *tf, __le16 *id);
-extern void ata_qc_complete(struct ata_queued_cmd *qc);
+extern void ata_qc_complete(struct ata_port *ap, struct ata_queued_cmd *=
qc);
 extern u64 ata_qc_get_active(struct ata_port *ap);
 extern int ata_std_bios_param(struct scsi_device *sdev,
 			      struct gendisk *unused,
