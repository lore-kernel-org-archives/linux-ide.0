Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B90383999
	for <linux-ide@vger.kernel.org>; Thu, 21 May 2026 17:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779384882; cv=none; b=VpJWvbUF9v3dK491Xbd2+3ckfwMGtiQSOVkT0oZRfnwmkcFpyxl589dvvKTegeAkGbOTZFtRSzzmY7RqlwHbCTfpWQ1F+lDBc5SItBYAnvxoWUJfZBaxkTGnREBHPlN5XnG4Orv/MPClyiqFUr+Jn91DPT5DnDyCLWoFBqgEb6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779384882; c=relaxed/simple;
	bh=W8G5FuHCXteKqJtjGAfGiQyG9o9OakenQ2xhkE7r4RE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JPE0NBd6NzW46JFOOy3hYlUptwLjCJF2HM2K7Gf7gYmXoawmnruJR6If8C9NY5FRKzBeueA1ARILF6/mDOeczY/+DFXiBvDkfP3cVUVpMQtxPAzlwRWF4c5T350sGgNdNJTvMt95xji+cEeNCXrOskrgoBH5rInEkk3Evya9uds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=vW3091pR; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="vW3091pR"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gLwX00vnCz1XM0ns;
	Thu, 21 May 2026 17:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1779384859; x=1781976860; bh=MQ7fh
	CQKdHNP3Q2F+KgYswsVHLxbiGB+c31OEiKM9Qg=; b=vW3091pRGNbsRRoJDsIqK
	TIJc6xgaJ0ErikxgT/PqL802DjHbx9wCZ61NNZJpbqOvQwbqVzR/X+lAZuvWPJeT
	2/TuCjRwtztn/P1tir66EzJHsgC+fjq7mYhct7Zz11jy+QzERaoYpXhh1r+iQPbK
	f7BVrWCR9rhTRm/8ys1qseynwEgdkjquaxzxJRKh9aKjhGtZhx9hy4+R+Dr74Pil
	UqD2UhDDFKvmFN71M3btY8XzQYiyn2PsVDrFUaKrN2Mhk06Yeg29I4W6m+JQGnAb
	eIlClLWk6IQs6CTOtWa8t1twoNRK4mmxTjUrSWSTMLOY7/7XskqUBjj9uyX+a+c4
	g==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id U7m08uh4WNty; Thu, 21 May 2026 17:34:19 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gLwWY4YHfz1XM0p0;
	Thu, 21 May 2026 17:34:17 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Marco Elver <elver@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Viresh Kumar <vireshk@kernel.org>,
	Mikael Pettersson <mikpelinux@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v2 8/9] ata: libata: Enable context analysis
Date: Thu, 21 May 2026 10:33:36 -0700
Message-ID: <20260521173347.2079560-9-bvanassche@acm.org>
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

Enable Clang's context analysis. This will cause the build to fail if
e.g. a locking bug would be introduced in an error path. This patch
should not affect the generated assembler code.

Note: although the Linux kernel documentation specifies 22 as minimal
version for Clang for context analysis support, annotating function
pointers is a Clang 23 feature. As one can see here, a patch has been
queued that fixes the kernel documentation:
https://lore.kernel.org/all/177926568868.711.3058599932884307249.tip-bot2=
@tip-bot2/

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/ata/Makefile         |  2 ++
 drivers/ata/ahci.h           |  3 ++-
 drivers/ata/ahci_imx.c       |  1 +
 drivers/ata/libata-core.c    |  1 +
 drivers/ata/libata-eh.c      |  3 +++
 drivers/ata/libata-pmp.c     |  5 +++++
 drivers/ata/libata.h         | 12 ++++++++----
 drivers/ata/pata_arasan_cf.c |  1 +
 drivers/ata/sata_dwc_460ex.c |  1 +
 drivers/ata/sata_fsl.c       |  1 +
 drivers/ata/sata_inic162x.c  |  1 +
 drivers/ata/sata_mv.c        |  1 +
 drivers/ata/sata_nv.c        |  2 ++
 drivers/ata/sata_promise.c   |  1 +
 drivers/ata/sata_qstor.c     |  1 +
 drivers/ata/sata_sil24.c     |  1 +
 drivers/ata/sata_sx4.c       |  1 +
 drivers/ata/sata_via.c       |  1 +
 include/linux/libata.h       | 18 ++++++++++++------
 19 files changed, 46 insertions(+), 11 deletions(-)

diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
index 20e6645ab737..b96025abd45e 100644
--- a/drivers/ata/Makefile
+++ b/drivers/ata/Makefile
@@ -1,5 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
=20
+CONTEXT_ANALYSIS :=3D y
+
 obj-$(CONFIG_ATA)		+=3D libata.o
=20
 # non-SFF interface
diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 9e8b6319025c..b57cca352faa 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -448,7 +448,8 @@ void ahci_set_em_messages(struct ahci_host_priv *hpri=
v,
 int ahci_reset_em(struct ata_host *host);
 void ahci_print_info(struct ata_host *host, const char *scc_s);
 int ahci_host_activate(struct ata_host *host, const struct scsi_host_tem=
plate *sht);
-void ahci_error_handler(struct ata_port *ap);
+void ahci_error_handler(struct ata_port *ap)
+	__must_hold(&ap->host->eh_mutex);
 u32 ahci_handle_port_intr(struct ata_host *host, u32 irq_masked);
=20
 static inline void __iomem *__ahci_port_base(struct ahci_host_priv *hpri=
v,
diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
index 3d26595524d3..6aaa18e29abc 100644
--- a/drivers/ata/ahci_imx.c
+++ b/drivers/ata/ahci_imx.c
@@ -598,6 +598,7 @@ static void imx_sata_disable(struct ahci_host_priv *h=
priv)
 }
=20
 static void ahci_imx_error_handler(struct ata_port *ap)
+	__must_hold(&ap->host->eh_mutex)
 {
 	u32 reg_val;
 	struct ata_device *dev;
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index f96e077514f9..8b8081f4dc63 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6828,6 +6828,7 @@ EXPORT_SYMBOL_GPL(ata_ratelimit);
  *	Might sleep.
  */
 void ata_msleep(struct ata_port *ap, unsigned int msecs)
+	__context_unsafe(conditional locking)
 {
 	bool owns_eh =3D ap && ap->host->eh_owner =3D=3D current;
=20
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 66ea590fad58..ddea4979e94b 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -3877,6 +3877,9 @@ int ata_eh_recover(struct ata_port *ap, struct ata_=
reset_operations *reset_ops,
 	ata_for_each_link(link, ap, EDGE) {
 		struct ata_eh_context *ehc =3D &link->eh_context;
=20
+		/* Tell the compiler that link->ap =3D=3D ap. */
+		__assume_ctx_lock(&link->ap->host->eh_mutex);
+
 		if (!(ehc->i.action & ATA_EH_RESET))
 			continue;
=20
diff --git a/drivers/ata/libata-pmp.c b/drivers/ata/libata-pmp.c
index e3adc008fed1..486c554883bf 100644
--- a/drivers/ata/libata-pmp.c
+++ b/drivers/ata/libata-pmp.c
@@ -742,6 +742,7 @@ static int sata_pmp_revalidate_quick(struct ata_devic=
e *dev)
  */
 static int sata_pmp_eh_recover_pmp(struct ata_port *ap,
 				   struct ata_reset_operations *reset_ops)
+	__must_hold(&ap->host->eh_mutex)
 {
 	struct ata_link *link =3D &ap->link;
 	struct ata_eh_context *ehc =3D &link->eh_context;
@@ -750,6 +751,9 @@ static int sata_pmp_eh_recover_pmp(struct ata_port *a=
p,
 	int detach =3D 0, rc =3D 0;
 	int reval_failed =3D 0;
=20
+	/* Tell the compiler that ap->link.ap =3D=3D ap. */
+	__assume_ctx_lock(&ap->link.ap->host->eh_mutex);
+
 	if (dev->flags & ATA_DFLAG_DETACH) {
 		detach =3D 1;
 		rc =3D -ENODEV;
@@ -907,6 +911,7 @@ static int sata_pmp_handle_link_fail(struct ata_link =
*link, int *link_tries)
  *	0 on success, -errno on failure.
  */
 static int sata_pmp_eh_recover(struct ata_port *ap)
+	__must_hold(&ap->host->eh_mutex)
 {
 	struct ata_port_operations *ops =3D ap->ops;
 	int pmp_tries, link_tries[SATA_PMP_MAX_PORTS];
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 5cdcb71f47b3..70e44e81f244 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -174,8 +174,10 @@ void ata_scsi_requeue_deferred_qc(struct ata_port *a=
p);
 /* libata-eh.c */
 extern unsigned int ata_internal_cmd_timeout(struct ata_device *dev, u8 =
cmd);
 extern void ata_internal_cmd_timed_out(struct ata_device *dev, u8 cmd);
-extern void ata_eh_acquire(struct ata_port *ap);
-extern void ata_eh_release(struct ata_port *ap);
+extern void ata_eh_acquire(struct ata_port *ap)
+	__acquires(ap->host->eh_mutex);
+extern void ata_eh_release(struct ata_port *ap)
+	__releases(ap->host->eh_mutex);
 extern void ata_scsi_error(struct Scsi_Host *host);
 extern void ata_eh_fastdrain_timerfn(struct timer_list *t);
 extern void ata_qc_schedule_eh(struct ata_port *ap, struct ata_queued_cm=
d *qc);
@@ -189,10 +191,12 @@ extern void ata_eh_autopsy(struct ata_port *ap);
 const char *ata_get_cmd_name(u8 command);
 extern void ata_eh_report(struct ata_port *ap);
 extern int ata_eh_reset(struct ata_link *link, int classify,
-			struct ata_reset_operations *reset_ops);
+			struct ata_reset_operations *reset_ops)
+	__must_hold(&link->ap->host->eh_mutex);
 extern int ata_eh_recover(struct ata_port *ap,
 			  struct ata_reset_operations *reset_ops,
-			  struct ata_link **r_failed_disk);
+			  struct ata_link **r_failed_disk)
+	__must_hold(&ap->host->eh_mutex);
 extern void ata_eh_finish(struct ata_port *ap);
 extern int ata_ering_map(struct ata_ering *ering,
 			 int (*map_fn)(struct ata_ering_entry *, void *),
diff --git a/drivers/ata/pata_arasan_cf.c b/drivers/ata/pata_arasan_cf.c
index a77fefd320c2..e05a4847e037 100644
--- a/drivers/ata/pata_arasan_cf.c
+++ b/drivers/ata/pata_arasan_cf.c
@@ -658,6 +658,7 @@ static void arasan_cf_freeze(struct ata_port *ap)
 }
=20
 static void arasan_cf_error_handler(struct ata_port *ap)
+	__must_hold(&ap->host->eh_mutex)
 {
 	struct arasan_cf_dev *acdev =3D ap->host->private_data;
=20
diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 169cfd85f0e6..8cd65a480010 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -1041,6 +1041,7 @@ static unsigned int sata_dwc_qc_issue(struct ata_qu=
eued_cmd *qc)
 }
=20
 static void sata_dwc_error_handler(struct ata_port *ap)
+	__must_hold(&ap->host->eh_mutex)
 {
 	ata_sff_error_handler(ap);
 }
diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index fc17e0c3e2f9..d05c9603489e 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -1035,6 +1035,7 @@ static int sata_fsl_softreset(struct ata_link *link=
, unsigned int *class,
 }
=20
 static void sata_fsl_error_handler(struct ata_port *ap)
+	__must_hold(&ap->host->eh_mutex)
 {
 	sata_pmp_error_handler(ap);
 }
diff --git a/drivers/ata/sata_inic162x.c b/drivers/ata/sata_inic162x.c
index ccfb863f018f..6ea9fceb8261 100644
--- a/drivers/ata/sata_inic162x.c
+++ b/drivers/ata/sata_inic162x.c
@@ -660,6 +660,7 @@ static int inic_hardreset(struct ata_link *link, unsi=
gned int *class,
 }
=20
 static void inic_error_handler(struct ata_port *ap)
+	__must_hold(&ap->host->eh_mutex)
 {
 	void __iomem *port_base =3D inic_port_base(ap);
=20
diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 84c1abd4d0ac..ea10c12f449c 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -2398,6 +2398,7 @@ static struct ata_queued_cmd *mv_get_active_qc(stru=
ct ata_port *ap)
 }
=20
 static void mv_pmp_error_handler(struct ata_port *ap)
+	__must_hold(&ap->host->eh_mutex)
 {
 	unsigned int pmp, pmp_map;
 	struct mv_port_priv *pp =3D ap->private_data;
diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index 841e7de2bba6..19b927065868 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -1626,6 +1626,7 @@ static void nv_mcp55_thaw(struct ata_port *ap)
 }
=20
 static void nv_adma_error_handler(struct ata_port *ap)
+	__must_hold(&ap->host->eh_mutex)
 {
 	struct nv_adma_port_priv *pp =3D ap->private_data;
 	if (!(pp->flags & NV_ADMA_PORT_REGISTER_MODE)) {
@@ -1795,6 +1796,7 @@ static void nv_swncq_ncq_stop(struct ata_port *ap)
 }
=20
 static void nv_swncq_error_handler(struct ata_port *ap)
+	__must_hold(&ap->host->eh_mutex)
 {
 	struct ata_eh_context *ehc =3D &ap->link.eh_context;
=20
diff --git a/drivers/ata/sata_promise.c b/drivers/ata/sata_promise.c
index 18d1eda69a4a..c980e609b246 100644
--- a/drivers/ata/sata_promise.c
+++ b/drivers/ata/sata_promise.c
@@ -816,6 +816,7 @@ static int pdc_sata_hardreset(struct ata_link *link, =
unsigned int *class,
 }
=20
 static void pdc_error_handler(struct ata_port *ap)
+	__must_hold(&ap->host->eh_mutex)
 {
 	if (!ata_port_is_frozen(ap))
 		pdc_reset_port(ap);
diff --git a/drivers/ata/sata_qstor.c b/drivers/ata/sata_qstor.c
index 9967a5b62643..c682285ea5e5 100644
--- a/drivers/ata/sata_qstor.c
+++ b/drivers/ata/sata_qstor.c
@@ -220,6 +220,7 @@ static int qs_scr_read(struct ata_link *link, unsigne=
d int sc_reg, u32 *val)
 }
=20
 static void qs_error_handler(struct ata_port *ap)
+	__must_hold(&ap->host->eh_mutex)
 {
 	qs_enter_reg_mode(ap);
 	ata_sff_error_handler(ap);
diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index ab27559667b6..9fc7ca6fb7a1 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -1167,6 +1167,7 @@ static irqreturn_t sil24_interrupt(int irq, void *d=
ev_instance)
 }
=20
 static void sil24_error_handler(struct ata_port *ap)
+	__must_hold(&ap->host->eh_mutex)
 {
 	struct sil24_port_priv *pp =3D ap->private_data;
=20
diff --git a/drivers/ata/sata_sx4.c b/drivers/ata/sata_sx4.c
index 607e8c34b813..fce5fed2b3be 100644
--- a/drivers/ata/sata_sx4.c
+++ b/drivers/ata/sata_sx4.c
@@ -853,6 +853,7 @@ static int pdc_softreset(struct ata_link *link, unsig=
ned int *class,
 }
=20
 static void pdc_error_handler(struct ata_port *ap)
+	__must_hold(&ap->host->eh_mutex)
 {
 	if (!ata_port_is_frozen(ap))
 		pdc_reset_port(ap);
diff --git a/drivers/ata/sata_via.c b/drivers/ata/sata_via.c
index 68e9003ec2d4..b672a1e05867 100644
--- a/drivers/ata/sata_via.c
+++ b/drivers/ata/sata_via.c
@@ -573,6 +573,7 @@ static irqreturn_t vt642x_interrupt(int irq, void *de=
v_instance)
 }
=20
 static void vt6421_error_handler(struct ata_port *ap)
+	__must_hold(&ap->host->eh_mutex)
 {
 	struct svia_priv *hpriv =3D ap->host->private_data;
 	struct pci_dev *pdev =3D to_pci_dev(ap->host->dev);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index e953a9c8e660..bf113e66f069 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -983,7 +983,8 @@ struct ata_port_operations {
 	void (*thaw)(struct ata_port *ap);
 	struct ata_reset_operations reset;
 	struct ata_reset_operations pmp_reset;
-	void (*error_handler)(struct ata_port *ap);
+	void (*error_handler)(struct ata_port *ap)
+		__must_hold(&ap->host->eh_mutex);
 	void (*lost_interrupt)(struct ata_port *ap);
 	void (*post_internal_cmd)(struct ata_queued_cmd *qc);
 	void (*sched_eh)(struct ata_port *ap);
@@ -1418,8 +1419,10 @@ extern void ata_eh_thaw_port(struct ata_port *ap);
 extern void ata_eh_qc_complete(struct ata_queued_cmd *qc);
 extern void ata_eh_qc_retry(struct ata_queued_cmd *qc);
=20
-extern void ata_std_error_handler(struct ata_port *ap);
-extern void ata_std_sched_eh(struct ata_port *ap);
+extern void ata_std_error_handler(struct ata_port *ap)
+	__must_hold(&ap->host->eh_mutex);
+extern void ata_std_sched_eh(struct ata_port *ap)
+	__must_hold(ap->lock);
 extern void ata_std_end_eh(struct ata_port *ap);
 extern int ata_link_nr_enabled(struct ata_link *link);
=20
@@ -1998,7 +2001,8 @@ extern void ata_timing_merge(const struct ata_timin=
g *,
 extern const struct ata_port_operations sata_pmp_port_ops;
=20
 extern int sata_pmp_qc_defer_cmd_switch(struct ata_queued_cmd *qc);
-extern void sata_pmp_error_handler(struct ata_port *ap);
+extern void sata_pmp_error_handler(struct ata_port *ap)
+	__must_hold(&ap->host->eh_mutex);
=20
 #else /* CONFIG_SATA_PMP */
=20
@@ -2062,7 +2066,8 @@ extern int sata_sff_hardreset(struct ata_link *link=
, unsigned int *class,
 			       unsigned long deadline);
 extern void ata_sff_postreset(struct ata_link *link, unsigned int *class=
es);
 extern void ata_sff_drain_fifo(struct ata_queued_cmd *qc);
-extern void ata_sff_error_handler(struct ata_port *ap);
+extern void ata_sff_error_handler(struct ata_port *ap)
+	__must_hold(&ap->host->eh_mutex);
 extern void ata_sff_std_ports(struct ata_ioports *ioaddr);
 #ifdef CONFIG_PCI
 extern int ata_pci_sff_init_host(struct ata_host *host);
@@ -2092,7 +2097,8 @@ extern enum ata_completion_errors ata_bmdma_dumb_qc=
_prep(struct ata_queued_cmd *
 extern unsigned int ata_bmdma_port_intr(struct ata_port *ap,
 				      struct ata_queued_cmd *qc);
 extern irqreturn_t ata_bmdma_interrupt(int irq, void *dev_instance);
-extern void ata_bmdma_error_handler(struct ata_port *ap);
+extern void ata_bmdma_error_handler(struct ata_port *ap)
+	__must_hold(&ap->host->eh_mutex);
 extern void ata_bmdma_post_internal_cmd(struct ata_queued_cmd *qc);
 extern void ata_bmdma_irq_clear(struct ata_port *ap);
 extern void ata_bmdma_setup(struct ata_queued_cmd *qc);
