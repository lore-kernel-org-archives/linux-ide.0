Return-Path: <SRS0=jBxd=5L=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8CD0C2D0ED
	for <linux-ide@archiver.kernel.org>; Thu, 26 Mar 2020 15:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80AE42083E
	for <linux-ide@archiver.kernel.org>; Thu, 26 Mar 2020 15:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="fd8HPbeh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728738AbgCZP7h (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 26 Mar 2020 11:59:37 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:52666 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728566AbgCZP6r (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 26 Mar 2020 11:58:47 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200326155846euoutp0280f4282b619494273b606c6f1ad9d89f~-5dvgn16U0032300323euoutp02v
        for <linux-ide@vger.kernel.org>; Thu, 26 Mar 2020 15:58:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200326155846euoutp0280f4282b619494273b606c6f1ad9d89f~-5dvgn16U0032300323euoutp02v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585238326;
        bh=n+Q8hEtMMCMkgK23mHp00SayWVv7Ig8jPGmxGHnXtfo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fd8HPbehXV5P9DZx5MAipA+ybRPW/Rhxv7sFVj5woOx8WGuuv3SQ+NOGcropIRFGv
         4MxufUOc0FjdAdSHJu6NFdI31D6rv2NcH3t/e0Yao7MZT+MBXeNqMOsjVUa6mq+E4C
         upSIU90cWsBIbUm+jlheSE9s9GhGP0w+F5TqbqM4=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200326155846eucas1p2effebb223f728f080e30981ab57cee7f~-5dvR_3Z52647226472eucas1p2M;
        Thu, 26 Mar 2020 15:58:46 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 06.F7.60698.631DC7E5; Thu, 26
        Mar 2020 15:58:46 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200326155845eucas1p170d540c74535517def9925bf9dffc0c7~-5du_iMdM2821328213eucas1p1x;
        Thu, 26 Mar 2020 15:58:45 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200326155845eusmtrp11d3c9259b0e5dc2e6f2df1a68f95558f~-5du9_OEL2090020900eusmtrp1r;
        Thu, 26 Mar 2020 15:58:45 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-9c-5e7cd136aadc
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 9E.CA.07950.531DC7E5; Thu, 26
        Mar 2020 15:58:45 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200326155845eusmtip15d1ae5fd7ffaf712552a470a35e61dbf~-5duishbo1506115061eusmtip10;
        Thu, 26 Mar 2020 15:58:45 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH v5 18/27] ata: move *sata_set_spd*() to libata-sata.c
Date:   Thu, 26 Mar 2020 16:58:13 +0100
Message-Id: <20200326155822.19400-19-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200326155822.19400-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLKsWRmVeSWpSXmKPExsWy7djPc7pmF2viDCbfZLNYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRXDYpqTmZZalF+nYJXBmdhxczFry1qug/eYSxgfG4fhcjJ4eE
        gInEtcZjzF2MXBxCAisYJc4s+cMG4XxhlLi8+TkrhPOZUWLilT1MMC09fzaA2UICyxklDnSE
        w3Xc77vJBpJgE7CSmNi+ihHEFhFQkOj5vRJsLLPAe0aJFZP2soAkhAVcJS4vmwbWwCKgKrH+
        41VWEJtXwE5i6f5/UNvkJbZ++wQW5wSKL183nxmiRlDi5MwnYHOYgWqat85mhqhfxi7xstUL
        wnaR+H/xMyOELSzx6vgWdghbRuL05B4WkIMkBNYxSvzteMEM4WxnlFg++R8bRJW1xJ1zv4Bs
        DqANmhLrd0FDzFHiyuyZjCBhCQE+iRtvBSFu4JOYtG06M0SYV6KjTQiiWk1iw7INbDBru3au
        hDrTQ+Ln1x1MExgVZyH5ZhaSb2Yh7F3AyLyKUTy1tDg3PbXYOC+1XK84Mbe4NC9dLzk/dxMj
        MBGd/nf86w7GfX+SDjEKcDAq8fA2tNXECbEmlhVX5h5ilOBgVhLhfRoJFOJNSaysSi3Kjy8q
        zUktPsQozcGiJM5rvOhlrJBAemJJanZqakFqEUyWiYNTqoHRwX32byOH3P9bY+uPbl21VnPe
        i0fHnZ8urtRcc3hZW+uX7TX27yI++XmxMR7zkLbY7f1X4PqjZztTDz9pP6j/+GK8neiuX3zm
        T9eHMEgc0Xf4tfKc4P9msXeC13YtS63e/2Cd0O7w55py4gHTF/l/0c8+zKz05HrjvwfNXrfT
        /7H9NJn2JzUhWImlOCPRUIu5qDgRAK9f41BAAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsVy+t/xu7qmF2viDP7M0rVYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6
        djYpqTmZZalF+nYJehmdhxczFry1qug/eYSxgfG4fhcjJ4eEgIlEz58NTF2MXBxCAksZJRqO
        /mbsYuQASshIHF9fBlEjLPHnWhcbRM0nRolp05pZQRJsAlYSE9tXMYLYIgIKEj2/V4IVMQt8
        ZZRYOqmbGSQhLOAqcXnZNDYQm0VAVWL9x6tgzbwCdhJL9/9jgtggL7H12yewOCdQfPm6+WC9
        QgK2Eou/fGCCqBeUODnzCQuIzQxU37x1NvMERoFZSFKzkKQWMDKtYhRJLS3OTc8tNtIrTswt
        Ls1L10vOz93ECIyYbcd+btnB2PUu+BCjAAejEg+vRktNnBBrYllxZe4hRgkOZiUR3qeRQCHe
        lMTKqtSi/Pii0pzU4kOMpkBPTGSWEk3OB0ZzXkm8oamhuYWlobmxubGZhZI4b4fAwRghgfTE
        ktTs1NSC1CKYPiYOTqkGxpS9wexZ2c3XK9htDt3XnRFV/pj7+0zee5Na7Nxnft53srjV6cwS
        8btrjF/vjPQ5u5KlZsJq5wKd/fv/1f91UahKEoiaxfj+l38H0z6rbrYfU9IZnxZuaIicOzHo
        9MMNq1gsS/sfBu86MWmSi0Pd98eXfZtfWkjX9zt9/tretFTIOv/aFQ0PPSWW4oxEQy3mouJE
        AJz3iu+uAgAA
X-CMS-MailID: 20200326155845eucas1p170d540c74535517def9925bf9dffc0c7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200326155845eucas1p170d540c74535517def9925bf9dffc0c7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200326155845eucas1p170d540c74535517def9925bf9dffc0c7
References: <20200326155822.19400-1-b.zolnierkie@samsung.com>
        <CGME20200326155845eucas1p170d540c74535517def9925bf9dffc0c7@eucas1p1.samsung.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

* move *sata_set_spd*() to libata-sata.c

* add static inlines for CONFIG_SATA_HOST=n case

Code size savings on m68k arch using (modified) atari_defconfig:

   text    data     bss     dec     hex filename
before:
  32842     572      40   33458    82ae drivers/ata/libata-core.o
after:
  32812     572      40   33428    8290 drivers/ata/libata-core.o

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/libata-core.c | 81 ---------------------------------------
 drivers/ata/libata-sata.c | 81 +++++++++++++++++++++++++++++++++++++++
 drivers/ata/libata.h      |  7 ++++
 include/linux/libata.h    |  3 +-
 4 files changed, 90 insertions(+), 82 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index ba1e5c4d3c09..13214ebd0e5c 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3050,87 +3050,6 @@ int sata_down_spd_limit(struct ata_link *link, u32 spd_limit)
 	return 0;
 }
 
-static int __sata_set_spd_needed(struct ata_link *link, u32 *scontrol)
-{
-	struct ata_link *host_link = &link->ap->link;
-	u32 limit, target, spd;
-
-	limit = link->sata_spd_limit;
-
-	/* Don't configure downstream link faster than upstream link.
-	 * It doesn't speed up anything and some PMPs choke on such
-	 * configuration.
-	 */
-	if (!ata_is_host_link(link) && host_link->sata_spd)
-		limit &= (1 << host_link->sata_spd) - 1;
-
-	if (limit == UINT_MAX)
-		target = 0;
-	else
-		target = fls(limit);
-
-	spd = (*scontrol >> 4) & 0xf;
-	*scontrol = (*scontrol & ~0xf0) | ((target & 0xf) << 4);
-
-	return spd != target;
-}
-
-/**
- *	sata_set_spd_needed - is SATA spd configuration needed
- *	@link: Link in question
- *
- *	Test whether the spd limit in SControl matches
- *	@link->sata_spd_limit.  This function is used to determine
- *	whether hardreset is necessary to apply SATA spd
- *	configuration.
- *
- *	LOCKING:
- *	Inherited from caller.
- *
- *	RETURNS:
- *	1 if SATA spd configuration is needed, 0 otherwise.
- */
-static int sata_set_spd_needed(struct ata_link *link)
-{
-	u32 scontrol;
-
-	if (sata_scr_read(link, SCR_CONTROL, &scontrol))
-		return 1;
-
-	return __sata_set_spd_needed(link, &scontrol);
-}
-
-/**
- *	sata_set_spd - set SATA spd according to spd limit
- *	@link: Link to set SATA spd for
- *
- *	Set SATA spd of @link according to sata_spd_limit.
- *
- *	LOCKING:
- *	Inherited from caller.
- *
- *	RETURNS:
- *	0 if spd doesn't need to be changed, 1 if spd has been
- *	changed.  Negative errno if SCR registers are inaccessible.
- */
-int sata_set_spd(struct ata_link *link)
-{
-	u32 scontrol;
-	int rc;
-
-	if ((rc = sata_scr_read(link, SCR_CONTROL, &scontrol)))
-		return rc;
-
-	if (!__sata_set_spd_needed(link, &scontrol))
-		return 0;
-
-	if ((rc = sata_scr_write(link, SCR_CONTROL, scontrol)))
-		return rc;
-
-	return 1;
-}
-EXPORT_SYMBOL_GPL(sata_set_spd);
-
 #ifdef CONFIG_ATA_ACPI
 /**
  *	ata_timing_cycle2mode - find xfer mode for the specified cycle duration
diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index 1ef4c19864ac..d66afdc33d54 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -271,6 +271,87 @@ int sata_link_scr_lpm(struct ata_link *link, enum ata_lpm_policy policy,
 }
 EXPORT_SYMBOL_GPL(sata_link_scr_lpm);
 
+static int __sata_set_spd_needed(struct ata_link *link, u32 *scontrol)
+{
+	struct ata_link *host_link = &link->ap->link;
+	u32 limit, target, spd;
+
+	limit = link->sata_spd_limit;
+
+	/* Don't configure downstream link faster than upstream link.
+	 * It doesn't speed up anything and some PMPs choke on such
+	 * configuration.
+	 */
+	if (!ata_is_host_link(link) && host_link->sata_spd)
+		limit &= (1 << host_link->sata_spd) - 1;
+
+	if (limit == UINT_MAX)
+		target = 0;
+	else
+		target = fls(limit);
+
+	spd = (*scontrol >> 4) & 0xf;
+	*scontrol = (*scontrol & ~0xf0) | ((target & 0xf) << 4);
+
+	return spd != target;
+}
+
+/**
+ *	sata_set_spd_needed - is SATA spd configuration needed
+ *	@link: Link in question
+ *
+ *	Test whether the spd limit in SControl matches
+ *	@link->sata_spd_limit.  This function is used to determine
+ *	whether hardreset is necessary to apply SATA spd
+ *	configuration.
+ *
+ *	LOCKING:
+ *	Inherited from caller.
+ *
+ *	RETURNS:
+ *	1 if SATA spd configuration is needed, 0 otherwise.
+ */
+int sata_set_spd_needed(struct ata_link *link)
+{
+	u32 scontrol;
+
+	if (sata_scr_read(link, SCR_CONTROL, &scontrol))
+		return 1;
+
+	return __sata_set_spd_needed(link, &scontrol);
+}
+
+/**
+ *	sata_set_spd - set SATA spd according to spd limit
+ *	@link: Link to set SATA spd for
+ *
+ *	Set SATA spd of @link according to sata_spd_limit.
+ *
+ *	LOCKING:
+ *	Inherited from caller.
+ *
+ *	RETURNS:
+ *	0 if spd doesn't need to be changed, 1 if spd has been
+ *	changed.  Negative errno if SCR registers are inaccessible.
+ */
+int sata_set_spd(struct ata_link *link)
+{
+	u32 scontrol;
+	int rc;
+
+	if ((rc = sata_scr_read(link, SCR_CONTROL, &scontrol)))
+		return rc;
+
+	if (!__sata_set_spd_needed(link, &scontrol))
+		return 0;
+
+	if ((rc = sata_scr_write(link, SCR_CONTROL, scontrol)))
+		return rc;
+
+	return 1;
+}
+EXPORT_SYMBOL_GPL(sata_set_spd);
+
 /**
  *	ata_slave_link_init - initialize slave link
  *	@ap: port to initialize slave link for
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index cd8090ad43e5..53b45ebe3d55 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -87,6 +87,13 @@ extern unsigned int ata_read_log_page(struct ata_device *dev, u8 log,
 
 #define to_ata_port(d) container_of(d, struct ata_port, tdev)
 
+/* libata-sata.c */
+#ifdef CONFIG_SATA_HOST
+int sata_set_spd_needed(struct ata_link *link);
+#else
+static inline int sata_set_spd_needed(struct ata_link *link) { return 1; }
+#endif
+
 /* libata-acpi.c */
 #ifdef CONFIG_ATA_ACPI
 extern unsigned int ata_acpi_gtf_filter;
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 86703ce5a33e..f0817a8f1e3f 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1074,7 +1074,6 @@ static inline int ata_port_is_dummy(struct ata_port *ap)
 	return ap->ops == &ata_dummy_port_ops;
 }
 
-extern int sata_set_spd(struct ata_link *link);
 extern int ata_std_prereset(struct ata_link *link, unsigned long deadline);
 extern int ata_wait_after_reset(struct ata_link *link, unsigned long deadline,
 				int (*check_ready)(struct ata_link *link));
@@ -1194,6 +1193,7 @@ extern int sata_scr_valid(struct ata_link *link);
 extern int sata_scr_read(struct ata_link *link, int reg, u32 *val);
 extern int sata_scr_write(struct ata_link *link, int reg, u32 val);
 extern int sata_scr_write_flush(struct ata_link *link, int reg, u32 val);
+extern int sata_set_spd(struct ata_link *link);
 #else
 static inline int sata_scr_valid(struct ata_link *link) { return 0; }
 static inline int sata_scr_read(struct ata_link *link, int reg, u32 *val)
@@ -1208,6 +1208,7 @@ static inline int sata_scr_write_flush(struct ata_link *link, int reg, u32 val)
 {
 	return -EOPNOTSUPP;
 }
+static inline int sata_set_spd(struct ata_link *link) { return -EOPNOTSUPP; }
 #endif
 extern int sata_link_scr_lpm(struct ata_link *link, enum ata_lpm_policy policy,
 			     bool spm_wakeup);
-- 
2.24.1

