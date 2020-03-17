Return-Path: <SRS0=AjNr=5C=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC72C18E5B
	for <linux-ide@archiver.kernel.org>; Tue, 17 Mar 2020 14:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8108D20735
	for <linux-ide@archiver.kernel.org>; Tue, 17 Mar 2020 14:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qB91acBH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgCQOoC (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 17 Mar 2020 10:44:02 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:40368 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbgCQOn4 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 17 Mar 2020 10:43:56 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200317144355euoutp02ab7d5e0e59839f182e6e5688794a4fa8~9Ho0y7NzB1582715827euoutp02N
        for <linux-ide@vger.kernel.org>; Tue, 17 Mar 2020 14:43:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200317144355euoutp02ab7d5e0e59839f182e6e5688794a4fa8~9Ho0y7NzB1582715827euoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1584456235;
        bh=Cpkdj+eqF9bnPmcwelMrostN1LPLwcwyIaRZUoPmpoM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qB91acBHj1W98UY9e1r6hd2PK6P8Pirx968BdICxWwfcmuB3bSfM10odTmrAeVYWq
         MjEW6FGahttM+0l0p7bwA584NJ6PTtDOVm+S2utf1QlElIRqf26rd4TaVu+ze0Ea93
         4DWIUJCWsr7UiAvlfUYnOX1bMUgmk5sNerV5J2CY=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200317144355eucas1p179e41f16b70d8e67ad15d7dd9648a9c7~9Ho0L28HN1084410844eucas1p1a;
        Tue, 17 Mar 2020 14:43:55 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 98.E9.60698.A22E07E5; Tue, 17
        Mar 2020 14:43:55 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200317144354eucas1p250e3fc557c00a80eda42b3332984f078~9HozpnTkk0560405604eucas1p2T;
        Tue, 17 Mar 2020 14:43:54 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200317144354eusmtrp2c0e276df70851f752c1ed011a9e05ada~9HozpAX_H0147801478eusmtrp2J;
        Tue, 17 Mar 2020 14:43:54 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-fe-5e70e22a9a80
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 92.33.07950.A22E07E5; Tue, 17
        Mar 2020 14:43:54 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200317144353eusmtip1839b814d33f8038061931a873db2fd87~9HozLXInq0538205382eusmtip1O;
        Tue, 17 Mar 2020 14:43:53 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH v4 27/27] ata: make "libata.force" kernel parameter optional
Date:   Tue, 17 Mar 2020 15:43:33 +0100
Message-Id: <20200317144333.2904-28-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200317144333.2904-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHKsWRmVeSWpSXmKPExsWy7djP87rajwriDA4eZ7RYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRXDYpqTmZZalF+nYJXBmf175mLFioVvFnZhtLA+NG+S5GTg4J
        AROJk+dPsXUxcnEICaxglOhZvIEVwvnCKPG25RQjhPOZUWLvmmYWmJY1jVeYQWwhgeWMEo/b
        5OA69nXPYAVJsAlYSUxsX8UIYosIKEj0/F4JtoNZ4D2jxIpJe8EmCQv4SEy9eo8JxGYRUJVY
        tfc3O4jNK2Arsb9/ISvENnmJrd8+gdmcQPFrh/+xQdQISpyc+QRsDjNQTfPW2cwgCyQElrFL
        THswlxmi2UViwsRDUGcLS7w6voUdwpaR+L9zPhNEwzpGib8dL6C6tzNKLJ8MsUJCwFrizrlf
        QDYH0ApNifW79CHCjhK3z/9iBAlLCPBJ3HgrCHEEn8SkbdOZIcK8Eh1tQhDVahIblm1gg1nb
        tXMl1GkeEtMmHGaawKg4C8k7s5C8Mwth7wJG5lWM4qmlxbnpqcXGeanlesWJucWleel6yfm5
        mxiBqej0v+NfdzDu+5N0iFGAg1GJhzdhU0GcEGtiWXFl7iFGCQ5mJRHexYX5cUK8KYmVValF
        +fFFpTmpxYcYpTlYlMR5jRe9jBUSSE8sSc1OTS1ILYLJMnFwSjUwdi1j3LUubkOxQ/NMNfZt
        rXNfeqkU1wS8uBL7JCGm6c7SE8zdai3/Ko5I535TvLpyuzR3p0Zr788VvjvZLhysvSlRyyuw
        u6hK5WL+qWc6n2aunHpH63DKpGUqG08EMvsr7jjiGjxbmuOA5pl+z73S9vOMi+7crQ8RU7+5
        WPX8laBXJ3149sS2KrEUZyQaajEXFScCAH2fSZ1BAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsVy+t/xu7pajwriDOY3S1qsvtvPZrFxxnpW
        i2e39jJZrFx9lMni2I5HTBaXd81hs1j+ZC2zxdzW6ewOHB47Z91l97h8ttTj0OEORo+Trd9Y
        PHbfbGDz6NuyitHj8ya5APYoPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9
        O5uU1JzMstQifbsEvYzPa18zFixUq/gzs42lgXGjfBcjJ4eEgInEmsYrzF2MXBxCAksZJSa+
        egXkcAAlZCSOry+DqBGW+HOtiw2i5hOjxIZ9GxhBEmwCVhIT21eB2SICChI9v1eCFTELfGWU
        WDqpmxkkISzgIzH16j0mEJtFQFVi1d7f7CA2r4CtxP7+hawQG+Qltn77BGZzAsWvHf7HBmIL
        CdhIvHjznwmiXlDi5MwnLCA2M1B989bZzBMYBWYhSc1CklrAyLSKUSS1tDg3PbfYSK84Mbe4
        NC9dLzk/dxMjMGK2Hfu5ZQdj17vgQ4wCHIxKPLwcGwrihFgTy4orcw8xSnAwK4nwLi7MjxPi
        TUmsrEotyo8vKs1JLT7EaAr0xERmKdHkfGA055XEG5oamltYGpobmxubWSiJ83YIHIwREkhP
        LEnNTk0tSC2C6WPi4JRqYFwWN12rY+6i1cu9vUO4WyN+Zu24W/Z4Sme6q/r/5hJb/Zrly6Rs
        LfTXV5d35fxLvvRy91//b8nSqoyba1sb6pUXTq0+Pjnb4/OudS/k3tdKxRx3Vypwf9xfaFzg
        tjGrLmPm191x5zMWOPd5lha1GLEIN0nc1n898dvzjtVrd4XfmjTj35I165RYijMSDbWYi4oT
        ASBvILKuAgAA
X-CMS-MailID: 20200317144354eucas1p250e3fc557c00a80eda42b3332984f078
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200317144354eucas1p250e3fc557c00a80eda42b3332984f078
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200317144354eucas1p250e3fc557c00a80eda42b3332984f078
References: <20200317144333.2904-1-b.zolnierkie@samsung.com>
        <CGME20200317144354eucas1p250e3fc557c00a80eda42b3332984f078@eucas1p2.samsung.com>
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
index 53d1d017c752..ce7d747dd2c0 100644
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

