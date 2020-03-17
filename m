Return-Path: <SRS0=AjNr=5C=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD22AC3F2CE
	for <linux-ide@archiver.kernel.org>; Tue, 17 Mar 2020 14:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A31020738
	for <linux-ide@archiver.kernel.org>; Tue, 17 Mar 2020 14:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rBpdvG22"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgCQOo2 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 17 Mar 2020 10:44:28 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:40436 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbgCQOnx (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 17 Mar 2020 10:43:53 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200317144351euoutp0220069ef1469cb8a0f95e1c222f3c5164~9HoxLodBj1539915399euoutp02b
        for <linux-ide@vger.kernel.org>; Tue, 17 Mar 2020 14:43:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200317144351euoutp0220069ef1469cb8a0f95e1c222f3c5164~9HoxLodBj1539915399euoutp02b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1584456231;
        bh=8MBAjsiUopV2bdr9lLe2/Ejl1swX+eFx+nmIOJm/mgU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rBpdvG22msQUwODCpAtwh6gxSQBMs459kJ022IDo0YttBTTjCCoTA23QVP7cXf+to
         MGDcTHs9JTu/MtMGunL2A2SaNATAfd+1Io6rTom86cOHkoBEPxS7d0AYfMUsdFYYIB
         S5wZ+N2274WQSQtAIrqiNFxeQPvIe6uimqZv2K/E=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200317144351eucas1p2761253b22b65000174b136a7bd42586a~9How2rrD00133301333eucas1p2p;
        Tue, 17 Mar 2020 14:43:51 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 96.E9.60698.722E07E5; Tue, 17
        Mar 2020 14:43:51 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200317144350eucas1p157dd88ee3f766ec4fd209172635369aa~9HowZAaxR1086210862eucas1p1Z;
        Tue, 17 Mar 2020 14:43:50 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200317144350eusmtrp19688f8b51597b5347047adf12193185e~9HowVV4250867908679eusmtrp1t;
        Tue, 17 Mar 2020 14:43:50 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-f5-5e70e227ad01
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id C2.E4.08375.622E07E5; Tue, 17
        Mar 2020 14:43:50 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200317144350eusmtip1cd8ca995cb2b910a2633ed72c796ddfb~9Hov6VvlP0973009730eusmtip1Y;
        Tue, 17 Mar 2020 14:43:50 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH v4 20/27] ata: move sata_link_hardreset() to libata-sata.c
Date:   Tue, 17 Mar 2020 15:43:26 +0100
Message-Id: <20200317144333.2904-21-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200317144333.2904-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLKsWRmVeSWpSXmKPExsWy7djP87rqjwriDJZ8F7VYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRXDYpqTmZZalF+nYJXBl7jocXtIRWnO3cxNLAeNW5i5GTQ0LA
        RKL16BXWLkYuDiGBFYwSu96eY4NwvjBKTFq+Acr5zChxfsYMVpiWFzuOsEAkljNK/Lv9jB2u
        Zenvs+wgVWwCVhIT21cxgtgiAgoSPb9Xgo1iFnjPKLFi0l4WkISwgJfEppVNbCA2i4CqxIfH
        B8FsXgFbiU+N/6HWyUts/fYJzOYEil87/A+qRlDi5MwnYHOYgWqat85mBlkgIbCMXWL5gTNA
        CQ4gx0Xiz6o0iDnCEq+Ob2GHsGUkTk/uYYGoX8co8bfjBVTzdkaJ5ZMhNkgIWEvcOfeLDWQQ
        s4CmxPpd+hBhR4n+W08YIebzSdx4KwhxA5/EpG3TmSHCvBIdbUIQ1WoSG5ZtYINZ27VzJTOE
        7SFx/ewG1gmMirOQfDMLyTezEPYuYGRexSieWlqcm55abJyXWq5XnJhbXJqXrpecn7uJEZiI
        Tv87/nUH474/SYcYBTgYlXh4EzYVxAmxJpYVV+YeYpTgYFYS4V1cmB8nxJuSWFmVWpQfX1Sa
        k1p8iFGag0VJnNd40ctYIYH0xJLU7NTUgtQimCwTB6dUA+PJcrcguxeONw9rpM9fqnfge/7+
        VTOVplUe4LxVece0Jsh88q2kjMj1xiFbo89NlVa8FRR755KQxZWgeUqh159xc97ozog52MGs
        rO6k2MlmU73g61O38C23Ox+f3PWVo6xFUct1o5To4zUv4t/k9AiyrT9cwaQxuY3jplzAcmXr
        TTOSws472iixFGckGmoxFxUnAgBscRfdQAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsVy+t/xu7pqjwriDF6uMrNYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6
        djYpqTmZZalF+nYJehl7jocXtIRWnO3cxNLAeNW5i5GTQ0LAROLFjiMsXYxcHEICSxklZvbN
        Yexi5ABKyEgcX18GUSMs8edaFxtEzSdGifmf77CAJNgErCQmtq9iBLFFBBQken6vBCtiFvjK
        KLF0UjczSEJYwEti08omNhCbRUBV4sPjg2A2r4CtxKfG/6wQG+Qltn77BGZzAsWvHf4HViMk
        YCPx4s1/Joh6QYmTM5+ALWYGqm/eOpt5AqPALCSpWUhSCxiZVjGKpJYW56bnFhvqFSfmFpfm
        pesl5+duYgTGy7ZjPzfvYLy0MfgQowAHoxIPL8eGgjgh1sSy4srcQ4wSHMxKIryLC/PjhHhT
        EiurUovy44tKc1KLDzGaAj0xkVlKNDkfGMt5JfGGpobmFpaG5sbmxmYWSuK8HQIHY4QE0hNL
        UrNTUwtSi2D6mDg4pRoYbcJPGJxi3iCTyfFRMMK3ikXmDc+0r/y1C4VSbj6Ocy/gDBJ+xqn2
        3V7wX8U58WPnT98KYd6Y8rDau3kC/2yB517aN/r3vFzzvula4Y2a9om7nj+SuCbU8lr01PuM
        dXMkvBbFHKhgvlyV9Oc19zTfrXwb/BPVWOan8BeX5ly++fjP7qPFiV7mSizFGYmGWsxFxYkA
        FYu+c60CAAA=
X-CMS-MailID: 20200317144350eucas1p157dd88ee3f766ec4fd209172635369aa
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200317144350eucas1p157dd88ee3f766ec4fd209172635369aa
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200317144350eucas1p157dd88ee3f766ec4fd209172635369aa
References: <20200317144333.2904-1-b.zolnierkie@samsung.com>
        <CGME20200317144350eucas1p157dd88ee3f766ec4fd209172635369aa@eucas1p1.samsung.com>
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
 drivers/ata/libata-core.c | 110 -------------------------------------
 drivers/ata/libata-sata.c | 112 +++++++++++++++++++++++++++++++++++++-
 drivers/ata/libata.h      |   7 ---
 include/linux/libata.h    |  16 +++++-
 4 files changed, 124 insertions(+), 121 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 9c4c7f6d90fc..1879072419fe 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3543,116 +3543,6 @@ int ata_std_prereset(struct ata_link *link, unsigned long deadline)
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
-	return rc;
-}
-EXPORT_SYMBOL_GPL(sata_link_hardreset);
-
 /**
  *	sata_std_hardreset - COMRESET w/o waiting or classification
  *	@link: link to reset
diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index 34852fced999..ccd60f71ca31 100644
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
 
@@ -490,6 +490,116 @@ int sata_set_spd(struct ata_link *link)
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
index f67a7bbb3c35..ecee9544fb86 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1069,9 +1069,6 @@ static inline int ata_port_is_dummy(struct ata_port *ap)
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

