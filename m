Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760F0C43219
	for <linux-ide@archiver.kernel.org>; Mon, 17 Oct 2022 06:26:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbiJQG0N (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 17 Oct 2022 02:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbiJQG0M (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 17 Oct 2022 02:26:12 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4138B9587
        for <linux-ide@vger.kernel.org>; Sun, 16 Oct 2022 23:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1665987971; x=1697523971;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Py1BLf3fDunWnt9ekpIjZ6gBXrSp7ABBfq3FJ7tJmXU=;
  b=HRDEQbkD52IncWjlMmYLz5MuNSUiVOOV6wW5zV2BGGVtuz1/MtUFGnk4
   Pt29LxXe0Tmifq4hZ3skYJqrpQShsh0uIiODu5qXoZ3g689XEoAdm2saL
   iRh1fj7njsQJ1ibnfmuvx0i0miONtNeMaQir+QjfiRoXfhRF9DjFc8oKD
   z1YnOKY3deZMdZ0YrQYAH5c9KcJejVWS8e2pOKz6dvLhijOJD8IWZtGEX
   KaYxcpuHY2Ad49aEtZg9jbi6vyLnDlPctTnzyAUdHhBKlCRSNvKh675VR
   WL2SEfnDhZfsnbcboDKQ0bBTrxsWouTcAIYFI2FBWxZMLjpObRdfnXoIJ
   g==;
X-IronPort-AV: E=Sophos;i="5.95,190,1661788800"; 
   d="scan'208";a="212316363"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 17 Oct 2022 14:26:09 +0800
IronPort-SDR: yNfI0doHXhdt8sV9FJoMXMo1wqrUVNTM2fjWQW4KK/4BHHM2i/n65NyNPydrHRhRG5TL2Q278R
 IEmQR22fOQHmQdTpjWyebyrvYqkHbJmCjnIm0WmIsFmEZwnUHBW8RcDzNqBpYpXml6RAcDwTjQ
 3ebPbESgGrM7gu4nopxt3VdEqVBBtLxLgwUxhZ6qBkTEj/9wrffzn/aCni3jnbDaq8UNWJPXiK
 Aji4SEx+JIjpn/gO8qRyt8uob6WvQ5y2w6oIT/KlSPCrTLhWsiILbbaOI0dhMQSw0pgv5WadSb
 vNUvOt3Dd5ydGPlVM/HTNuBo
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Oct 2022 22:40:04 -0700
IronPort-SDR: gGqTpSAxXFb6XT3pffOyel/R3s2PAEl+6t0pFNxjLLS79qgu3qqzLUEWVmlEgEQRA3IBYsvnyn
 di7CgvmKzuh2AsWe4gEtrQQv+3EBKMZbyJI175wiOYj4H9QwPfO6/7cQxeURMl4fVKrGk49mvL
 rqnwabluhPljph/iMdbHehEiUEOg0Dw9y5fnq4e8BaEsjpT+BJ1ZzRpyVqUkW8lKJGaD8wbG79
 2ynOnpCCMJZKXck3DGsSqpXAsE9n7Q9Bc1VxJJo9HtvL5M1b6a2F7SaNOxd7iTxKFb7IuOqtUQ
 stQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Oct 2022 23:26:09 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MrRp90dhsz1Rwt8
        for <linux-ide@vger.kernel.org>; Sun, 16 Oct 2022 23:26:09 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1665987963; x=1668579964; bh=Py1BLf3fDunWnt9ekp
        IjZ6gBXrSp7ABBfq3FJ7tJmXU=; b=KS1mo6nZXHFoYCa1kPh7F7dL/kuP3iLi6B
        7kksawvPLzXdMpH1+AnWctxTrL9TsJiGAnBh72iqWJBXHz2vZVJXqMU582KR34DA
        KkTb8hMIW2DctTzDpuYguVPZJRWijEEtFkz6yE7+62/9oepp33MOshi4xciR5uxE
        el0woCiyiaeUE20+MJPii8IFSOpIum1SfnuL0F6v4jGSulzJlZtayot71Hcxolbb
        985lFkgxRvInDmr0mzVxRHRgV4sS/+t9R0dLuzBoJcoSaomcMcjwS/z+bYVnDBYm
        t8LeithISwitxt9G5PXcDH+THrzXSLV2vE0gpEbPv+hFuxMdL6dw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2rHkOyis_J5o for <linux-ide@vger.kernel.org>;
        Sun, 16 Oct 2022 23:26:03 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MrRp23XWVz1RvTp;
        Sun, 16 Oct 2022 23:26:02 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH 1/2] ata: sata_gemini: Remove dependency on OF for compile tests
Date:   Mon, 17 Oct 2022 15:25:58 +0900
Message-Id: <20221017062559.2221881-2-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221017062559.2221881-1-damien.lemoal@opensource.wdc.com>
References: <20221017062559.2221881-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

If CONFIG_OF is disabled, then using the macro of_match_ptr() results
in the gemini_sata_of_match variable being unused, which generates a
compilation warning and a compilation error if CONFIG_WERROR is enabled.

Removing the use of this macro by directly assigning the
gemini_sata_of_match match table to the .of_match_table field in the
platform driver definition allows removing the dependency on OF for
compile tests, thus improving compile test coverage.

Fixes: f7220eac752f ("ata: Kconfig: fix sata gemini compile test conditio=
n")
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/ata/Kconfig       | 2 +-
 drivers/ata/sata_gemini.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 36833a862998..37e065106baf 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -295,7 +295,7 @@ config SATA_FSL
=20
 config SATA_GEMINI
 	tristate "Gemini SATA bridge support"
-	depends on ARCH_GEMINI || (OF && COMPILE_TEST)
+	depends on ARCH_GEMINI || COMPILE_TEST
 	select SATA_HOST
 	default ARCH_GEMINI
 	help
diff --git a/drivers/ata/sata_gemini.c b/drivers/ata/sata_gemini.c
index b729e9919bb0..c42cc9bbbc4e 100644
--- a/drivers/ata/sata_gemini.c
+++ b/drivers/ata/sata_gemini.c
@@ -421,7 +421,7 @@ static const struct of_device_id gemini_sata_of_match=
[] =3D {
 static struct platform_driver gemini_sata_driver =3D {
 	.driver =3D {
 		.name =3D DRV_NAME,
-		.of_match_table =3D of_match_ptr(gemini_sata_of_match),
+		.of_match_table =3D gemini_sata_of_match,
 	},
 	.probe =3D gemini_sata_probe,
 	.remove =3D gemini_sata_remove,
--=20
2.37.3

