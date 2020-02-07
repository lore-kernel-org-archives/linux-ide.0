Return-Path: <SRS0=qhS8=33=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 533C6C35242
	for <linux-ide@archiver.kernel.org>; Fri,  7 Feb 2020 14:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A35D20838
	for <linux-ide@archiver.kernel.org>; Fri,  7 Feb 2020 14:28:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="TDMsIEBk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgBGO2n (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 7 Feb 2020 09:28:43 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:49631 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727767AbgBGO2B (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 7 Feb 2020 09:28:01 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200207142800euoutp028ff6708b948ca8b297e3562340191ba2~xJQyPrz-S2564025640euoutp02X
        for <linux-ide@vger.kernel.org>; Fri,  7 Feb 2020 14:28:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200207142800euoutp028ff6708b948ca8b297e3562340191ba2~xJQyPrz-S2564025640euoutp02X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1581085680;
        bh=eMTrn/BOlbpukSD2cCojPSkEiIm79Mkx6T2P5MlYsZg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TDMsIEBk53g5gXuKqK+FN1LXtcFZQTTYqSsz6Tv5o0VkqdHKjFVvm+vbHJ4DAuxFz
         Tl3vKbltmMROJiQnZyYlQv5C3lCR/xGj95hK0oeZFXFIr71alKDAh7HlI+TOhmCQh9
         a6KToq6c4e3rrrnlZz1w+dO2PVQuyp0WzVAMOeE0=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200207142759eucas1p2ec538765aada319f66de22f80c9a5838~xJQxw26mH0410804108eucas1p20;
        Fri,  7 Feb 2020 14:27:59 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 42.D8.60698.FE37D3E5; Fri,  7
        Feb 2020 14:27:59 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200207142759eucas1p1205ee995145f1a1e4990a4bdbf14b6d5~xJQxdi8AE2844428444eucas1p1n;
        Fri,  7 Feb 2020 14:27:59 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200207142759eusmtrp293bf6d8a4c6a499e9c27d545a1f5a928~xJQxagOCm1121511215eusmtrp2B;
        Fri,  7 Feb 2020 14:27:59 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-c6-5e3d73ef8901
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 81.D5.07950.FE37D3E5; Fri,  7
        Feb 2020 14:27:59 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200207142758eusmtip27bd89d43d55565875f473eeb1ceb643e~xJQw5FtGs3155831558eusmtip2I;
        Fri,  7 Feb 2020 14:27:58 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH v2 16/26] ata: move sata_scr_*() to libata-sata.c
Date:   Fri,  7 Feb 2020 15:27:24 +0100
Message-Id: <20200207142734.8431-17-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200207142734.8431-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHKsWRmVeSWpSXmKPExsWy7djP87rvi23jDH4dkrVYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRXDYpqTmZZalF+nYJXBlvrn9mLpjpWXHx+BL2BsbTVl2MnBwS
        AiYS5xcdZepi5OIQEljBKHGlq4UNwvnCKNH+bANU5jOjRPf+1ywwLR8nv2WHSCxnlDgzeREr
        XMurqc+YQarYBKwkJravYgSxRQQUJHp+rwSbyyzwnlFixaS9YKOEBRwlTq7vBdrBwcEioCrx
        83QqSJhXwFZiWctEVoht8hJbv30CszmB4h+n/GWDqBGUODnzCdgYZqCa5q2zmUHmSwisYpe4
        9/8GM0Szi0Tv5PNQtrDEq+Nb2CFsGYn/O+czQTSsY5T42/ECqns7o8Tyyf/YIKqsJe6c+8UG
        ch2zgKbE+l36EGFHicmPQGHBAWTzSdx4KwhxBJ/EpG3TmSHCvBIdbUIQ1WoSG5ZtYINZ27Vz
        JdQ5HhJrNs1lm8CoOAvJO7OQvDMLYe8CRuZVjOKppcW56anFxnmp5XrFibnFpXnpesn5uZsY
        gano9L/jX3cw7vuTdIhRgINRiYc3wdEmTog1say4MvcQowQHs5IIb5+qbZwQb0piZVVqUX58
        UWlOavEhRmkOFiVxXuNFL2OFBNITS1KzU1MLUotgskwcnFINjNL8yXen3o5a0Vi7fnnBheuq
        tQI9Pn71Z2WSeOU2PsuJml9uFuv9lSuN4Z3bofnC/Ylca37dfvuijaeqQKQ13bI6urvws+TV
        b6zTlk6ozP1m/MW6Lffa9bqgd3eePYs/oHVT/FBH3ykHnf03k1es+G177/AK37u32rznftxk
        vXDVjK27L01abq/EUpyRaKjFXFScCAC9YzwHQQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsVy+t/xe7rvi23jDI68ZrZYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6
        djYpqTmZZalF+nYJehlvrn9mLpjpWXHx+BL2BsbTVl2MnBwSAiYSHye/Ze9i5OIQEljKKLGq
        Yy9bFyMHUEJG4vj6MogaYYk/17rYIGo+MUrM7d/KCJJgE7CSmNi+CswWEVCQ6Pm9EqyIWeAr
        o8TSSd3MIAlhAUeJk+t7mUCGsgioSvw8nQoS5hWwlVjWMpEVYoG8xNZvn8BsTqD4xyl/2UBs
        IQEbie/vJ7FD1AtKnJz5hAXEZgaqb946m3kCo8AsJKlZSFILGJlWMYqklhbnpucWG+kVJ+YW
        l+al6yXn525iBMbLtmM/t+xg7HoXfIhRgINRiYc3wdEmTog1say4MvcQowQHs5IIb5+qbZwQ
        b0piZVVqUX58UWlOavEhRlOgHyYyS4km5wNjOa8k3tDU0NzC0tDc2NzYzEJJnLdD4GCMkEB6
        YklqdmpqQWoRTB8TB6dUA6PtpF+H9VsW1bx1rrnvN/vUnCWcH3OWh9t19u/f/nS7flvqNcMC
        xbXrVxy1Fw0Ji/M7fF6voHVPfNnfGyvuZFj9eZtlf9uL7d6RBx9rrp++IHc0vvRzi+Wur3cu
        a7zutV8iFeiRPUUjuSc2Youx1/Gb2qfVn81l/l2VfvDcxN6nDodNLU33zFRQYinOSDTUYi4q
        TgQASS3NuK0CAAA=
X-CMS-MailID: 20200207142759eucas1p1205ee995145f1a1e4990a4bdbf14b6d5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200207142759eucas1p1205ee995145f1a1e4990a4bdbf14b6d5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200207142759eucas1p1205ee995145f1a1e4990a4bdbf14b6d5
References: <20200207142734.8431-1-b.zolnierkie@samsung.com>
        <CGME20200207142759eucas1p1205ee995145f1a1e4990a4bdbf14b6d5@eucas1p1.samsung.com>
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

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/libata-core.c | 109 --------------------------------------
 drivers/ata/libata-sata.c | 109 ++++++++++++++++++++++++++++++++++++++
 include/linux/libata.h    |  24 +++++++--
 3 files changed, 129 insertions(+), 113 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 5b656a604341..f2882d1c731b 100644
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
index 4c7f038cc0e7..57c5081eb601 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1127,10 +1127,6 @@ extern void ata_sas_tport_delete(struct ata_port *ap);
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
@@ -1195,6 +1191,26 @@ extern void ata_scsi_cmd_error_handler(struct Scsi_Host *host, struct ata_port *
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

