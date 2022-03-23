Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC36DC433F5
	for <linux-ide@archiver.kernel.org>; Wed, 23 Mar 2022 08:19:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242584AbiCWIVF (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 23 Mar 2022 04:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242576AbiCWIUz (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 23 Mar 2022 04:20:55 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0123E5EDD2
        for <linux-ide@vger.kernel.org>; Wed, 23 Mar 2022 01:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648023563; x=1679559563;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=B8TYeHAp0j3AZlA/STOL4yQI1w21+ola/hye7BV8YCk=;
  b=hkxHlf9oRRRhlfmHjnPgHU4KgKBfufpKU86UkTlQSRLQ/L9Bvi8t0pUp
   B9AJZDKckFLOJj/8OvQ/p36YYsjzC06zPheLIgiBkb16SXLuW0wNh9Is/
   mzvDshfZ3hErC+DgHVHCf50UhGNkjOwltpRbPRnLm/R7ABnwxLTkDfwMT
   1nVbfPNC/ronFGfLgLHhtZjAGOzdyo76mVniPovnvA98vYofvZBYxgnGt
   2MtyeyIJE1MUQI/HBBwxG2x+T5VJ+MpzScmx1yTSfuMvYhNOA3VB3w90T
   NqwPlqzB0mt06b27I0JQ3ptABtPigqFKjGQdPnqghcOdPE3SVomLqpWI5
   g==;
X-IronPort-AV: E=Sophos;i="5.90,203,1643644800"; 
   d="scan'208";a="196047607"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Mar 2022 16:19:22 +0800
IronPort-SDR: nuOpeuBp7x3vX3fwavdfYLRGTXfswwJGtoUif+wbJLvTehZQ484yi+ynWvLcXnwLk0QtUVU+cQ
 6SzzD0Y8f/keUi7NLMO7t5XeImfkSMUAos3/EjL4okeGvTPle0NVLIHw99hzzjRbP5Q9I+A0Mq
 u18wqVTIWaEjb5I5P04n1dZpj3Kakuu0V4dOVY5TJCUhKivym70qqoIMCMbNhhlzSEZ8lFNjH0
 3/P7TqmdZg+aYIUDe7iO6k2fit3B9p7+ozhjXGchidIXyZTwSAMII+znaq+e+TJktmvTWccxCq
 kNAUa8Q4SyoCggWyOull/sE0
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 00:51:18 -0700
IronPort-SDR: e8RSxH/QBAhZI/MgPLzramlEsmGqqI9uvZdsv8IjVqnhpS2V73+9icV0wVMmdIu1yKiUdtpWua
 yFlL6VnUKtAyhwttz2fnkIFJ7yFo8B6ePQnjB9IEgKF2s3ZH1A6lgM6YUPU5UZVfY+yu15dkxe
 0cT8zN8uw0aYESougX9sCmweqbceyD2hLYZQgHdHRQzbtMhqr1OUh+bFHPGFPU+9UyKm5lT9Ll
 Z6SZBfls2qHcQ0u7vc/5idSRlRf/mlHBB7x+jzoHVXXMyuxsU1zopcWDlXVPrtg0TXXHrXffhp
 XIQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 01:19:24 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KNh8r1Znqz1SVnx
        for <linux-ide@vger.kernel.org>; Wed, 23 Mar 2022 01:19:24 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1648023563; x=1650615564; bh=B8TYeHAp0j3AZlA/ST
        OL4yQI1w21+ola/hye7BV8YCk=; b=Rj+GM+I7iyYmY9a4OdnLUz/LxqoJW4rRu0
        zdrQPFz1/y2T03Vwu9Sn8P07Aw/MpiC08cX09cT3b8Z0Oq0ncNDm/8oVl87/FpfF
        uLJ20LxyGJFgtU/DuAHQlUL9cNGDmr32uAgPne8t+wJQC+8ph8lzkSP3zIljq994
        026eZk2disFQaW8ZnLHE3GAJUJmuxitfsF8154HsV4Dloh2nE5xJxSmjMTsVwcLp
        g8rGRgKckKqVGgjB09zDil5nuQvxEcEr9h3mcJQxbL9wa+oUXtB3IjEDleIKx+EQ
        +/WZN2agcvUTO2+HNShL8OIvYkhh2EDi2MNIdylWGDBuM6H/c1wg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id C_ZEiB6jpYlF for <linux-ide@vger.kernel.org>;
        Wed, 23 Mar 2022 01:19:23 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KNh8q1KnCz1Rvlx;
        Wed, 23 Mar 2022 01:19:23 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH 2/4] ata: libata-sata: Introduce struct sata_deb_timing
Date:   Wed, 23 Mar 2022 17:17:38 +0900
Message-Id: <20220323081740.540006-3-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220323081740.540006-1-damien.lemoal@opensource.wdc.com>
References: <20220323081740.540006-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The SATA interval, duration and timeout debounce timing parameters
(sata_deb_timing_normal, sata_deb_timing_hotplug and
sata_deb_timing_long) are defined as an array of 3 unsigned long
integers. The entries are referenced directly without any index macro
indicating the name of the field being accessed.

Introduce struct sata_deb_timing to more clearly define the values and
their use. The interface of the sata_ehc_deb_timing(),
sata_link_hardreset() and sata_link_debounce() functions is modified to
take this new structure as argument.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/ata/ahci.c          |  7 +++---
 drivers/ata/ahci_qoriq.c    |  5 ++--
 drivers/ata/ahci_xgene.c    |  3 ++-
 drivers/ata/libahci.c       |  5 ++--
 drivers/ata/libata-core.c   |  5 ++--
 drivers/ata/libata-pmp.c    |  2 +-
 drivers/ata/libata-sata.c   | 47 ++++++++++++++++++++++++++-----------
 drivers/ata/libata-sff.c    |  6 ++---
 drivers/ata/sata_highbank.c |  4 ++--
 drivers/ata/sata_mv.c       |  8 +++----
 drivers/ata/sata_nv.c       |  2 +-
 drivers/ata/sata_sil24.c    |  2 +-
 include/linux/libata.h      | 38 +++++++++++++++++++-----------
 13 files changed, 80 insertions(+), 54 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 84456c05e845..ccf94e8a3056 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -787,7 +787,6 @@ static int ahci_p5wdh_hardreset(struct ata_link *link=
, unsigned int *class,
 static int ahci_avn_hardreset(struct ata_link *link, unsigned int *class=
,
 			      unsigned long deadline)
 {
-	const unsigned long *timing =3D sata_ehc_deb_timing(&link->eh_context);
 	struct ata_port *ap =3D link->ap;
 	struct ahci_port_priv *pp =3D ap->private_data;
 	struct ahci_host_priv *hpriv =3D ap->host->private_data;
@@ -811,8 +810,10 @@ static int ahci_avn_hardreset(struct ata_link *link,=
 unsigned int *class,
 		tf.status =3D ATA_BUSY;
 		ata_tf_to_fis(&tf, 0, 0, d2h_fis);
=20
-		rc =3D sata_link_hardreset(link, timing, deadline, &online,
-				ahci_check_ready);
+		rc =3D sata_link_hardreset(link,
+					 sata_ehc_deb_timing(&link->eh_context),
+					 deadline, &online,
+					 ahci_check_ready);
=20
 		if (sata_scr_read(link, SCR_STATUS, &sstatus) !=3D 0 ||
 				(sstatus & 0xf) !=3D 1)
diff --git a/drivers/ata/ahci_qoriq.c b/drivers/ata/ahci_qoriq.c
index 6cd61842ad48..a5eeedadf0c9 100644
--- a/drivers/ata/ahci_qoriq.c
+++ b/drivers/ata/ahci_qoriq.c
@@ -90,7 +90,6 @@ MODULE_DEVICE_TABLE(acpi, ahci_qoriq_acpi_match);
 static int ahci_qoriq_hardreset(struct ata_link *link, unsigned int *cla=
ss,
 			  unsigned long deadline)
 {
-	const unsigned long *timing =3D sata_ehc_deb_timing(&link->eh_context);
 	void __iomem *port_mmio =3D ahci_port_base(link->ap);
 	u32 px_cmd, px_is, px_val;
 	struct ata_port *ap =3D link->ap;
@@ -126,8 +125,8 @@ static int ahci_qoriq_hardreset(struct ata_link *link=
, unsigned int *class,
 	tf.status =3D ATA_BUSY;
 	ata_tf_to_fis(&tf, 0, 0, d2h_fis);
=20
-	rc =3D sata_link_hardreset(link, timing, deadline, &online,
-				 ahci_check_ready);
+	rc =3D sata_link_hardreset(link, sata_ehc_deb_timing(&link->eh_context)=
,
+				 deadline, &online, ahci_check_ready);
=20
 	/* restore the PxCMD and PxIS on ls1021 */
 	if (ls1021a_workaround) {
diff --git a/drivers/ata/ahci_xgene.c b/drivers/ata/ahci_xgene.c
index 7bb5db17f864..8d1598232e92 100644
--- a/drivers/ata/ahci_xgene.c
+++ b/drivers/ata/ahci_xgene.c
@@ -350,7 +350,8 @@ static void xgene_ahci_set_phy_cfg(struct xgene_ahci_=
context *ctx, int channel)
 static int xgene_ahci_do_hardreset(struct ata_link *link,
 				   unsigned long deadline, bool *online)
 {
-	const unsigned long *timing =3D sata_ehc_deb_timing(&link->eh_context);
+	const struct sata_deb_timing *timing =3D
+		sata_ehc_deb_timing(&link->eh_context);
 	struct ata_port *ap =3D link->ap;
 	struct ahci_host_priv *hpriv =3D ap->host->private_data;
 	struct xgene_ahci_context *ctx =3D hpriv->plat_data;
diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index cf8c7fd59ada..0ac3b382fa52 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -1549,7 +1549,6 @@ static int ahci_pmp_retry_softreset(struct ata_link=
 *link, unsigned int *class,
 int ahci_do_hardreset(struct ata_link *link, unsigned int *class,
 		      unsigned long deadline, bool *online)
 {
-	const unsigned long *timing =3D sata_ehc_deb_timing(&link->eh_context);
 	struct ata_port *ap =3D link->ap;
 	struct ahci_port_priv *pp =3D ap->private_data;
 	struct ahci_host_priv *hpriv =3D ap->host->private_data;
@@ -1564,8 +1563,8 @@ int ahci_do_hardreset(struct ata_link *link, unsign=
ed int *class,
 	tf.status =3D ATA_BUSY;
 	ata_tf_to_fis(&tf, 0, 0, d2h_fis);
=20
-	rc =3D sata_link_hardreset(link, timing, deadline, online,
-				 ahci_check_ready);
+	rc =3D sata_link_hardreset(link, sata_ehc_deb_timing(&link->eh_context)=
,
+				 deadline, online, ahci_check_ready);
=20
 	hpriv->start_engine(ap);
=20
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 1bdb6e78f0ed..ffad7c1afb64 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3616,12 +3616,13 @@ EXPORT_SYMBOL_GPL(ata_std_prereset);
 int sata_std_hardreset(struct ata_link *link, unsigned int *class,
 		       unsigned long deadline)
 {
-	const unsigned long *timing =3D sata_ehc_deb_timing(&link->eh_context);
 	bool online;
 	int rc;
=20
 	/* do hardreset */
-	rc =3D sata_link_hardreset(link, timing, deadline, &online, NULL);
+	rc =3D sata_link_hardreset(link, sata_ehc_deb_timing(&link->eh_context)=
,
+				 deadline, &online, NULL);
+
 	return online ? -EAGAIN : rc;
 }
 EXPORT_SYMBOL_GPL(sata_std_hardreset);
diff --git a/drivers/ata/libata-pmp.c b/drivers/ata/libata-pmp.c
index e2e9cbd405fa..1ea472ddbe3f 100644
--- a/drivers/ata/libata-pmp.c
+++ b/drivers/ata/libata-pmp.c
@@ -851,7 +851,7 @@ static int sata_pmp_eh_handle_disabled_links(struct a=
ta_port *ap)
 		/* Some PMPs require hardreset sequence to get
 		 * SError.N working.
 		 */
-		sata_link_hardreset(link, sata_deb_timing_normal,
+		sata_link_hardreset(link, &sata_deb_timing_normal,
 				ata_deadline(jiffies, ATA_TMOUT_INTERNAL_QUICK),
 				NULL, NULL);
=20
diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index 86f1475e5bca..be46833d77a6 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -16,12 +16,31 @@
 #include "libata.h"
 #include "libata-transport.h"
=20
-/* debounce timing parameters in msecs { interval, duration, timeout } *=
/
-const unsigned long sata_deb_timing_normal[]		=3D {   5,  100, 2000 };
+/*
+ * Debounce timing parameters in msecs.
+ */
+const struct sata_deb_timing sata_deb_timing_normal =3D
+{
+	.interval	=3D 5,
+	.duration	=3D 100,
+	.timeout	=3D 2000
+};
 EXPORT_SYMBOL_GPL(sata_deb_timing_normal);
-const unsigned long sata_deb_timing_hotplug[]		=3D {  25,  500, 2000 };
+
+const struct sata_deb_timing sata_deb_timing_hotplug =3D
+{
+	.interval	=3D 25,
+	.duration	=3D 500,
+	.timeout	=3D 2000
+};
 EXPORT_SYMBOL_GPL(sata_deb_timing_hotplug);
-const unsigned long sata_deb_timing_long[]		=3D { 100, 2000, 5000 };
+
+const struct sata_deb_timing sata_deb_timing_long =3D
+{
+	.interval	=3D 100,
+	.duration	=3D 2000,
+	.timeout	=3D 5000
+};
 EXPORT_SYMBOL_GPL(sata_deb_timing_long);
=20
 /**
@@ -211,7 +230,7 @@ EXPORT_SYMBOL_GPL(ata_tf_from_fis);
 /**
  *	sata_link_debounce - debounce SATA phy status
  *	@link: ATA link to debounce SATA phy status for
- *	@params: timing parameters { interval, duration, timeout } in msec
+ *	@timing: debounce timing
  *	@deadline: deadline jiffies for the operation
  *
  *	Make sure SStatus of @link reaches stable state, determined by
@@ -230,16 +249,15 @@ EXPORT_SYMBOL_GPL(ata_tf_from_fis);
  *	RETURNS:
  *	0 on success, -errno on failure.
  */
-int sata_link_debounce(struct ata_link *link, const unsigned long *param=
s,
+int sata_link_debounce(struct ata_link *link,
+		       const struct sata_deb_timing *timing,
 		       unsigned long deadline)
 {
-	unsigned long interval =3D params[0];
-	unsigned long duration =3D params[1];
 	unsigned long last_jiffies, t;
 	u32 last, cur;
 	int rc;
=20
-	t =3D ata_deadline(jiffies, params[2]);
+	t =3D ata_deadline(jiffies, timing->timeout);
 	if (time_before(t, deadline))
 		deadline =3D t;
=20
@@ -251,7 +269,7 @@ int sata_link_debounce(struct ata_link *link, const u=
nsigned long *params,
 	last_jiffies =3D jiffies;
=20
 	while (1) {
-		ata_msleep(link->ap, interval);
+		ata_msleep(link->ap, timing->interval);
 		if ((rc =3D sata_scr_read(link, SCR_STATUS, &cur)))
 			return rc;
 		cur &=3D 0xf;
@@ -261,7 +279,7 @@ int sata_link_debounce(struct ata_link *link, const u=
nsigned long *params,
 			if (cur =3D=3D 1 && time_before(jiffies, deadline))
 				continue;
 			if (time_after(jiffies,
-				       ata_deadline(last_jiffies, duration)))
+				ata_deadline(last_jiffies, timing->duration)))
 				return 0;
 			continue;
 		}
@@ -280,7 +298,7 @@ int sata_link_debounce(struct ata_link *link, const u=
nsigned long *params,
 EXPORT_SYMBOL_GPL(sata_link_debounce);
=20
 static int __sata_link_resume(struct ata_link *link,
-			      const unsigned long *timing,
+			      const struct sata_deb_timing *timing,
 			      unsigned long deadline)
 {
 	int tries =3D ATA_LINK_RESUME_TRIES;
@@ -511,7 +529,7 @@ EXPORT_SYMBOL_GPL(sata_set_spd);
 /**
  *	sata_link_hardreset - reset link via SATA phy reset
  *	@link: link to reset
- *	@timing: timing parameters { interval, duration, timeout } in msec
+ *	@timing: debounce timing parameters
  *	@deadline: deadline jiffies for the operation
  *	@online: optional out parameter indicating link onlineness
  *	@check_ready: optional callback to check link readiness
@@ -532,7 +550,8 @@ EXPORT_SYMBOL_GPL(sata_set_spd);
  *	RETURNS:
  *	0 on success, -errno otherwise.
  */
-int sata_link_hardreset(struct ata_link *link, const unsigned long *timi=
ng,
+int sata_link_hardreset(struct ata_link *link,
+			const struct sata_deb_timing *timing,
 			unsigned long deadline,
 			bool *online, int (*check_ready)(struct ata_link *))
 {
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index b3be7a8f5bea..ffd085b09abc 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -2030,13 +2030,11 @@ EXPORT_SYMBOL_GPL(ata_sff_softreset);
 int sata_sff_hardreset(struct ata_link *link, unsigned int *class,
 		       unsigned long deadline)
 {
-	struct ata_eh_context *ehc =3D &link->eh_context;
-	const unsigned long *timing =3D sata_ehc_deb_timing(ehc);
 	bool online;
 	int rc;
=20
-	rc =3D sata_link_hardreset(link, timing, deadline, &online,
-				 ata_sff_check_ready);
+	rc =3D sata_link_hardreset(link, sata_ehc_deb_timing(&link->eh_context)=
,
+				 deadline, &online, ata_sff_check_ready);
 	if (online)
 		*class =3D ata_sff_dev_classify(link->device, 1, NULL);
=20
diff --git a/drivers/ata/sata_highbank.c b/drivers/ata/sata_highbank.c
index dfbf9493e451..16da571e8083 100644
--- a/drivers/ata/sata_highbank.c
+++ b/drivers/ata/sata_highbank.c
@@ -385,7 +385,7 @@ static int highbank_initialize_phys(struct device *de=
v, void __iomem *addr)
 static int ahci_highbank_hardreset(struct ata_link *link, unsigned int *=
class,
 				unsigned long deadline)
 {
-	static const unsigned long timing[] =3D { 5, 100, 500};
+	const struct sata_deb_timing timing =3D { 5, 100, 500};
 	struct ata_port *ap =3D link->ap;
 	struct ahci_port_priv *pp =3D ap->private_data;
 	struct ahci_host_priv *hpriv =3D ap->host->private_data;
@@ -405,7 +405,7 @@ static int ahci_highbank_hardreset(struct ata_link *l=
ink, unsigned int *class,
=20
 	do {
 		highbank_cphy_disable_overrides(link->ap->port_no);
-		rc =3D sata_link_hardreset(link, timing, deadline, &online, NULL);
+		rc =3D sata_link_hardreset(link, &timing, deadline, &online, NULL);
 		highbank_cphy_override_lane(link->ap->port_no);
=20
 		/* If the status is 1, we are connected, but the link did not
diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index de5bd02cad44..8ad0f3776c48 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -3633,11 +3633,9 @@ static int mv_hardreset(struct ata_link *link, uns=
igned int *class,
=20
 	/* Workaround for errata FEr SATA#10 (part 2) */
 	do {
-		const unsigned long *timing =3D
-				sata_ehc_deb_timing(&link->eh_context);
-
-		rc =3D sata_link_hardreset(link, timing, deadline + extra,
-					 &online, NULL);
+		rc =3D sata_link_hardreset(link,
+					 sata_ehc_deb_timing(&link->eh_context),
+					 deadline + extra, &online, NULL);
 		rc =3D online ? -EAGAIN : rc;
 		if (rc)
 			return rc;
diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index b5f27eac86b1..5c8db8f8c47f 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -1526,7 +1526,7 @@ static int nv_hardreset(struct ata_link *link, unsi=
gned int *class,
 	 */
 	if (!(link->ap->pflags & ATA_PFLAG_LOADING) &&
 	    !ata_dev_enabled(link->device))
-		sata_link_hardreset(link, sata_deb_timing_hotplug, deadline,
+		sata_link_hardreset(link, &sata_deb_timing_hotplug, deadline,
 				    NULL, NULL);
 	else {
 		int rc;
diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index 2fef6ce93f07..4c4ff67bf06a 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -735,7 +735,7 @@ static int sil24_hardreset(struct ata_link *link, uns=
igned int *class,
 	/* SStatus oscillates between zero and valid status after
 	 * DEV_RST, debounce it.
 	 */
-	rc =3D sata_link_debounce(link, sata_deb_timing_long, deadline);
+	rc =3D sata_link_debounce(link, &sata_deb_timing_long, deadline);
 	if (rc) {
 		reason =3D "PHY debouncing failed";
 		goto err;
diff --git a/include/linux/libata.h b/include/linux/libata.h
index e89d612326f6..166263d9bbc7 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1150,17 +1150,26 @@ extern void ata_scsi_cmd_error_handler(struct Scs=
i_Host *host, struct ata_port *
  * SATA specific code - drivers/ata/libata-sata.c
  */
 #ifdef CONFIG_SATA_HOST
-extern const unsigned long sata_deb_timing_normal[];
-extern const unsigned long sata_deb_timing_hotplug[];
-extern const unsigned long sata_deb_timing_long[];
=20
-static inline const unsigned long *
+/*
+ * Debounce timing parameters in msecs.
+ */
+struct sata_deb_timing {
+	unsigned long interval;
+	unsigned long duration;
+	unsigned long timeout;
+};
+
+extern const struct sata_deb_timing sata_deb_timing_normal;
+extern const struct sata_deb_timing sata_deb_timing_hotplug;
+extern const struct sata_deb_timing sata_deb_timing_long;
+
+static inline const struct sata_deb_timing *
 sata_ehc_deb_timing(struct ata_eh_context *ehc)
 {
 	if (ehc->i.flags & ATA_EHI_HOTPLUGGED)
-		return sata_deb_timing_hotplug;
-	else
-		return sata_deb_timing_normal;
+		return &sata_deb_timing_hotplug;
+	return &sata_deb_timing_normal;
 }
=20
 extern int sata_scr_valid(struct ata_link *link);
@@ -1169,12 +1178,13 @@ extern int sata_scr_write(struct ata_link *link, =
int reg, u32 val);
 extern int sata_scr_write_flush(struct ata_link *link, int reg, u32 val)=
;
 extern int sata_set_spd(struct ata_link *link);
 extern int sata_link_hardreset(struct ata_link *link,
-			const unsigned long *timing, unsigned long deadline,
-			bool *online, int (*check_ready)(struct ata_link *));
+			       const struct sata_deb_timing *timing,
+			       unsigned long deadline, bool *online,
+			       int (*check_ready)(struct ata_link *));
 extern int sata_link_resume(struct ata_link *link, unsigned long deadlin=
e);
 extern void ata_eh_analyze_ncq_error(struct ata_link *link);
 #else
-static inline const unsigned long *
+static inline const struct sata_deb_timing *
 sata_ehc_deb_timing(struct ata_eh_context *ehc)
 {
 	return NULL;
@@ -1194,9 +1204,8 @@ static inline int sata_scr_write_flush(struct ata_l=
ink *link, int reg, u32 val)
 }
 static inline int sata_set_spd(struct ata_link *link) { return -EOPNOTSU=
PP; }
 static inline int sata_link_hardreset(struct ata_link *link,
-				      const unsigned long *timing,
-				      unsigned long deadline,
-				      bool *online,
+				      const struct sata_deb_timing *timing,
+				      unsigned long deadline, bool *online,
 				      int (*check_ready)(struct ata_link *))
 {
 	if (online)
@@ -1211,7 +1220,8 @@ static inline int sata_link_resume(struct ata_link =
*link,
 static inline void ata_eh_analyze_ncq_error(struct ata_link *link) { }
 #endif
 extern int sata_link_debounce(struct ata_link *link,
-			const unsigned long *params, unsigned long deadline);
+			      const struct sata_deb_timing *timing,
+			      unsigned long deadline);
 extern int sata_link_scr_lpm(struct ata_link *link, enum ata_lpm_policy =
policy,
 			     bool spm_wakeup);
 extern int ata_slave_link_init(struct ata_port *ap);
--=20
2.35.1

