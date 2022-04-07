Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A75C433FE
	for <linux-ide@archiver.kernel.org>; Thu,  7 Apr 2022 12:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245294AbiDGMj7 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 7 Apr 2022 08:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245287AbiDGMjy (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 7 Apr 2022 08:39:54 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F502571CE
        for <linux-ide@vger.kernel.org>; Thu,  7 Apr 2022 05:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1649335074; x=1680871074;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CR6xmZ4GrUB9DRUi2bQjJEZSXj5yLfeoLjUiIaP8Uiw=;
  b=fZbzeb+LRG7d526tx+3RsGcFnTbSw9T9rdhhCrkOxF3WStu5kZu/78sq
   rSUnadu2GIDer4hP22e7wYqx41AHXv47dfjZi2s0W/Sbn8stKseqSmpjP
   Odla6+NfYB4EtKuJn2R89NGohGeJDkO7YKHeLIVnXF8Mf6Sy8OSCLOGY8
   f8x6FIIqy20xQpG6cE0VRFo47VR8IVaxTQ6fv9KZW19afGGZBJRAVcp86
   0Ic3sOQOC8+3hlufL1OcJJuP8ZnNp64QorSGOVKEqvQ6e1eUU0MQIDo+a
   MtSN2GhHVg/XqV5LDSyKKVgOrTOXsr+Nv4aa3FJTcRyd5Qs+B+hV9SFYZ
   A==;
X-IronPort-AV: E=Sophos;i="5.90,242,1643644800"; 
   d="scan'208";a="301515553"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Apr 2022 20:37:53 +0800
IronPort-SDR: rzFcLLK4SA79ZrkXwIEnf8TjIE7Qmk39nizX55OriiHeu5tfyEmiMb/5RnoX4HQtapkg/DXQ8h
 xVB888e1za3TkVe0y42rb4UlTP+20p6YJMDlkT5m2zeFB+mJ/12wLB9397L1IiEydMlF1rN50j
 8WRksDQ2RolqSF2gxt5dABys7QYcC9AER3E7afe8Kwb+oEOI46jDRII43bgPy5vD1eHIXpPcEQ
 rEB7Z2luPO6Bke5E+s2ZGzpHZ3yD0ionxiUbPlHgI2Rp2vNCLzblDLe5ssxIdLEuF5tx9DSo45
 ZSLgtDP9q45ugWs94tGc/e2E
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Apr 2022 05:09:23 -0700
IronPort-SDR: SZoGJTMAtMHuuUZQcXNSYvXu9x2ALYx3AgsEwaqojZec6yQpMv6Cy2WDMmNKDob7cIHkhKDUQx
 14htbKsAGg11zllAZSS5OYhviW7bNtJteiCqmlLRwETG94xjX9Y7Zp91jaa6eQkScgMX6qGU+n
 DB0GWFmvCCQpk0m09RqqGvXRa21gPB0W+VmhKDj7w4gpe0CudFv5Js5xUeF6BHEKI6F8HwD1KX
 9Oo2KQTnRMYQH97qwm0LXhWGM1W20lH+U6okEzqKKmQIuOAALQSfXhodGTzYgpoJys5wElDl9B
 DIU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Apr 2022 05:37:54 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KZ1B946Xjz1SHwl
        for <linux-ide@vger.kernel.org>; Thu,  7 Apr 2022 05:37:53 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1649335073; x=1651927074; bh=CR6xmZ4GrUB9DRUi2b
        QjJEZSXj5yLfeoLjUiIaP8Uiw=; b=Rs5PzkyaFIN8xGQ/+4JZxit1TwtCCytpn4
        FMF9Y+A4Fs4Hcr8NR0k2V70WTfMSgABaqkX4KM8QXTywGJ7YRZ49xJklmH6SGOMz
        KCW1f4bXDaws3AdEyhIE9WuHhBcEMiacoBNI7bvC5HonVcN+ENZwxnR5Jf8nieo7
        qs35UVY1xCG858YKHJY2UGN3Vlg0MoiohUT8VDtn1SAZOjXX/P8RjoFxcp2avRmu
        0gU5YdIq598xwI8pfrj1Tm63eT850wWePeenLNjq0YuJmOooIlWgoMGokFqG2H6b
        fnbkVDguMhuFo2uqHRnJE8WMTFi2vuMrWUhS0Jk8sTVYU54Jg2Ew==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id x9xSr46HWgO9 for <linux-ide@vger.kernel.org>;
        Thu,  7 Apr 2022 05:37:53 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KZ1B82P8wz1Rvlx;
        Thu,  7 Apr 2022 05:37:52 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH 2/5] ata: libata-core: Refactor force_tbl definition
Date:   Thu,  7 Apr 2022 21:37:45 +0900
Message-Id: <20220407123748.1170212-3-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220407123748.1170212-1-damien.lemoal@opensource.wdc.com>
References: <20220407123748.1170212-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Introduce the macro definitions force_cbl(), force_spd_limit(),
force_xfer(), force_lflag_on(), force_horkage_on() and
force_horkage_onoff() to define with a more compact syntax the struct
ata_force_param entries in the force_tbl array defined in the function
ata_parse_force_one().
To reduce the indentation of the array declaration, force_tbl definition
is also moved out of the ata_parse_force_one() function.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/ata/libata-core.c | 139 ++++++++++++++++++++++----------------
 1 file changed, 81 insertions(+), 58 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index bc59c77b99b6..c0cf42ffcc38 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6143,67 +6143,90 @@ int ata_platform_remove_one(struct platform_devic=
e *pdev)
 EXPORT_SYMBOL_GPL(ata_platform_remove_one);
=20
 #ifdef CONFIG_ATA_FORCE
+
+#define force_cbl(name, flag)				\
+	{ # name,	.cbl		=3D (flag) }
+
+#define force_spd_limit(spd, val)			\
+	{ # spd,	.spd_limit	=3D (val) }
+
+#define force_xfer(mode, shift)				\
+	{ # mode,	.xfer_mask	=3D (1UL << (shift)) }
+
+#define force_lflag_on(name, flags)			\
+	{ # name,	.lflags		=3D (flags) }
+
+#define force_horkage_on(name, flag)			\
+	{ # name,	.horkage_on	=3D (flag) }
+
+#define force_horkage_onoff(name, flag)			\
+	{ "no" # name,	.horkage_on	=3D (flag) },	\
+	{ # name,	.horkage_off	=3D (flag) }
+
+static const struct ata_force_param force_tbl[] __initconst =3D {
+	force_cbl(40c,			ATA_CBL_PATA40),
+	force_cbl(80c,			ATA_CBL_PATA80),
+	force_cbl(short40c,		ATA_CBL_PATA40_SHORT),
+	force_cbl(unk,			ATA_CBL_PATA_UNK),
+	force_cbl(ign,			ATA_CBL_PATA_IGN),
+	force_cbl(sata,			ATA_CBL_SATA),
+
+	force_spd_limit(1.5Gbps,	1),
+	force_spd_limit(3.0Gbps,	2),
+
+	force_xfer(pio0,		ATA_SHIFT_PIO + 0),
+	force_xfer(pio1,		ATA_SHIFT_PIO + 1),
+	force_xfer(pio2,		ATA_SHIFT_PIO + 2),
+	force_xfer(pio3,		ATA_SHIFT_PIO + 3),
+	force_xfer(pio4,		ATA_SHIFT_PIO + 4),
+	force_xfer(pio5,		ATA_SHIFT_PIO + 5),
+	force_xfer(pio6,		ATA_SHIFT_PIO + 6),
+	force_xfer(mwdma0,		ATA_SHIFT_MWDMA + 0),
+	force_xfer(mwdma1,		ATA_SHIFT_MWDMA + 1),
+	force_xfer(mwdma2,		ATA_SHIFT_MWDMA + 2),
+	force_xfer(mwdma3,		ATA_SHIFT_MWDMA + 3),
+	force_xfer(mwdma4,		ATA_SHIFT_MWDMA + 4),
+	force_xfer(udma0,		ATA_SHIFT_UDMA + 0),
+	force_xfer(udma16,		ATA_SHIFT_UDMA + 0),
+	force_xfer(udma/16,		ATA_SHIFT_UDMA + 0),
+	force_xfer(udma1,		ATA_SHIFT_UDMA + 1),
+	force_xfer(udma25,		ATA_SHIFT_UDMA + 1),
+	force_xfer(udma/25,		ATA_SHIFT_UDMA + 1),
+	force_xfer(udma2,		ATA_SHIFT_UDMA + 2),
+	force_xfer(udma33,		ATA_SHIFT_UDMA + 2),
+	force_xfer(udma/33,		ATA_SHIFT_UDMA + 2),
+	force_xfer(udma3,		ATA_SHIFT_UDMA + 3),
+	force_xfer(udma44,		ATA_SHIFT_UDMA + 3),
+	force_xfer(udma/44,		ATA_SHIFT_UDMA + 3),
+	force_xfer(udma4,		ATA_SHIFT_UDMA + 4),
+	force_xfer(udma66,		ATA_SHIFT_UDMA + 4),
+	force_xfer(udma/66,		ATA_SHIFT_UDMA + 4),
+	force_xfer(udma5,		ATA_SHIFT_UDMA + 5),
+	force_xfer(udma100,		ATA_SHIFT_UDMA + 5),
+	force_xfer(udma/100,		ATA_SHIFT_UDMA + 5),
+	force_xfer(udma6,		ATA_SHIFT_UDMA + 6),
+	force_xfer(udma133,		ATA_SHIFT_UDMA + 6),
+	force_xfer(udma/133,		ATA_SHIFT_UDMA + 6),
+	force_xfer(udma7,		ATA_SHIFT_UDMA + 7),
+
+	force_lflag_on(nohrst,		ATA_LFLAG_NO_HRST),
+	force_lflag_on(nosrst,		ATA_LFLAG_NO_SRST),
+	force_lflag_on(norst,		ATA_LFLAG_NO_HRST | ATA_LFLAG_NO_SRST),
+	force_lflag_on(rstonce,		ATA_LFLAG_RST_ONCE),
+
+	force_horkage_onoff(ncq,	ATA_HORKAGE_NONCQ),
+	force_horkage_onoff(ncqtrim,	ATA_HORKAGE_NO_NCQ_TRIM),
+	force_horkage_onoff(ncqati,	ATA_HORKAGE_NO_NCQ_ON_ATI),
+
+	force_horkage_on(dump_id,	ATA_HORKAGE_DUMP_ID),
+	force_horkage_on(atapi_dmadir,	ATA_HORKAGE_ATAPI_DMADIR),
+	force_horkage_on(disable,	ATA_HORKAGE_DISABLE)
+};
+
 static int __init ata_parse_force_one(char **cur,
 				      struct ata_force_ent *force_ent,
 				      const char **reason)
 {
-	static const struct ata_force_param force_tbl[] __initconst =3D {
-		{ "40c",	.cbl		=3D ATA_CBL_PATA40 },
-		{ "80c",	.cbl		=3D ATA_CBL_PATA80 },
-		{ "short40c",	.cbl		=3D ATA_CBL_PATA40_SHORT },
-		{ "unk",	.cbl		=3D ATA_CBL_PATA_UNK },
-		{ "ign",	.cbl		=3D ATA_CBL_PATA_IGN },
-		{ "sata",	.cbl		=3D ATA_CBL_SATA },
-		{ "1.5Gbps",	.spd_limit	=3D 1 },
-		{ "3.0Gbps",	.spd_limit	=3D 2 },
-		{ "noncq",	.horkage_on	=3D ATA_HORKAGE_NONCQ },
-		{ "ncq",	.horkage_off	=3D ATA_HORKAGE_NONCQ },
-		{ "noncqtrim",	.horkage_on	=3D ATA_HORKAGE_NO_NCQ_TRIM },
-		{ "ncqtrim",	.horkage_off	=3D ATA_HORKAGE_NO_NCQ_TRIM },
-		{ "noncqati",	.horkage_on	=3D ATA_HORKAGE_NO_NCQ_ON_ATI },
-		{ "ncqati",	.horkage_off	=3D ATA_HORKAGE_NO_NCQ_ON_ATI },
-		{ "dump_id",	.horkage_on	=3D ATA_HORKAGE_DUMP_ID },
-		{ "pio0",	.xfer_mask	=3D 1 << (ATA_SHIFT_PIO + 0) },
-		{ "pio1",	.xfer_mask	=3D 1 << (ATA_SHIFT_PIO + 1) },
-		{ "pio2",	.xfer_mask	=3D 1 << (ATA_SHIFT_PIO + 2) },
-		{ "pio3",	.xfer_mask	=3D 1 << (ATA_SHIFT_PIO + 3) },
-		{ "pio4",	.xfer_mask	=3D 1 << (ATA_SHIFT_PIO + 4) },
-		{ "pio5",	.xfer_mask	=3D 1 << (ATA_SHIFT_PIO + 5) },
-		{ "pio6",	.xfer_mask	=3D 1 << (ATA_SHIFT_PIO + 6) },
-		{ "mwdma0",	.xfer_mask	=3D 1 << (ATA_SHIFT_MWDMA + 0) },
-		{ "mwdma1",	.xfer_mask	=3D 1 << (ATA_SHIFT_MWDMA + 1) },
-		{ "mwdma2",	.xfer_mask	=3D 1 << (ATA_SHIFT_MWDMA + 2) },
-		{ "mwdma3",	.xfer_mask	=3D 1 << (ATA_SHIFT_MWDMA + 3) },
-		{ "mwdma4",	.xfer_mask	=3D 1 << (ATA_SHIFT_MWDMA + 4) },
-		{ "udma0",	.xfer_mask	=3D 1 << (ATA_SHIFT_UDMA + 0) },
-		{ "udma16",	.xfer_mask	=3D 1 << (ATA_SHIFT_UDMA + 0) },
-		{ "udma/16",	.xfer_mask	=3D 1 << (ATA_SHIFT_UDMA + 0) },
-		{ "udma1",	.xfer_mask	=3D 1 << (ATA_SHIFT_UDMA + 1) },
-		{ "udma25",	.xfer_mask	=3D 1 << (ATA_SHIFT_UDMA + 1) },
-		{ "udma/25",	.xfer_mask	=3D 1 << (ATA_SHIFT_UDMA + 1) },
-		{ "udma2",	.xfer_mask	=3D 1 << (ATA_SHIFT_UDMA + 2) },
-		{ "udma33",	.xfer_mask	=3D 1 << (ATA_SHIFT_UDMA + 2) },
-		{ "udma/33",	.xfer_mask	=3D 1 << (ATA_SHIFT_UDMA + 2) },
-		{ "udma3",	.xfer_mask	=3D 1 << (ATA_SHIFT_UDMA + 3) },
-		{ "udma44",	.xfer_mask	=3D 1 << (ATA_SHIFT_UDMA + 3) },
-		{ "udma/44",	.xfer_mask	=3D 1 << (ATA_SHIFT_UDMA + 3) },
-		{ "udma4",	.xfer_mask	=3D 1 << (ATA_SHIFT_UDMA + 4) },
-		{ "udma66",	.xfer_mask	=3D 1 << (ATA_SHIFT_UDMA + 4) },
-		{ "udma/66",	.xfer_mask	=3D 1 << (ATA_SHIFT_UDMA + 4) },
-		{ "udma5",	.xfer_mask	=3D 1 << (ATA_SHIFT_UDMA + 5) },
-		{ "udma100",	.xfer_mask	=3D 1 << (ATA_SHIFT_UDMA + 5) },
-		{ "udma/100",	.xfer_mask	=3D 1 << (ATA_SHIFT_UDMA + 5) },
-		{ "udma6",	.xfer_mask	=3D 1 << (ATA_SHIFT_UDMA + 6) },
-		{ "udma133",	.xfer_mask	=3D 1 << (ATA_SHIFT_UDMA + 6) },
-		{ "udma/133",	.xfer_mask	=3D 1 << (ATA_SHIFT_UDMA + 6) },
-		{ "udma7",	.xfer_mask	=3D 1 << (ATA_SHIFT_UDMA + 7) },
-		{ "nohrst",	.lflags		=3D ATA_LFLAG_NO_HRST },
-		{ "nosrst",	.lflags		=3D ATA_LFLAG_NO_SRST },
-		{ "norst",	.lflags		=3D ATA_LFLAG_NO_HRST | ATA_LFLAG_NO_SRST },
-		{ "rstonce",	.lflags		=3D ATA_LFLAG_RST_ONCE },
-		{ "atapi_dmadir", .horkage_on	=3D ATA_HORKAGE_ATAPI_DMADIR },
-		{ "disable",	.horkage_on	=3D ATA_HORKAGE_DISABLE },
-	};
 	char *start =3D *cur, *p =3D *cur;
 	char *id, *val, *endp;
 	const struct ata_force_param *match_fp =3D NULL;
@@ -6285,7 +6308,7 @@ static void __init ata_parse_force_param(void)
 	int last_port =3D -1, last_device =3D -1;
 	char *p, *cur, *next;
=20
-	/* calculate maximum number of params and allocate force_tbl */
+	/* Calculate maximum number of params and allocate ata_force_tbl */
 	for (p =3D ata_force_param_buf; *p; p++)
 		if (*p =3D=3D ',')
 			size++;
--=20
2.35.1

