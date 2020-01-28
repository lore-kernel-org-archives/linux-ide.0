Return-Path: <SRS0=dw68=3R=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 210BAC33CB2
	for <linux-ide@archiver.kernel.org>; Tue, 28 Jan 2020 13:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6CE524688
	for <linux-ide@archiver.kernel.org>; Tue, 28 Jan 2020 13:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="CHCZPGRX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgA1Neu (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 28 Jan 2020 08:34:50 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:58994 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgA1NeU (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 28 Jan 2020 08:34:20 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200128133418euoutp01caad8263bb155cfe4710b862e9e83c85~uEFDdz3mG0325703257euoutp01P
        for <linux-ide@vger.kernel.org>; Tue, 28 Jan 2020 13:34:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200128133418euoutp01caad8263bb155cfe4710b862e9e83c85~uEFDdz3mG0325703257euoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1580218458;
        bh=AXm0HSoMq02vwcjEKRD6f3iMCXkI1IufLmhvZIy3S/g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CHCZPGRX7V/mntRgx6btgsjXMc5OYPabRF6RxndJPLkRlAkJc0ojlv8bctjuYo11/
         sP9txOY3dS4v5PiQHBixR0Tmqim0kr9ggEmZSLF/i7IffZDrWF+STsLoDcIxMy7hXj
         a1YHNHNvNtpM0DSE0bf5KSzFpf4rxF8qRKCw3j9w=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200128133418eucas1p121657ba799ac94596e06bb37318e9fde~uEFDRYeUK0089200892eucas1p18;
        Tue, 28 Jan 2020 13:34:18 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id AA.DA.60698.A58303E5; Tue, 28
        Jan 2020 13:34:18 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200128133418eucas1p1b28eb901c4d21446376c1028b2977017~uEFC0nVFk0714007140eucas1p1n;
        Tue, 28 Jan 2020 13:34:18 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200128133418eusmtrp2eb935f5f3685fac7e9511a7902b1abf8~uEFC0AAn_0330003300eusmtrp28;
        Tue, 28 Jan 2020 13:34:18 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-c6-5e30385af143
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 43.82.07950.958303E5; Tue, 28
        Jan 2020 13:34:18 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200128133417eusmtip2942640f5c4e310c20cb0ac641eba1cce~uEFCejSHz0657406574eusmtip2i;
        Tue, 28 Jan 2020 13:34:17 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH 22/28] ata: move sata_scr_*() to libata-core-sata.c
Date:   Tue, 28 Jan 2020 14:33:37 +0100
Message-Id: <20200128133343.29905-23-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200128133343.29905-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBKsWRmVeSWpSXmKPExsWy7djPc7pRFgZxBouXyVusvtvPZrFxxnpW
        i2e39jJZHNvxiMni8q45bBZzW6ezO7B57Jx1l93j8tlSj0OHOxg9+rasYvT4vEkugDWKyyYl
        NSezLLVI3y6BK2PGq26WggbvihkzRBoY19h0MXJwSAiYSPT1FXQxcnEICaxglNhzbDYrhPOF
        UWLZnc9sEM5nRommLe+Yuxg5wTp+Pf7JDJFYziix/PNtZriWhm0fwKrYBKwkJravYgSxRQQU
        JHp+rwQbxSywhlFi1eEmsISwgLPE1Xv/2EFsFgFViburtjCB2LwCdhLdP9ayQ6yTl9j67RMr
        yLGcQPGeveYQJYISJ2c+YQGxmYFKmrfOBjtCQqCZXeLX5aVQvS4SvQ37oWxhiVfHt0DZMhL/
        d85ngmhYxyjxt+MFVPd2oH8m/2ODqLKWuHPuFxvIZmYBTYn1u/Qhwo4Sd+6uYYeEHp/EjbeC
        EEfwSUzaNp0ZIswr0dEmBFGtJrFh2QY2mLVdO1dCQ9FD4uTOL6wTGBVnIXlnFpJ3ZiHsXcDI
        vIpRPLW0ODc9tdg4L7Vcrzgxt7g0L10vOT93EyMwvZz+d/zrDsZ9f5IOMQpwMCrx8DooGcQJ
        sSaWFVfmHmKU4GBWEuHtZAIK8aYkVlalFuXHF5XmpBYfYpTmYFES5zVe9DJWSCA9sSQ1OzW1
        ILUIJsvEwSnVwNj2f1rn5LLFDVXdWfOP7TT/wGyU2hCW4vr8zB1JFoN9m1cr8cxPvh3IzKTu
        9nLqh1VChTK/n2gXnRa45rdftU+qlk9gU4bAh2PSCxsc2lXTXU33hn4oWfWyWJ718OdbU6q3
        NJUWzV6Qk389MOzPsx3yTO3BSy7KLakyc51V8v5XtGFoK/dcPiWW4oxEQy3mouJEAPhhqVkr
        AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmkeLIzCtJLcpLzFFi42I5/e/4Pd0oC4M4gycOFqvv9rNZbJyxntXi
        2a29TBbHdjxisri8aw6bxdzW6ewObB47Z91l97h8ttTj0OEORo++LasYPT5vkgtgjdKzKcov
        LUlVyMgvLrFVija0MNIztLTQMzKx1DM0No+1MjJV0rezSUnNySxLLdK3S9DLmPGqm6Wgwbti
        xgyRBsY1Nl2MnBwSAiYSvx7/ZO5i5OIQEljKKNFy6yyQwwGUkJE4vr4MokZY4s+1LjYQW0jg
        E6PE7aZIEJtNwEpiYvsqRhBbREBBouf3SjaQOcwCGxglXt38wgKSEBZwlrh67x87iM0ioCpx
        d9UWJhCbV8BOovvHWnaIBfISW799YgXZywkU79lrDrHLVmL9maesEOWCEidnPgEbyQxU3rx1
        NvMERoFZSFKzkKQWMDKtYhRJLS3OTc8tNtIrTswtLs1L10vOz93ECIyAbcd+btnB2PUu+BCj
        AAejEg+vg5JBnBBrYllxZe4hRgkOZiUR3k4moBBvSmJlVWpRfnxRaU5q8SFGU6AfJjJLiSbn
        A6MzryTe0NTQ3MLS0NzY3NjMQkmct0PgYIyQQHpiSWp2ampBahFMHxMHp1QD44z4O8euh06N
        1WdZ8iI7snXqkbKHL+8/2t+3s1D1SqJeojb7lEcHa9fUtbOucNr6U+pdoHpptrjOmVvBKamm
        3eWtR+dqnzReEGFx7nz6vk3lj7Niv219WKx88X9wUSlf457LYSdyNT7XRRwuEqvc/v9Rb12H
        e8nE/dHzPJKn8imUHV2zvZMrQImlOCPRUIu5qDgRAB0v6DOWAgAA
X-CMS-MailID: 20200128133418eucas1p1b28eb901c4d21446376c1028b2977017
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200128133418eucas1p1b28eb901c4d21446376c1028b2977017
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200128133418eucas1p1b28eb901c4d21446376c1028b2977017
References: <20200128133343.29905-1-b.zolnierkie@samsung.com>
        <CGME20200128133418eucas1p1b28eb901c4d21446376c1028b2977017@eucas1p1.samsung.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

* move sata_scr_*() to libata-core-sata.c

* add static inlines for CONFIG_SATA_HOST=n case

Code size savings on m68k arch using atari_defconfig:

   text    data     bss     dec     hex filename
before:
  32815     572      40   33427    8293 drivers/ata/libata-core.o
after:
  32146     572      40   32758    7ff6 drivers/ata/libata-core.o

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/libata-core-sata.c | 109 +++++++++++++++++++++++++++++++++
 drivers/ata/libata-core.c      | 109 ---------------------------------
 include/linux/libata.h         |  21 +++++--
 3 files changed, 126 insertions(+), 113 deletions(-)

diff --git a/drivers/ata/libata-core-sata.c b/drivers/ata/libata-core-sata.c
index 5749aa57c352..a3709b356fd2 100644
--- a/drivers/ata/libata-core-sata.c
+++ b/drivers/ata/libata-core-sata.c
@@ -831,6 +831,115 @@ int ata_qc_complete_multiple(struct ata_port *ap, u64 qc_active)
 }
 EXPORT_SYMBOL_GPL(ata_qc_complete_multiple);
 
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
  *	sata_link_init_spd - Initialize link->sata_spd_limit
  *	@link: Link to configure sata_spd_limit for
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 204e64ff4b93..f7124aede419 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4531,115 +4531,6 @@ void ata_qc_issue(struct ata_queued_cmd *qc)
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
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 62e962b62c5d..3f5d714caa43 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1119,10 +1119,6 @@ extern void ata_sas_tport_delete(struct ata_port *ap);
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
@@ -1198,6 +1194,10 @@ extern int sata_link_hardreset(struct ata_link *link,
 			const unsigned long *timing, unsigned long deadline,
 			bool *online, int (*check_ready)(struct ata_link *));
 extern int ata_slave_link_init(struct ata_port *ap);
+extern int sata_scr_valid(struct ata_link *link);
+extern int sata_scr_read(struct ata_link *link, int reg, u32 *val);
+extern int sata_scr_write(struct ata_link *link, int reg, u32 val);
+extern int sata_scr_write_flush(struct ata_link *link, int reg, u32 val);
 extern void ata_tf_to_fis(const struct ata_taskfile *tf,
 			  u8 pmp, int is_cmd, u8 *fis);
 extern void ata_tf_from_fis(const u8 *fis, struct ata_taskfile *tf);
@@ -1221,6 +1221,19 @@ static inline int sata_link_hardreset(struct ata_link *link,
 		*online = false;
 	return -EOPNOTSUPP;
 }
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
 #endif
 
 extern int ata_cable_40wire(struct ata_port *ap);
-- 
2.24.1

