Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 576C8C4332F
	for <linux-ide@archiver.kernel.org>; Mon, 25 Apr 2022 01:34:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240168AbiDYBhy (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 24 Apr 2022 21:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240170AbiDYBh1 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 24 Apr 2022 21:37:27 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4DAEE989
        for <linux-ide@vger.kernel.org>; Sun, 24 Apr 2022 18:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650850464; x=1682386464;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RA1Ay2qkBB1rB9TMmKbzRx1yRW6Y+GLFxl1gfChErqc=;
  b=kWGK+fFpcKUat38qWXAmTZ7N+4ASvEHLPqztgUouHaUnfyT7iDevOUuu
   CErGGjQmJkGNjHH0+4N0Ds8lAFoVoYqsdqsgXKRzcX/c/PqgIExZfNiRc
   c7z4gFBDpWSlsjviSSC15Rk6cmqVn2Ux96HajVlMonSK4Jgs/44Oy1OFU
   IWcsUyPBflPH8SveNrp+Fi+CeyRRyWs+o4enIFpYAmoYr4qX2/jjWjqat
   iS7q84d8BUZ0i5wAvAD8coVrxDMU2WNoPjzjQET+3bOX1BqWbJGx6Pnwe
   yLlS0GPTrSJxM09s4h4Vtx5bR+/NSQZAK84oeMDss9qG3ojeKlcS1ZQaY
   g==;
X-IronPort-AV: E=Sophos;i="5.90,287,1643644800"; 
   d="scan'208";a="197558813"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 25 Apr 2022 09:34:24 +0800
IronPort-SDR: knByx4AbhtpinIhXCs8xdvMr1UcMyCFgzypYuPPyqrxPM5fu3zdmy8Tp1tsTPGqlh8AmLn9YDJ
 CsM+2sQDRJZsYB++cg+XrnBfm6cZ1RHBKxWS5wHk2jSwvfj8QsUDuoVn3IVpmpLJ1lcPyfywox
 rLIuDdJmihVZ/LPjnJN3wZLa2zN5GhS/fd5WFUqjSwr9zLsnFGGMlkMWVH8qcHu83953YNKDvV
 0XXL1WTeGhdqpjLmc5j0NtclBz0TUqvA05de0DrTzNRujFTuI1NBRKKTjhtpMDZqnX9gPsUjDB
 zdPv/nGnwm3cNYCY/R9A/inf
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Apr 2022 18:04:37 -0700
IronPort-SDR: pXbZVlja3yjBgZQfM3kV117yLIWqPen2LDYvrcyd3gAO9k+Cs6asUxJrUHp8HlzUFqzeCPOu2N
 6QsfwFitKkbM1crwShyHYtA62YH9bJTecC9IpA48wMNbQ1RND3kJC+Mc61sPseqkhvMd1nFSdy
 rehWD1q6fD2ScvC8PnSAKJv5o3boERphdXU6wLa44c1M7KLnAY2MWisk1JvWLXwBEug/US+uAW
 JFZBMZx9KNR8/YzALxz/hFIfZXuuMyae1rUqlhWOhXQ1olWNWK2BNMfbNHRuyCSyIC0wSh5XN/
 7qs=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Apr 2022 18:34:24 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KmncJ034Cz1SVnx
        for <linux-ide@vger.kernel.org>; Sun, 24 Apr 2022 18:34:23 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1650850463; x=1653442464; bh=RA1Ay2qkBB1rB9TMmK
        bzRx1yRW6Y+GLFxl1gfChErqc=; b=JXuaai8f8ojmd71xDGW9KK4kp9O+dbxAHi
        xTBsepFKqPQPW9BsIsNl4KeiFL+acJl8TkhlA5h9MwcdmppXbuy4hSnf2p2HKQDQ
        3lCaSIjK6/wWTJrPRQvy31BTSkKXQ9hCV+DU6Aje3qwh6toHoFq9AbNU9E6J+900
        jcKzZrR5fwg8K2swRpZsOBivFsEN+k0JdkJGU6B3W0K+AHMgGS9iYm311rhwUsop
        ZKktqc5EHe6gkltrACG+J6Zrb7PwrCznN399H4IsQgSvvlkIbeIul6ldbK4AHo/I
        lrvTwnQyolInhqFQ/VSg5V2OB/mjJO/I1G79ixDoFNvzGAMqgmuQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 0NC__f4F46ZZ for <linux-ide@vger.kernel.org>;
        Sun, 24 Apr 2022 18:34:23 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KmncG5j6mz1Rwrw;
        Sun, 24 Apr 2022 18:34:22 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH v2 3/5] ata: libata-core: Improve link flags forced settings
Date:   Mon, 25 Apr 2022 10:34:15 +0900
Message-Id: <20220425013417.3947791-4-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220425013417.3947791-1-damien.lemoal@opensource.wdc.com>
References: <20220425013417.3947791-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Similarly to the horkage flags, introduce the force_lflag_onoff() macro
to define struct ata_force_param entries of the force_tbl array that
allow turning on or off a link flag using the libata.force boot
parameter. To be consistent with naming, the macro force_lflag() is
renamed to force_lflag_on().

Using force_lflag_onoff(), define a new force_tbl entry for the
ATA_LFLAG_NO_DEBOUNCE_DELAY link flag, thus allowing testing if an
adapter requires a link debounce delay or not.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
---
 drivers/ata/libata-core.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index dfdb23c2bbd6..e5a0e73b39d3 100644
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
@@ -6153,8 +6160,12 @@ EXPORT_SYMBOL_GPL(ata_platform_remove_one);
 #define force_xfer(mode, shift)				\
 	{ #mode,	.xfer_mask	=3D (1UL << (shift)) }
=20
-#define force_lflag(name, flags)			\
-	{ #name,	.lflags		=3D (flags) }
+#define force_lflag_on(name, flags)			\
+	{ #name,	.lflags_on	=3D (flags) }
+
+#define force_lflag_onoff(name, flags)			\
+	{ "no" #name,	.lflags_on	=3D (flags) },	\
+	{ #name,	.lflags_off	=3D (flags) }
=20
 #define force_horkage_on(name, flag)			\
 	{ #name,	.horkage_on	=3D (flag) }
@@ -6209,10 +6220,11 @@ static const struct ata_force_param force_tbl[] _=
_initconst =3D {
 	force_xfer(udma/133,		ATA_SHIFT_UDMA + 6),
 	force_xfer(udma7,		ATA_SHIFT_UDMA + 7),
=20
-	force_lflag(nohrst,		ATA_LFLAG_NO_HRST),
-	force_lflag(nosrst,		ATA_LFLAG_NO_SRST),
-	force_lflag(norst,		ATA_LFLAG_NO_HRST | ATA_LFLAG_NO_SRST),
-	force_lflag(rstonce,		ATA_LFLAG_RST_ONCE),
+	force_lflag_on(nohrst,		ATA_LFLAG_NO_HRST),
+	force_lflag_on(nosrst,		ATA_LFLAG_NO_SRST),
+	force_lflag_on(norst,		ATA_LFLAG_NO_HRST | ATA_LFLAG_NO_SRST),
+	force_lflag_on(rstonce,		ATA_LFLAG_RST_ONCE),
+	force_lflag_onoff(dbdelay,	ATA_LFLAG_NO_DEBOUNCE_DELAY),
=20
 	force_horkage_onoff(ncq,	ATA_HORKAGE_NONCQ),
 	force_horkage_onoff(ncqtrim,	ATA_HORKAGE_NO_NCQ_TRIM),
--=20
2.35.1

