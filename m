Return-Path: <SRS0=qhS8=33=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00CBCC35250
	for <linux-ide@archiver.kernel.org>; Fri,  7 Feb 2020 14:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2E37214AF
	for <linux-ide@archiver.kernel.org>; Fri,  7 Feb 2020 14:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="DAAfCVgK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbgBGO2n (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 7 Feb 2020 09:28:43 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:59687 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727790AbgBGO2D (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 7 Feb 2020 09:28:03 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200207142801euoutp01507300b9876387af5def5f4f43d6b8ac~xJQzQO0eO2241722417euoutp01N
        for <linux-ide@vger.kernel.org>; Fri,  7 Feb 2020 14:28:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200207142801euoutp01507300b9876387af5def5f4f43d6b8ac~xJQzQO0eO2241722417euoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1581085681;
        bh=q+bzbIpIuoJx5gE+LXlzkXqH3tL3jE8nZ3SQR+FjBk8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DAAfCVgKgtVi0m1D+K4o99n3BuZhcxNwDiaRkq5LINLwU2UU8MuAY/ug90JgHydUk
         3YQaEE9nBR9Y2UxpCDflYkm/0x1nsWv+33baT50LAhV5ZVQIEWwOp+kBn9E5r/3WzR
         iGov0UGE5Mwnxu8iAsyIgP5klWmR6JGl3L1QSGkk=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200207142800eucas1p25c47779e71d949e9f240c6c7278f1b90~xJQy-9asJ2441424414eucas1p2g;
        Fri,  7 Feb 2020 14:28:00 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 91.5D.60679.0F37D3E5; Fri,  7
        Feb 2020 14:28:00 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200207142800eucas1p197819409e445b948ba8cacc8acdbf5f9~xJQyxbkyO0218702187eucas1p1c;
        Fri,  7 Feb 2020 14:28:00 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200207142800eusmtrp2a448a7e3906887ad15e9002aec030f6d~xJQywycuG1102911029eusmtrp2I;
        Fri,  7 Feb 2020 14:28:00 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-84-5e3d73f07419
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id F2.D5.07950.0F37D3E5; Fri,  7
        Feb 2020 14:28:00 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200207142800eusmtip282748c7456140d613847a48ea07e0132~xJQyQa5lv2944029440eusmtip2j;
        Fri,  7 Feb 2020 14:28:00 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH v2 19/26] ata: move sata_link_hardreset() to libata-sata.c
Date:   Fri,  7 Feb 2020 15:27:27 +0100
Message-Id: <20200207142734.8431-20-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200207142734.8431-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHKsWRmVeSWpSXmKPExsWy7djP87ofim3jDN41mlisvtvPZrFxxnpW
        i2e39jJZrFx9lMni2I5HTBaXd81hs1j+ZC2zxdzW6ewOHB47Z91l97h8ttTj0OEORo+Trd9Y
        PHbfbGDz6NuyitHj8ya5APYoLpuU1JzMstQifbsEroy1u6ayF/wKrdi34ClLA+N2ly5GTg4J
        AROJT30NjF2MXBxCAisYJZZ3r4JyvjBKzH1/jRnC+cwosfLFY3aYlh2ndrBBJJYzShw884kV
        ruXAo0ssIFVsAlYSE9tBZnFyiAgoSPT8XgnWwSzwnlFixaS9YEXCAl4SU+cfBytiEVCVeLrx
        B1icV8BWomPRN0aIdfISW7+BbODk4ASKf5zylw2iRlDi5MwnYPXMQDXNW2eD3SohsIxd4vqj
        /0C3cgA5LhJ3dqRDzBGWeHV8C9QLMhL/d85ngqhfxyjxt+MFVPN2YBBM/scGUWUtcefcLzaQ
        QcwCmhLrd+lDhB0ljnzfwAQxn0/ixltBiBv4JCZtm84MEeaV6GgTgqhWk9iwbAMbzNqunSuZ
        IWwPiWWbdrNMYFScheSbWUi+mYWwdwEj8ypG8dTS4tz01GKjvNRyveLE3OLSvHS95PzcTYzA
        VHT63/EvOxh3/Uk6xCjAwajEw5vgaBMnxJpYVlyZe4hRgoNZSYS3T9U2Tog3JbGyKrUoP76o
        NCe1+BCjNAeLkjiv8aKXsUIC6YklqdmpqQWpRTBZJg5OqQZGUaEbxyPeyXr9TfIvY/Y4wTu/
        /er71TnK709eisqxrp3EyyTdGLzkbIn0u8nfTiS/dZV2NHRIXr5S/GF+hmSc4h6uMIHYC1XH
        tfJW/oou9hNZ6lS7/vXG4GLGteenOWmHtfrPDj5SIbfr+P8j6xX5mnj3bAne/yap5pd1yHyO
        1WxHilKPMMYosRRnJBpqMRcVJwIACJjockEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsVy+t/xe7ofim3jDL4uV7BYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6
        djYpqTmZZalF+nYJehlrd01lL/gVWrFvwVOWBsbtLl2MnBwSAiYSO07tYOti5OIQEljKKHHn
        YS+QwwGUkJE4vr4MokZY4s+1LqiaT4wSb9o72UASbAJWEhPbVzGC2CICChI9v1eCFTELfGWU
        WDqpmxkkISzgJTF1/nGwIhYBVYmnG3+wgNi8ArYSHYu+MUJskJfY+u0TK4jNCRT/OOUv2AIh
        ARuJ7+8nsUPUC0qcnPkErJcZqL5562zmCYwCs5CkZiFJLWBkWsUoklpanJueW2ykV5yYW1ya
        l66XnJ+7iREYMduO/dyyg7HrXfAhRgEORiUe3gRHmzgh1sSy4srcQ4wSHMxKIrx9qrZxQrwp
        iZVVqUX58UWlOanFhxhNgZ6YyCwlmpwPjOa8knhDU0NzC0tDc2NzYzMLJXHeDoGDMUIC6Ykl
        qdmpqQWpRTB9TBycUg2MExQ+PePcJRT/J2BZ4fup7BuYpe9dSZu44dJ7rRUFa1LecK0T1jZo
        SXnus1WGKTU79F6DrrfeSRmHr1YtF/Qnv7s7e5NX5+NPe6NSJ9mvls/MrnrVJr9YuHGq5kuR
        t98kNzyf0r9cPnd9S8Ea3wdnREX+RXQkl6XN6RFXcvl/+NNzi467irkrlFiKMxINtZiLihMB
        /KDsg64CAAA=
X-CMS-MailID: 20200207142800eucas1p197819409e445b948ba8cacc8acdbf5f9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200207142800eucas1p197819409e445b948ba8cacc8acdbf5f9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200207142800eucas1p197819409e445b948ba8cacc8acdbf5f9
References: <20200207142734.8431-1-b.zolnierkie@samsung.com>
        <CGME20200207142800eucas1p197819409e445b948ba8cacc8acdbf5f9@eucas1p1.samsung.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

* move sata_link_hardreset() to libata-sata.c

* add static inline for CONFIG_SATA_HOST=n case

* make sata_set_spd_needed() static

Code size savings on m68k arch using (modified) atari_defconfig:

   text    data     bss     dec     hex filename
before:
  32724     572      40   33336    8238 drivers/ata/libata-core.o
after:
  32559     572      40   33171    8193 drivers/ata/libata-core.o

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/libata-core.c | 113 -------------------------------------
 drivers/ata/libata-sata.c | 115 +++++++++++++++++++++++++++++++++++++-
 drivers/ata/libata.h      |   7 ---
 include/linux/libata.h    |  16 +++++-
 4 files changed, 127 insertions(+), 124 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index f3391e66b694..cd0febf26dd5 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3531,119 +3531,6 @@ int ata_std_prereset(struct ata_link *link, unsigned long deadline)
 }
 EXPORT_SYMBOL_GPL(ata_std_prereset);
 
-/**
- *	sata_link_hardreset - reset link via SATA phy reset
- *	@link: link to reset
- *	@timing: timing parameters { interval, duration, timeout } in msec
- *	@deadline: deadline jiffies for the operation
- *	@online: optional out parameter indicating link onlineness
- *	@check_ready: optional callback to check link readiness
- *
- *	SATA phy-reset @link using DET bits of SControl register.
- *	After hardreset, link readiness is waited upon using
- *	ata_wait_ready() if @check_ready is specified.  LLDs are
- *	allowed to not specify @check_ready and wait itself after this
- *	function returns.  Device classification is LLD's
- *	responsibility.
- *
- *	*@online is set to one iff reset succeeded and @link is online
- *	after reset.
- *
- *	LOCKING:
- *	Kernel thread context (may sleep)
- *
- *	RETURNS:
- *	0 on success, -errno otherwise.
- */
-int sata_link_hardreset(struct ata_link *link, const unsigned long *timing,
-			unsigned long deadline,
-			bool *online, int (*check_ready)(struct ata_link *))
-{
-	u32 scontrol;
-	int rc;
-
-	DPRINTK("ENTER\n");
-
-	if (online)
-		*online = false;
-
-	if (sata_set_spd_needed(link)) {
-		/* SATA spec says nothing about how to reconfigure
-		 * spd.  To be on the safe side, turn off phy during
-		 * reconfiguration.  This works for at least ICH7 AHCI
-		 * and Sil3124.
-		 */
-		if ((rc = sata_scr_read(link, SCR_CONTROL, &scontrol)))
-			goto out;
-
-		scontrol = (scontrol & 0x0f0) | 0x304;
-
-		if ((rc = sata_scr_write(link, SCR_CONTROL, scontrol)))
-			goto out;
-
-		sata_set_spd(link);
-	}
-
-	/* issue phy wake/reset */
-	if ((rc = sata_scr_read(link, SCR_CONTROL, &scontrol)))
-		goto out;
-
-	scontrol = (scontrol & 0x0f0) | 0x301;
-
-	if ((rc = sata_scr_write_flush(link, SCR_CONTROL, scontrol)))
-		goto out;
-
-	/* Couldn't find anything in SATA I/II specs, but AHCI-1.1
-	 * 10.4.2 says at least 1 ms.
-	 */
-	ata_msleep(link->ap, 1);
-
-	/* bring link back */
-	rc = sata_link_resume(link, timing, deadline);
-	if (rc)
-		goto out;
-	/* if link is offline nothing more to do */
-	if (ata_phys_link_offline(link))
-		goto out;
-
-	/* Link is online.  From this point, -ENODEV too is an error. */
-	if (online)
-		*online = true;
-
-	if (sata_pmp_supported(link->ap) && ata_is_host_link(link)) {
-		/* If PMP is supported, we have to do follow-up SRST.
-		 * Some PMPs don't send D2H Reg FIS after hardreset if
-		 * the first port is empty.  Wait only for
-		 * ATA_TMOUT_PMP_SRST_WAIT.
-		 */
-		if (check_ready) {
-			unsigned long pmp_deadline;
-
-			pmp_deadline = ata_deadline(jiffies,
-						    ATA_TMOUT_PMP_SRST_WAIT);
-			if (time_after(pmp_deadline, deadline))
-				pmp_deadline = deadline;
-			ata_wait_ready(link, pmp_deadline, check_ready);
-		}
-		rc = -EAGAIN;
-		goto out;
-	}
-
-	rc = 0;
-	if (check_ready)
-		rc = ata_wait_ready(link, deadline, check_ready);
- out:
-	if (rc && rc != -EAGAIN) {
-		/* online is set iff link is online && reset succeeded */
-		if (online)
-			*online = false;
-		ata_link_err(link, "COMRESET failed (errno=%d)\n", rc);
-	}
-	DPRINTK("EXIT, rc=%d\n", rc);
-	return rc;
-}
-EXPORT_SYMBOL_GPL(sata_link_hardreset);
-
 /**
  *	sata_std_hardreset - COMRESET w/o waiting or classification
  *	@link: link to reset
diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index 34852fced999..05a1872ba329 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -449,7 +449,7 @@ static int __sata_set_spd_needed(struct ata_link *link, u32 *scontrol)
  *	RETURNS:
  *	1 if SATA spd configuration is needed, 0 otherwise.
  */
-int sata_set_spd_needed(struct ata_link *link)
+static int sata_set_spd_needed(struct ata_link *link)
 {
 	u32 scontrol;
 
@@ -490,6 +490,119 @@ int sata_set_spd(struct ata_link *link)
 }
 EXPORT_SYMBOL_GPL(sata_set_spd);
 
+/**
+ *	sata_link_hardreset - reset link via SATA phy reset
+ *	@link: link to reset
+ *	@timing: timing parameters { interval, duration, timeout } in msec
+ *	@deadline: deadline jiffies for the operation
+ *	@online: optional out parameter indicating link onlineness
+ *	@check_ready: optional callback to check link readiness
+ *
+ *	SATA phy-reset @link using DET bits of SControl register.
+ *	After hardreset, link readiness is waited upon using
+ *	ata_wait_ready() if @check_ready is specified.  LLDs are
+ *	allowed to not specify @check_ready and wait itself after this
+ *	function returns.  Device classification is LLD's
+ *	responsibility.
+ *
+ *	*@online is set to one iff reset succeeded and @link is online
+ *	after reset.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep)
+ *
+ *	RETURNS:
+ *	0 on success, -errno otherwise.
+ */
+int sata_link_hardreset(struct ata_link *link, const unsigned long *timing,
+			unsigned long deadline,
+			bool *online, int (*check_ready)(struct ata_link *))
+{
+	u32 scontrol;
+	int rc;
+
+	DPRINTK("ENTER\n");
+
+	if (online)
+		*online = false;
+
+	if (sata_set_spd_needed(link)) {
+		/* SATA spec says nothing about how to reconfigure
+		 * spd.  To be on the safe side, turn off phy during
+		 * reconfiguration.  This works for at least ICH7 AHCI
+		 * and Sil3124.
+		 */
+		if ((rc = sata_scr_read(link, SCR_CONTROL, &scontrol)))
+			goto out;
+
+		scontrol = (scontrol & 0x0f0) | 0x304;
+
+		if ((rc = sata_scr_write(link, SCR_CONTROL, scontrol)))
+			goto out;
+
+		sata_set_spd(link);
+	}
+
+	/* issue phy wake/reset */
+	if ((rc = sata_scr_read(link, SCR_CONTROL, &scontrol)))
+		goto out;
+
+	scontrol = (scontrol & 0x0f0) | 0x301;
+
+	if ((rc = sata_scr_write_flush(link, SCR_CONTROL, scontrol)))
+		goto out;
+
+	/* Couldn't find anything in SATA I/II specs, but AHCI-1.1
+	 * 10.4.2 says at least 1 ms.
+	 */
+	ata_msleep(link->ap, 1);
+
+	/* bring link back */
+	rc = sata_link_resume(link, timing, deadline);
+	if (rc)
+		goto out;
+	/* if link is offline nothing more to do */
+	if (ata_phys_link_offline(link))
+		goto out;
+
+	/* Link is online.  From this point, -ENODEV too is an error. */
+	if (online)
+		*online = true;
+
+	if (sata_pmp_supported(link->ap) && ata_is_host_link(link)) {
+		/* If PMP is supported, we have to do follow-up SRST.
+		 * Some PMPs don't send D2H Reg FIS after hardreset if
+		 * the first port is empty.  Wait only for
+		 * ATA_TMOUT_PMP_SRST_WAIT.
+		 */
+		if (check_ready) {
+			unsigned long pmp_deadline;
+
+			pmp_deadline = ata_deadline(jiffies,
+						    ATA_TMOUT_PMP_SRST_WAIT);
+			if (time_after(pmp_deadline, deadline))
+				pmp_deadline = deadline;
+			ata_wait_ready(link, pmp_deadline, check_ready);
+		}
+		rc = -EAGAIN;
+		goto out;
+	}
+
+	rc = 0;
+	if (check_ready)
+		rc = ata_wait_ready(link, deadline, check_ready);
+ out:
+	if (rc && rc != -EAGAIN) {
+		/* online is set iff link is online && reset succeeded */
+		if (online)
+			*online = false;
+		ata_link_err(link, "COMRESET failed (errno=%d)\n", rc);
+	}
+	DPRINTK("EXIT, rc=%d\n", rc);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(sata_link_hardreset);
+
 /**
  *	ata_slave_link_init - initialize slave link
  *	@ap: port to initialize slave link for
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 53b45ebe3d55..cd8090ad43e5 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -87,13 +87,6 @@ extern unsigned int ata_read_log_page(struct ata_device *dev, u8 log,
 
 #define to_ata_port(d) container_of(d, struct ata_port, tdev)
 
-/* libata-sata.c */
-#ifdef CONFIG_SATA_HOST
-int sata_set_spd_needed(struct ata_link *link);
-#else
-static inline int sata_set_spd_needed(struct ata_link *link) { return 1; }
-#endif
-
 /* libata-acpi.c */
 #ifdef CONFIG_ATA_ACPI
 extern unsigned int ata_acpi_gtf_filter;
diff --git a/include/linux/libata.h b/include/linux/libata.h
index bd0ac8007911..0c8c3b6eac9f 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1079,9 +1079,6 @@ static inline int ata_port_is_dummy(struct ata_port *ap)
 extern int ata_std_prereset(struct ata_link *link, unsigned long deadline);
 extern int ata_wait_after_reset(struct ata_link *link, unsigned long deadline,
 				int (*check_ready)(struct ata_link *link));
-extern int sata_link_hardreset(struct ata_link *link,
-			const unsigned long *timing, unsigned long deadline,
-			bool *online, int (*check_ready)(struct ata_link *));
 extern int sata_std_hardreset(struct ata_link *link, unsigned int *class,
 			      unsigned long deadline);
 extern void ata_std_postreset(struct ata_link *link, unsigned int *classes);
@@ -1192,6 +1189,9 @@ extern int sata_scr_read(struct ata_link *link, int reg, u32 *val);
 extern int sata_scr_write(struct ata_link *link, int reg, u32 val);
 extern int sata_scr_write_flush(struct ata_link *link, int reg, u32 val);
 extern int sata_set_spd(struct ata_link *link);
+extern int sata_link_hardreset(struct ata_link *link,
+			const unsigned long *timing, unsigned long deadline,
+			bool *online, int (*check_ready)(struct ata_link *));
 extern int sata_link_resume(struct ata_link *link, const unsigned long *params,
 			    unsigned long deadline);
 #else
@@ -1209,6 +1209,16 @@ static inline int sata_scr_write_flush(struct ata_link *link, int reg, u32 val)
 	return -EOPNOTSUPP;
 }
 static inline int sata_set_spd(struct ata_link *link) { return -EOPNOTSUPP; }
+static inline int sata_link_hardreset(struct ata_link *link,
+				      const unsigned long *timing,
+				      unsigned long deadline,
+				      bool *online,
+				      int (*check_ready)(struct ata_link *))
+{
+	if (online)
+		*online = false;
+	return -EOPNOTSUPP;
+}
 static inline int sata_link_resume(struct ata_link *link,
 				   const unsigned long *params,
 				   unsigned long deadline)
-- 
2.24.1

