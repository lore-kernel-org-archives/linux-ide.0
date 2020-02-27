Return-Path: <SRS0=ljer=4P=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A84A4C35E1E
	for <linux-ide@archiver.kernel.org>; Thu, 27 Feb 2020 18:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8502C246AF
	for <linux-ide@archiver.kernel.org>; Thu, 27 Feb 2020 18:23:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ixG4Qbks"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731000AbgB0SXX (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 27 Feb 2020 13:23:23 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:39756 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731006AbgB0SWv (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 27 Feb 2020 13:22:51 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200227182250euoutp016b0d9e7d2e605731a7bf3f64c2b1866e~3VXih5jRY1217012170euoutp01r
        for <linux-ide@vger.kernel.org>; Thu, 27 Feb 2020 18:22:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200227182250euoutp016b0d9e7d2e605731a7bf3f64c2b1866e~3VXih5jRY1217012170euoutp01r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1582827770;
        bh=ryjrNR/26naFeLnBxM9i19vci7WgexkjCIh6CNIIzqA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ixG4QbksVQ5zTR+wNPnC0RIoziecoe8EXN9kvJo5GHfMDgWI/uh7jM+OFluT+tOe3
         EyIs0jiHEHodGZxBx8TpkWvqbpFKMXL4NDCaoR+ScL1ZqK7/UxVROKLbLjazUkVEdl
         2j/tqZgPMLz4m3EmyYp4Tn6TJBtulz2M3ncSfpZI=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200227182249eucas1p2db035687e07a2573cbe73b4a677ab936~3VXhopGP83198431984eucas1p2D;
        Thu, 27 Feb 2020 18:22:49 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id E6.5F.61286.9F8085E5; Thu, 27
        Feb 2020 18:22:49 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200227182249eucas1p14e64b8693929cd84a289909bbdb4506e~3VXhb-6vO1734817348eucas1p1-;
        Thu, 27 Feb 2020 18:22:49 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200227182249eusmtrp2acd9cdf67621a8c636f5c9f298f3075f~3VXhbfrVx1813218132eusmtrp2w;
        Thu, 27 Feb 2020 18:22:49 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-6c-5e5808f9b9fa
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 93.C1.08375.9F8085E5; Thu, 27
        Feb 2020 18:22:49 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200227182248eusmtip2521032cbd6a5f0e1f792a359bb152346~3VXg7G3kJ3109031090eusmtip2v;
        Thu, 27 Feb 2020 18:22:48 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH v3 22/27] ata: move sata_deb_timing_*() to libata-sata.c
Date:   Thu, 27 Feb 2020 19:22:21 +0100
Message-Id: <20200227182226.19188-23-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200227182226.19188-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNKsWRmVeSWpSXmKPExsWy7djPc7o/OSLiDOa9VbdYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRXDYpqTmZZalF+nYJXBnHt/5mL5itXPHpOlsD43rZLkYODgkB
        E4ndazi6GDk5hARWMErs/pQPYX9hlJgzia2LkQvI/swo8bxpFytIAqR+xa/1zBCJ5YwSf1+f
        hXKAOh4+fs8EUsUmYCUxsX0VI4gtIqAg0fN7JdgoZoH3jBIrJu1lAUkIC3hI3N/8GKyIRUBV
        4vHqZWA2r4CdxLynZxkh1slLbP32CWw1J1D8Rt92NogaQYmTM5+AzWEGqmneOhvsCgmBVewS
        m75tZYdodpGYc2UplC0s8er4FihbRuL/zvlMEA3rgH7oeAHVvZ1RYvnkf2wQVdYSd879YgOF
        ErOApsT6XfoQYUeJDwtes0ECj0/ixltBiCP4JCZtm84MEeaV6GgTgqhWk9iwbAMbzNqunSuZ
        IWwPiZcLWtknMCrOQvLOLCTvzELYu4CReRWjeGppcW56arFhXmq5XnFibnFpXrpecn7uJkZg
        Ejr97/inHYxfLyUdYhTgYFTi4V2wIzxOiDWxrLgy9xCjBAezkgjvxq+hcUK8KYmVValF+fFF
        pTmpxYcYpTlYlMR5jRe9jBUSSE8sSc1OTS1ILYLJMnFwSjUwqjrE8nB0+DfP4jnw0Eq4c97P
        txJSa06lf3bq+nZl7rVXIY8iH2r66R+R/XLKX0WHdeX3uXYVpyRaDL7xfno9d+OtfofYzQ/P
        ave2eAYXaurLvn1XalYo0LDYunilUuzsR5XrPAX0pjBV7jY31X10y26TjvRHBgvVbrHqXiuG
        1XoFyWnX721SYinOSDTUYi4qTgQAteC9+D4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsVy+t/xe7o/OSLiDL7PFbNYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6
        djYpqTmZZalF+nYJehnHt/5mL5itXPHpOlsD43rZLkZODgkBE4kVv9YzdzFycQgJLGWUeLZ0
        E1sXIwdQQkbi+PoyiBphiT/Xutggaj4xSmx8doUdJMEmYCUxsX0VI4gtIqAg0fN7JVgRs8BX
        Romlk7qZQRLCAh4S9zc/BitiEVCVeLx6GZjNK2AnMe/pWUaIDfISW799YgWxOYHiN/q2s4HY
        QgK2El0dT6HqBSVOznzCAmIzA9U3b53NPIFRYBaS1CwkqQWMTKsYRVJLi3PTc4sN9YoTc4tL
        89L1kvNzNzEC42XbsZ+bdzBe2hh8iFGAg1GJh3fBjvA4IdbEsuLK3EOMEhzMSiK8G7+Gxgnx
        piRWVqUW5ccXleakFh9iNAV6YiKzlGhyPjCW80riDU0NzS0sDc2NzY3NLJTEeTsEDsYICaQn
        lqRmp6YWpBbB9DFxcEo1MJr82cHLs8Rs+56a6KVGlwvWFT/pYP70blnon9CsJ58U880n+zJo
        79p0L79i0XbTqN0mhpEGCeftL91/X/1CR2Ctl+TsV05zTy5ea9lRxGghan/kf7TOQb1Otomz
        V1zdEuZx8JJuZU+1cmbyjcd7ZC0uCBVe3/VmP2+n1vzHzB4Tnzx0qm712qbEUpyRaKjFXFSc
        CABkF178rQIAAA==
X-CMS-MailID: 20200227182249eucas1p14e64b8693929cd84a289909bbdb4506e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200227182249eucas1p14e64b8693929cd84a289909bbdb4506e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200227182249eucas1p14e64b8693929cd84a289909bbdb4506e
References: <20200227182226.19188-1-b.zolnierkie@samsung.com>
        <CGME20200227182249eucas1p14e64b8693929cd84a289909bbdb4506e@eucas1p1.samsung.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

* move sata_deb_timing_*() to libata-sata.c

* add static inline for sata_ehc_deb_timing() for
  CONFIG_SATA_HOST=n case

Code size savings on m68k arch using (modified) atari_defconfig:

   text    data     bss     dec     hex filename
before:
  32158     572      40   32770    8002 drivers/ata/libata-core.o
after:
  32015     572      40   32627    7f73 drivers/ata/libata-core.o

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/libata-core.c |  8 --------
 drivers/ata/libata-sata.c |  8 ++++++++
 include/linux/libata.h    | 31 ++++++++++++++++++-------------
 3 files changed, 26 insertions(+), 21 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 2ef0960b2154..20c22dbc1f24 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -65,14 +65,6 @@
 #include "libata.h"
 #include "libata-transport.h"
 
-/* debounce timing parameters in msecs { interval, duration, timeout } */
-const unsigned long sata_deb_timing_normal[]		= {   5,  100, 2000 };
-EXPORT_SYMBOL_GPL(sata_deb_timing_normal);
-const unsigned long sata_deb_timing_hotplug[]		= {  25,  500, 2000 };
-EXPORT_SYMBOL_GPL(sata_deb_timing_hotplug);
-const unsigned long sata_deb_timing_long[]		= { 100, 2000, 5000 };
-EXPORT_SYMBOL_GPL(sata_deb_timing_long);
-
 const struct ata_port_operations ata_base_port_ops = {
 	.prereset		= ata_std_prereset,
 	.postreset		= ata_std_postreset,
diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index 849582e0d653..f3ad4aca5d09 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -12,6 +12,14 @@
 
 #include "libata.h"
 
+/* debounce timing parameters in msecs { interval, duration, timeout } */
+const unsigned long sata_deb_timing_normal[]		= {   5,  100, 2000 };
+EXPORT_SYMBOL_GPL(sata_deb_timing_normal);
+const unsigned long sata_deb_timing_hotplug[]		= {  25,  500, 2000 };
+EXPORT_SYMBOL_GPL(sata_deb_timing_hotplug);
+const unsigned long sata_deb_timing_long[]		= { 100, 2000, 5000 };
+EXPORT_SYMBOL_GPL(sata_deb_timing_long);
+
 /**
  *	sata_scr_valid - test whether SCRs are accessible
  *	@link: ATA link to test SCR accessibility for
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 8fdfe5e4e6e9..99cd52a5a4c2 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1021,10 +1021,6 @@ struct ata_timing {
 /*
  * Core layer - drivers/ata/libata-core.c
  */
-extern const unsigned long sata_deb_timing_normal[];
-extern const unsigned long sata_deb_timing_hotplug[];
-extern const unsigned long sata_deb_timing_long[];
-
 extern struct ata_port_operations ata_dummy_port_ops;
 extern const struct ata_port_info ata_dummy_port_info;
 
@@ -1062,15 +1058,6 @@ static inline int is_multi_taskfile(struct ata_taskfile *tf)
 	       (tf->command == ATA_CMD_WRITE_MULTI_FUA_EXT);
 }
 
-static inline const unsigned long *
-sata_ehc_deb_timing(struct ata_eh_context *ehc)
-{
-	if (ehc->i.flags & ATA_EHI_HOTPLUGGED)
-		return sata_deb_timing_hotplug;
-	else
-		return sata_deb_timing_normal;
-}
-
 static inline int ata_port_is_dummy(struct ata_port *ap)
 {
 	return ap->ops == &ata_dummy_port_ops;
@@ -1183,6 +1170,19 @@ extern void ata_scsi_cmd_error_handler(struct Scsi_Host *host, struct ata_port *
  * SATA specific code - drivers/ata/libata-sata.c
  */
 #ifdef CONFIG_SATA_HOST
+extern const unsigned long sata_deb_timing_normal[];
+extern const unsigned long sata_deb_timing_hotplug[];
+extern const unsigned long sata_deb_timing_long[];
+
+static inline const unsigned long *
+sata_ehc_deb_timing(struct ata_eh_context *ehc)
+{
+	if (ehc->i.flags & ATA_EHI_HOTPLUGGED)
+		return sata_deb_timing_hotplug;
+	else
+		return sata_deb_timing_normal;
+}
+
 extern int sata_scr_valid(struct ata_link *link);
 extern int sata_scr_read(struct ata_link *link, int reg, u32 *val);
 extern int sata_scr_write(struct ata_link *link, int reg, u32 val);
@@ -1194,6 +1194,11 @@ extern int sata_link_hardreset(struct ata_link *link,
 extern int sata_link_resume(struct ata_link *link, const unsigned long *params,
 			    unsigned long deadline);
 #else
+static inline const unsigned long *
+sata_ehc_deb_timing(struct ata_eh_context *ehc)
+{
+	return NULL;
+}
 static inline int sata_scr_valid(struct ata_link *link) { return 0; }
 static inline int sata_scr_read(struct ata_link *link, int reg, u32 *val)
 {
-- 
2.24.1

