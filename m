Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26111C433EF
	for <linux-ide@archiver.kernel.org>; Wed, 16 Feb 2022 07:19:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbiBPHT0 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 16 Feb 2022 02:19:26 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:46736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbiBPHTZ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 16 Feb 2022 02:19:25 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C8821E21
        for <linux-ide@vger.kernel.org>; Tue, 15 Feb 2022 23:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644995946; x=1676531946;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PgHb45fjk7fVCVwQBEuLhzyXD2Z4wiqYpzUTIJ+GT8o=;
  b=H39HOzQ0A6zu8WmaxJ2X1HVkVyl8XPhl4lU1EZIcY9HM59XN2TFJ3x7n
   TgHOxAvTpIZXYINHsfSGh/z02Nm+XVXdV/pkw4UheqGCe7opUMpoFy2fc
   PhCgMdl53ys0O5B55OMfWRIu8/rCcxEu/EyfAVjnSgVn+Y4644bV36mzA
   dGpHZ3GuJrrw4euqfoVwW62+HUinEO0/xLUXzwJNk/G9puHjktcAyS+iV
   EYx9pv0qovHCR4H94HDROiITchfa+4Pgrzgz8ZDToUDojicGQWi3Eb4PC
   TQmcArFq8Uf1ZcHwgq2jvtsCoT/F3/wzEcqcrOfM2j2TYKKprGhBsSQJf
   w==;
X-IronPort-AV: E=Sophos;i="5.88,373,1635177600"; 
   d="scan'208";a="193075464"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Feb 2022 15:19:06 +0800
IronPort-SDR: jCc0PQg2gSVts8+KdjznQ8m3dI1F0e4JZef6rkAbkHlpbsvk24QnYpiqnvPSCgtg0bXd4VrwO8
 JC4SZxg5L735kqRBYOnZodt2wuJ3o9GGeU83/EUH0dMETwOIHLP2QSAkO0wnspY7edfpdLx1Zh
 unkM/p3+PkhCGUbfaCQVRTVa3ROtETB2wztN0itzfSOvIRM32Tpow0NGcM/K6NseiW0WPdCQby
 uXfVI13Ta44edx6Wj1+0sKxkB6JRoTMSpeZJbYAHHw7fGl4YxTOIZU4uzCX7++X/IeindxcSnO
 u5LrWIRkImrzdb9yxUE8h8ea
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 22:51:55 -0800
IronPort-SDR: saSa6kuVeDXTaVFQYXU+Fax1TkUdQOOdBN8tUN9Tjq39iNoUVX+retMMeBPUSgjWQ8vz4zcLQ1
 WRayXiG9eSDBbD6f/9Sl7ovz5ntyrQ8kVSEIO5E+iC9T+25vQufABuJTZ2cAl1iY4WZcXMz86O
 A45QHZS5zrz+whBfKssPLMEG6gFIYWUXIEjuP9k7AWBTvWELnciUdxPgZw4a//cS1yqP1Mwt9P
 ktOUfDkfBvRrPv5+J9lWBOb4TdBoLXyXFhcRj3bBegGNdOZwSp7ueAi+OWDGEH6sMdA5D6G8Bl
 JvA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 23:19:07 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Jz8TR1DvVz1SHwl
        for <linux-ide@vger.kernel.org>; Tue, 15 Feb 2022 23:19:07 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :mime-version:x-mailer:message-id:date:subject:to:from; s=dkim;
         t=1644995946; x=1647587947; bh=PgHb45fjk7fVCVwQBEuLhzyXD2Z4wiqY
        pzUTIJ+GT8o=; b=j2bxQeNsQ3b7M6fYej8zIPCMgQTSrsdKhKM158+xnoXd8pd1
        UunmAISIiI28GVPAC4uyNooWwGoDk8lB6/NIHPL8ARzdMTrHObOdjmunRuNBm7lB
        vD4MNzsbZ0B9Si4VrodEQXxMrTWIMVoi5J/g0iANqFHBKtWAHsKbu9AEjv06X2ol
        NOzW9zRL4+CDL1YuHaJamPdsiBCfyCZH++SkEFSQR4BkaST33RYvSGkhXpowY9Ty
        53m/XOqEJdVb4o9I4Rb3x/FO+742e75U1JYC6IVOotYn5zlfdAkjLdKFXI3sld3S
        xtPdKH4ckt3BVRvyiXhhbanzQqDBD1pPN/yNGA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id j5nS8P-0x3uq for <linux-ide@vger.kernel.org>;
        Tue, 15 Feb 2022 23:19:06 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Jz8TQ3fWcz1Rwrw
        for <linux-ide@vger.kernel.org>; Tue, 15 Feb 2022 23:19:06 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Subject: [PATCH] ata: Kconfig: fix sata gemini compile test condition
Date:   Wed, 16 Feb 2022 16:19:04 +0900
Message-Id: <20220216071904.265969-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

When compile testing the sata gemini driver, CONFIG_OF is required to
avoid the warning:

drivers/ata/sata_gemini.c:421:34: error: =E2=80=98gemini_sata_of_match=E2=
=80=99 defined
but not used [-Werror=3Dunused-const-variable=3D]

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/ata/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index cb54631fd950..f2d436df9da3 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -283,7 +283,7 @@ config SATA_FSL
=20
 config SATA_GEMINI
 	tristate "Gemini SATA bridge support"
-	depends on ARCH_GEMINI || COMPILE_TEST
+	depends on ARCH_GEMINI || (OF && COMPILE_TEST)
 	select SATA_HOST
 	default ARCH_GEMINI
 	help
--=20
2.34.1

