Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C5D397699
	for <linux-ide@vger.kernel.org>; Fri, 29 May 2026 18:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780077834; cv=none; b=fXZ+h1Y02koXr+ZMwF162K1MLCIVE1+rAPEp+E38rMIIu8tf4/MIGY0uuzJtzXXHUXZJ+C83aVp0vZrnUkLmRZXxFaJaFb7rVnQ9s4Ncp0v3myyumjwoh+DyYw/VuiAcF4fVO8Z23U9Y/4LF5l0y4gPE72T/QBE7kYXYJ6vVhVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780077834; c=relaxed/simple;
	bh=k0B9EOF7lTAYR0bXjhXdB3MGfkdwJyegnXBkvFhb8dE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E27oaLPCaiU5yWaZUI1JnnfbWxyXLLabQazk8+Orb6MD11tYHrZZL89AzlwNyrwtByDl9VRqoNSeJeF8DaE4aSJvHjh71tjg02ZBfXW/BQqXZ01p5KJU+9Y8PTcxk6Zy7nCmMqF1LAGR3+YgWtE34JBmZvlGXc/RIJC8WiK1o6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=1cqPo1v1; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="1cqPo1v1"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gRrp05M9tzlfgPv;
	Fri, 29 May 2026 18:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1780077810; x=1782669811; bh=S2Yz7
	rsM0zQOGEvY8m5dU9upLIK3U5I1ASJniskS1ro=; b=1cqPo1v12J6DRTsEWieQl
	1whG6GrubxN8HH7WKB3PTwBZtX5Iq9Z4ooehaTTKDz/b/sCwjnmdIsJgQrfe+JPp
	vabUoRJRTn1wHoJJQl7Sva7E7Ram07v762OpZJZus44U0iCv/9DJogVZYnTfxtp4
	zmfr4v4Y1S/w1CUXoYe5ii2D0TZm2DraXD9YhERKNKRwaWNKnmS0H9zk4oQ7l7pD
	MiIKlxn91o3ne9Ac4O48b0V1drCwF68xjT6iQmR6Z2pU1nTuk2Gfu04JBxKTTosT
	tmF+OgijrmbhUmvfGT+BLInV+1RjHEg8i9Hkn3Nq22vBeliXKEx3AeCW2aYjCtzs
	w==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id BXC62azaLSgc; Fri, 29 May 2026 18:03:30 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gRrnW6VtQzlh2rN;
	Fri, 29 May 2026 18:03:27 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Hannes Reinecke <hare@suse.com>,
	Marco Elver <elver@google.com>,
	linux-ide@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Viresh Kumar <vireshk@kernel.org>,
	Mikael Pettersson <mikpelinux@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v5 2/2] ata: libata: Document when host->eh_mutex should be held
Date: Fri, 29 May 2026 11:03:10 -0700
Message-ID: <d59f518d4de1d606862e388c48c58f19784a25fb.1780077008.git.bvanassche@acm.org>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
In-Reply-To: <cover.1780077008.git.bvanassche@acm.org>
References: <cover.1780077008.git.bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Annotate the following functions with __must_hold(&host->eh_mutex):
 * All ata_port_operations.error_handler() implementations.
 * ata_eh_reset() and ata_eh_recover() because these functions call
   ata_eh_release() and ata_eh_acquire().
 * All callers of ata_eh_reset() and ata_eh_recover().

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
 drivers/ata/libahci.c        |  1 +
 drivers/ata/libata-core.c    |  2 ++
 drivers/ata/libata-eh.c      |  5 +++++
 drivers/ata/libata-pmp.c     |  3 +++
 drivers/ata/libata-sff.c     |  2 ++
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
 include/linux/libata.h       | 15 ++++++++++-----
 21 files changed, 48 insertions(+), 10 deletions(-)

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
diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index e0af4b5716b3..6d72eb017b49 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -2208,6 +2208,7 @@ static void ahci_thaw(struct ata_port *ap)
 }
=20
 void ahci_error_handler(struct ata_port *ap)
+	__must_hold(&ap->host->eh_mutex)
 {
 	struct ahci_host_priv *hpriv =3D ap->host->private_data;
=20
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 3d25dec6ac6c..e9ebcfe20fc4 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6832,6 +6832,7 @@ EXPORT_SYMBOL_GPL(ata_ratelimit);
  *	Might sleep.
  */
 void ata_msleep(struct ata_port *ap, unsigned int msecs)
+	__context_unsafe(conditional locking)
 {
 	bool owns_eh =3D ap && ap->host->eh_owner =3D=3D current;
=20
@@ -6906,6 +6907,7 @@ static unsigned int ata_dummy_qc_issue(struct ata_q=
ueued_cmd *qc)
 }
=20
 static void ata_dummy_error_handler(struct ata_port *ap)
+	__must_hold(&ap->host->eh_mutex)
 {
 	/* truly dummy */
 }
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index e331812ae0db..a66663d3579e 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -469,6 +469,7 @@ static void ata_eh_clear_action(struct ata_link *link=
, struct ata_device *dev,
  *	EH context.
  */
 void ata_eh_acquire(struct ata_port *ap)
+	__acquires(&ap->host->eh_mutex)
 {
 	mutex_lock(&ap->host->eh_mutex);
 	WARN_ON_ONCE(ap->host->eh_owner);
@@ -486,6 +487,7 @@ void ata_eh_acquire(struct ata_port *ap)
  *	EH context.
  */
 void ata_eh_release(struct ata_port *ap)
+	__releases(&ap->host->eh_mutex)
 {
 	WARN_ON_ONCE(ap->host->eh_owner !=3D current);
 	ap->host->eh_owner =3D NULL;
@@ -2833,6 +2835,7 @@ static bool ata_eh_followup_srst_needed(struct ata_=
link *link, int rc)
=20
 int ata_eh_reset(struct ata_port *ap, struct ata_link *link, int classif=
y,
 		 struct ata_reset_operations *reset_ops)
+	__must_hold(&ap->host->eh_mutex)
 {
 	struct ata_link *slave =3D ap->slave_link;
 	struct ata_eh_context *ehc =3D &link->eh_context;
@@ -3815,6 +3818,7 @@ static int ata_eh_handle_dev_fail(struct ata_device=
 *dev, int err)
  */
 int ata_eh_recover(struct ata_port *ap, struct ata_reset_operations *res=
et_ops,
 		   struct ata_link **r_failed_link)
+	__must_hold(&ap->host->eh_mutex)
 {
 	struct ata_link *link;
 	struct ata_device *dev;
@@ -4112,6 +4116,7 @@ void ata_eh_finish(struct ata_port *ap)
  *	Kernel thread context (may sleep).
  */
 void ata_std_error_handler(struct ata_port *ap)
+	__must_hold(&ap->host->eh_mutex)
 {
 	struct ata_reset_operations *reset_ops =3D &ap->ops->reset;
 	struct ata_link *link =3D &ap->link;
diff --git a/drivers/ata/libata-pmp.c b/drivers/ata/libata-pmp.c
index 32fe7b60de24..188fc12c2704 100644
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
@@ -907,6 +908,7 @@ static int sata_pmp_handle_link_fail(struct ata_link =
*link, int *link_tries)
  *	0 on success, -errno on failure.
  */
 static int sata_pmp_eh_recover(struct ata_port *ap)
+	__must_hold(&ap->host->eh_mutex)
 {
 	struct ata_port_operations *ops =3D ap->ops;
 	int pmp_tries, link_tries[SATA_PMP_MAX_PORTS];
@@ -1084,6 +1086,7 @@ static int sata_pmp_eh_recover(struct ata_port *ap)
  *	Kernel thread context (may sleep).
  */
 void sata_pmp_error_handler(struct ata_port *ap)
+	__must_hold(&ap->host->eh_mutex)
 {
 	ata_eh_autopsy(ap);
 	ata_eh_report(ap);
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 785b6e371abf..734e7c88439a 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -2053,6 +2053,7 @@ EXPORT_SYMBOL_GPL(ata_sff_drain_fifo);
  *	Kernel thread context (may sleep)
  */
 void ata_sff_error_handler(struct ata_port *ap)
+	__must_hold(&ap->host->eh_mutex)
 {
 	struct ata_queued_cmd *qc;
 	unsigned long flags;
@@ -2769,6 +2770,7 @@ EXPORT_SYMBOL_GPL(ata_bmdma_interrupt);
  *	Kernel thread context (may sleep)
  */
 void ata_bmdma_error_handler(struct ata_port *ap)
+	__must_hold(&ap->host->eh_mutex)
 {
 	struct ata_queued_cmd *qc;
 	unsigned long flags;
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index a5920c10aaca..d0b0ecd3d086 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -173,8 +173,10 @@ void ata_scsi_requeue_deferred_qc(struct ata_port *a=
p);
 /* libata-eh.c */
 extern unsigned int ata_internal_cmd_timeout(struct ata_device *dev, u8 =
cmd);
 extern void ata_internal_cmd_timed_out(struct ata_device *dev, u8 cmd);
-extern void ata_eh_acquire(struct ata_port *ap);
-extern void ata_eh_release(struct ata_port *ap);
+extern void ata_eh_acquire(struct ata_port *ap)
+	__acquires(&ap->host->eh_mutex);
+extern void ata_eh_release(struct ata_port *ap)
+	__releases(&ap->host->eh_mutex);
 extern void ata_scsi_error(struct Scsi_Host *host);
 extern void ata_eh_fastdrain_timerfn(struct timer_list *t);
 extern void ata_qc_schedule_eh(struct ata_queued_cmd *qc);
@@ -188,10 +190,12 @@ extern void ata_eh_autopsy(struct ata_port *ap);
 const char *ata_get_cmd_name(u8 command);
 extern void ata_eh_report(struct ata_port *ap);
 extern int ata_eh_reset(struct ata_port *ap, struct ata_link *link,
-			int classify, struct ata_reset_operations *reset_ops);
+			int classify, struct ata_reset_operations *reset_ops)
+	__must_hold(&ap->host->eh_mutex);
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
index 64cb544903d8..4fc22ce4bd9a 100644
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
index be829fcc584d..70b210afd291 100644
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
index 46a8c20daf18..065408975f5b 100644
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
index ffb396f61731..f6942fd80bae 100644
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
index 2a005aede123..c5fad448bafc 100644
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
index cfb9b5b61cd7..1add7a7d5ff6 100644
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
index d642ece9f07a..89a10704e98e 100644
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
index 0986ebd1eb4e..227dc1d4e85b 100644
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
index 5c085ef4eda7..5f6bbe5d504f 100644
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
@@ -1418,7 +1419,8 @@ extern void ata_eh_thaw_port(struct ata_port *ap);
 extern void ata_eh_qc_complete(struct ata_queued_cmd *qc);
 extern void ata_eh_qc_retry(struct ata_queued_cmd *qc);
=20
-extern void ata_std_error_handler(struct ata_port *ap);
+extern void ata_std_error_handler(struct ata_port *ap)
+	__must_hold(&ap->host->eh_mutex);
 extern void ata_std_sched_eh(struct ata_port *ap);
 extern void ata_std_end_eh(struct ata_port *ap);
 extern int ata_link_nr_enabled(struct ata_link *link);
@@ -1998,7 +2000,8 @@ extern void ata_timing_merge(const struct ata_timin=
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
@@ -2062,7 +2065,8 @@ extern int sata_sff_hardreset(struct ata_link *link=
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
@@ -2092,7 +2096,8 @@ extern enum ata_completion_errors ata_bmdma_dumb_qc=
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
