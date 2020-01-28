Return-Path: <SRS0=dw68=3R=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D8EFC3F68F
	for <linux-ide@archiver.kernel.org>; Tue, 28 Jan 2020 13:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21CD22468E
	for <linux-ide@archiver.kernel.org>; Tue, 28 Jan 2020 13:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="JgbbXAiI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbgA1Net (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 28 Jan 2020 08:34:49 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:58923 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbgA1NeU (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 28 Jan 2020 08:34:20 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200128133417euoutp014ec82854c6cdddee2199fb8d784efcbf~uEFCqf-X30189001890euoutp01O
        for <linux-ide@vger.kernel.org>; Tue, 28 Jan 2020 13:34:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200128133417euoutp014ec82854c6cdddee2199fb8d784efcbf~uEFCqf-X30189001890euoutp01O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1580218457;
        bh=MSsDQt5Pg4t4BFk2Ll3SVYQv6ObFV5LjYpoHSs93Inw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JgbbXAiImp9pltcVS6+T5YsQhHCme/SFUwPfY3DeCC4bbFlWWhsRJ76jkFbYauTPP
         n3/rG8kBw+J9ehL43AikaOYLoK0IO2Brz126bvIbh/Lojq18B9rAbF48AiGsyRvkRV
         8e7UBo76I1nwdmVPfCDDTwWuMm9q3g9yb7SRNJdE=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200128133417eucas1p2a022c9c89c709de575118cfd88db350c~uEFCOLNH32469924699eucas1p2x;
        Tue, 28 Jan 2020 13:34:17 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id A9.DA.60698.958303E5; Tue, 28
        Jan 2020 13:34:17 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200128133417eucas1p1b907d220ad2b809cdf628fb47a14589c~uEFB57vDd0713407134eucas1p1v;
        Tue, 28 Jan 2020 13:34:17 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200128133417eusmtrp24cf63c301d0a681fb9929ef9c67fce57~uEFB5YMPd0330103301eusmtrp23;
        Tue, 28 Jan 2020 13:34:17 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-bf-5e30385941d4
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 45.92.08375.858303E5; Tue, 28
        Jan 2020 13:34:16 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200128133416eusmtip21911f557d610ec023d6ac9a132b2f1a1~uEFBiNZSG0657106571eusmtip2j;
        Tue, 28 Jan 2020 13:34:16 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH 19/28] ata: move sata_link_hardreset() to libata-core-sata.c
Date:   Tue, 28 Jan 2020 14:33:34 +0100
Message-Id: <20200128133343.29905-20-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200128133343.29905-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRmVeSWpSXmKPExsWy7djP87qRFgZxBmuaJSxW3+1ns9g4Yz2r
        xbNbe5ksju14xGRxedccNou5rdPZHdg8ds66y+5x+Wypx6HDHYwefVtWMXp83iQXwBrFZZOS
        mpNZllqkb5fAlfFxwQX2gtnhFU2HbzE2MO527WLk5JAQMJFYdu0tYxcjF4eQwApGiYNnzrBD
        OF8YJRY+vAGV+cwo8f/EU0aYlj0Nr9kgEssZJc6dusUCkgBruXEWzGYTsJKY2L4KrEFEQEGi
        5/dKsAZmgTWMEqsON4ElhAV8JP5cX8oGYrMIqErcbPrDBGLzCthJ3Hz9jR1im7zE1m+fWLsY
        OTg4geI9e80hSgQlTs58AraLGaikeetsZpD5EgLt7BLHti+B6nWReHf2CCuELSzx6vgWqLiM
        xP+d85kgGtYxSvzteAHVvZ1RYvnkf2wQVdYSd879YgPZzCygKbF+lz5E2FFi2ollTCBhCQE+
        iRtvBSGO4JOYtG06M0SYV6KjTQiiWk1iw7INbDBru3auZIawPSR+zfjEPoFRcRaSd2YheWcW
        wt4FjMyrGMVTS4tz01OLjfNSy/WKE3OLS/PS9ZLzczcxAhPM6X/Hv+5g3Pcn6RCjAAejEg+v
        g5JBnBBrYllxZe4hRgkOZiUR3k4moBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFe40UvY4UE0hNL
        UrNTUwtSi2CyTBycUg2MonYXtp4+td7SrvX2N6aP1c9vy6gKzv69vTpA01twYX2G5DzlnWka
        CpOWLtrkUHo+5uTb3e8u8ORzuhS3VNx50SV981bk3lAtk4XBBa+0Tz0Qk4jmct/Qy+Hgvvdo
        ueevTc43Xyze11RV/eCKYcdbCxfNBaqBBxjF5dkrTeW4BQK6q7vsZ71XYinOSDTUYi4qTgQA
        lmzSdCwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjkeLIzCtJLcpLzFFi42I5/e/4Pd0IC4M4g/+XbCxW3+1ns9g4Yz2r
        xbNbe5ksju14xGRxedccNou5rdPZHdg8ds66y+5x+Wypx6HDHYwefVtWMXp83iQXwBqlZ1OU
        X1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5egl/FxwQX2gtnh
        FU2HbzE2MO527WLk5JAQMJHY0/CarYuRi0NIYCmjxPK+/axdjBxACRmJ4+vLIGqEJf5c64Kq
        +cQoMX/tNxaQBJuAlcTE9lWMILaIgIJEz++VYEXMAhsYJV7d/AJWJCzgI/Hn+lI2EJtFQFXi
        ZtMfJhCbV8BO4ubrb+wQG+Qltn77BLaYEyjes9ccJCwkYCux/sxTVohyQYmTM5+AjWQGKm/e
        Opt5AqPALCSpWUhSCxiZVjGKpJYW56bnFhvqFSfmFpfmpesl5+duYgTGwbZjPzfvYLy0MfgQ
        owAHoxIP7wwVgzgh1sSy4srcQ4wSHMxKIrydTEAh3pTEyqrUovz4otKc1OJDjKZAP0xklhJN
        zgfGaF5JvKGpobmFpaG5sbmxmYWSOG+HwMEYIYH0xJLU7NTUgtQimD4mDk6pBka7S0xnD/xp
        UykV+b1t3Xm9aj1h32tzf3ssOcf+xGeB7F3RUM/wC2E7mbn3mwanTJmQdHpXU1pY+t0pDgFN
        +/f7+Sc6NouIzZtzPJuxXYPdgyUodqn2g38FyUf5FjoYTM86+fRerHjX7ltrnzeb8m6XfKF/
        6N2nfRp6N6timRmfLzk7Q0W3x1+JpTgj0VCLuag4EQAH8N9zmQIAAA==
X-CMS-MailID: 20200128133417eucas1p1b907d220ad2b809cdf628fb47a14589c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200128133417eucas1p1b907d220ad2b809cdf628fb47a14589c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200128133417eucas1p1b907d220ad2b809cdf628fb47a14589c
References: <20200128133343.29905-1-b.zolnierkie@samsung.com>
        <CGME20200128133417eucas1p1b907d220ad2b809cdf628fb47a14589c@eucas1p1.samsung.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

* move sata_link_hardreset() to libata-core-sata.c

* add static inline for CONFIG_SATA_HOST=n case

* make sata_set_spd_needed() static

Code size savings on m68k arch using atari_defconfig:

   text    data     bss     dec     hex filename
before:
  33909     572      40   34521    86d9 drivers/ata/libata-core.o
after:
  33574     572      40   34186    858a drivers/ata/libata-core.o

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/libata-core-sata.c | 115 ++++++++++++++++++++++++++++++++-
 drivers/ata/libata-core.c      | 113 --------------------------------
 drivers/ata/libata.h           |   2 -
 include/linux/libata.h         |  16 ++++-
 4 files changed, 127 insertions(+), 119 deletions(-)

diff --git a/drivers/ata/libata-core-sata.c b/drivers/ata/libata-core-sata.c
index 73f8be386a44..b43207396829 100644
--- a/drivers/ata/libata-core-sata.c
+++ b/drivers/ata/libata-core-sata.c
@@ -405,7 +405,7 @@ static int __sata_set_spd_needed(struct ata_link *link, u32 *scontrol)
  *	RETURNS:
  *	1 if SATA spd configuration is needed, 0 otherwise.
  */
-int sata_set_spd_needed(struct ata_link *link)
+static int sata_set_spd_needed(struct ata_link *link)
 {
 	u32 scontrol;
 
@@ -659,6 +659,119 @@ int sata_link_scr_lpm(struct ata_link *link, enum ata_lpm_policy policy,
 }
 EXPORT_SYMBOL_GPL(sata_link_scr_lpm);
 
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
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index d3587fb1e78c..bd82cab2996e 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3236,119 +3236,6 @@ int ata_std_prereset(struct ata_link *link, unsigned long deadline)
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
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index ea614ac10c76..518a8e08a26d 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -108,7 +108,6 @@ int ata_do_link_spd_horkage(struct ata_device *dev);
 int ata_dev_config_ncq(struct ata_device *dev, char *desc, size_t desc_sz);
 void sata_print_link_status(struct ata_link *link);
 int sata_down_spd_limit(struct ata_link *link, u32 spd_limit);
-int sata_set_spd_needed(struct ata_link *link);
 #else
 static inline int ata_do_link_spd_horkage(struct ata_device *dev) { return 0; }
 static inline int ata_dev_config_ncq(struct ata_device *dev, char *desc,
@@ -122,7 +121,6 @@ static inline int sata_down_spd_limit(struct ata_link *link, u32 spd_limit)
 {
 	return -EOPNOTSUPP;
 }
-static inline int sata_set_spd_needed(struct ata_link *link) { return 1; }
 #endif
 
 /* libata-acpi.c */
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 8a11ae3a019f..453322cdf64a 100644
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
@@ -1198,6 +1195,9 @@ extern int sata_link_resume(struct ata_link *link, const unsigned long *params,
 			    unsigned long deadline);
 extern int sata_link_scr_lpm(struct ata_link *link, enum ata_lpm_policy policy,
 			     bool spm_wakeup);
+extern int sata_link_hardreset(struct ata_link *link,
+			const unsigned long *timing, unsigned long deadline,
+			bool *online, int (*check_ready)(struct ata_link *));
 extern int ata_slave_link_init(struct ata_port *ap);
 extern void ata_tf_to_fis(const struct ata_taskfile *tf,
 			  u8 pmp, int is_cmd, u8 *fis);
@@ -1211,6 +1211,16 @@ static inline int sata_link_resume(struct ata_link *link,
 {
 	return -EOPNOTSUPP;
 }
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
 #endif
 
 extern int ata_cable_40wire(struct ata_port *ap);
-- 
2.24.1

