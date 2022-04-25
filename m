Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46486C433F5
	for <linux-ide@archiver.kernel.org>; Mon, 25 Apr 2022 01:35:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240177AbiDYBh7 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 24 Apr 2022 21:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240174AbiDYBh3 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 24 Apr 2022 21:37:29 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C70FEE98E
        for <linux-ide@vger.kernel.org>; Sun, 24 Apr 2022 18:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650850465; x=1682386465;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=llwuokZnUcjanxh4EchFJknIfCkgARjdpbLqLAJtaoQ=;
  b=RVDQa8PJGpN67FhxQz46wOhjAvYfCF3BKrh0nm0jA/lNp+mRRB+2mG1d
   an8gyDtLosEtxLrLT+W+eLt+NcQfPVjwjUKLqeWadvzYOVNAlMeSW3bT+
   dvDTKM2jnuvGupcOscnta1bnN3PZzA2Fq1Afe80t7uCPf9JJFdlHtAj9J
   j1XJbxGxhoIYn9mbXRpr4gC5oWMrFsJ/rSWMvaVuvJ1GvZuaXtb55noEe
   99iQnxLMXGImSlpEkOtxon5oR2ai7A2yHd7y9oi6fxHn5bVmdwKXk8SjE
   PTIt7nHe8tzne2Abapjs0tdqgHB5yPS/dDlHVsIRPktzHkRctS+glMXlT
   A==;
X-IronPort-AV: E=Sophos;i="5.90,287,1643644800"; 
   d="scan'208";a="302917789"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Apr 2022 09:34:23 +0800
IronPort-SDR: aC5C+rco7MCT0WmPK76QrI8CIr2MTtf5BGBcpKgpjJ6ayOgpk3nFvJ+Aou/cDjXfJMWc5QOIBG
 dNTFNTUxfI4XqsvhpfyDU/ovdcwyXSKky+9Ssi+p+e+NcEQJ3biFdviq/PjVndI2016KtdZa8s
 WXK4FMb87eE3v/+9rUA+BaF/xPctko6hvG7mc/C0/VUt6fJObnpK2pC1Yz5bcTf2H7zP0OTxrV
 fqiRDnyY3Ozw1Lj9a6VG7FjPGlGuSJGGaDfSPfTKSwelTZPhE6McwWd01H+vZiz/I/i1dDKyOD
 pvggzTHhQ5TzR3rdV6crJPn9
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Apr 2022 18:05:20 -0700
IronPort-SDR: 17AQqqnta61074vGRaTfUiOw3c8ss5PoGQOkhPUPZ8Ayr6MgSytKdLVj8sRbbbvOenUUhZEpaI
 ip84wdntfurhlgrREbMtqj1fBF9achGHmMzrRYWvMgsJe7s5pEJcSYmy3EhKC+C0khd5Hk2m1i
 mdmE17RJUP6f5ifsic1a0zdvSWnAe9vqLZ2o1R3dLOkvFW5/2sl5SUNf4QR3k5kbrFzjmulLW1
 RTZszDPwxqoUnMaWRYUX/6kDypdiv+q3wNsHG2/yATz/joqdYrL7li5+Hls6UX8mFmmysxHBrg
 DXo=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Apr 2022 18:34:23 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KmncH0FlYz1SVp0
        for <linux-ide@vger.kernel.org>; Sun, 24 Apr 2022 18:34:23 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1650850462; x=1653442463; bh=llwuokZnUcjanxh4Ec
        hFJknIfCkgARjdpbLqLAJtaoQ=; b=mGqXL+tLyUqjIpBMqYD24MNVKJ3eYB8y/g
        a9kvFQiiMkClTJ2hfOOVPYGMkUIqnXFGgqFYjtc7WjVbgtEkqe4HcXuXoFnPTcfr
        +A9G8nBeN1KQhNHkwXBb9oR8LQM92WCp9ZCaJjTqxvTExSht1vUNKFimZahP0ZP9
        YmfIVTPb8ESXKClTlI1hwf/zh9Yk4lkX1leNLjuBO4Ucefhvk2ZWqsQ0wB6Q79Sq
        uZmfHejmLJ0gUPGQ0e9CP55wah8H4F4V/ALfwxa3OHFOtKiaQMqH+ncjpQgBLxBM
        /yF90OvCU758KcECf5VHaYRQpBnWW4+VJ8ifdayOdm1q+0LW0f5g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ThHdYtqZehlZ for <linux-ide@vger.kernel.org>;
        Sun, 24 Apr 2022 18:34:22 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KmncF4DTXz1Rvlx;
        Sun, 24 Apr 2022 18:34:21 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH v2 2/5] ata: libata-core: Refactor force_tbl definition
Date:   Mon, 25 Apr 2022 10:34:14 +0900
Message-Id: <20220425013417.3947791-3-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220425013417.3947791-1-damien.lemoal@opensource.wdc.com>
References: <20220425013417.3947791-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Introduce the macro definitions force_cbl(), force_spd_limit(),
force_xfer(), force_lflag(), force_horkage_on() and
force_horkage_onoff() to define with a more compact syntax the struct
ata_force_param entries in the force_tbl array defined in the function
ata_parse_force_one().

To reduce the indentation of the array declaration, force_tbl definition
is also moved out of the ata_parse_force_one() function. The entries are
also reordered to group them by type of the quirck that is applied.

Finally, fix a comment in ata_parse_force_param() incorrectly
referencing force_tbl instead of ata_force_tbl.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
---
 drivers/ata/libata-core.c | 139 ++++++++++++++++++++++----------------
 1 file changed, 81 insertions(+), 58 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index bc59c77b99b6..dfdb23c2bbd6 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6143,67 +6143,90 @@ int ata_platform_remove_one(struct platform_devic=
e *pdev)
 EXPORT_SYMBOL_GPL(ata_platform_remove_one);
=20
 #ifdef CONFIG_ATA_FORCE
+
+#define force_cbl(name, flag)				\
+	{ #name,	.cbl		=3D (flag) }
+
+#define force_spd_limit(spd, val)			\
+	{ #spd,	.spd_limit		=3D (val) }
+
+#define force_xfer(mode, shift)				\
+	{ #mode,	.xfer_mask	=3D (1UL << (shift)) }
+
+#define force_lflag(name, flags)			\
+	{ #name,	.lflags		=3D (flags) }
+
+#define force_horkage_on(name, flag)			\
+	{ #name,	.horkage_on	=3D (flag) }
+
+#define force_horkage_onoff(name, flag)			\
+	{ "no" #name,	.horkage_on	=3D (flag) },	\
+	{ #name,	.horkage_off	=3D (flag) }
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
+	force_lflag(nohrst,		ATA_LFLAG_NO_HRST),
+	force_lflag(nosrst,		ATA_LFLAG_NO_SRST),
+	force_lflag(norst,		ATA_LFLAG_NO_HRST | ATA_LFLAG_NO_SRST),
+	force_lflag(rstonce,		ATA_LFLAG_RST_ONCE),
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

