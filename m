Return-Path: <SRS0=jBxd=5L=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DB4C2D0F0
	for <linux-ide@archiver.kernel.org>; Thu, 26 Mar 2020 15:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 755FF20737
	for <linux-ide@archiver.kernel.org>; Thu, 26 Mar 2020 15:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="N3GIXAyB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbgCZP73 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 26 Mar 2020 11:59:29 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:58992 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728600AbgCZP6t (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 26 Mar 2020 11:58:49 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200326155848euoutp01563178320022a4027d31b250ee04d7e2~-5dxCci3Y2919829198euoutp01_
        for <linux-ide@vger.kernel.org>; Thu, 26 Mar 2020 15:58:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200326155848euoutp01563178320022a4027d31b250ee04d7e2~-5dxCci3Y2919829198euoutp01_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585238328;
        bh=MjEAvxE9az05TD4ljo19sQQTx7oyiMSJNzS3vHE5Dw0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N3GIXAyBOwhoCpFzRAkUrWFnNRgXqSNIWFTaL2sUbbK8QN8mydTQnSyCyIRFbr6EF
         rD0e3Eaq1vj8HRJVAqxQYrfvi/v9Frt6LXIZ5VM6jHv795G93kjDQOc9GrnY9Q7hEu
         c3JNhMPIUJd6e7zaFF1H4Tqg4hLWVm7ItGFhhUm4=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200326155847eucas1p140d3fee2e780848bfdf3ad81f4120365~-5dwxYbJ60942909429eucas1p1U;
        Thu, 26 Mar 2020 15:58:47 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 87.F7.60698.731DC7E5; Thu, 26
        Mar 2020 15:58:47 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200326155847eucas1p274137b9af50464c076fbbfb45947493d~-5dwd_0OM2633426334eucas1p2g;
        Thu, 26 Mar 2020 15:58:47 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200326155847eusmtrp1c7f62cbe6bc1de3f1c8bce69a3ffb165~-5dwdaRay2090020900eusmtrp1w;
        Thu, 26 Mar 2020 15:58:47 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-a1-5e7cd1373c99
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 40.DA.07950.731DC7E5; Thu, 26
        Mar 2020 15:58:47 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200326155846eusmtip1c1887f262c25ec1b4b58720833f13763~-5dwCdKSW1233412334eusmtip1z;
        Thu, 26 Mar 2020 15:58:46 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH v5 22/27] ata: move sata_deb_timing_*() to libata-sata.c
Date:   Thu, 26 Mar 2020 16:58:17 +0100
Message-Id: <20200326155822.19400-23-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200326155822.19400-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHKsWRmVeSWpSXmKPExsWy7djPc7rmF2viDDpWa1usvtvPZrFxxnpW
        i2e39jJZrFx9lMni2I5HTBaXd81hs1j+ZC2zxdzW6ewOHB47Z91l97h8ttTj0OEORo+Trd9Y
        PHbfbGDz6NuyitHj8ya5APYoLpuU1JzMstQifbsEroyeRUeZC04oV3zb0c/SwHhdtouRk0NC
        wERi3Yn77F2MXBxCAisYJRZ92sgI4XxhlFg4+zoLhPOZUaL51XxGmJbJ96awQSSWM0pc3Xwf
        oeXEwqlgVWwCVhIT21eB2SICChI9v1eCdTALvGeUWDFpLwtIQljAQ2L2nAPsIDaLgKrErtnH
        mUFsXgE7iZ1LzzFBrJOX2PrtEyuIzQkUX75uPlSNoMTJmU/A5jAD1TRvnc0MskBCYBm7xPwv
        C4E2cwA5LhItzYEQc4QlXh3fwg5hy0icntzDAlG/jlHib8cLqObtjBLLJ/9jg6iylrhz7hcb
        yCBmAU2J9bv0IcKOEu+aJjFDzOeTuPFWEOIGPolJ26ZDhXklOtqEIKrVJDYs28AGs7Zr50pm
        CNtDYsqz5SwTGBVnIflmFpJvZiHsXcDIvIpRPLW0ODc9tdg4L7Vcrzgxt7g0L10vOT93EyMw
        FZ3+d/zrDsZ9f5IOMQpwMCrx8Da01cQJsSaWFVfmHmKU4GBWEuF9GgkU4k1JrKxKLcqPLyrN
        SS0+xCjNwaIkzmu86GWskEB6YklqdmpqQWoRTJaJg1OqgfF4ppVvsFCgxaHL096nuXJxx8wM
        aWmzOd9ys0FYrFKmb4EYQzGv8Mnlb9YduRWiJfC/2eWhTE/3p+2PrObOD8zglDwRU+T+z3bb
        6xaT8M5Os5zbjn72Esdtl3PErxTWiH4u/IrhnNz+hbuEhZ5OXH5Z9cBV/iStyEA1pqIcL503
        Uw4Hb3T8qcRSnJFoqMVcVJwIAGaUScdBAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsVy+t/xu7rmF2viDLa8EbZYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6
        djYpqTmZZalF+nYJehk9i44yF5xQrvi2o5+lgfG6bBcjJ4eEgInE5HtT2LoYuTiEBJYySpz7
        tZG9i5EDKCEjcXx9GUSNsMSfa11QNZ8YJV5t7mUCSbAJWElMbF/FCGKLCChI9PxeCVbELPCV
        UWLppG5mkISwgIfE7DkH2EFsFgFViV2zj4PFeQXsJHYuPccEsUFeYuu3T6wgNidQfPm6+WA1
        QgK2Eou/fGCCqBeUODnzCQuIzQxU37x1NvMERoFZSFKzkKQWMDKtYhRJLS3OTc8tNtIrTswt
        Ls1L10vOz93ECIyYbcd+btnB2PUu+BCjAAejEg+vRktNnBBrYllxZe4hRgkOZiUR3qeRQCHe
        lMTKqtSi/Pii0pzU4kOMpkBPTGSWEk3OB0ZzXkm8oamhuYWlobmxubGZhZI4b4fAwRghgfTE
        ktTs1NSC1CKYPiYOTqkGRma29u6fYimfz7+QPmWelZwQ7pXQaV4nduJUwGyTvz9CpYU32p2f
        ZSKvtMQlfc9fgSUlf1qOWXxedTaDu0nErVBrzvqinJXfv21yqXKrO9MhMckwK2+GmcP9BVcv
        Fv3glcgzkI9N3C/FcbrT31jQ0uOzmeSWNXNuv26+cHrfniW1B5ZMOHI5S4mlOCPRUIu5qDgR
        ANUH3I+uAgAA
X-CMS-MailID: 20200326155847eucas1p274137b9af50464c076fbbfb45947493d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200326155847eucas1p274137b9af50464c076fbbfb45947493d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200326155847eucas1p274137b9af50464c076fbbfb45947493d
References: <20200326155822.19400-1-b.zolnierkie@samsung.com>
        <CGME20200326155847eucas1p274137b9af50464c076fbbfb45947493d@eucas1p2.samsung.com>
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

Reviewed-by: Christoph Hellwig <hch@lst.de>
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
index 08fec96a6a1e..90c929b5df3d 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1019,10 +1019,6 @@ struct ata_timing {
 /*
  * Core layer - drivers/ata/libata-core.c
  */
-extern const unsigned long sata_deb_timing_normal[];
-extern const unsigned long sata_deb_timing_hotplug[];
-extern const unsigned long sata_deb_timing_long[];
-
 extern struct ata_port_operations ata_dummy_port_ops;
 extern const struct ata_port_info ata_dummy_port_info;
 
@@ -1060,15 +1056,6 @@ static inline int is_multi_taskfile(struct ata_taskfile *tf)
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
@@ -1181,6 +1168,19 @@ extern void ata_scsi_cmd_error_handler(struct Scsi_Host *host, struct ata_port *
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
@@ -1192,6 +1192,11 @@ extern int sata_link_hardreset(struct ata_link *link,
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

