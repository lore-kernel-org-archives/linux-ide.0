Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3FD2C433F5
	for <linux-ide@archiver.kernel.org>; Wed, 23 Mar 2022 08:19:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242575AbiCWIUy (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 23 Mar 2022 04:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237876AbiCWIUy (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 23 Mar 2022 04:20:54 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C145EDC1
        for <linux-ide@vger.kernel.org>; Wed, 23 Mar 2022 01:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648023563; x=1679559563;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NkAwXimJP512DU9dLD5JNat71WrXp4shbL048LlbGe4=;
  b=XplhtUc22xWMXHD94xdt2F8ZPuyer1/dy4W0rg9Om90g/B4eoLn/3Jmx
   FsWdZ82whYEhmf+FkTiigQAr8KNL7NEuc+OShHMg1reTZ8EEZdX5qSXak
   wYUmckNmlawYNe1FQuNKbAoCK0nX90QhQZoJ6tkS1hKyViA2vIoy5j6MI
   DK17ISfIaLnhID4CoxgYcG4+xh0YQfzpRq+6RnfrYhrWL1MSoMs0dyP14
   pgguUHcVbgcjerdwzzi8xqyOecZTfBU0/ODfYVJsyP/0ut6DmAeLIoQvu
   Q3QdogoJ7JdV8S/BZQQ0mWGoc66IfJnyju2TngfMvLhMx8/6tGFOptQuc
   A==;
X-IronPort-AV: E=Sophos;i="5.90,203,1643644800"; 
   d="scan'208";a="196047605"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Mar 2022 16:19:22 +0800
IronPort-SDR: YZqR+17F1bck9DvijtZBTsrbdzWLyz7aZ5A9NuR7t5wujcL5N/RDrngdT2uhQrcg/hnv4HUQQ8
 DlDhB+inrs7XaKtTUlsVpDxMxwqqQVGmu83gurO1K+75FRMMwXNy47Moson98OOwYCeN38arg1
 +wGWWMZPr63vZg0BrPnmsxx/vY2MUBoc7L89UADzdR2mSGV/svXZJ6qIlFeROZrf+NRWAQgM4g
 lVkN5CPH+QD8KlgTwyJwyN4L2B14FOqraSHbQNC8FN0nheCz6WdNn++MLJ8Mb/CyIci1TH1W8L
 g3dvC1yoUYKyxeCPcJN4YD7U
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 00:51:17 -0700
IronPort-SDR: XCRiQoN6EROT+Q9zanR8f0ddv4XfPHTSpqer1+vNxD+cgHhVm8tgBfxQ/91xkSmp0LQvnS6icR
 0MZZNl4ezdKqlL+aXgs6NjBtUjdVHlEQjaan32EUv9oLerwkd/tVrgbuMF4H2XQ3+COKBiJjQp
 1AjYx855DPzahV/pYSvmHjaSuLLQGEAbzdGoiVfu/5EoiGkaauYMB3hJyLqQhiGYlDP3Yejhx0
 V7y+p5qQbfkmrMm8WU/EnhMcIP/NxSRjh564GqLJXOvUZyqoz3YOngzQgKR56M8CoQq9XTcBU7
 LW8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 01:19:23 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KNh8q2P1Tz1SVnx
        for <linux-ide@vger.kernel.org>; Wed, 23 Mar 2022 01:19:23 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1648023562; x=1650615563; bh=NkAwXimJP512DU9dLD
        5JNat71WrXp4shbL048LlbGe4=; b=f+d3njDu5eCZsbml9C6eRBePVThuFU/wbv
        IVPulRxuKRgII9lX6uPQwRhGwrt1yAfXGtz/eZR1Hn+MN1OYcuwU8sMhK7BxBqYK
        2kzpNUYfJM/pKFvMxJIAi8SucCXZkY9km6gE6GjD5iVQlG7fmPy09qlvimlvCKDA
        URyQ0bySEDPHUqhp5CugnQn3HvjG+MyKlSS2vYN4jglOVUdlelxl87o8z3EVnKb/
        HMD69S9w2/Ud+bgfVHg0WFbXcWCWytkZQIYAoly1BAfKmjB6cCvNtDqSkTEd8CrL
        GRApTrn+4HXM+9v3/Q0b+9diXpfl2/UMS1c6WYGLVe7DKhHYCiug==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id lBUqwaZs0eDT for <linux-ide@vger.kernel.org>;
        Wed, 23 Mar 2022 01:19:22 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KNh8p3QGpz1Rwrw;
        Wed, 23 Mar 2022 01:19:22 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH 1/4] ata: libata-sata: Simplify sata_link_resume() interface
Date:   Wed, 23 Mar 2022 17:17:37 +0900
Message-Id: <20220323081740.540006-2-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220323081740.540006-1-damien.lemoal@opensource.wdc.com>
References: <20220323081740.540006-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

When called directly outside of sata_link_hardreset(), the debounce
timing array passed to sata_link_resume() is always the array returned
by sata_ehc_deb_timing() for the target link. Based on this, the
interface of sata_link_resume() can be simplified by removing the
params argument. The timing array is infered locally using
sata_ehc_deb_timing().

To allow sata_link_hardreset() to specify a timing array, the helper
function __sata_link_resume() is introduced and sata_link_resume()
implemented using this helper.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/ata/libata-core.c   |  3 +--
 drivers/ata/libata-sata.c   | 42 +++++++++++++++++++++----------------
 drivers/ata/sata_inic162x.c |  3 +--
 drivers/ata/sata_nv.c       |  3 +--
 include/linux/libata.h      |  4 +---
 5 files changed, 28 insertions(+), 27 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index cceedde51126..1bdb6e78f0ed 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3575,7 +3575,6 @@ int ata_std_prereset(struct ata_link *link, unsigne=
d long deadline)
 {
 	struct ata_port *ap =3D link->ap;
 	struct ata_eh_context *ehc =3D &link->eh_context;
-	const unsigned long *timing =3D sata_ehc_deb_timing(ehc);
 	int rc;
=20
 	/* if we're about to do hardreset, nothing more to do */
@@ -3584,7 +3583,7 @@ int ata_std_prereset(struct ata_link *link, unsigne=
d long deadline)
=20
 	/* if SATA, resume link */
 	if (ap->flags & ATA_FLAG_SATA) {
-		rc =3D sata_link_resume(link, timing, deadline);
+		rc =3D sata_link_resume(link, deadline);
 		/* whine about phy resume failure but proceed */
 		if (rc && rc !=3D -EOPNOTSUPP)
 			ata_link_warn(link,
diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index 044a16daa2d4..86f1475e5bca 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -279,22 +279,9 @@ int sata_link_debounce(struct ata_link *link, const =
unsigned long *params,
 }
 EXPORT_SYMBOL_GPL(sata_link_debounce);
=20
-/**
- *	sata_link_resume - resume SATA link
- *	@link: ATA link to resume SATA
- *	@params: timing parameters { interval, duration, timeout } in msec
- *	@deadline: deadline jiffies for the operation
- *
- *	Resume SATA phy @link and debounce it.
- *
- *	LOCKING:
- *	Kernel thread context (may sleep)
- *
- *	RETURNS:
- *	0 on success, -errno on failure.
- */
-int sata_link_resume(struct ata_link *link, const unsigned long *params,
-		     unsigned long deadline)
+static int __sata_link_resume(struct ata_link *link,
+			      const unsigned long *timing,
+			      unsigned long deadline)
 {
 	int tries =3D ATA_LINK_RESUME_TRIES;
 	u32 scontrol, serror;
@@ -335,7 +322,7 @@ int sata_link_resume(struct ata_link *link, const uns=
igned long *params,
 		ata_link_warn(link, "link resume succeeded after %d retries\n",
 			      ATA_LINK_RESUME_TRIES - tries);
=20
-	if ((rc =3D sata_link_debounce(link, params, deadline)))
+	if ((rc =3D sata_link_debounce(link, timing, deadline)))
 		return rc;
=20
 	/* clear SError, some PHYs require this even for SRST to work */
@@ -344,6 +331,25 @@ int sata_link_resume(struct ata_link *link, const un=
signed long *params,
=20
 	return rc !=3D -EINVAL ? rc : 0;
 }
+
+/**
+ *	sata_link_resume - resume SATA link
+ *	@link: ATA link to resume SATA
+ *	@deadline: deadline jiffies for the operation
+ *
+ *	Resume SATA phy @link and debounce it.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep)
+ *
+ *	RETURNS:
+ *	0 on success, -errno on failure.
+ */
+int sata_link_resume(struct ata_link *link, unsigned long deadline)
+{
+	return __sata_link_resume(link,
+			sata_ehc_deb_timing(&link->eh_context), deadline);
+}
 EXPORT_SYMBOL_GPL(sata_link_resume);
=20
 /**
@@ -568,7 +574,7 @@ int sata_link_hardreset(struct ata_link *link, const =
unsigned long *timing,
 	ata_msleep(link->ap, 1);
=20
 	/* bring link back */
-	rc =3D sata_link_resume(link, timing, deadline);
+	rc =3D __sata_link_resume(link, timing, deadline);
 	if (rc)
 		goto out;
 	/* if link is offline nothing more to do */
diff --git a/drivers/ata/sata_inic162x.c b/drivers/ata/sata_inic162x.c
index 11e518f0111c..8d4d041cc724 100644
--- a/drivers/ata/sata_inic162x.c
+++ b/drivers/ata/sata_inic162x.c
@@ -621,7 +621,6 @@ static int inic_hardreset(struct ata_link *link, unsi=
gned int *class,
 	struct ata_port *ap =3D link->ap;
 	void __iomem *port_base =3D inic_port_base(ap);
 	void __iomem *idma_ctl =3D port_base + PORT_IDMA_CTL;
-	const unsigned long *timing =3D sata_ehc_deb_timing(&link->eh_context);
 	int rc;
=20
 	/* hammer it into sane state */
@@ -632,7 +631,7 @@ static int inic_hardreset(struct ata_link *link, unsi=
gned int *class,
 	ata_msleep(ap, 1);
 	writew(0, idma_ctl);
=20
-	rc =3D sata_link_resume(link, timing, deadline);
+	rc =3D sata_link_resume(link, deadline);
 	if (rc) {
 		ata_link_warn(link,
 			      "failed to resume link after reset (errno=3D%d)\n",
diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index 7f14d0d31057..b5f27eac86b1 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -1529,7 +1529,6 @@ static int nv_hardreset(struct ata_link *link, unsi=
gned int *class,
 		sata_link_hardreset(link, sata_deb_timing_hotplug, deadline,
 				    NULL, NULL);
 	else {
-		const unsigned long *timing =3D sata_ehc_deb_timing(ehc);
 		int rc;
=20
 		if (!(ehc->i.flags & ATA_EHI_QUIET))
@@ -1537,7 +1536,7 @@ static int nv_hardreset(struct ata_link *link, unsi=
gned int *class,
 				      "nv: skipping hardreset on occupied port\n");
=20
 		/* make sure the link is online */
-		rc =3D sata_link_resume(link, timing, deadline);
+		rc =3D sata_link_resume(link, deadline);
 		/* whine about phy resume failure but proceed */
 		if (rc && rc !=3D -EOPNOTSUPP)
 			ata_link_warn(link, "failed to resume link (errno=3D%d)\n",
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 9b1d3d8b1252..e89d612326f6 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1171,8 +1171,7 @@ extern int sata_set_spd(struct ata_link *link);
 extern int sata_link_hardreset(struct ata_link *link,
 			const unsigned long *timing, unsigned long deadline,
 			bool *online, int (*check_ready)(struct ata_link *));
-extern int sata_link_resume(struct ata_link *link, const unsigned long *=
params,
-			    unsigned long deadline);
+extern int sata_link_resume(struct ata_link *link, unsigned long deadlin=
e);
 extern void ata_eh_analyze_ncq_error(struct ata_link *link);
 #else
 static inline const unsigned long *
@@ -1205,7 +1204,6 @@ static inline int sata_link_hardreset(struct ata_li=
nk *link,
 	return -EOPNOTSUPP;
 }
 static inline int sata_link_resume(struct ata_link *link,
-				   const unsigned long *params,
 				   unsigned long deadline)
 {
 	return -EOPNOTSUPP;
--=20
2.35.1

