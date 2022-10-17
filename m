Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F16C4332F
	for <linux-ide@archiver.kernel.org>; Mon, 17 Oct 2022 06:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiJQG0N (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 17 Oct 2022 02:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiJQG0M (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 17 Oct 2022 02:26:12 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7D12E69B
        for <linux-ide@vger.kernel.org>; Sun, 16 Oct 2022 23:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1665987971; x=1697523971;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t4teOJveAsuZ73M/b4IVMod3m+YB2xkwcL5g6oHeKPI=;
  b=jPaLYFCBjz4E7VVUZJpBzdAnNEYpE6LSg+R1IK1g+0aqHdAKC08tZMKu
   8Bxfb+L0UnFb4Ewtl5NucdwjQLSFQePFwPuoRSKIXjrKE4BSHTkZk+YKJ
   TRCl47WJIpkFxS9r7hM++hNSCs7Q2YJrwEaxIGor3omDlSLCX7oiqlkNs
   bkGGk1Jh606XfJHPdUY4WiI8WOnTj0rtQOjJ9PIgXNqNYFJuNsCqkRx51
   SVSXsIP/SEgwgIOaqkHB+/vBZN5UkZxlsY82yQ7Es+m09xTiY/V+tKish
   39mOypp4OuMvNe989BrTseOiFKJTcQUEMWBjFWlzP3FCQpnZlB6LdJhLh
   w==;
X-IronPort-AV: E=Sophos;i="5.95,190,1661788800"; 
   d="scan'208";a="212316364"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 17 Oct 2022 14:26:09 +0800
IronPort-SDR: jimibWU0WDKwlLLuvmgK9i66xCO+uEdGkUYH7cVp7uq5e2iMfjjFFeQkHtskjTBLIUqKb7jo6t
 h/ieQoxunCr1t3+IwJOIHFj3F11fidAW5PD2IFMl26RaCpO+0OFCBAaB96rr/kSfbst81xuCOd
 tYpkMR7U8cMCxNwYNBZ57Ai932EA303NAqF5LPlZ4ehZEYK2YKP3mvMVZJ2JqR9gNQwWnapluO
 FgQ5mimwcvnej6q1ZcDvBbDm4Sll17wdQPS9tR//yA4dfgV/aQOGjGKf2gMWVACEfKg/ehlQSo
 WydRVPRr7HsEQ+b7GnvU7QrZ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Oct 2022 22:40:04 -0700
IronPort-SDR: uuhb7lIz19dSXjjQUjwYTterUISejD+ltNuK1wXVdqX7IpRbCBMg5PcFky3Z28w8m20mQYpbU0
 sz8SG6q5xJuWBXfrjFHW4ZNm42C+WrVgmRMtl8jtEwTo/PQudJgahlLyl71WHCej1fY80vNHAQ
 Acd+LqRcMpnCj27MbVmNC5scnoaTQlGCUFiPMK2kfUwfl5ydlvZTo3xN5nNgGcs5x+MOKLhC/T
 Jk+BrpYB5+QAmziso0FfI41wlgk543QXPp47RAhdkVJq+YgUpGr6x3m20Gh3UyN2bibrpwgpSp
 Vs4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Oct 2022 23:26:09 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MrRp90rVlz1RwtC
        for <linux-ide@vger.kernel.org>; Sun, 16 Oct 2022 23:26:09 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1665987964; x=1668579965; bh=t4teOJveAsuZ73M/b4
        IVMod3m+YB2xkwcL5g6oHeKPI=; b=ShETl2BxybGCHJMT5BwO0S/zjExU7qhMRY
        IujBczGP+yg4ct3g3H7xvZxUaSSbIyo/zb9q+CogXehgnXEtyaMcmBUCkb3STzaj
        1/pMCV/N2+LR6WzEqSOVwohIKESg+MlTXN6PHIupd4RwmnTWZLWqQxZ0KKkNwpwh
        6Z7QlGllLKxvcSEpIUQomv1RZp0bE/0eXbSNVHElE2mlG0CtPs5Z2i+uUIxk5lCH
        Oxb9T5jpGd7bjqT5M47mSl3fbq+Yfc0GpAzzEr1WRYbNcvCnTz62SDxSa+7QJjWh
        G/banSlP7MC6NbcmIFCTGvSQaDA18gAltesdp2i+qyXQ5/5y8hew==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id rWOhh-HpKRsc for <linux-ide@vger.kernel.org>;
        Sun, 16 Oct 2022 23:26:04 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MrRp32fZQz1RvTr;
        Sun, 16 Oct 2022 23:26:03 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH 2/2] ata: pata_ftide010: Remove build dependency on OF
Date:   Mon, 17 Oct 2022 15:25:59 +0900
Message-Id: <20221017062559.2221881-3-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221017062559.2221881-1-damien.lemoal@opensource.wdc.com>
References: <20221017062559.2221881-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The pata_ftide010 can be built without CONFIG_OF being enabled, as long
as the macro of_match_ptr() is not used when initializing the platform
driver .of_match_table field.

Remove the use of this macro and the build dependency on OF.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/ata/Kconfig         | 1 -
 drivers/ata/pata_ftide010.c | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 37e065106baf..b30f71859154 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -696,7 +696,6 @@ config PATA_EP93XX
=20
 config PATA_FTIDE010
 	tristate "Faraday Technology FTIDE010 PATA support"
-	depends on OF
 	depends on ARM || COMPILE_TEST
 	depends on SATA_GEMINI
 	help
diff --git a/drivers/ata/pata_ftide010.c b/drivers/ata/pata_ftide010.c
index 0117df0fe3c5..88924b5daa1a 100644
--- a/drivers/ata/pata_ftide010.c
+++ b/drivers/ata/pata_ftide010.c
@@ -560,7 +560,7 @@ static const struct of_device_id pata_ftide010_of_mat=
ch[] =3D {
 static struct platform_driver pata_ftide010_driver =3D {
 	.driver =3D {
 		.name =3D DRV_NAME,
-		.of_match_table =3D of_match_ptr(pata_ftide010_of_match),
+		.of_match_table =3D pata_ftide010_of_match,
 	},
 	.probe =3D pata_ftide010_probe,
 	.remove =3D pata_ftide010_remove,
--=20
2.37.3

