Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6683AE712
	for <linux-ide@vger.kernel.org>; Tue,  5 May 2026 04:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777954976; cv=none; b=l/fz+Suzrg+JMBkxmbO/MztwKbhAoLTWsQ7zWyTR7i4HopiFWcd0P5cK+OrmPZ9sr4kE/c4D8+fjuQ1AxFjEFW9ozOcnZyBOobIupLvvUMteersflFE/1OQwvw/owADNqJuzsvQKtVnV30ZofJhpkqkuK3qYNTXufnXC40grvrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777954976; c=relaxed/simple;
	bh=QBubOZagBEBoLIZoIpDMB6KkzDmopsvIe1lzD3nw6LM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jeWOkT0CpCWmD2hLARC1DJN5NjT/1EuQiS0JD83zWKXHVxGlrmI+EpKHTUKgiTY4i2gPV4Tvps/ImD7er23WaBtWJHNWqrAXfXT9rYj/CG287bmSZhxSr3/CxO/AJ6bJXkcRYUEsYIfGsu9OqMn3XE9coBjqps+fMupggdOP4AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=M6QihKr1; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="M6QihKr1"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4g8ljh0t10z1XM6JG;
	Tue,  5 May 2026 04:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1777954960; x=1780546961; bh=Tl69rZcP+FvkZAkAQTdfaIMlAB/QRPZP2AH
	Kk8vbSgI=; b=M6QihKr19gpthvNDc2adGuDwu2lF2wT87BwDUmy8mP2HIDgNDVN
	TBlnVIzwk/GCvqahzefeQZ1s98j1yqGv2DY9/S/0Vvzplg9oRhKJ9Y/RIUZY165d
	TtY7BufLnzsOWmjGNATWrU2Tbn0dPqAuBN8p7Ayx/P41/5SjT10W/nJ8n07d7lpW
	Foex4TRlzXAhTF5G3UbP4hJz6ETg0Dyr+CC/Y6bCRL2XIp1URI47BDBNfW0sx6n9
	zH7DyUDFfbD/dgNtDOdEvxITY3qfFaDXfCcnY1VZM+VVdvucj/RjxU63CadBSk0u
	jSp3OkgYZhk9ycdTddBFNRYbaJxpcgOSsgw==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id nWXb4F6MOKtK; Tue,  5 May 2026 04:22:40 +0000 (UTC)
Received: from bvanassche-glaptop2.roam.corp.google.com (unknown [213.147.98.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4g8ljV0K8Cz1XM5kD;
	Tue,  5 May 2026 04:22:37 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>,
	Marco Elver <elver@google.com>,
	linux-ide@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH] ata: libata-core: Enable context analysis
Date: Tue,  5 May 2026 06:22:27 +0200
Message-ID: <20260505042227.909666-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
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

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/ata/Makefile      |  2 ++
 drivers/ata/libata-core.c | 28 ++++++++++++++++++++++++++++
 drivers/ata/libata-eh.c   |  6 ++++++
 drivers/ata/libata.h      |  6 ++++--
 4 files changed, 40 insertions(+), 2 deletions(-)

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
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index e76d15411e2a..ecdd6310236b 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1537,6 +1537,7 @@ unsigned int ata_exec_internal(struct ata_device *d=
ev, struct ata_taskfile *tf,
 			       const u8 *cdb, enum dma_data_direction dma_dir,
 			       void *buf, unsigned int buflen,
 			       unsigned int timeout)
+	__must_hold(&dev->link->ap->host->eh_mutex)
 {
 	struct ata_link *link =3D dev->link;
 	struct ata_port *ap =3D link->ap;
@@ -1747,6 +1748,7 @@ static u32 ata_pio_mask_no_iordy(const struct ata_d=
evice *adev)
  */
 unsigned int ata_do_dev_read_id(struct ata_device *dev,
 				struct ata_taskfile *tf, __le16 *id)
+	__must_hold(&dev->link->ap->host->eh_mutex)
 {
 	return ata_exec_internal(dev, tf, NULL, DMA_FROM_DEVICE,
 				     id, sizeof(id[0]) * ATA_ID_WORDS, 0);
@@ -1776,6 +1778,7 @@ EXPORT_SYMBOL_GPL(ata_do_dev_read_id);
  */
 int ata_dev_read_id(struct ata_device *dev, unsigned int *p_class,
 		    unsigned int flags, u16 *id)
+	__must_hold(&dev->link->ap->host->eh_mutex)
 {
 	struct ata_port *ap =3D dev->link->ap;
 	unsigned int class =3D *p_class;
@@ -1990,6 +1993,7 @@ bool ata_dev_power_init_tf(struct ata_device *dev, =
struct ata_taskfile *tf,
 }
=20
 static bool ata_dev_power_is_active(struct ata_device *dev)
+	__must_hold(&dev->link->ap->host->eh_mutex)
 {
 	struct ata_taskfile tf;
 	unsigned int err_mask;
@@ -2027,6 +2031,7 @@ static bool ata_dev_power_is_active(struct ata_devi=
ce *dev)
  *	Kernel thread context (may sleep).
  */
 void ata_dev_power_set_standby(struct ata_device *dev)
+	__must_hold(&dev->link->ap->host->eh_mutex)
 {
 	unsigned long ap_flags =3D dev->link->ap->flags;
 	struct ata_taskfile tf;
@@ -2074,6 +2079,7 @@ void ata_dev_power_set_standby(struct ata_device *d=
ev)
  *	Kernel thread context (may sleep).
  */
 void ata_dev_power_set_active(struct ata_device *dev)
+	__must_hold(&dev->link->ap->host->eh_mutex)
 {
 	struct ata_taskfile tf;
 	unsigned int err_mask;
@@ -2118,6 +2124,7 @@ void ata_dev_power_set_active(struct ata_device *de=
v)
  */
 unsigned int ata_read_log_page(struct ata_device *dev, u8 log,
 			       u8 page, void *buf, unsigned int sectors)
+	__must_hold(&dev->link->ap->host->eh_mutex)
 {
 	unsigned long ap_flags =3D dev->link->ap->flags;
 	struct ata_taskfile tf;
@@ -2174,6 +2181,7 @@ static inline void ata_clear_log_directory(struct a=
ta_device *dev)
 }
=20
 static int ata_read_log_directory(struct ata_device *dev)
+	__must_hold(&dev->link->ap->host->eh_mutex)
 {
 	u16 version;
=20
@@ -2197,6 +2205,7 @@ static int ata_read_log_directory(struct ata_device=
 *dev)
 }
=20
 static int ata_log_supported(struct ata_device *dev, u8 log)
+	__must_hold(&dev->link->ap->host->eh_mutex)
 {
 	if (dev->quirks & ATA_QUIRK_NO_LOG_DIR)
 		return 0;
@@ -2208,6 +2217,7 @@ static int ata_log_supported(struct ata_device *dev=
, u8 log)
 }
=20
 static bool ata_identify_page_supported(struct ata_device *dev, u8 page)
+	__must_hold(&dev->link->ap->host->eh_mutex)
 {
 	unsigned int err, i;
=20
@@ -2288,6 +2298,7 @@ static inline bool ata_dev_knobble(struct ata_devic=
e *dev)
 }
=20
 static void ata_dev_config_ncq_send_recv(struct ata_device *dev)
+	__must_hold(&dev->link->ap->host->eh_mutex)
 {
 	unsigned int err_mask;
=20
@@ -2312,6 +2323,7 @@ static void ata_dev_config_ncq_send_recv(struct ata=
_device *dev)
 }
=20
 static void ata_dev_config_ncq_non_data(struct ata_device *dev)
+	__must_hold(&dev->link->ap->host->eh_mutex)
 {
 	unsigned int err_mask;
=20
@@ -2328,6 +2340,7 @@ static void ata_dev_config_ncq_non_data(struct ata_=
device *dev)
 }
=20
 static void ata_dev_config_ncq_prio(struct ata_device *dev)
+	__must_hold(&dev->link->ap->host->eh_mutex)
 {
 	unsigned int err_mask;
=20
@@ -2392,6 +2405,7 @@ bool ata_adapter_is_online(struct ata_port *ap)
=20
 static int ata_dev_config_ncq(struct ata_device *dev,
 			       char *desc, size_t desc_sz)
+	__must_hold(&dev->link->ap->host->eh_mutex)
 {
 	struct ata_port *ap =3D dev->link->ap;
 	int hdepth =3D 0, ddepth =3D ata_id_queue_depth(dev->id);
@@ -2474,6 +2488,7 @@ static void ata_dev_config_sense_reporting(struct a=
ta_device *dev)
 }
=20
 static void ata_dev_config_zac(struct ata_device *dev)
+	__must_hold(&dev->link->ap->host->eh_mutex)
 {
 	unsigned int err_mask;
 	u8 *identify_buf =3D dev->sector_buf;
@@ -2516,6 +2531,7 @@ static void ata_dev_config_zac(struct ata_device *d=
ev)
 }
=20
 static void ata_dev_config_trusted(struct ata_device *dev)
+	__must_hold(&dev->link->ap->host->eh_mutex)
 {
 	u64 trusted_cap;
 	unsigned int err;
@@ -2552,6 +2568,7 @@ static void ata_dev_cleanup_cdl_resources(struct at=
a_device *dev)
 }
=20
 static int ata_dev_init_cdl_resources(struct ata_device *dev)
+	__must_hold(&dev->link->ap->host->eh_mutex)
 {
 	struct ata_cdl *cdl =3D dev->cdl;
 	unsigned int err_mask;
@@ -2575,6 +2592,7 @@ static int ata_dev_init_cdl_resources(struct ata_de=
vice *dev)
 }
=20
 static void ata_dev_config_cdl(struct ata_device *dev)
+	__must_hold(&dev->link->ap->host->eh_mutex)
 {
 	unsigned int err_mask;
 	bool cdl_enabled;
@@ -2691,6 +2709,7 @@ static void ata_dev_config_cdl(struct ata_device *d=
ev)
 }
=20
 static int ata_dev_config_lba(struct ata_device *dev)
+	__must_hold(&dev->link->ap->host->eh_mutex)
 {
 	const u16 *id =3D dev->id;
 	const char *lba_desc;
@@ -2770,6 +2789,7 @@ static void ata_dev_config_fua(struct ata_device *d=
ev)
 }
=20
 static void ata_dev_config_devslp(struct ata_device *dev)
+	__must_hold(&dev->link->ap->host->eh_mutex)
 {
 	u8 *sata_setting =3D dev->sector_buf;
 	unsigned int err_mask;
@@ -2798,6 +2818,7 @@ static void ata_dev_config_devslp(struct ata_device=
 *dev)
 }
=20
 static void ata_dev_config_cpr(struct ata_device *dev)
+	__must_hold(&dev->link->ap->host->eh_mutex)
 {
 	unsigned int err_mask;
 	size_t buf_len;
@@ -2936,6 +2957,7 @@ static void ata_dev_print_features(struct ata_devic=
e *dev)
  *	0 on success, -errno otherwise
  */
 int ata_dev_configure(struct ata_device *dev)
+	__must_hold(&dev->link->ap->host->eh_mutex)
 {
 	struct ata_port *ap =3D dev->link->ap;
 	bool print_info =3D ata_dev_print_info(dev);
@@ -3896,6 +3918,7 @@ static int ata_dev_same_device(struct ata_device *d=
ev, unsigned int new_class,
  *	0 on success, negative errno otherwise
  */
 int ata_dev_reread_id(struct ata_device *dev, unsigned int readid_flags)
+	__must_hold(&dev->link->ap->host->eh_mutex)
 {
 	unsigned int class =3D dev->class;
 	u16 *id =3D (void *)dev->sector_buf;
@@ -3931,6 +3954,7 @@ int ata_dev_reread_id(struct ata_device *dev, unsig=
ned int readid_flags)
  */
 int ata_dev_revalidate(struct ata_device *dev, unsigned int new_class,
 		       unsigned int readid_flags)
+	__must_hold(&dev->link->ap->host->eh_mutex)
 {
 	u64 n_sectors =3D dev->n_sectors;
 	u64 n_native_sectors =3D dev->n_native_sectors;
@@ -4631,6 +4655,7 @@ static void ata_dev_xfermask(struct ata_device *dev=
)
  */
=20
 static unsigned int ata_dev_set_xfermode(struct ata_device *dev)
+	__must_hold(&dev->link->ap->host->eh_mutex)
 {
 	struct ata_taskfile tf;
=20
@@ -4676,6 +4701,7 @@ static unsigned int ata_dev_set_xfermode(struct ata=
_device *dev)
  *	0 on success, AC_ERR_* mask otherwise.
  */
 unsigned int ata_dev_set_feature(struct ata_device *dev, u8 subcmd, u8 a=
ction)
+	__must_hold(&dev->link->ap->host->eh_mutex)
 {
 	struct ata_taskfile tf;
 	unsigned int timeout =3D 0;
@@ -4712,6 +4738,7 @@ EXPORT_SYMBOL_GPL(ata_dev_set_feature);
  */
 static unsigned int ata_dev_init_params(struct ata_device *dev,
 					u16 heads, u16 sectors)
+	__must_hold(&dev->link->ap->host->eh_mutex)
 {
 	struct ata_taskfile tf;
 	unsigned int err_mask;
@@ -6817,6 +6844,7 @@ EXPORT_SYMBOL_GPL(ata_ratelimit);
  *	Might sleep.
  */
 void ata_msleep(struct ata_port *ap, unsigned int msecs)
+	__context_unsafe(conditional locking)
 {
 	bool owns_eh =3D ap && ap->host->eh_owner =3D=3D current;
=20
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 9a4b67b90b17..093af027c99b 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2833,6 +2833,7 @@ static bool ata_eh_followup_srst_needed(struct ata_=
link *link, int rc)
=20
 int ata_eh_reset(struct ata_link *link, int classify,
 		 struct ata_reset_operations *reset_ops)
+	__must_hold(&link->ap->host->eh_mutex)
 {
 	struct ata_port *ap =3D link->ap;
 	struct ata_link *slave =3D ap->slave_link;
@@ -3816,6 +3817,7 @@ static int ata_eh_handle_dev_fail(struct ata_device=
 *dev, int err)
  */
 int ata_eh_recover(struct ata_port *ap, struct ata_reset_operations *res=
et_ops,
 		   struct ata_link **r_failed_link)
+	__must_hold(&ap->host->eh_mutex)
 {
 	struct ata_link *link;
 	struct ata_device *dev;
@@ -3879,6 +3881,9 @@ int ata_eh_recover(struct ata_port *ap, struct ata_=
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
@@ -4112,6 +4117,7 @@ void ata_eh_finish(struct ata_port *ap)
  *	Kernel thread context (may sleep).
  */
 void ata_std_error_handler(struct ata_port *ap)
+	__must_hold(&ap->host->eh_mutex)
 {
 	struct ata_reset_operations *reset_ops =3D &ap->ops->reset;
 	struct ata_link *link =3D &ap->link;
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index b5423b6e97de..f58bb591b3fa 100644
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
+	__acquires(ap->host->eh_mutex);
+extern void ata_eh_release(struct ata_port *ap)
+	__releases(ap->host->eh_mutex);
 extern void ata_scsi_error(struct Scsi_Host *host);
 extern void ata_eh_fastdrain_timerfn(struct timer_list *t);
 extern void ata_qc_schedule_eh(struct ata_queued_cmd *qc);
