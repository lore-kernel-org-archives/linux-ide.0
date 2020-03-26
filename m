Return-Path: <SRS0=jBxd=5L=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BEEBC2D0EC
	for <linux-ide@archiver.kernel.org>; Thu, 26 Mar 2020 15:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 437532078E
	for <linux-ide@archiver.kernel.org>; Thu, 26 Mar 2020 15:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="jLC0e9C3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbgCZP7g (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 26 Mar 2020 11:59:36 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:52690 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728565AbgCZP6s (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 26 Mar 2020 11:58:48 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200326155846euoutp02dc787c683ba9aee34936decc26f58565~-5dvbMzpX0032300323euoutp02u
        for <linux-ide@vger.kernel.org>; Thu, 26 Mar 2020 15:58:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200326155846euoutp02dc787c683ba9aee34936decc26f58565~-5dvbMzpX0032300323euoutp02u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585238326;
        bh=lKEI+OS8DcnfFcgCxEDU5x6WeNZQjnaXg5ouq02ynmg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jLC0e9C3bmbLPJaT54bdlIQDzljpt2c7F7+VWPkRtnofwA18bGaxKCQqDiFIeX7tK
         EXODJ6/yyUsxhwtsMCqwxmNFF2XycW36E8fvHzH/AaPNqFFwrjIGO0l5MninoZ7QbN
         RKkntF9HAfJuqQQUzU2McdxCi2VszNnJZnoH+GZg=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200326155845eucas1p26201b3f8198f73e7c4dfe637d49677af~-5du6FJqY3015130151eucas1p22;
        Thu, 26 Mar 2020 15:58:45 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id C4.F7.60698.531DC7E5; Thu, 26
        Mar 2020 15:58:45 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200326155845eucas1p2cd33e166f3ac6ab47f4681385491f538~-5dulXkBT2255222552eucas1p2P;
        Thu, 26 Mar 2020 15:58:45 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200326155845eusmtrp1dbcb91faf7e8bf54d6a4cb8aae0c3058~-5duk0G_22090020900eusmtrp1q;
        Thu, 26 Mar 2020 15:58:45 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-9b-5e7cd1358577
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id ED.CA.07950.531DC7E5; Thu, 26
        Mar 2020 15:58:45 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200326155844eusmtip1180d4425edaaff31677228e44411af94~-5duLSsnP1233412334eusmtip1y;
        Thu, 26 Mar 2020 15:58:44 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH v5 17/27] ata: move sata_scr_*() to libata-sata.c
Date:   Thu, 26 Mar 2020 16:58:12 +0100
Message-Id: <20200326155822.19400-18-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200326155822.19400-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLKsWRmVeSWpSXmKPExsWy7djPc7qmF2viDG4v17ZYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRXDYpqTmZZalF+nYJXBnLV99lKjjmWXHi/X2mBsbPVl2MnBwS
        AiYSJ+ZdZexi5OIQEljBKDFjykkmCOcLo8TiyS+gMp8ZJZas38YO03Jt+RlWiMRyRonHFyew
        w7U8WnuGDaSKTcBKYmL7KkYQW0RAQaLn90o2kCJmgfeMEism7WUBSQgLOEqsurARzGYRUJXY
        OnMLUAMHB6+AncSf5hyIbfISW799YgWxOYHCy9fNZwaxeQUEJU7OfALWygxU07x1NjPIfAmB
        ZewS73bfYgaZIyHgInF9fxHEHGGJV8e3QH0gI3F6cg8LRP06Rom/HS+gmrczSiyf/I8Nospa
        4s65X2wgg5gFNCXW79KHCDtKXL3xDGo+n8SNt4IQN/BJTNo2HSrMK9HRJgRRrSaxYdkGNpi1
        XTtXMkPYHhIX7j1gn8CoOAvJN7OQfDMLYe8CRuZVjOKppcW56anFxnmp5XrFibnFpXnpesn5
        uZsYgYno9L/jX3cw7vuTdIhRgINRiYe3oa0mTog1say4MvcQowQHs5II79NIoBBvSmJlVWpR
        fnxRaU5q8SFGaQ4WJXFe40UvY4UE0hNLUrNTUwtSi2CyTBycUg2MJn0S246wt6q5lHyvYPfu
        OJ6keK/GL+EE38vTW652GOZxGl16v40tev2Mh4rvuLc0Vp02KxePEnzIpiMTK9b/3ZBjs1/i
        RJNU/577hk8W2XUqfDa89DTBeuGkm4Fd6XvOvwhVcv+t/tPX4GDCT+/cD4ts7vyc1z1ZSPqV
        3vrCBV1+T3pkT7sosRRnJBpqMRcVJwIA08eqg0ADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsVy+t/xu7qmF2viDP7/ErZYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6
        djYpqTmZZalF+nYJehnLV99lKjjmWXHi/X2mBsbPVl2MnBwSAiYS15afYe1i5OIQEljKKNH9
        uYmxi5EDKCEjcXx9GUSNsMSfa11sEDWfGCVW/Z/KDJJgE7CSmNi+ihHEFhFQkOj5vRKsiFng
        K6PE0kndYEXCAo4Sqy5sZAGxWQRUJbbO3AK2gFfATuJPcw7EAnmJrd8+sYLYnEDh5evmg7UK
        CdhKLP7ygQnE5hUQlDg58wnYGGag+uats5knMArMQpKahSS1gJFpFaNIamlxbnpusZFecWJu
        cWleul5yfu4mRmC8bDv2c8sOxq53wYcYBTgYlXh4NVpq4oRYE8uKK3MPMUpwMCuJ8D6NBArx
        piRWVqUW5ccXleakFh9iNAX6YSKzlGhyPjCW80riDU0NzS0sDc2NzY3NLJTEeTsEDsYICaQn
        lqRmp6YWpBbB9DFxcEo1MJ688nHTrdpp8YYq0mHrZ7LLCDTq6aS75cVmSCy69OeI+4IVN31e
        5acwzFmRwN/xtOOf91fjqJoj3sd2Kr2w8FAXupVrwa6vc/95v3fUzekCC3qkHH9zrFA86mXg
        YssY6ailU2t/bdEzf/31/36sWbLq0rzcGHnTA1bnTqzgnOMYutU30Em/Q4mlOCPRUIu5qDgR
        ABh2rJCtAgAA
X-CMS-MailID: 20200326155845eucas1p2cd33e166f3ac6ab47f4681385491f538
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200326155845eucas1p2cd33e166f3ac6ab47f4681385491f538
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200326155845eucas1p2cd33e166f3ac6ab47f4681385491f538
References: <20200326155822.19400-1-b.zolnierkie@samsung.com>
        <CGME20200326155845eucas1p2cd33e166f3ac6ab47f4681385491f538@eucas1p2.samsung.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

* move sata_scr_*() to libata-sata.c

* add static inlines for CONFIG_SATA_HOST=n case

Code size savings on m68k arch using (modified) atari_defconfig:

   text    data     bss     dec     hex filename
before:
  35642     572      40   36254    8d9e drivers/ata/libata-core.o
  16607      18       0   16625    40f1 drivers/ata/libata-eh.o
after:
  32846     572      40   33458    82b2 drivers/ata/libata-core.o
  16243      18       0   16261    3f85 drivers/ata/libata-eh.o

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/libata-core.c | 109 --------------------------------------
 drivers/ata/libata-sata.c | 109 ++++++++++++++++++++++++++++++++++++++
 include/linux/libata.h    |  24 +++++++--
 3 files changed, 129 insertions(+), 113 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index b4a952dce7ab..ba1e5c4d3c09 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5215,115 +5215,6 @@ void ata_qc_issue(struct ata_queued_cmd *qc)
 	ata_qc_complete(qc);
 }
 
-/**
- *	sata_scr_valid - test whether SCRs are accessible
- *	@link: ATA link to test SCR accessibility for
- *
- *	Test whether SCRs are accessible for @link.
- *
- *	LOCKING:
- *	None.
- *
- *	RETURNS:
- *	1 if SCRs are accessible, 0 otherwise.
- */
-int sata_scr_valid(struct ata_link *link)
-{
-	struct ata_port *ap = link->ap;
-
-	return (ap->flags & ATA_FLAG_SATA) && ap->ops->scr_read;
-}
-EXPORT_SYMBOL_GPL(sata_scr_valid);
-
-/**
- *	sata_scr_read - read SCR register of the specified port
- *	@link: ATA link to read SCR for
- *	@reg: SCR to read
- *	@val: Place to store read value
- *
- *	Read SCR register @reg of @link into *@val.  This function is
- *	guaranteed to succeed if @link is ap->link, the cable type of
- *	the port is SATA and the port implements ->scr_read.
- *
- *	LOCKING:
- *	None if @link is ap->link.  Kernel thread context otherwise.
- *
- *	RETURNS:
- *	0 on success, negative errno on failure.
- */
-int sata_scr_read(struct ata_link *link, int reg, u32 *val)
-{
-	if (ata_is_host_link(link)) {
-		if (sata_scr_valid(link))
-			return link->ap->ops->scr_read(link, reg, val);
-		return -EOPNOTSUPP;
-	}
-
-	return sata_pmp_scr_read(link, reg, val);
-}
-EXPORT_SYMBOL_GPL(sata_scr_read);
-
-/**
- *	sata_scr_write - write SCR register of the specified port
- *	@link: ATA link to write SCR for
- *	@reg: SCR to write
- *	@val: value to write
- *
- *	Write @val to SCR register @reg of @link.  This function is
- *	guaranteed to succeed if @link is ap->link, the cable type of
- *	the port is SATA and the port implements ->scr_read.
- *
- *	LOCKING:
- *	None if @link is ap->link.  Kernel thread context otherwise.
- *
- *	RETURNS:
- *	0 on success, negative errno on failure.
- */
-int sata_scr_write(struct ata_link *link, int reg, u32 val)
-{
-	if (ata_is_host_link(link)) {
-		if (sata_scr_valid(link))
-			return link->ap->ops->scr_write(link, reg, val);
-		return -EOPNOTSUPP;
-	}
-
-	return sata_pmp_scr_write(link, reg, val);
-}
-EXPORT_SYMBOL_GPL(sata_scr_write);
-
-/**
- *	sata_scr_write_flush - write SCR register of the specified port and flush
- *	@link: ATA link to write SCR for
- *	@reg: SCR to write
- *	@val: value to write
- *
- *	This function is identical to sata_scr_write() except that this
- *	function performs flush after writing to the register.
- *
- *	LOCKING:
- *	None if @link is ap->link.  Kernel thread context otherwise.
- *
- *	RETURNS:
- *	0 on success, negative errno on failure.
- */
-int sata_scr_write_flush(struct ata_link *link, int reg, u32 val)
-{
-	if (ata_is_host_link(link)) {
-		int rc;
-
-		if (sata_scr_valid(link)) {
-			rc = link->ap->ops->scr_write(link, reg, val);
-			if (rc == 0)
-				rc = link->ap->ops->scr_read(link, reg, &val);
-			return rc;
-		}
-		return -EOPNOTSUPP;
-	}
-
-	return sata_pmp_scr_write(link, reg, val);
-}
-EXPORT_SYMBOL_GPL(sata_scr_write_flush);
-
 /**
  *	ata_phys_link_online - test whether the given link is online
  *	@link: ATA link to test
diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index 04f1ecaf414c..1ef4c19864ac 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -12,6 +12,115 @@
 
 #include "libata.h"
 
+/**
+ *	sata_scr_valid - test whether SCRs are accessible
+ *	@link: ATA link to test SCR accessibility for
+ *
+ *	Test whether SCRs are accessible for @link.
+ *
+ *	LOCKING:
+ *	None.
+ *
+ *	RETURNS:
+ *	1 if SCRs are accessible, 0 otherwise.
+ */
+int sata_scr_valid(struct ata_link *link)
+{
+	struct ata_port *ap = link->ap;
+
+	return (ap->flags & ATA_FLAG_SATA) && ap->ops->scr_read;
+}
+EXPORT_SYMBOL_GPL(sata_scr_valid);
+
+/**
+ *	sata_scr_read - read SCR register of the specified port
+ *	@link: ATA link to read SCR for
+ *	@reg: SCR to read
+ *	@val: Place to store read value
+ *
+ *	Read SCR register @reg of @link into *@val.  This function is
+ *	guaranteed to succeed if @link is ap->link, the cable type of
+ *	the port is SATA and the port implements ->scr_read.
+ *
+ *	LOCKING:
+ *	None if @link is ap->link.  Kernel thread context otherwise.
+ *
+ *	RETURNS:
+ *	0 on success, negative errno on failure.
+ */
+int sata_scr_read(struct ata_link *link, int reg, u32 *val)
+{
+	if (ata_is_host_link(link)) {
+		if (sata_scr_valid(link))
+			return link->ap->ops->scr_read(link, reg, val);
+		return -EOPNOTSUPP;
+	}
+
+	return sata_pmp_scr_read(link, reg, val);
+}
+EXPORT_SYMBOL_GPL(sata_scr_read);
+
+/**
+ *	sata_scr_write - write SCR register of the specified port
+ *	@link: ATA link to write SCR for
+ *	@reg: SCR to write
+ *	@val: value to write
+ *
+ *	Write @val to SCR register @reg of @link.  This function is
+ *	guaranteed to succeed if @link is ap->link, the cable type of
+ *	the port is SATA and the port implements ->scr_read.
+ *
+ *	LOCKING:
+ *	None if @link is ap->link.  Kernel thread context otherwise.
+ *
+ *	RETURNS:
+ *	0 on success, negative errno on failure.
+ */
+int sata_scr_write(struct ata_link *link, int reg, u32 val)
+{
+	if (ata_is_host_link(link)) {
+		if (sata_scr_valid(link))
+			return link->ap->ops->scr_write(link, reg, val);
+		return -EOPNOTSUPP;
+	}
+
+	return sata_pmp_scr_write(link, reg, val);
+}
+EXPORT_SYMBOL_GPL(sata_scr_write);
+
+/**
+ *	sata_scr_write_flush - write SCR register of the specified port and flush
+ *	@link: ATA link to write SCR for
+ *	@reg: SCR to write
+ *	@val: value to write
+ *
+ *	This function is identical to sata_scr_write() except that this
+ *	function performs flush after writing to the register.
+ *
+ *	LOCKING:
+ *	None if @link is ap->link.  Kernel thread context otherwise.
+ *
+ *	RETURNS:
+ *	0 on success, negative errno on failure.
+ */
+int sata_scr_write_flush(struct ata_link *link, int reg, u32 val)
+{
+	if (ata_is_host_link(link)) {
+		int rc;
+
+		if (sata_scr_valid(link)) {
+			rc = link->ap->ops->scr_write(link, reg, val);
+			if (rc == 0)
+				rc = link->ap->ops->scr_read(link, reg, &val);
+			return rc;
+		}
+		return -EOPNOTSUPP;
+	}
+
+	return sata_pmp_scr_write(link, reg, val);
+}
+EXPORT_SYMBOL_GPL(sata_scr_write_flush);
+
 /**
  *	ata_tf_to_fis - Convert ATA taskfile to SATA FIS structure
  *	@tf: Taskfile to convert
diff --git a/include/linux/libata.h b/include/linux/libata.h
index b419d7412f71..86703ce5a33e 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1125,10 +1125,6 @@ extern void ata_sas_tport_delete(struct ata_port *ap);
 extern void ata_sas_port_stop(struct ata_port *ap);
 extern int ata_sas_slave_configure(struct scsi_device *, struct ata_port *);
 extern int ata_sas_queuecmd(struct scsi_cmnd *cmd, struct ata_port *ap);
-extern int sata_scr_valid(struct ata_link *link);
-extern int sata_scr_read(struct ata_link *link, int reg, u32 *val);
-extern int sata_scr_write(struct ata_link *link, int reg, u32 val);
-extern int sata_scr_write_flush(struct ata_link *link, int reg, u32 val);
 extern bool ata_link_online(struct ata_link *link);
 extern bool ata_link_offline(struct ata_link *link);
 #ifdef CONFIG_PM
@@ -1193,6 +1189,26 @@ extern void ata_scsi_cmd_error_handler(struct Scsi_Host *host, struct ata_port *
 /*
  * SATA specific code - drivers/ata/libata-sata.c
  */
+#ifdef CONFIG_SATA_HOST
+extern int sata_scr_valid(struct ata_link *link);
+extern int sata_scr_read(struct ata_link *link, int reg, u32 *val);
+extern int sata_scr_write(struct ata_link *link, int reg, u32 val);
+extern int sata_scr_write_flush(struct ata_link *link, int reg, u32 val);
+#else
+static inline int sata_scr_valid(struct ata_link *link) { return 0; }
+static inline int sata_scr_read(struct ata_link *link, int reg, u32 *val)
+{
+	return -EOPNOTSUPP;
+}
+static inline int sata_scr_write(struct ata_link *link, int reg, u32 val)
+{
+	return -EOPNOTSUPP;
+}
+static inline int sata_scr_write_flush(struct ata_link *link, int reg, u32 val)
+{
+	return -EOPNOTSUPP;
+}
+#endif
 extern int sata_link_scr_lpm(struct ata_link *link, enum ata_lpm_policy policy,
 			     bool spm_wakeup);
 extern int ata_slave_link_init(struct ata_port *ap);
-- 
2.24.1

