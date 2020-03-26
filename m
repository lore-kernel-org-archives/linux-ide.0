Return-Path: <SRS0=jBxd=5L=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC458C2D0ED
	for <linux-ide@archiver.kernel.org>; Thu, 26 Mar 2020 15:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9588F20737
	for <linux-ide@archiver.kernel.org>; Thu, 26 Mar 2020 15:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="h8Nu6R7w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbgCZP7V (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 26 Mar 2020 11:59:21 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:58986 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728595AbgCZP6u (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 26 Mar 2020 11:58:50 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200326155847euoutp01e9b73bfd9b556646c2a54cb1e4ec2558~-5dw7TEAL3032230322euoutp01E
        for <linux-ide@vger.kernel.org>; Thu, 26 Mar 2020 15:58:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200326155847euoutp01e9b73bfd9b556646c2a54cb1e4ec2558~-5dw7TEAL3032230322euoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585238327;
        bh=UjXMYxtl1H/9Fkd6zmTpzA/DzNeAj5oMfvoZE0TRpqk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h8Nu6R7w3WDbWs7nE6C5Gr0sB6Uj+RzSNAJMdmFOdAMdRLRpDewGQWQmd8STQNkiw
         AOYIUm++nCibGId8yw/eictJ3swk8VaiIOYa+csZgsyYlcr5i11NWTnFwc5FTc6Wud
         3Ozs+13tt/r8m08Q8HDciz7KLTBqx1oWMpnWU2bQ=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200326155847eucas1p21e13686fd7f98486c9d3d10abb0754b7~-5dwjcgxf3015130151eucas1p24;
        Thu, 26 Mar 2020 15:58:47 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 08.E9.60679.731DC7E5; Thu, 26
        Mar 2020 15:58:47 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200326155846eucas1p26ed8a94105fa06625f4fd2c4a66f8960~-5dvrdhZx2633426334eucas1p2f;
        Thu, 26 Mar 2020 15:58:46 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200326155846eusmtrp162b5e2676a315d852231707e5c8045b1~-5dvqzE7W2091520915eusmtrp1W;
        Thu, 26 Mar 2020 15:58:46 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-d7-5e7cd1373a15
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id A0.6A.08375.631DC7E5; Thu, 26
        Mar 2020 15:58:46 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200326155846eusmtip1a9e1e4ae9681b5508286a04070392218~-5dvS6l7F1572315723eusmtip1t;
        Thu, 26 Mar 2020 15:58:46 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH v5 20/27] ata: move sata_link_hardreset() to libata-sata.c
Date:   Thu, 26 Mar 2020 16:58:15 +0100
Message-Id: <20200326155822.19400-21-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200326155822.19400-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHKsWRmVeSWpSXmKPExsWy7djP87rmF2viDFo/ilqsvtvPZrFxxnpW
        i2e39jJZrFx9lMni2I5HTBaXd81hs1j+ZC2zxdzW6ewOHB47Z91l97h8ttTj0OEORo+Trd9Y
        PHbfbGDz6NuyitHj8ya5APYoLpuU1JzMstQifbsEroyJm9eyFiwPq7i0+hBbA+N9ly5GTg4J
        AROJxkWXGbsYuTiEBFYwSpw8cQvK+cIoMb9hKitIlZDAZ0aJ29f8YDqaW76yQBQtZ5SYO3c5
        O1xH++UnLCBVbAJWEhPbVzGC2CICChI9v1eygRQxC7xnlFgxaS9YkbCAl8TzdfOYQGwWAVWJ
        fTevsoHYvAJ2Egc39rFDrJOX2PrtE9gZnEDx5evmM0PUCEqcnAmxjBmopnnrbGaQBRICy9gl
        Zn8+wwrR7CKxb/NnRghbWOLV8S1QQ2UkTk/uYYFoWMco8bfjBVT3dkaJ5ZP/sUFUWUvcOfcL
        yOYAWqEpsX6XPkTYUWLNoQPsIGEJAT6JG28FIY7gk5i0bTozRJhXoqNNCKJaTWLDsg1sMGu7
        dq5khrA9JH6eW8s2gVFxFpJ3ZiF5ZxbC3gWMzKsYxVNLi3PTU4uN8lLL9YoTc4tL89L1kvNz
        NzECU9Hpf8e/7GDc9SfpEKMAB6MSD69GS02cEGtiWXFl7iFGCQ5mJRHep5FAId6UxMqq1KL8
        +KLSnNTiQ4zSHCxK4rzGi17GCgmkJ5akZqemFqQWwWSZODilGhizpAs9XikedlW06D/1uCFM
        9KPXHXnN/SzffTtzFwpaNMy0DyvwXrF9zuvleXK7Jy1p3z99ec6Tt7uNLFcEdBvpvmiYbyx0
        h/F3Un1gUkCHxcl7dw49Dpbe+cC7xOebygwR/y5ZwbMbV1+z/6QhxSls/D2675B4B6t2tG3I
        tKqb2SuW9d+Q41JiKc5INNRiLipOBAAiYRnUQQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsVy+t/xu7pmF2viDM6dUbBYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6
        djYpqTmZZalF+nYJehkTN69lLVgeVnFp9SG2Bsb7Ll2MnBwSAiYSzS1fWboYuTiEBJYyShzZ
        MhPI4QBKyEgcX18GUSMs8edaFxtEzSdGiS1LpzGCJNgErCQmtq8Cs0UEFCR6fq8EK2IW+Moo
        sXRSNzNIQljAS+L5unlMIDaLgKrEvptX2UBsXgE7iYMb+9ghNshLbP32iRXE5gSKL183H6xX
        SMBWYvGXD0wQ9YISJ2c+YQGxmYHqm7fOZp7AKDALSWoWktQCRqZVjCKppcW56bnFhnrFibnF
        pXnpesn5uZsYgRGz7djPzTsYL20MPsQowMGoxMOr0VITJ8SaWFZcmXuIUYKDWUmE92kkUIg3
        JbGyKrUoP76oNCe1+BCjKdATE5mlRJPzgdGcVxJvaGpobmFpaG5sbmxmoSTO2yFwMEZIID2x
        JDU7NbUgtQimj4mDU6qBcWbqbTO7jjb9aIbGZcoWi5x3659e7jrnbuu8tleiUoseWCd+Prd9
        +Wuhjn+ThL+ZNur3Hj5wnlur/u+pgz2ZVSz+h2dPyb7hd84xegd7u9jPzYzLHsVKxM/9MLNR
        UJi1c/qtdXdUi03lFk+ZaKP55zVPf7JWtN3a5ZoHZ9RPfsh81H2lVDcwnbAUZyQaajEXFScC
        ABwRUwiuAgAA
X-CMS-MailID: 20200326155846eucas1p26ed8a94105fa06625f4fd2c4a66f8960
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200326155846eucas1p26ed8a94105fa06625f4fd2c4a66f8960
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200326155846eucas1p26ed8a94105fa06625f4fd2c4a66f8960
References: <20200326155822.19400-1-b.zolnierkie@samsung.com>
        <CGME20200326155846eucas1p26ed8a94105fa06625f4fd2c4a66f8960@eucas1p2.samsung.com>
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

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/libata-core.c | 113 -------------------------------------
 drivers/ata/libata-sata.c | 115 +++++++++++++++++++++++++++++++++++++-
 drivers/ata/libata.h      |   7 ---
 include/linux/libata.h    |  16 +++++-
 4 files changed, 127 insertions(+), 124 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 4ca81ef7c8bd..19624d056d92 100644
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
index b05538d06919..981f73c02509 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1077,9 +1077,6 @@ static inline int ata_port_is_dummy(struct ata_port *ap)
 extern int ata_std_prereset(struct ata_link *link, unsigned long deadline);
 extern int ata_wait_after_reset(struct ata_link *link, unsigned long deadline,
 				int (*check_ready)(struct ata_link *link));
-extern int sata_link_hardreset(struct ata_link *link,
-			const unsigned long *timing, unsigned long deadline,
-			bool *online, int (*check_ready)(struct ata_link *));
 extern int sata_std_hardreset(struct ata_link *link, unsigned int *class,
 			      unsigned long deadline);
 extern void ata_std_postreset(struct ata_link *link, unsigned int *classes);
@@ -1190,6 +1187,9 @@ extern int sata_scr_read(struct ata_link *link, int reg, u32 *val);
 extern int sata_scr_write(struct ata_link *link, int reg, u32 val);
 extern int sata_scr_write_flush(struct ata_link *link, int reg, u32 val);
 extern int sata_set_spd(struct ata_link *link);
+extern int sata_link_hardreset(struct ata_link *link,
+			const unsigned long *timing, unsigned long deadline,
+			bool *online, int (*check_ready)(struct ata_link *));
 extern int sata_link_resume(struct ata_link *link, const unsigned long *params,
 			    unsigned long deadline);
 #else
@@ -1207,6 +1207,16 @@ static inline int sata_scr_write_flush(struct ata_link *link, int reg, u32 val)
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

