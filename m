Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16940C4332F
	for <linux-ide@archiver.kernel.org>; Mon, 17 Oct 2022 03:22:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbiJQDWS (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 16 Oct 2022 23:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232191AbiJQDWO (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 16 Oct 2022 23:22:14 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E8F4DB06
        for <linux-ide@vger.kernel.org>; Sun, 16 Oct 2022 20:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1665976933; x=1697512933;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qb90FWiWJqsBiM+rnnLq+ou+II9tNJdbJqeHntpNBfE=;
  b=q3uMJnMuUMPDCnNYfmFfyiFcGP2+knDr34832onjhlnFAp4cpiF+tOAw
   XeN6FooYUBPol2IsX9EdinBUFXWbcDtoOSvMMaSqHhfTxXGYQ7KNESqn+
   WL9+OiRy3ngGgmvKsk0RxiGNYo9avwbDTjCOSwYkBaLtRibZo68ZcH9Jk
   r287Dm+XkiqiecUmpjXosWYlTmwTB3/aQ5aXmvKldgqPbwINntw2eylX6
   sY96QAVuPDYIB4WKUKf+eMHekbVA5xUBmKKufcG6eKCMLvU0NYwQtyvqP
   JD701ZzCHSTjM/Ppde5Xvd6/dQKO+Bn54jEq/M0LbPEHjvr9hHqg0zhLh
   A==;
X-IronPort-AV: E=Sophos;i="5.95,190,1661788800"; 
   d="scan'208";a="219135007"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Oct 2022 11:22:12 +0800
IronPort-SDR: qGjctXMncbsgkZzjrzvj5eD5TqAqEh20ivmCYk/FrXQwpt1hdbtWBZkLU0k6dYltU3msoZhxK2
 Yw2bRB74q4yaQAVIWju42nUmAmd3jtWv+fEe4HewKlqEqjMBjzRI8HU33NEnohOsurG4wAkBRh
 DMGx2EzWRlhYyQv089ncuTDA361DHhIp01Jk6UdE8qCPPyvwdB/1aqC23YK14Xj2SNm776+nBU
 pwLJmz5kpjw/wpU9qSax9FiQPrrJKwj2b10h4h6r+eRL0y0GDDHvCd0Lc0bGgapuLKbKAb/ncz
 ueYIYrU+3cCKicLHQsR262YB
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Oct 2022 19:41:45 -0700
IronPort-SDR: jwHgoTz+xSjJ/XRolAXmimu1cIuf6Lryw/WroTeQ5WgF+gxnHm5G4n1iiPY5FsA1lzClHseCqs
 JcgIMpG6ZytcBZphqGKnp9XVZylWgGB7/0QtR5RY32/N6rX7xAm8ilji/6GdMoU5ioPMR3CRcu
 yQOXzL8G/V2Bz6u2F3/+/em0xzHLtiWGkoa45RPt9eSOjqXEbio+m/Yp2F+4paern8Jhpqesuw
 8TU8fJP5+uZeb8xMIcSnzQl4Zd8Zdq6MLM+T1ihPwNNLfe5G42DnlP+yQsDC1gEQA4QggUqi70
 2gE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Oct 2022 20:22:12 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MrMjw3jKPz1Rwrq
        for <linux-ide@vger.kernel.org>; Sun, 16 Oct 2022 20:22:12 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1665976931; x=1668568932; bh=qb90FWiWJqsBiM+rnn
        Lq+ou+II9tNJdbJqeHntpNBfE=; b=pX4hETffpYuWnSM4cUy/mzy/YSWqKPaMN+
        Y8s1HK5NKXdW5umftot/90hQibIvG85C/s5zeJYjEkqfDnKJ++WZg0LVqQE8MNK0
        e0rF8aJ0Lfrw0lyfXjkxBcWQvdEg4CLF/b5QCFOH8RJkxAeVxRCg3sWyb8XnfTBj
        qx1Fr2nb5hBXdJ9c6NHU+nSaLg0sx9SUF9iT+qIUIK6wF2zB3luaRbvhc1/0QSW3
        NRGNvl/hSFfynEbO+3JbxNejaNgbjU4ef6rS8x1LFHGHjhQ8OFGvVsa4UICJTc/5
        HeGnQUtTb0Ux9RO0fosA1zThLypoNZvUP8GvViAWgUgLm1y5i2bA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id uEFRGX9pNrPN for <linux-ide@vger.kernel.org>;
        Sun, 16 Oct 2022 20:22:11 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MrMjt4jtnz1RvLy;
        Sun, 16 Oct 2022 20:22:10 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        linux-renesas-soc@vger.kernel.org,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH 2/6] ata: sata_rcar: Fix compilation warning
Date:   Mon, 17 Oct 2022 12:22:01 +0900
Message-Id: <20221017032205.2210188-3-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221017032205.2210188-1-damien.lemoal@opensource.wdc.com>
References: <20221017032205.2210188-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

When compiling with clang and W=3D1, the following warning is generated:

drivers/ata/sata_rcar.c:878:15: error: cast to smaller integer type
'enum sata_rcar_type' from 'const void *'
[-Werror,-Wvoid-pointer-to-enum-cast]
        priv->type =3D (enum sata_rcar_type)of_device_get_match_data(dev)=
;
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Fix this by using a cast to unsigned long to match the "void *" type
size returned by of_device_get_match_data().

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/ata/sata_rcar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/sata_rcar.c b/drivers/ata/sata_rcar.c
index 590ebea99601..0195eb29f6c2 100644
--- a/drivers/ata/sata_rcar.c
+++ b/drivers/ata/sata_rcar.c
@@ -875,7 +875,7 @@ static int sata_rcar_probe(struct platform_device *pd=
ev)
 	if (!priv)
 		return -ENOMEM;
=20
-	priv->type =3D (enum sata_rcar_type)of_device_get_match_data(dev);
+	priv->type =3D (unsigned long)of_device_get_match_data(dev);
=20
 	pm_runtime_enable(dev);
 	ret =3D pm_runtime_get_sync(dev);
--=20
2.37.3

