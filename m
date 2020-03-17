Return-Path: <SRS0=AjNr=5C=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E3FC2BB1D
	for <linux-ide@archiver.kernel.org>; Tue, 17 Mar 2020 14:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0006205ED
	for <linux-ide@archiver.kernel.org>; Tue, 17 Mar 2020 14:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="lcCVRQpP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbgCQOoo (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 17 Mar 2020 10:44:44 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:40405 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbgCQOnv (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 17 Mar 2020 10:43:51 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200317144350euoutp02d09e5743833fc8fe59acb6670526d31b~9Hovy1O8Z1582715827euoutp02E
        for <linux-ide@vger.kernel.org>; Tue, 17 Mar 2020 14:43:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200317144350euoutp02d09e5743833fc8fe59acb6670526d31b~9Hovy1O8Z1582715827euoutp02E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1584456230;
        bh=s/zRy4LE3BnT3lvMawLNd9ZScsqzl4miPJQTw6PQ4uk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lcCVRQpPB0bRCYDnnVNPFYVsAnIjV4AOC9ALlDVoRXq6/TaNNx9v4NbWhxyRdSvjO
         7IFcZq+8zvUxcGH3qZ+yWcZWsRX/WJ33okUWRLS+XCtc9+PCSI3QdZCVEARiU890Ms
         HT2tV5tO8dTQPaWUKVg1TXRjMBiM42HEIZUfWPW8=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200317144350eucas1p1376ad31da3db496b3421c22b475136e7~9HovjMhY11081910819eucas1p1f;
        Tue, 17 Mar 2020 14:43:50 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 95.E9.60698.522E07E5; Tue, 17
        Mar 2020 14:43:49 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200317144349eucas1p1a2e79758cbdf36c747c8a82cd4ddbd74~9HovFaSI61084510845eucas1p1T;
        Tue, 17 Mar 2020 14:43:49 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200317144349eusmtrp217b9469b34d0b639086fe835f9651364~9HovE1QBZ0146401464eusmtrp2S;
        Tue, 17 Mar 2020 14:43:49 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-f2-5e70e2258e38
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id BD.23.07950.522E07E5; Tue, 17
        Mar 2020 14:43:49 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200317144349eusmtip1aac03df61cd9d6139ed2a92ff9bde526~9HoulgDgp0973009730eusmtip1X;
        Tue, 17 Mar 2020 14:43:48 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH v4 17/27] ata: move sata_scr_*() to libata-sata.c
Date:   Tue, 17 Mar 2020 15:43:23 +0100
Message-Id: <20200317144333.2904-18-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200317144333.2904-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDKsWRmVeSWpSXmKPExsWy7djPc7qqjwriDO6ssLRYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRXDYpqTmZZalF+nYJXBlvf15jK5jtWXG76wprA+Meqy5GDg4J
        AROJjttqXYxcHEICKxglbi5exwLhfGGUmNy/HMjhBHI+M0qc/xoOYoM0LJzSxQRRtJxRYvG/
        n+xwHRvmbWYCqWITsJKY2L6KEcQWEVCQ6Pm9kg2kiFngPaPEikl7wcYKCzhKtLZuZQaxWQRU
        JR7N3AjWwCtgK3Hu2Tx2iHXyElu/fWIFsTmB4tcO/2ODqBGUODnzCdgcZqCa5q2zmUEWSAis
        YpdYtuwMO8RzLhLLWyIh5ghLvDq+BWqmjMT/nfOZIOrXMUr87XgB1bydUWL5ZIgNEgLWEnfO
        /WIDGcQsoCmxfpc+RNhRYuPv/0wQ8/kkbrwVhLiBT2LStunMEGFeiY42IYhqNYkNyzawwazt
        2rmSGcL2kDgy9y7jBEbFWUi+mYXkm1kIexcwMq9iFE8tLc5NTy02zkst1ytOzC0uzUvXS87P
        3cQITEOn/x3/uoNx35+kQ4wCHIxKPLwJmwrihFgTy4orcw8xSnAwK4nwLi7MjxPiTUmsrEot
        yo8vKs1JLT7EKM3BoiTOa7zoZayQQHpiSWp2ampBahFMlomDU6qBUVxl3cr7nTxWtmwhIkxm
        +zL2/3x9ymieto5v1/npB2d7x9t/PVlxbsOWEPswneY7jG3mNksEDlxdEP1aPOPYDq+rnZlK
        6Y/TGDY8+TKv+K2ofan4v6B5L+olnwmpnD634Xes5UOlhZdmBv9xnXJbnk/Jd8/ENzaT5ms9
        OWfm9n5i3gWO+98qI5VYijMSDbWYi4oTAdFOkr0/AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsVy+t/xu7qqjwriDF7dkbFYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6
        djYpqTmZZalF+nYJehlvf15jK5jtWXG76wprA+Meqy5GTg4JAROJhVO6mLoYuTiEBJYySrTu
        OMvWxcgBlJCROL6+DKJGWOLPtS42iJpPjBJHzixmA0mwCVhJTGxfxQhiiwgoSPT8XglWxCzw
        lVFi6aRuZpCEsICjRGvrVjCbRUBV4tHMjWANvAK2EueezWOH2CAvsfXbJ1YQmxMofu3wP7AF
        QgI2Ei/e/GeCqBeUODnzCQuIzQxU37x1NvMERoFZSFKzkKQWMDKtYhRJLS3OTc8tNtIrTswt
        Ls1L10vOz93ECIyYbcd+btnB2PUu+BCjAAejEg8vx4aCOCHWxLLiytxDjBIczEoivIsL8+OE
        eFMSK6tSi/Lji0pzUosPMZoCPTGRWUo0OR8YzXkl8YamhuYWlobmxubGZhZK4rwdAgdjhATS
        E0tSs1NTC1KLYPqYODilGhgDrHfmKfedt9Rl+ZwZ/Xz39nwlp1dtO14ncs1O7Vvld+za9Tm+
        y94w59lv3lMsy+2envG0xOdYXfCH909cvGP2zPSpeHfufcgCQ60DIid62CTD4w5c8zJSvtF4
        uV0jNCY8g7GM6YmISE3nnD0/6mufvr/+baHwg0embzqYZOL7zduderK3dSuxFGckGmoxFxUn
        AgAnut2IrgIAAA==
X-CMS-MailID: 20200317144349eucas1p1a2e79758cbdf36c747c8a82cd4ddbd74
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200317144349eucas1p1a2e79758cbdf36c747c8a82cd4ddbd74
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200317144349eucas1p1a2e79758cbdf36c747c8a82cd4ddbd74
References: <20200317144333.2904-1-b.zolnierkie@samsung.com>
        <CGME20200317144349eucas1p1a2e79758cbdf36c747c8a82cd4ddbd74@eucas1p1.samsung.com>
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
index 270fe10468c1..099d776289d7 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5220,115 +5220,6 @@ void ata_qc_issue(struct ata_queued_cmd *qc)
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
index f38faa80b2ba..6848e2403d4f 100644
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
@@ -1195,6 +1191,26 @@ extern void ata_scsi_cmd_error_handler(struct Scsi_Host *host,
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

