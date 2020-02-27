Return-Path: <SRS0=ljer=4P=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15190C11D3D
	for <linux-ide@archiver.kernel.org>; Thu, 27 Feb 2020 18:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E54CB246A6
	for <linux-ide@archiver.kernel.org>; Thu, 27 Feb 2020 18:23:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Tf+1kBE4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731055AbgB0SWz (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 27 Feb 2020 13:22:55 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:59192 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731053AbgB0SWx (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 27 Feb 2020 13:22:53 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200227182252euoutp02bb536b7ef4bdb069b111f8157a54e12b~3VXkeh7kj0821508215euoutp02d
        for <linux-ide@vger.kernel.org>; Thu, 27 Feb 2020 18:22:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200227182252euoutp02bb536b7ef4bdb069b111f8157a54e12b~3VXkeh7kj0821508215euoutp02d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1582827772;
        bh=oJxinzcZQikeV/qL4opDhOfrDKNJwOP6OlMTsUMGRiY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tf+1kBE48hL5R2J9jtYtJYIqR8ddC1nBJfe5qsCcmzlZt98WLHhfudh3W+I1+8aV5
         0cOR0WjmzFe0ILXv4Y0rYZI+yDzdULeJung742Ju2fy+kN+OE5EcFpzXXAygUFfNH0
         VBcm8/+LkuROlGAp0y77u+T0LDZL+ExQJjCsmcIM=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200227182252eucas1p1d179917c42fb9f6fb3f26ac6fef685f7~3VXkKcv8c1937419374eucas1p19;
        Thu, 27 Feb 2020 18:22:52 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id E9.5F.60679.CF8085E5; Thu, 27
        Feb 2020 18:22:52 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200227182251eucas1p1f8f29d3df1a07a6997e3b7c3a3176cb3~3VXjroDEW1207712077eucas1p1H;
        Thu, 27 Feb 2020 18:22:51 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200227182251eusmtrp1a40827692d3926ac0f120ca631b6d2aa~3VXjq3xS-0185901859eusmtrp1l;
        Thu, 27 Feb 2020 18:22:51 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-c0-5e5808fc449c
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id C8.61.07950.BF8085E5; Thu, 27
        Feb 2020 18:22:51 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200227182251eusmtip207341bec51687cae47c64fa54dd7b401~3VXjKnZII2149421494eusmtip2N;
        Thu, 27 Feb 2020 18:22:51 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH v3 27/27] ata: make "libata.force" kernel parameter optional
Date:   Thu, 27 Feb 2020 19:22:26 +0100
Message-Id: <20200227182226.19188-28-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200227182226.19188-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLKsWRmVeSWpSXmKPExsWy7djPc7p/OCLiDD7MELNYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRXDYpqTmZZalF+nYJXBk/tx9nKlioVrGhdQNzA+NG+S5GTg4J
        AROJ220PWLoYuTiEBFYwSuxYtZ8RwvnCKDH33A5GkCohgc+MEqdfMsJ0tP4+BNWxnFHi29mF
        CB3vHs1kAaliE7CSmNi+CqxDREBBouf3SjaQImaB94wSKybtBSsSFvCR+PJ5KiuIzSKgKvF6
        zQs2EJtXwE7i0pleVoh18hJbv30CszmB4jf6tkPVCEqcnPkEbA4zUE3z1tnMIAskBFaxS1xr
        Xgp1q4vEzX3HWSBsYYlXx7ewQ9gyEqcn97BANKxjlPjb8QKqezujxPLJ/9ggqqwl7pz7BWRz
        AK3QlFi/Sx8i7Cgx7+RCZpCwhACfxI23ghBH8ElM2jYdKswr0dEmBFGtJrFh2QY2mLVdO1dC
        lXhILH5aPoFRcRaSb2Yh+WYWwtoFjMyrGMVTS4tz01OLjfJSy/WKE3OLS/PS9ZLzczcxAhPR
        6X/Hv+xg3PUn6RCjAAejEg/vgh3hcUKsiWXFlbmHGCU4mJVEeDd+DY0T4k1JrKxKLcqPLyrN
        SS0+xCjNwaIkzmu86GWskEB6YklqdmpqQWoRTJaJg1OqgbFGUCn057GrRe9MuI9MdWi02CW4
        7/T2n+t6xSZFOUl/+t/f4cNsPHuGN8PhpdODmzsm75bR/cOX5yTJ0ndJLvr8zQn/Pf9tjr5d
        va1Ta7PW2hkbLnSZSa3YEBwosnlGuOr0ZVPePespK6z/2PJY20bcRep8do4P679bV+W/bk5h
        PGz7Y82q1Z1KLMUZiYZazEXFiQBrweM/QAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsVy+t/xe7q/OSLiDCZO1rNYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6
        djYpqTmZZalF+nYJehk/tx9nKlioVrGhdQNzA+NG+S5GTg4JAROJ1t+HWLoYuTiEBJYySvxb
        N4e1i5EDKCEjcXx9GUSNsMSfa11sEDWfGCX27zrCCpJgE7CSmNi+ihHEFhFQkOj5vRKsiFng
        K6PE0kndzCAJYQEfiS+fp4I1sAioSrxe84INxOYVsJO4dKaXFWKDvMTWb5/AbE6g+I2+7WA1
        QgK2El0dTxkh6gUlTs58wgJiMwPVN2+dzTyBUWAWktQsJKkFjEyrGEVSS4tz03OLjfSKE3OL
        S/PS9ZLzczcxAiNm27GfW3Ywdr0LPsQowMGoxMPrsS08Tog1say4MvcQowQHs5II78avoXFC
        vCmJlVWpRfnxRaU5qcWHGE2BnpjILCWanA+M5rySeENTQ3MLS0NzY3NjMwslcd4OgYMxQgLp
        iSWp2ampBalFMH1MHJxSDYwOS3ZdlFp3ibFgUaySYXjYaa13W1Jn+y5R1knafmvRtrOH1UWU
        pP61SQjMEGp4/b1w0U1eVYmT7ic815oaG7Tazzu9r2LL9eUcix1K7Z0XPjlacILbSTTN9fvs
        pevPrtbbcTb86cy3/4QCUicynwt7ln0s19j2ghFP0IeUezK26XtDj0x5IGqmxFKckWioxVxU
        nAgA0IWCRK4CAAA=
X-CMS-MailID: 20200227182251eucas1p1f8f29d3df1a07a6997e3b7c3a3176cb3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200227182251eucas1p1f8f29d3df1a07a6997e3b7c3a3176cb3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200227182251eucas1p1f8f29d3df1a07a6997e3b7c3a3176cb3
References: <20200227182226.19188-1-b.zolnierkie@samsung.com>
        <CGME20200227182251eucas1p1f8f29d3df1a07a6997e3b7c3a3176cb3@eucas1p1.samsung.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Add ATA_FORCE config option (visible only if EXPERT config
option is enabled) and make "libata.force" kernel parameter
optional.

Code size savings on m68k arch using (modified) atari_defconfig:

   text    data     bss     dec     hex filename
w/ CONFIG_ATA_FORCE=y:
  31983     572      40   32595    7f53 drivers/ata/libata-core.o
w/ CONFIG_ATA_FROCE=n:
  28958     316      32   29306    727a drivers/ata/libata-core.o

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/Kconfig       | 16 ++++++++++++++++
 drivers/ata/libata-core.c | 22 ++++++++++++++++++++--
 drivers/ata/libata.h      |  4 ++++
 3 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 5b55ebf56b5a..05ecdce1b702 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -51,6 +51,22 @@ config ATA_VERBOSE_ERROR
 
 	  If unsure, say Y.
 
+config ATA_FORCE
+	bool "\"libata.force=\" kernel parameter support" if EXPERT
+	default y
+	help
+	  This option adds support for "libata.force=" kernel parameter for
+	  forcing configuration settings.
+
+	  For further information, please read
+	  <file:Documentation/admin-guide/kernel-parameters.txt>.
+
+	  This option will enlarge the kernel by approx. 3KB. Disable it if
+	  kernel size is more important than ability to override the default
+	  configuration settings.
+
+	  If unsure, say Y.
+
 config ATA_ACPI
 	bool "ATA ACPI Support"
 	depends on ACPI
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 20c22dbc1f24..beca5f91bb4c 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -89,6 +89,7 @@ static unsigned long ata_dev_blacklisted(const struct ata_device *dev);
 
 atomic_t ata_print_id = ATOMIC_INIT(0);
 
+#ifdef CONFIG_ATA_FORCE
 struct ata_force_param {
 	const char	*name;
 	u8		cbl;
@@ -112,6 +113,7 @@ static char ata_force_param_buf[COMMAND_LINE_SIZE] __initdata;
 /* param_buf is thrown away after initialization, disallow read */
 module_param_string(force, ata_force_param_buf, sizeof(ata_force_param_buf), 0);
 MODULE_PARM_DESC(force, "Force ATA configurations including cable type, link speed and transfer mode (see Documentation/admin-guide/kernel-parameters.rst for details)");
+#endif
 
 static int atapi_enabled = 1;
 module_param(atapi_enabled, int, 0444);
@@ -303,6 +305,7 @@ struct ata_link *ata_dev_phys_link(struct ata_device *dev)
 	return ap->slave_link;
 }
 
+#ifdef CONFIG_ATA_FORCE
 /**
  *	ata_force_cbl - force cable type according to libata.force
  *	@ap: ATA port of interest
@@ -483,6 +486,11 @@ static void ata_force_horkage(struct ata_device *dev)
 			       fe->param.name);
 	}
 }
+#else
+static inline void ata_force_link_limits(struct ata_link *link) { }
+static inline void ata_force_xfermask(struct ata_device *dev) { }
+static inline void ata_force_horkage(struct ata_device *dev) { }
+#endif
 
 /**
  *	atapi_cmd_type - Determine ATAPI command type from SCSI opcode
@@ -6080,6 +6088,7 @@ int ata_platform_remove_one(struct platform_device *pdev)
 }
 EXPORT_SYMBOL_GPL(ata_platform_remove_one);
 
+#ifdef CONFIG_ATA_FORCE
 static int __init ata_parse_force_one(char **cur,
 				      struct ata_force_ent *force_ent,
 				      const char **reason)
@@ -6259,6 +6268,15 @@ static void __init ata_parse_force_param(void)
 	ata_force_tbl_size = idx;
 }
 
+static void ata_free_force_param(void)
+{
+	kfree(ata_force_tbl);
+}
+#else
+static inline void ata_parse_force_param(void) { }
+static inline void ata_free_force_param(void) { }
+#endif
+
 static int __init ata_init(void)
 {
 	int rc;
@@ -6267,7 +6285,7 @@ static int __init ata_init(void)
 
 	rc = ata_sff_init();
 	if (rc) {
-		kfree(ata_force_tbl);
+		ata_free_force_param();
 		return rc;
 	}
 
@@ -6291,7 +6309,7 @@ static void __exit ata_exit(void)
 	ata_release_transport(ata_scsi_transport_template);
 	libata_transport_exit();
 	ata_sff_exit();
-	kfree(ata_force_tbl);
+	ata_free_force_param();
 }
 
 subsys_initcall(ata_init);
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 6c808cf39135..68cdd81d747c 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -37,7 +37,11 @@ extern int libata_noacpi;
 extern int libata_allow_tpm;
 extern const struct device_type ata_port_type;
 extern struct ata_link *ata_dev_phys_link(struct ata_device *dev);
+#ifdef CONFIG_ATA_FORCE
 extern void ata_force_cbl(struct ata_port *ap);
+#else
+static inline void ata_force_cbl(struct ata_port *ap) { }
+#endif
 extern u64 ata_tf_to_lba(const struct ata_taskfile *tf);
 extern u64 ata_tf_to_lba48(const struct ata_taskfile *tf);
 extern struct ata_queued_cmd *ata_qc_new_init(struct ata_device *dev, int tag);
-- 
2.24.1

