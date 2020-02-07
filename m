Return-Path: <SRS0=qhS8=33=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFEE6C35242
	for <linux-ide@archiver.kernel.org>; Fri,  7 Feb 2020 14:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2F47217BA
	for <linux-ide@archiver.kernel.org>; Fri,  7 Feb 2020 14:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="osjBJICm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbgBGO21 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 7 Feb 2020 09:28:27 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:59687 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727843AbgBGO2G (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 7 Feb 2020 09:28:06 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200207142804euoutp01241659895730ee67ac5fc001d63f9a00~xJQ2xJa-V2084620846euoutp01Z
        for <linux-ide@vger.kernel.org>; Fri,  7 Feb 2020 14:28:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200207142804euoutp01241659895730ee67ac5fc001d63f9a00~xJQ2xJa-V2084620846euoutp01Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1581085684;
        bh=FUd6xhoC/qV1w/XW5ncEkD/KhYSLrw1iKI+rpkPuva8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=osjBJICmghMk0rHL9Ym/9s2O3VI7O89b80blZHmlzO5eZl06qfwaPetnP1jqvNLut
         ozyNfQT1XcgiFjAkl3RHj4ra60dteUspRHieZwPgUqXO7AZHUgcJW6/O0G2rVpeDMM
         /5b11H4LI94qydGTG40AWSxBdONcuiYHpXGsQY2I=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200207142804eucas1p1b6aac3d08d84bc272a4a4f9b87ea6087~xJQ2g_0R11078610786eucas1p17;
        Fri,  7 Feb 2020 14:28:04 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 46.D8.60698.4F37D3E5; Fri,  7
        Feb 2020 14:28:04 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200207142804eucas1p109106a07c632440423b850168f26f7d8~xJQ2Fmf-31078610786eucas1p16;
        Fri,  7 Feb 2020 14:28:04 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200207142804eusmtrp160f62086b17186e08ee214a4872db98c~xJQ2FBTx10480004800eusmtrp1d;
        Fri,  7 Feb 2020 14:28:04 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-d8-5e3d73f4f1e3
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id D3.99.08375.4F37D3E5; Fri,  7
        Feb 2020 14:28:04 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200207142803eusmtip28d0659c48d9a48054309de4956df19f8~xJQ1nm9dM3158331583eusmtip2D;
        Fri,  7 Feb 2020 14:28:03 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH v2 26/26] ata: make "libata.force" kernel parameter optional
Date:   Fri,  7 Feb 2020 15:27:34 +0100
Message-Id: <20200207142734.8431-27-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200207142734.8431-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNKsWRmVeSWpSXmKPExsWy7djPc7pfim3jDN4eVbJYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRXDYpqTmZZalF+nYJXBnfzwoWLFSr2PjiG3MD40b5LkZODgkB
        E4lTVx4zdzFycQgJrGCUePNoHytIQkjgC6NEy8cqiMRnRomnh7YydjFygHU03S+HiC9nlFg5
        bws7hAPUcPXTXbBuNgEriYntqxhBbBEBBYme3yvZQIqYBd4zSqyYtJcFJCEs4COxbPMbsCIW
        AVWJ7tUnwGxeAVuJOS03mCHuk5fY+u0T2FBOoPjHKX/ZIGoEJU7OfAI2hxmopnnrbLAfJASW
        sUu8b2xggmh2kdh17TgrhC0s8eo4yKkgtozE6ck9LBAN6xgl/na8gOreziixfPI/Nogqa4k7
        536xgTzNLKApsX6XPsT/jhITz3hDmHwSN94KQtzAJzFp23RmiDCvREebEMQMNYkNyzawwWzt
        2rkS6i0PiW/dvUwTGBVnIflmFpJvZiGsXcDIvIpRPLW0ODc9tdg4L7Vcrzgxt7g0L10vOT93
        EyMwCZ3+d/zrDsZ9f5IOMQpwMCrx8CY42sQJsSaWFVfmHmKU4GBWEuHtU7WNE+JNSaysSi3K
        jy8qzUktPsQozcGiJM5rvOhlrJBAemJJanZqakFqEUyWiYNTqoGxbfKVm50+Yf/2fH8pmO5S
        dL3h6rJFivOvh3byubAdfpW03+ecSbNl8MuFV+VmsSiXui5WtXv4godRzqnUuOtVYG70V/sZ
        nCki7uJTXkzz+aWQ7OLn/s/w8daQr/ZtByIbJ/uUGP3jv3sx05c94oeXYOWBtTfvd/Pvqihc
        pp3sx81lt9f8lqQSS3FGoqEWc1FxIgDU73GQPgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsVy+t/xe7pfim3jDO7M57BYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6
        djYpqTmZZalF+nYJehnfzwoWLFSr2PjiG3MD40b5LkYODgkBE4mm++VdjFwcQgJLGSXWfHjI
        DBGXkTi+vqyLkRPIFJb4c62LDaLmE6PE2/Nf2EESbAJWEhPbVzGC2CICChI9v1eCFTELfGWU
        WDqpmxkkISzgI7Fs8xuwIhYBVYnu1SfAbF4BW4k5LTeYITbIS2z99okVxOYEin+c8pcNxBYS
        sJH4/n4SO0S9oMTJmU9YQGxmoPrmrbOZJzAKzEKSmoUktYCRaRWjSGppcW56brGhXnFibnFp
        Xrpecn7uJkZgtGw79nPzDsZLG4MPMQpwMCrx8CY42sQJsSaWFVfmHmKU4GBWEuHtU7WNE+JN
        SaysSi3Kjy8qzUktPsRoCvTERGYp0eR8YCTnlcQbmhqaW1gamhubG5tZKInzdggcjBESSE8s
        Sc1OTS1ILYLpY+LglGpgrPLOmiBuviCN1zN78xXn4MV3647If9Jd8fDD1AWrz4hY2bf4hcW+
        vzKj89PjWOn8N1N/FbRWhlz1WCOw55Xz1xf7pBanbeaYJrlL5INxxyf/JDmvD8v2zH1WybCR
        zaJj50xpkd9q+QJLL1W0z37i+iL/UHfg2w0Hlipr/p/AmMqtfefd47tVt5VYijMSDbWYi4oT
        ATmEzSGsAgAA
X-CMS-MailID: 20200207142804eucas1p109106a07c632440423b850168f26f7d8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200207142804eucas1p109106a07c632440423b850168f26f7d8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200207142804eucas1p109106a07c632440423b850168f26f7d8
References: <20200207142734.8431-1-b.zolnierkie@samsung.com>
        <CGME20200207142804eucas1p109106a07c632440423b850168f26f7d8@eucas1p1.samsung.com>
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
index 1a3218e81703..fb1bd65acb3c 100644
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
@@ -6059,6 +6067,7 @@ int ata_platform_remove_one(struct platform_device *pdev)
 }
 EXPORT_SYMBOL_GPL(ata_platform_remove_one);
 
+#ifdef CONFIG_ATA_FORCE
 static int __init ata_parse_force_one(char **cur,
 				      struct ata_force_ent *force_ent,
 				      const char **reason)
@@ -6238,6 +6247,15 @@ static void __init ata_parse_force_param(void)
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
@@ -6246,7 +6264,7 @@ static int __init ata_init(void)
 
 	rc = ata_sff_init();
 	if (rc) {
-		kfree(ata_force_tbl);
+		ata_free_force_param();
 		return rc;
 	}
 
@@ -6270,7 +6288,7 @@ static void __exit ata_exit(void)
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

