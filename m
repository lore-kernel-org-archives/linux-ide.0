Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B31B3E1732
	for <linux-ide@vger.kernel.org>; Thu, 21 May 2026 17:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779384903; cv=none; b=aBYlAoaGxEHq/sbQX79apMfJHS6T7F78hl3xLSevAnv9All8uYmr07eWb3TLTqvK6bRoBGoJql/myR8a801iKZav4204EdCIKgR2k5guKpz7o+yCZDmD3uUJjVjSeLCSN/px1Ed80QJtY91iYgJP6TMkpA23NvHLPxn8Az55m5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779384903; c=relaxed/simple;
	bh=/eYzWLyo6t1wjkqyNk6VT3Dp75n1VW8gtGAQ333mlGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a5V3FCIOgSHYCVKXnUP7Mr+rnRvdERc7H1DntV6iGC0v06Qm+jarJk6RldEmtswk54CBQt21eIjQWt+cGKL9wEw7zdToVRDa5U4/YOwjKeVMZscgP1/UcVIgILIdCqGv5Td/7BecW5P7xX1xfFg7CVDhL3pt6s/oSu1I9Y0Xn/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Q1ZTuR2c; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Q1ZTuR2c"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gLwXN1kD9z1XM0p0;
	Thu, 21 May 2026 17:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1779384863; x=1781976864; bh=LrbHW
	gbtT1N1wx3J0sV4LtyTr/b4/i++fiQAXy/W/M0=; b=Q1ZTuR2cAs05af0CbEYSO
	eaozNc+j7ilB3yru4YHKITN2VsgVudOSAqmbkRO62MT5b9ZxJR3BxPmwJpOFzZS9
	z0PaPyFiQ9hRE4XxpJIqd1DREbEbBppUCnY5sDiAMQaH5/pFyTXKqPtpaSExcoST
	K0cS5UIrVHpxgxkKew3ZbyBLfEFuAmzCv7Ksitq/7NhXAnoWGJnL59oaO1LbabBY
	qAswUt9USrddgoguv32u2YDA+JYgnFaeRIeVY5Hz7xAlERm4CgkxUIaYNnVveg0j
	l4+WoAuSCXShaUv0nO8YceQdCp9SHbN7gUJVeqciphXOJl159ciZhhZ9mJXk3o4j
	Q==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id JxkKI8PYPczi; Thu, 21 May 2026 17:34:23 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gLwWf08zBz1XM0pD;
	Thu, 21 May 2026 17:34:21 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Marco Elver <elver@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Mikael Pettersson <mikpelinux@gmail.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH v2 9/9] ata: Annotate the code that uses the host lock
Date: Thu, 21 May 2026 10:33:37 -0700
Message-ID: <20260521173347.2079560-10-bvanassche@acm.org>
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

Annotate all functions and also their direct and indirect callers with
__must_hold() that have a lockdep_assert_held() statement in their
function body for the host lock. As one can see in the comments added by
this patch, locking is missing from the following two functions:
 * Some of the ata_port_freeze() callers.
 * nv_do_interrupt().

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/ata/ahci.h           |  3 ++-
 drivers/ata/ahci_xgene.c     |  1 +
 drivers/ata/libahci.c        |  9 +++++++++
 drivers/ata/libata-core.c    |  7 +++++++
 drivers/ata/libata-eh.c      |  8 ++++++++
 drivers/ata/libata-scsi.c    |  8 ++++++++
 drivers/ata/libata-sff.c     |  8 ++++++++
 drivers/ata/libata.h         | 15 ++++++++++-----
 drivers/ata/pdc_adma.c       | 12 +++++++++++-
 drivers/ata/sata_dwc_460ex.c |  6 ++++++
 drivers/ata/sata_fsl.c       |  7 +++++++
 drivers/ata/sata_inic162x.c  |  7 ++++++-
 drivers/ata/sata_mv.c        | 13 +++++++++++++
 drivers/ata/sata_nv.c        | 16 ++++++++++++++++
 drivers/ata/sata_promise.c   | 13 ++++++++++++-
 drivers/ata/sata_qstor.c     | 14 ++++++++++++++
 drivers/ata/sata_rcar.c      |  5 +++++
 drivers/ata/sata_sil.c       |  4 ++++
 drivers/ata/sata_sil24.c     |  7 +++++++
 drivers/ata/sata_sx4.c       |  4 ++++
 drivers/ata/sata_vsc.c       |  7 +++++++
 include/linux/libata.h       | 32 +++++++++++++++++++++-----------
 22 files changed, 186 insertions(+), 20 deletions(-)

diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index b57cca352faa..582b7a117ad4 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -450,7 +450,8 @@ void ahci_print_info(struct ata_host *host, const cha=
r *scc_s);
 int ahci_host_activate(struct ata_host *host, const struct scsi_host_tem=
plate *sht);
 void ahci_error_handler(struct ata_port *ap)
 	__must_hold(&ap->host->eh_mutex);
-u32 ahci_handle_port_intr(struct ata_host *host, u32 irq_masked);
+u32 ahci_handle_port_intr(struct ata_host *host, u32 irq_masked)
+	__must_hold(host->lock);
=20
 static inline void __iomem *__ahci_port_base(struct ahci_host_priv *hpri=
v,
 					     unsigned int port_no)
diff --git a/drivers/ata/ahci_xgene.c b/drivers/ata/ahci_xgene.c
index 98c99b5a8242..d17d57767fc9 100644
--- a/drivers/ata/ahci_xgene.c
+++ b/drivers/ata/ahci_xgene.c
@@ -555,6 +555,7 @@ static int xgene_ahci_softreset(struct ata_link *link=
, unsigned int *class,
  */
 static int xgene_ahci_handle_broken_edge_irq(struct ata_host *host,
 					     u32 irq_masked)
+	__must_hold(host->lock)
 {
 	struct ahci_host_priv *hpriv =3D host->private_data;
 	void __iomem *port_mmio;
diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 2f685ab5ba78..2af53a12634b 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -1749,6 +1749,7 @@ static void ahci_fbs_dec_intr(struct ata_port *ap)
 }
=20
 static void ahci_error_intr(struct ata_port *ap, u32 irq_stat)
+	__must_hold(ap->lock)
 {
 	struct ahci_host_priv *hpriv =3D ap->host->private_data;
 	struct ahci_port_priv *pp =3D ap->private_data;
@@ -1778,6 +1779,9 @@ static void ahci_error_intr(struct ata_port *ap, u3=
2 irq_stat)
 	if (!link)
 		link =3D &ap->link;
=20
+	/* Tell the compiler that link->ap =3D=3D ap. */
+	__assume_ctx_lock(link->ap->lock);
+
 	active_qc =3D ata_qc_from_tag(ap, link->active_tag);
 	active_ehi =3D &link->eh_info;
=20
@@ -1860,6 +1864,7 @@ static void ahci_error_intr(struct ata_port *ap, u3=
2 irq_stat)
 }
=20
 static void ahci_qc_complete(struct ata_port *ap, void __iomem *port_mmi=
o)
+	__must_hold(ap->lock)
 {
 	struct ata_eh_info *ehi =3D &ap->link.eh_info;
 	struct ahci_port_priv *pp =3D ap->private_data;
@@ -1894,6 +1899,7 @@ static void ahci_qc_complete(struct ata_port *ap, v=
oid __iomem *port_mmio)
=20
 static void ahci_handle_port_interrupt(struct ata_port *ap,
 				       void __iomem *port_mmio, u32 status)
+	__must_hold(ap->lock)
 {
 	struct ahci_port_priv *pp =3D ap->private_data;
 	struct ahci_host_priv *hpriv =3D ap->host->private_data;
@@ -1955,6 +1961,7 @@ static void ahci_handle_port_interrupt(struct ata_p=
ort *ap,
 }
=20
 static void ahci_port_intr(struct ata_port *ap)
+	__must_hold(ap->lock)
 {
 	void __iomem *port_mmio =3D ahci_port_base(ap);
 	u32 status;
@@ -1993,6 +2000,8 @@ u32 ahci_handle_port_intr(struct ata_host *host, u3=
2 irq_masked)
=20
 		ap =3D host->ports[i];
 		if (ap) {
+			/* Tell the compiler that ap->lock =3D=3D host->lock. */
+			__assume_ctx_lock(ap->lock);
 			ahci_port_intr(ap);
 		} else {
 			if (ata_ratelimit())
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 8b8081f4dc63..52bcd8c78774 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5027,6 +5027,9 @@ void ata_qc_complete(struct ata_port *ap, struct at=
a_queued_cmd *qc)
 	struct ata_device *dev =3D qc->dev;
 	struct ata_eh_info *ehi =3D &dev->link->eh_info;
=20
+	/* Tell the compiler that qc->dev->link->ap =3D=3D ap. */
+	__assume_ctx_lock(qc->dev->link->ap->lock);
+
 	/* Trigger the LED (if available) */
 	ledtrig_disk_activity(!!(qc->tf.flags & ATA_TFLAG_WRITE));
=20
@@ -5162,6 +5165,10 @@ void ata_qc_issue(struct ata_port *ap, struct ata_=
queued_cmd *qc)
 	struct ata_link *link =3D qc->dev->link;
 	u8 prot =3D qc->tf.protocol;
=20
+	/* Tell the compiler that qc->ap =3D=3D qc->dev->link->ap->lock =3D=3D =
ap. */
+	__assume_ctx_lock(qc->ap->lock);
+	__assume_ctx_lock(qc->dev->link->ap->lock);
+
 	/*
 	 * Make sure we have a valid tag and that only one non-NCQ command is
 	 * outstanding.
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index ddea4979e94b..8fe29659efe7 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -936,6 +936,7 @@ void ata_eh_fastdrain_timerfn(struct timer_list *t)
  *	spin_lock_irqsave(host lock)
  */
 static void ata_eh_set_pending(struct ata_port *ap, bool fastdrain)
+	__must_hold(ap->lock)
 {
 	unsigned int cnt;
=20
@@ -1047,6 +1048,7 @@ void ata_port_schedule_eh(struct ata_port *ap)
 EXPORT_SYMBOL_GPL(ata_port_schedule_eh);
=20
 static int ata_do_link_abort(struct ata_port *ap, struct ata_link *link)
+	__must_hold(ap->lock)
 {
 	struct ata_queued_cmd *qc;
 	int tag, nr_aborted =3D 0;
@@ -1057,6 +1059,9 @@ static int ata_do_link_abort(struct ata_port *ap, s=
truct ata_link *link)
 	/* include internal tag in iteration */
 	ata_qc_for_each_with_internal(ap, qc, tag) {
 		if (qc && (!link || qc->dev->link =3D=3D link)) {
+			/* Tell the compiler that link->ap =3D=3D ap. */
+			__assume_ctx_lock(&link->ap->host->eh_mutex);
+
 			qc->flags |=3D ATA_QCFLAG_EH;
 			ata_qc_complete(ap, qc);
 			nr_aborted++;
@@ -1149,6 +1154,9 @@ static void __ata_port_freeze(struct ata_port *ap)
  */
 int ata_port_freeze(struct ata_port *ap)
 {
+	/* TO DO: fix all callers of this function that do not hold ap->lock. *=
/
+	__assume_ctx_lock(ap->lock);
+
 	__ata_port_freeze(ap);
=20
 	return ata_port_abort(ap);
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 352b9b9e9b6b..35575123408b 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1705,6 +1705,7 @@ void ata_scsi_requeue_deferred_qc(struct ata_port *=
ap)
 }
=20
 static void ata_scsi_schedule_deferred_qc(struct ata_port *ap)
+	__must_hold(ap->lock)
 {
 	struct ata_queued_cmd *qc =3D ap->deferred_qc;
=20
@@ -1727,6 +1728,7 @@ static void ata_scsi_schedule_deferred_qc(struct at=
a_port *ap)
 }
=20
 static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
+	__must_hold(qc->ap->lock)
 {
 	struct ata_port *ap =3D qc->ap;
 	struct scsi_cmnd *cmd =3D qc->scsicmd;
@@ -1763,6 +1765,7 @@ static void ata_scsi_qc_complete(struct ata_queued_=
cmd *qc)
 }
=20
 static int ata_scsi_qc_issue(struct ata_port *ap, struct ata_queued_cmd =
*qc)
+	__must_hold(ap->lock)
 {
 	int ret;
=20
@@ -1848,6 +1851,7 @@ static int ata_scsi_qc_issue(struct ata_port *ap, s=
truct ata_queued_cmd *qc)
  */
 static int ata_scsi_translate(struct ata_device *dev, struct scsi_cmnd *=
cmd,
 			      ata_xlat_func_t xlat_func)
+	__must_hold(dev->link->ap->lock)
 {
 	struct ata_port *ap =3D dev->link->ap;
 	struct ata_queued_cmd *qc;
@@ -3694,6 +3698,7 @@ static unsigned int ata_scsiop_maint_in(struct ata_=
device *dev,
  *	What a mess.
  */
 static void ata_scsi_report_zones_complete(struct ata_queued_cmd *qc)
+	__must_hold(qc->ap->lock)
 {
 	struct scsi_cmnd *scmd =3D qc->scsicmd;
 	struct sg_mapping_iter miter;
@@ -4548,6 +4553,9 @@ enum scsi_qc_status __ata_scsi_queuecmd(struct scsi=
_cmnd *scmd,
 		xlat_func =3D ata_get_xlat_func(dev, scsi_op);
 	}
=20
+	/* Tell the compiler that dev->link->ap =3D=3D ap. */
+	__assume_ctx_lock(dev->link->ap->lock);
+
 	if (xlat_func)
 		return ata_scsi_translate(dev, scmd, xlat_func);
=20
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 38226ed51bb5..6250ec524cc3 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -881,9 +881,13 @@ static inline int ata_hsm_ok_in_wq(struct ata_port *=
ap,
  *	Otherwise, none on entry and grabs host lock.
  */
 static void ata_hsm_qc_complete(struct ata_queued_cmd *qc, int in_wq)
+	__must_hold(qc->dev->link->ap->lock)
 {
 	struct ata_port *ap =3D qc->ap;
=20
+	/* Tell the compiler that qc->dev->link->ap =3D=3D ap. */
+	__assume_ctx_lock(ap->lock);
+
 	if (in_wq) {
 		/* EH might have kicked in while host lock is released. */
 		qc =3D ata_qc_from_tag(ap, qc->tag);
@@ -921,6 +925,9 @@ int ata_sff_hsm_move(struct ata_port *ap, struct ata_=
queued_cmd *qc,
=20
 	lockdep_assert_held(ap->lock);
=20
+	/* Tell the compiler that qc->dev->link->ap =3D=3D ap. */
+	__assume_ctx_lock(qc->dev->link->ap->lock);
+
 	WARN_ON_ONCE((qc->flags & ATA_QCFLAG_ACTIVE) =3D=3D 0);
=20
 	/* Make sure ata_sff_qc_issue() does not throw things
@@ -1394,6 +1401,7 @@ static unsigned int ata_sff_idle_irq(struct ata_por=
t *ap)
 static unsigned int __ata_sff_port_intr(struct ata_port *ap,
 					struct ata_queued_cmd *qc,
 					bool hsmv_on_idle)
+	__must_hold(ap->lock)
 {
 	u8 status;
=20
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 70e44e81f244..360ba7f7db05 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -88,8 +88,10 @@ extern int ata_down_xfermask_limit(struct ata_device *=
dev, unsigned int sel);
 extern unsigned int ata_dev_set_feature(struct ata_device *dev,
 					u8 subcmd, u8 action);
 extern void ata_qc_free(struct ata_queued_cmd *qc);
-extern void ata_qc_issue(struct ata_port *ap, struct ata_queued_cmd *qc)=
;
-extern void __ata_qc_complete(struct ata_port *ap, struct ata_queued_cmd=
 *qc);
+extern void ata_qc_issue(struct ata_port *ap, struct ata_queued_cmd *qc)
+	__must_hold(ap->lock);
+extern void __ata_qc_complete(struct ata_port *ap, struct ata_queued_cmd=
 *qc)
+	__must_hold(ap->lock);
 extern int atapi_check_dma(struct ata_queued_cmd *qc);
 extern void swap_buf_le16(u16 *buf, unsigned int buf_words);
 extern bool ata_phys_link_online(struct ata_link *link);
@@ -167,9 +169,11 @@ int ata_scsi_dev_config(struct scsi_device *sdev, st=
ruct queue_limits *lim,
 		struct ata_device *dev);
 enum scsi_qc_status __ata_scsi_queuecmd(struct scsi_cmnd *scmd,
 					struct ata_device *dev,
-					struct ata_port *ap);
+					struct ata_port *ap)
+	__must_hold(ap->lock);
 void ata_scsi_deferred_qc_work(struct work_struct *work);
-void ata_scsi_requeue_deferred_qc(struct ata_port *ap);
+void ata_scsi_requeue_deferred_qc(struct ata_port *ap)
+	__must_hold(ap->lock);
=20
 /* libata-eh.c */
 extern unsigned int ata_internal_cmd_timeout(struct ata_device *dev, u8 =
cmd);
@@ -180,7 +184,8 @@ extern void ata_eh_release(struct ata_port *ap)
 	__releases(ap->host->eh_mutex);
 extern void ata_scsi_error(struct Scsi_Host *host);
 extern void ata_eh_fastdrain_timerfn(struct timer_list *t);
-extern void ata_qc_schedule_eh(struct ata_port *ap, struct ata_queued_cm=
d *qc);
+extern void ata_qc_schedule_eh(struct ata_port *ap, struct ata_queued_cm=
d *qc)
+	__must_hold(ap->lock);
 extern void ata_dev_disable(struct ata_device *dev);
 extern void ata_eh_detach_dev(struct ata_device *dev);
 extern void ata_eh_about_to_do(struct ata_link *link, struct ata_device =
*dev,
diff --git a/drivers/ata/pdc_adma.c b/drivers/ata/pdc_adma.c
index b8f7633537c1..0760c760aefc 100644
--- a/drivers/ata/pdc_adma.c
+++ b/drivers/ata/pdc_adma.c
@@ -385,6 +385,7 @@ static unsigned int adma_qc_issue(struct ata_queued_c=
md *qc)
 }
=20
 static inline unsigned int adma_intr_pkt(struct ata_host *host)
+	__must_hold(host->lock)
 {
 	unsigned int handled =3D 0, port_no;
=20
@@ -395,6 +396,9 @@ static inline unsigned int adma_intr_pkt(struct ata_h=
ost *host)
 		void __iomem *chan =3D ADMA_PORT_REGS(ap);
 		u8 status =3D readb(chan + ADMA_STATUS);
=20
+		/* Tell the compiler that host->lock =3D=3D ap->lock. */
+		__assume_ctx_lock(ap->lock);
+
 		if (status =3D=3D 0)
 			continue;
 		handled =3D 1;
@@ -404,6 +408,9 @@ static inline unsigned int adma_intr_pkt(struct ata_h=
ost *host)
 			continue;
 		qc =3D ata_qc_from_tag(ap, ap->link.active_tag);
 		if (qc && (!(qc->tf.flags & ATA_TFLAG_POLLING))) {
+			/* Tell the compiler that qc->dev->link->ap =3D=3D ap. */
+			__assume_ctx_lock(qc->dev->link->ap->lock);
+
 			if (status & aPERR)
 				qc->err_mask |=3D AC_ERR_HOST_BUS;
 			else if ((status & (aPSD | aUIRQ)))
@@ -435,6 +442,7 @@ static inline unsigned int adma_intr_pkt(struct ata_h=
ost *host)
 }
=20
 static inline unsigned int adma_intr_mmio(struct ata_host *host)
+	__must_hold(host->lock)
 {
 	unsigned int handled =3D 0, port_no;
=20
@@ -443,11 +451,13 @@ static inline unsigned int adma_intr_mmio(struct at=
a_host *host)
 		struct adma_port_priv *pp =3D ap->private_data;
 		struct ata_queued_cmd *qc;
=20
+		/* Tell the compiler that host->lock =3D=3D ap->lock. */
+		__assume_ctx_lock(ap->lock);
+
 		if (!pp || pp->state !=3D adma_state_mmio)
 			continue;
 		qc =3D ata_qc_from_tag(ap, ap->link.active_tag);
 		if (qc && (!(qc->tf.flags & ATA_TFLAG_POLLING))) {
-
 			/* check main status, clearing INTRQ */
 			u8 status =3D ata_sff_check_status(ap);
 			if ((status & ATA_BUSY))
diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 8cd65a480010..a3d8a6b02609 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -410,6 +410,7 @@ static u32 qcmd_tag_to_mask(u8 tag)
 /* See ahci.c */
 static void sata_dwc_error_intr(struct ata_port *ap,
 				struct sata_dwc_device *hsdev, uint intpr)
+	__must_hold(ap->lock)
 {
 	struct sata_dwc_device_port *hsdevp =3D HSDEVP_FROM_AP(ap);
 	struct ata_eh_info *ehi =3D &ap->link.eh_info;
@@ -478,6 +479,10 @@ static irqreturn_t sata_dwc_isr(int irq, void *dev_i=
nstance)
 	intpr =3D sata_dwc_readl(&hsdev->sata_dwc_regs->intpr);
=20
 	ap =3D host->ports[port];
+
+	/* Tell the compiler that host->lock =3D=3D ap->lock. */
+	__assume_ctx_lock(ap->lock);
+
 	hsdevp =3D HSDEVP_FROM_AP(ap);
=20
 	dev_dbg(ap->dev, "%s intpr=3D0x%08x active_tag=3D%d\n", __func__, intpr=
,
@@ -738,6 +743,7 @@ static void sata_dwc_dma_xfer_complete(struct ata_por=
t *ap)
 }
=20
 static int sata_dwc_qc_complete(struct ata_port *ap, struct ata_queued_c=
md *qc)
+	__must_hold(ap->lock)
 {
 	u8 status =3D 0;
 	u32 mask =3D 0x0;
diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index d05c9603489e..d32c0921968d 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -1052,6 +1052,7 @@ static void sata_fsl_post_internal_cmd(struct ata_q=
ueued_cmd *qc)
 }
=20
 static void sata_fsl_error_intr(struct ata_port *ap)
+	__must_hold(ap->lock)
 {
 	struct sata_fsl_host_priv *host_priv =3D ap->host->private_data;
 	void __iomem *hcr_base =3D host_priv->hcr_base;
@@ -1178,6 +1179,7 @@ static void sata_fsl_error_intr(struct ata_port *ap=
)
 }
=20
 static void sata_fsl_host_intr(struct ata_port *ap)
+	__must_hold(ap->lock)
 {
 	struct sata_fsl_host_priv *host_priv =3D ap->host->private_data;
 	void __iomem *hcr_base =3D host_priv->hcr_base;
@@ -1197,6 +1199,9 @@ static void sata_fsl_host_intr(struct ata_port *ap)
 	/* Workaround for data length mismatch errata */
 	if (unlikely(hstatus & INT_ON_DATA_LENGTH_MISMATCH)) {
 		ata_qc_for_each_with_internal(ap, qc, tag) {
+			/* Tell the compiler that qc->dev->link->ap =3D=3D ap. */
+			__assume_ctx_lock(qc->dev->link->ap->lock);
+
 			if (qc && ata_is_atapi(qc->tf.protocol)) {
 				u32 hcontrol;
 				/* Set HControl[27] to clear error registers */
@@ -1298,6 +1303,8 @@ static irqreturn_t sata_fsl_interrupt(int irq, void=
 *dev_instance)
=20
 	ap =3D host->ports[0];
 	if (ap) {
+		/* Tell the compiler that host->lock =3D=3D ap->lock. */
+		__assume_ctx_lock(ap->lock);
 		sata_fsl_host_intr(ap);
 	} else {
 		dev_warn(host->dev, "interrupt on disabled port 0\n");
diff --git a/drivers/ata/sata_inic162x.c b/drivers/ata/sata_inic162x.c
index 6ea9fceb8261..0f7a06fe929d 100644
--- a/drivers/ata/sata_inic162x.c
+++ b/drivers/ata/sata_inic162x.c
@@ -324,6 +324,7 @@ static void inic_stop_idma(struct ata_port *ap)
 }
=20
 static void inic_host_err_intr(struct ata_port *ap, u8 irq_stat, u16 idm=
a_stat)
+	__must_hold(ap->lock)
 {
 	struct ata_eh_info *ehi =3D &ap->link.eh_info;
 	struct inic_port_priv *pp =3D ap->private_data;
@@ -380,6 +381,7 @@ static void inic_host_err_intr(struct ata_port *ap, u=
8 irq_stat, u16 idma_stat)
 }
=20
 static void inic_host_intr(struct ata_port *ap)
+	__must_hold(ap->lock)
 {
 	void __iomem *port_base =3D inic_port_base(ap);
 	struct ata_queued_cmd *qc =3D ata_qc_from_tag(ap, ap->link.active_tag);
@@ -430,11 +432,14 @@ static irqreturn_t inic_interrupt(int irq, void *de=
v_instance)
=20
 	spin_lock(&host->lock);
=20
-	for (i =3D 0; i < NR_PORTS; i++)
+	for (i =3D 0; i < NR_PORTS; i++) {
+		/* Tell the compiler that host->ports[i]->lock =3D=3D host->lock. */
+		__assume_ctx_lock(host->ports[i]->lock);
 		if (host_irq_stat & (HIRQ_PORT0 << i)) {
 			inic_host_intr(host->ports[i]);
 			handled++;
 		}
+	}
=20
 	spin_unlock(&host->lock);
=20
diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index ea10c12f449c..18a15dcc39aa 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -2433,6 +2433,7 @@ static unsigned int mv_get_err_pmp_map(struct ata_p=
ort *ap)
 }
=20
 static void mv_pmp_eh_prep(struct ata_port *ap, unsigned int pmp_map)
+	__must_hold(ap->lock)
 {
 	unsigned int pmp;
=20
@@ -2445,6 +2446,9 @@ static void mv_pmp_eh_prep(struct ata_port *ap, uns=
igned int pmp_map)
 			struct ata_link *link =3D &ap->pmp_link[pmp];
 			struct ata_eh_info *ehi =3D &link->eh_info;
=20
+			/* Tell the compiler that link->ap =3D=3D ap. */
+			__assume_ctx_lock(link->ap->lock);
+
 			pmp_map &=3D ~this_pmp;
 			ata_ehi_clear_desc(ehi);
 			ata_ehi_push_desc(ehi, "dev err");
@@ -2468,6 +2472,7 @@ static int mv_req_q_empty(struct ata_port *ap)
 }
=20
 static int mv_handle_fbs_ncq_dev_err(struct ata_port *ap)
+	__must_hold(ap->lock)
 {
 	struct mv_port_priv *pp =3D ap->private_data;
 	int failed_links;
@@ -2528,6 +2533,7 @@ static int mv_handle_fbs_non_ncq_dev_err(struct ata=
_port *ap)
 }
=20
 static int mv_handle_dev_err(struct ata_port *ap, u32 edma_err_cause)
+	__must_hold(ap->lock)
 {
 	struct mv_port_priv *pp =3D ap->private_data;
=20
@@ -2601,6 +2607,7 @@ static void mv_unexpected_intr(struct ata_port *ap,=
 int edma_was_enabled)
  *      Inherited from caller.
  */
 static void mv_err_intr(struct ata_port *ap)
+	__must_hold(ap->lock)
 {
 	void __iomem *port_mmio =3D mv_ap_base(ap);
 	u32 edma_err_cause, eh_freeze_mask, serr =3D 0;
@@ -2764,6 +2771,7 @@ static bool mv_process_crpb_response(struct ata_por=
t *ap,
 }
=20
 static void mv_process_crpb_entries(struct ata_port *ap, struct mv_port_=
priv *pp)
+	__must_hold(ap->lock)
 {
 	void __iomem *port_mmio =3D mv_ap_base(ap);
 	struct mv_host_priv *hpriv =3D ap->host->private_data;
@@ -2806,6 +2814,7 @@ static void mv_process_crpb_entries(struct ata_port=
 *ap, struct mv_port_priv *pp
 }
=20
 static void mv_port_intr(struct ata_port *ap, u32 port_cause)
+	__must_hold(ap->lock)
 {
 	struct mv_port_priv *pp;
 	int edma_was_enabled;
@@ -2848,6 +2857,7 @@ static void mv_port_intr(struct ata_port *ap, u32 p=
ort_cause)
  *      Inherited from caller.
  */
 static int mv_host_intr(struct ata_host *host, u32 main_irq_cause)
+	__must_hold(host->lock)
 {
 	struct mv_host_priv *hpriv =3D host->private_data;
 	void __iomem *mmio =3D hpriv->base, *hc_mmio;
@@ -2861,6 +2871,9 @@ static int mv_host_intr(struct ata_host *host, u32 =
main_irq_cause)
 		struct ata_port *ap =3D host->ports[port];
 		unsigned int p, shift, hardport, port_cause;
=20
+		/* Tell the compiler that ap->lock =3D=3D host->lock. */
+		__assume_ctx_lock(ap->lock);
+
 		MV_PORT_TO_SHIFT_AND_HARDPORT(port, shift, hardport);
 		/*
 		 * Each hc within the host has its own hc_irq_cause register,
diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index 19b927065868..01bf8302c88c 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -808,6 +808,7 @@ static unsigned int nv_adma_tf_to_cpb(struct ata_task=
file *tf, __le16 *cpb)
 }
=20
 static int nv_adma_check_cpb(struct ata_port *ap, int cpb_num, int force=
_err)
+	__must_hold(ap->lock)
 {
 	struct nv_adma_port_priv *pp =3D ap->private_data;
 	u8 flags =3D pp->cpb[cpb_num].resp_flags;
@@ -853,6 +854,7 @@ static int nv_adma_check_cpb(struct ata_port *ap, int=
 cpb_num, int force_err)
 }
=20
 static int nv_host_intr(struct ata_port *ap, u8 irq_stat)
+	__must_hold(ap->lock)
 {
 	struct ata_queued_cmd *qc =3D ata_qc_from_tag(ap, ap->link.active_tag);
=20
@@ -892,6 +894,9 @@ static irqreturn_t nv_adma_interrupt(int irq, void *d=
ev_instance)
 		u32 gen_ctl;
 		u32 notifier, notifier_error;
=20
+		/* Tell the compiler that ap->lock =3D=3D host->lock. */
+		__assume_ctx_lock(ap->lock);
+
 		notifier_clears[i] =3D 0;
=20
 		/* if ADMA is disabled, use standard ata interrupt handler */
@@ -1444,6 +1449,9 @@ static irqreturn_t nv_generic_interrupt(int irq, vo=
id *dev_instance)
 		struct ata_port *ap =3D host->ports[i];
 		struct ata_queued_cmd *qc;
=20
+		/* Tell the compiler that ap->lock =3D=3D &host->lock. */
+		__assume_ctx_lock(ap->lock);
+
 		qc =3D ata_qc_from_tag(ap, ap->link.active_tag);
 		if (qc && (!(qc->tf.flags & ATA_TFLAG_POLLING))) {
 			handled +=3D ata_bmdma_port_intr(ap, qc);
@@ -1465,7 +1473,10 @@ static irqreturn_t nv_do_interrupt(struct ata_host=
 *host, u8 irq_stat)
 {
 	int i, handled =3D 0;
=20
+	/* TO DO: protect the code below with &host->lock. */
+
 	for (i =3D 0; i < host->n_ports; i++) {
+		__assume_ctx_lock(host->ports[i]->lock);
 		handled +=3D nv_host_intr(host->ports[i], irq_stat);
 		irq_stat >>=3D NV_INT_PORT_SHIFT;
 	}
@@ -2064,6 +2075,7 @@ static void nv_swncq_hotplug(struct ata_port *ap, u=
32 fis)
 }
=20
 static int nv_swncq_sdbfis(struct ata_port *ap)
+	__must_hold(ap->lock)
 {
 	struct ata_queued_cmd *qc;
 	struct nv_swncq_port_priv *pp =3D ap->private_data;
@@ -2179,6 +2191,7 @@ static void nv_swncq_dmafis(struct ata_port *ap)
 }
=20
 static void nv_swncq_host_interrupt(struct ata_port *ap, u16 fis)
+	__must_hold(ap->lock)
 {
 	struct nv_swncq_port_priv *pp =3D ap->private_data;
 	struct ata_queued_cmd *qc;
@@ -2292,6 +2305,9 @@ static irqreturn_t nv_swncq_interrupt(int irq, void=
 *dev_instance)
 	for (i =3D 0; i < host->n_ports; i++) {
 		struct ata_port *ap =3D host->ports[i];
=20
+		/* Tell the compiler that ap->lock =3D=3D host->lock. */
+		__assume_ctx_lock(ap->lock);
+
 		if (ap->link.sactive) {
 			nv_swncq_host_interrupt(ap, (u16)irq_stat);
 			handled =3D 1;
diff --git a/drivers/ata/sata_promise.c b/drivers/ata/sata_promise.c
index c980e609b246..877961ac8512 100644
--- a/drivers/ata/sata_promise.c
+++ b/drivers/ata/sata_promise.c
@@ -835,6 +835,7 @@ static void pdc_post_internal_cmd(struct ata_queued_c=
md *qc)
=20
 static void pdc_error_intr(struct ata_port *ap, struct ata_queued_cmd *q=
c,
 			   u32 port_status, u32 err_mask)
+	__must_hold(ap->lock)
 {
 	struct ata_eh_info *ehi =3D &ap->link.eh_info;
 	unsigned int ac_err_mask =3D 0;
@@ -869,11 +870,15 @@ static void pdc_error_intr(struct ata_port *ap, str=
uct ata_queued_cmd *qc,
=20
 static unsigned int pdc_host_intr(struct ata_port *ap,
 				  struct ata_queued_cmd *qc)
+	__must_hold(ap->lock)
 {
 	unsigned int handled =3D 0;
 	void __iomem *ata_mmio =3D ap->ioaddr.cmd_addr;
 	u32 port_status, err_mask;
=20
+	/* Tell the compiler that qc->dev->link->ap =3D=3D ap. */
+	__assume_ctx_lock(qc->dev->link->ap->lock);
+
 	err_mask =3D PDC_ERR_MASK;
 	if (ap->flags & PDC_FLAG_GEN_II)
 		err_mask &=3D ~PDC1_ERR_MASK;
@@ -974,8 +979,14 @@ static irqreturn_t pdc_interrupt(int irq, void *dev_=
instance)
 			struct ata_queued_cmd *qc;
=20
 			qc =3D ata_qc_from_tag(ap, ap->link.active_tag);
-			if (qc && (!(qc->tf.flags & ATA_TFLAG_POLLING)))
+			if (qc && (!(qc->tf.flags & ATA_TFLAG_POLLING))) {
+				/*
+				 * Tell the compiler that ap->lock =3D=3D
+				 * host->lock.
+				 */
+				__assume_ctx_lock(ap->lock);
 				handled +=3D pdc_host_intr(ap, qc);
+			}
 		}
 	}
=20
diff --git a/drivers/ata/sata_qstor.c b/drivers/ata/sata_qstor.c
index c682285ea5e5..2406598183b2 100644
--- a/drivers/ata/sata_qstor.c
+++ b/drivers/ata/sata_qstor.c
@@ -329,9 +329,13 @@ static unsigned int qs_qc_issue(struct ata_queued_cm=
d *qc)
 }
=20
 static void qs_do_or_die(struct ata_queued_cmd *qc, u8 status)
+	__must_hold(qc->dev->link->ap->lock)
 {
 	struct ata_port *ap =3D qc->ap;
=20
+	/* Tell the compiler that ap =3D=3D qc->dev->link->ap. */
+	__assume_ctx_lock(ap->lock);
+
 	qc->err_mask |=3D ac_err_mask(status);
=20
 	if (!qc->err_mask) {
@@ -350,6 +354,7 @@ static void qs_do_or_die(struct ata_queued_cmd *qc, u=
8 status)
 }
=20
 static inline unsigned int qs_intr_pkt(struct ata_host *host)
+	__must_hold(host->lock)
 {
 	unsigned int handled =3D 0;
 	u8 sFFE;
@@ -376,6 +381,11 @@ static inline unsigned int qs_intr_pkt(struct ata_ho=
st *host)
 				continue;
 			qc =3D ata_qc_from_tag(ap, ap->link.active_tag);
 			if (qc && (!(qc->tf.flags & ATA_TFLAG_POLLING))) {
+				/*
+				 * Tell the compiler that qc->dev->link->ap->
+				 * scsi_host =3D=3D host.
+				 */
+				__assume_ctx_lock(qc->dev->link->ap->lock);
 				switch (sHST) {
 				case 0: /* successful CPB */
 				case 3: /* device error */
@@ -392,6 +402,7 @@ static inline unsigned int qs_intr_pkt(struct ata_hos=
t *host)
 }
=20
 static inline unsigned int qs_intr_mmio(struct ata_host *host)
+	__must_hold(host->lock)
 {
 	unsigned int handled =3D 0, port_no;
=20
@@ -400,6 +411,9 @@ static inline unsigned int qs_intr_mmio(struct ata_ho=
st *host)
 		struct qs_port_priv *pp =3D ap->private_data;
 		struct ata_queued_cmd *qc;
=20
+		/* Tell the compiler that ap->lock =3D=3D host->lock. */
+		__assume_ctx_lock(ap->lock);
+
 		qc =3D ata_qc_from_tag(ap, ap->link.active_tag);
 		if (!qc) {
 			/*
diff --git a/drivers/ata/sata_rcar.c b/drivers/ata/sata_rcar.c
index 487eadd4073f..8dc6e325fb88 100644
--- a/drivers/ata/sata_rcar.c
+++ b/drivers/ata/sata_rcar.c
@@ -648,6 +648,7 @@ static struct ata_port_operations sata_rcar_port_ops =
=3D {
 };
=20
 static void sata_rcar_serr_interrupt(struct ata_port *ap)
+	__must_hold(ap->lock)
 {
 	struct sata_rcar_priv *priv =3D ap->host->private_data;
 	struct ata_eh_info *ehi =3D &ap->link.eh_info;
@@ -679,6 +680,7 @@ static void sata_rcar_serr_interrupt(struct ata_port =
*ap)
 }
=20
 static void sata_rcar_ata_interrupt(struct ata_port *ap)
+	__must_hold(ap->lock)
 {
 	struct ata_queued_cmd *qc;
 	int handled =3D 0;
@@ -713,6 +715,9 @@ static irqreturn_t sata_rcar_interrupt(int irq, void =
*dev_instance)
=20
 	ap =3D host->ports[0];
=20
+	/* Tell the compiler that ap->lock =3D=3D host->lock. */
+	__assume_ctx_lock(ap->lock);
+
 	if (sataintstat & SATAINTSTAT_ATA)
 		sata_rcar_ata_interrupt(ap);
=20
diff --git a/drivers/ata/sata_sil.c b/drivers/ata/sata_sil.c
index 1b6dc950a42a..4545aadaaf10 100644
--- a/drivers/ata/sata_sil.c
+++ b/drivers/ata/sata_sil.c
@@ -417,6 +417,7 @@ static int sil_scr_write(struct ata_link *link, unsig=
ned int sc_reg, u32 val)
 }
=20
 static void sil_host_intr(struct ata_port *ap, u32 bmdma2)
+	__must_hold(ap->lock)
 {
 	struct ata_eh_info *ehi =3D &ap->link.eh_info;
 	struct ata_queued_cmd *qc =3D ata_qc_from_tag(ap, ap->link.active_tag);
@@ -524,6 +525,9 @@ static irqreturn_t sil_interrupt(int irq, void *dev_i=
nstance)
 		    !(bmdma2 & (SIL_DMA_COMPLETE | SIL_DMA_SATA_IRQ)))
 			continue;
=20
+		/* Tell the compiler that ap->lock =3D=3D host->lock. */
+		__assume_ctx_lock(ap->lock);
+
 		sil_host_intr(ap, bmdma2);
 		handled =3D 1;
 	}
diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index 9fc7ca6fb7a1..d61673f9a0d0 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -966,6 +966,7 @@ static void sil24_thaw(struct ata_port *ap)
 }
=20
 static void sil24_error_intr(struct ata_port *ap)
+	__must_hold(ap->lock)
 {
 	void __iomem *port =3D sil24_port_base(ap);
 	struct sil24_port_priv *pp =3D ap->private_data;
@@ -1093,6 +1094,7 @@ static void sil24_error_intr(struct ata_port *ap)
 }
=20
 static inline void sil24_host_intr(struct ata_port *ap)
+	__must_hold(ap->lock)
 {
 	void __iomem *port =3D sil24_port_base(ap);
 	u32 slot_stat, qc_active;
@@ -1157,6 +1159,11 @@ static irqreturn_t sil24_interrupt(int irq, void *=
dev_instance)
=20
 	for (i =3D 0; i < host->n_ports; i++)
 		if (status & (1 << i)) {
+			/*
+			 * Tell the compiler that this is the same lock as
+			 * host->lock.
+			 */
+			__assume_ctx_lock(host->ports[i]->lock);
 			sil24_host_intr(host->ports[i]);
 			handled++;
 		}
diff --git a/drivers/ata/sata_sx4.c b/drivers/ata/sata_sx4.c
index fce5fed2b3be..603ffff5ecef 100644
--- a/drivers/ata/sata_sx4.c
+++ b/drivers/ata/sata_sx4.c
@@ -656,6 +656,7 @@ static inline unsigned int pdc20621_host_intr(struct =
ata_port *ap,
 					  struct ata_queued_cmd *qc,
 					  unsigned int doing_hdma,
 					  void __iomem *mmio)
+	__must_hold(ap->lock)
 {
 	unsigned int port_no =3D ap->port_no;
 	unsigned int port_ofs =3D
@@ -778,6 +779,9 @@ static irqreturn_t pdc20621_interrupt(int irq, void *=
dev_instance)
 		if (tmp && ap) {
 			struct ata_queued_cmd *qc;
=20
+			/* Tell the compiler that ap->lock =3D=3D host->lock. */
+			__assume_ctx_lock(ap->lock);
+
 			qc =3D ata_qc_from_tag(ap, ap->link.active_tag);
 			if (qc && (!(qc->tf.flags & ATA_TFLAG_POLLING)))
 				handled +=3D pdc20621_host_intr(ap, qc, (i > 4),
diff --git a/drivers/ata/sata_vsc.c b/drivers/ata/sata_vsc.c
index a53a2dfc1e17..0ddc7a45b674 100644
--- a/drivers/ata/sata_vsc.c
+++ b/drivers/ata/sata_vsc.c
@@ -209,6 +209,7 @@ static void vsc_sata_tf_read(struct ata_port *ap, str=
uct ata_taskfile *tf)
 }
=20
 static inline void vsc_error_intr(u8 port_status, struct ata_port *ap)
+	__must_hold(ap->lock)
 {
 	if (port_status & (VSC_SATA_INT_PHY_CHANGE | VSC_SATA_INT_ERROR_M))
 		ata_port_freeze(ap);
@@ -217,6 +218,7 @@ static inline void vsc_error_intr(u8 port_status, str=
uct ata_port *ap)
 }
=20
 static void vsc_port_intr(u8 port_status, struct ata_port *ap)
+	__must_hold(ap->lock)
 {
 	struct ata_queued_cmd *qc;
 	int handled =3D 0;
@@ -266,6 +268,11 @@ static irqreturn_t vsc_sata_interrupt(int irq, void =
*dev_instance)
 	for (i =3D 0; i < host->n_ports; i++) {
 		u8 port_status =3D (status >> (8 * i)) & 0xff;
 		if (port_status) {
+			/*
+			 * Tell the compiler that this is the same lock as
+			 * host->lock.
+			 */
+			__assume_ctx_lock(host->ports[i]->lock);
 			vsc_port_intr(port_status, host->ports[i]);
 			handled++;
 		}
diff --git a/include/linux/libata.h b/include/linux/libata.h
index bf113e66f069..19867a4909ca 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -666,7 +666,7 @@ struct ata_queued_cmd {
=20
 	unsigned int		err_mask;
 	struct ata_taskfile	result_tf;
-	ata_qc_cb_t		complete_fn;
+	ata_qc_cb_t		complete_fn /*__must_hold(qc->ap->lock)*/;
=20
 	void			*private_data;
 	void			*lldd_task;
@@ -962,7 +962,8 @@ struct ata_port_operations {
 	int (*qc_defer)(struct ata_queued_cmd *qc);
 	int (*check_atapi_dma)(struct ata_queued_cmd *qc);
 	enum ata_completion_errors (*qc_prep)(struct ata_queued_cmd *qc);
-	unsigned int (*qc_issue)(struct ata_queued_cmd *qc);
+	unsigned int (*qc_issue)(struct ata_queued_cmd *qc)
+		__must_hold(&qc->dev->link->ap->lock);
 	void (*qc_fill_rtf)(struct ata_queued_cmd *qc);
 	void (*qc_ncq_fill_rtf)(struct ata_port *ap, u64 done_mask);
=20
@@ -1204,7 +1205,8 @@ extern void ata_id_c_string(const u16 *id, unsigned=
 char *s,
 			    unsigned int ofs, unsigned int len);
 extern unsigned int ata_do_dev_read_id(struct ata_device *dev,
 				       struct ata_taskfile *tf, __le16 *id);
-extern void ata_qc_complete(struct ata_port *ap, struct ata_queued_cmd *=
qc);
+extern void ata_qc_complete(struct ata_port *ap, struct ata_queued_cmd *=
qc)
+	__must_hold(ap->lock);
 extern u64 ata_qc_get_active(struct ata_port *ap);
 extern int ata_std_bios_param(struct scsi_device *sdev,
 			      struct gendisk *unused,
@@ -1314,11 +1316,13 @@ extern int ata_tport_add(struct device *parent, s=
truct ata_port *ap);
 extern void ata_tport_delete(struct ata_port *ap);
 int ata_sas_sdev_configure(struct scsi_device *sdev, struct queue_limits=
 *lim,
 			   struct ata_port *ap);
-extern int ata_sas_queuecmd(struct scsi_cmnd *cmd, struct ata_port *ap);
+extern int ata_sas_queuecmd(struct scsi_cmnd *cmd, struct ata_port *ap)
+	__must_hold(ap->lock);
 extern void ata_tf_to_fis(const struct ata_taskfile *tf,
 			  u8 pmp, int is_cmd, u8 *fis);
 extern void ata_tf_from_fis(const u8 *fis, struct ata_taskfile *tf);
-extern int ata_qc_complete_multiple(struct ata_port *ap, u64 qc_active);
+extern int ata_qc_complete_multiple(struct ata_port *ap, u64 qc_active)
+	__must_hold(ap->lock);
 extern bool sata_lpm_ignore_phy_events(struct ata_link *link);
 extern int sata_async_notification(struct ata_port *ap);
=20
@@ -1409,8 +1413,10 @@ static inline int ata_acpi_cbl_pata_type(struct at=
a_port *ap)
  */
 extern void ata_port_schedule_eh(struct ata_port *ap);
 extern void ata_port_wait_eh(struct ata_port *ap);
-extern int ata_link_abort(struct ata_port *ap, struct ata_link *link);
-extern int ata_port_abort(struct ata_port *ap);
+extern int ata_link_abort(struct ata_port *ap, struct ata_link *link)
+	__must_hold(ap->lock);
+extern int ata_port_abort(struct ata_port *ap)
+	__must_hold(ap->lock);
 extern int ata_port_freeze(struct ata_port *ap);
=20
 extern void ata_eh_freeze_port(struct ata_port *ap);
@@ -2042,7 +2048,8 @@ extern unsigned int ata_sff_data_xfer32(struct ata_=
queued_cmd *qc,
 			unsigned char *buf, unsigned int buflen, int rw);
 extern void ata_sff_irq_on(struct ata_port *ap);
 extern int ata_sff_hsm_move(struct ata_port *ap, struct ata_queued_cmd *=
qc,
-			    u8 status, int in_wq);
+			    u8 status, int in_wq)
+	__must_hold(ap->lock);
 extern void ata_sff_queue_work(struct work_struct *work);
 extern void ata_sff_queue_delayed_work(struct delayed_work *dwork,
 		unsigned long delay);
@@ -2050,9 +2057,11 @@ extern void ata_sff_queue_pio_task(struct ata_link=
 *link, unsigned long delay);
 extern unsigned int ata_sff_qc_issue(struct ata_queued_cmd *qc);
 extern void ata_sff_qc_fill_rtf(struct ata_queued_cmd *qc);
 extern unsigned int ata_sff_port_intr(struct ata_port *ap,
-				      struct ata_queued_cmd *qc);
+				      struct ata_queued_cmd *qc)
+	__must_hold(ap->lock);
 extern irqreturn_t ata_sff_interrupt(int irq, void *dev_instance);
-extern void ata_sff_lost_interrupt(struct ata_port *ap);
+extern void ata_sff_lost_interrupt(struct ata_port *ap)
+	__must_hold(ap->lock);
 extern void ata_sff_freeze(struct ata_port *ap);
 extern void ata_sff_thaw(struct ata_port *ap);
 extern int ata_sff_prereset(struct ata_link *link, unsigned long deadlin=
e);
@@ -2095,7 +2104,8 @@ extern enum ata_completion_errors ata_bmdma_qc_prep=
(struct ata_queued_cmd *qc);
 extern unsigned int ata_bmdma_qc_issue(struct ata_queued_cmd *qc);
 extern enum ata_completion_errors ata_bmdma_dumb_qc_prep(struct ata_queu=
ed_cmd *qc);
 extern unsigned int ata_bmdma_port_intr(struct ata_port *ap,
-				      struct ata_queued_cmd *qc);
+				      struct ata_queued_cmd *qc)
+	__must_hold(ap->lock);
 extern irqreturn_t ata_bmdma_interrupt(int irq, void *dev_instance);
 extern void ata_bmdma_error_handler(struct ata_port *ap)
 	__must_hold(&ap->host->eh_mutex);
