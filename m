Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 910D9C43219
	for <linux-ide@archiver.kernel.org>; Thu,  7 Apr 2022 12:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233132AbiDGMkB (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 7 Apr 2022 08:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245290AbiDGMjz (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 7 Apr 2022 08:39:55 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558CA258440
        for <linux-ide@vger.kernel.org>; Thu,  7 Apr 2022 05:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1649335075; x=1680871075;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=C43GuHygh9MYCzCzqGWlW+js2bhjbMUxxJbOoh5GSXY=;
  b=JVJ29JxffCubPcdUW633bLkHPklDhbx4kJJSLUFXdv8NyhsLkM8YLmW6
   IGrFLZeUmor06Wx1nwxMOI1XSFKFGxVY6qCex/AbBl9UeUEQX48GWSeoK
   9vQarWL8IgvM1VhDKdp9XnHTVFuWicpKNHxFGArIgBJiVlu+5HYPjlE+G
   PcH8EqJxxDHkuB2wRGwBfQI/8Czri7hKogKQj8JCNyBnFZS1uZNqf598U
   l7iOykxYm/6EsBvBpfpzYRN2g3RMSRR2CKEjS7tS6kkq1oxUO6UGvI33T
   3+Sc1g5+mTauOtE5bfPFHEQxv3tkswXy0bPwcWPVtc9DQZ2JIYFwXJIOC
   g==;
X-IronPort-AV: E=Sophos;i="5.90,242,1643644800"; 
   d="scan'208";a="301515556"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Apr 2022 20:37:54 +0800
IronPort-SDR: gaNwBUBf5eRxKTr3wLv9KBSRmg2xXr3PJh7zKdsBxrTzWUjNClzTxPwPSGQJi8nx7A9XhPD/Qk
 SXbYNbPb+BalWGgI0+vjDVj5Ijwgyh70FUoLO+UDZXWNzLQVQOoXGieCtuuyNKCkzTjZ4cjowF
 cZY7X5lPbgry9Pb1QCDynJOnh7NbrU4Esi+MI9sk9Mpr9bkKzwZA/i/sRHST8bxtxSovfgOAv8
 Vgeu/HQcO4AKT4mHmIdvyv9nHseDUdC/GRiOLtplyCEgYztEgeXDQ+Q/iwtxK8jyCsT5DOcrXT
 ijnBwjKC6Ee7NoCA15HTBnJF
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Apr 2022 05:09:24 -0700
IronPort-SDR: zrtu8yQYyE5epnGtyOvTkCHD1dPaMWY8JcZiLE5U2pEGkiUoofWPC3oFTIqaOou/HrMnwuhudJ
 xbY0RDe0LgXwEDfIY7mS1lZZpWvyCrTWX3g71Bttak9h4JlUayjdJHpZ+RUhc9sR9fhBf2kxzA
 3MEIevBQOf7QlDGzijLnB37YbK7hBOSeP6kzZdDCZwMfbH3B0LG+lCYWL/TMJjF+XHJ2+KVVNW
 wRVAC9doijGrW5T42WUVDEGzNXbDgKbZn9En6zPYC7HgKF2LvcJvUUmdl6c/n3MmlcSUM4Okiy
 Xr0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Apr 2022 05:37:55 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KZ1BB38pCz1SHwl
        for <linux-ide@vger.kernel.org>; Thu,  7 Apr 2022 05:37:54 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1649335074; x=1651927075; bh=C43GuHygh9MYCzCzqG
        WlW+js2bhjbMUxxJbOoh5GSXY=; b=pfVOA6g8/YUUhOIWK9xGPOTyg661XpJyPm
        3wgklTUEjfLGBwBeGTQlIWQLKTBPsV3obC4jidT2d/FUGYdYQ5wAkpUKcxnAhRCy
        FW6RS56KaPeWWmM2ruv2DVFG90sZG3ufA82YUA1MEmR8moKqZBJ5lFSadb2r86yJ
        lGCIu/7zk8IqqOY7lpwPzfPf7M4h6au9WwjUAMnkW+xznBa50/Kqk48REi5Cq1Bg
        fx0LiR3oNoe1nipM+la/ya9v4cluC9z8Y6BDl/0iD7IaAiqRUi2e3AaWpBPFHWVT
        pX2L5HQOFl9FRWTOhQO0Yf1BCf2XbByJfM2XGiElltWZPC8Iyd9w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id b2E1cZOlEWbs for <linux-ide@vger.kernel.org>;
        Thu,  7 Apr 2022 05:37:54 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KZ1B92Dcrz1Rwrw;
        Thu,  7 Apr 2022 05:37:53 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH 3/5] ata: libata-core: Improve link flags forced settings
Date:   Thu,  7 Apr 2022 21:37:46 +0900
Message-Id: <20220407123748.1170212-4-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220407123748.1170212-1-damien.lemoal@opensource.wdc.com>
References: <20220407123748.1170212-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Similarly to the horkage flags, introduce the force_lflag_onoff() macro
to define struct ata_force_param entries of the force_tbl array that
allow turning on or off a link flag using the libata.force boot
parameter. Using this new helper macro, define a new force_tbl entry
for the ATA_LFLAG_NO_DEBOUNCE_DELAY link flag, thus allowing testing if
an adapter requires a link debounce delay or not.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/ata/libata-core.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index c0cf42ffcc38..75856f4210d7 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -96,7 +96,8 @@ struct ata_force_param {
 	unsigned long	xfer_mask;
 	unsigned int	horkage_on;
 	unsigned int	horkage_off;
-	u16		lflags;
+	u16		lflags_on;
+	u16		lflags_off;
 };
=20
 struct ata_force_ent {
@@ -386,11 +387,17 @@ static void ata_force_link_limits(struct ata_link *=
link)
 		}
=20
 		/* let lflags stack */
-		if (fe->param.lflags) {
-			link->flags |=3D fe->param.lflags;
+		if (fe->param.lflags_on) {
+			link->flags |=3D fe->param.lflags_on;
 			ata_link_notice(link,
 					"FORCE: link flag 0x%x forced -> 0x%x\n",
-					fe->param.lflags, link->flags);
+					fe->param.lflags_on, link->flags);
+		}
+		if (fe->param.lflags_off) {
+			link->flags &=3D ~fe->param.lflags_off;
+			ata_link_notice(link,
+				"FORCE: link flag 0x%x cleared -> 0x%x\n",
+				fe->param.lflags_off, link->flags);
 		}
 	}
 }
@@ -6154,7 +6161,11 @@ EXPORT_SYMBOL_GPL(ata_platform_remove_one);
 	{ # mode,	.xfer_mask	=3D (1UL << (shift)) }
=20
 #define force_lflag_on(name, flags)			\
-	{ # name,	.lflags		=3D (flags) }
+	{ # name,	.lflags_on	=3D (flags) }
+
+#define force_lflag_onoff(name, flags)			\
+	{ "no" # name,	.lflags_on	=3D (flags) },	\
+	{ # name,	.lflags_off	=3D (flags) }
=20
 #define force_horkage_on(name, flag)			\
 	{ # name,	.horkage_on	=3D (flag) }
@@ -6213,6 +6224,7 @@ static const struct ata_force_param force_tbl[] __i=
nitconst =3D {
 	force_lflag_on(nosrst,		ATA_LFLAG_NO_SRST),
 	force_lflag_on(norst,		ATA_LFLAG_NO_HRST | ATA_LFLAG_NO_SRST),
 	force_lflag_on(rstonce,		ATA_LFLAG_RST_ONCE),
+	force_lflag_onoff(dbdelay,	ATA_LFLAG_NO_DEBOUNCE_DELAY),
=20
 	force_horkage_onoff(ncq,	ATA_HORKAGE_NONCQ),
 	force_horkage_onoff(ncqtrim,	ATA_HORKAGE_NO_NCQ_TRIM),
--=20
2.35.1

