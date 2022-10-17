Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE5B8C4332F
	for <linux-ide@archiver.kernel.org>; Mon, 17 Oct 2022 03:22:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbiJQDWg (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 16 Oct 2022 23:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232206AbiJQDWT (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 16 Oct 2022 23:22:19 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614254DB09
        for <linux-ide@vger.kernel.org>; Sun, 16 Oct 2022 20:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1665976938; x=1697512938;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AmpxHBtPrMCtfK9ErFiTCWFNTcLn+8gXnygCT8fikds=;
  b=FD+0eiHtocQqYjPoyGAtbB1Rbxi4VpY2qzWtq17xqgS+rEZAaDQBt/rd
   oW8+rhZsW+dZwvg+S+Wtomvm/Bu0AGW/upONDBGP/zqqKkGmE+9MaKeEj
   O9d7OC3rhtUHgZi5QXuwXQ3qgU11602thN6rvANz0Ege+d/7PTbwzjzX4
   MRyC4WqyQiU8DRz9sCAAXNt+QZCQ9ZKGzzLsa4qt884MdJ4BG8moemahX
   h/0oAoJ5GxY14U1ol9utt9pQO/JJL2F17KNQmYZh02qwzycK2dmLXIjKf
   SPH74p/g4i1+/iwCt8mtcjW3G6U9issoO/oXEaSriNmzRW7HIjSjbkuxH
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,190,1661788800"; 
   d="scan'208";a="318298410"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Oct 2022 11:22:17 +0800
IronPort-SDR: MW5BIgwPa2cfkMyKhQ8OgsnQeo5oFgiWxQUOuIAO1Tp8NAUsXPX9uKS4IAioOpKIOpQtswDgQc
 pfEDbmk1dy1DIl85mlwno69l9K4Xti9T650f7RN5eKmsGVDCYFc31Ams3lCqpd/T1EONsd34gI
 XEHAFtbaXh8SVLAIIUtBBAZ/ASFLe/J5L4mri3SikvivbuwX32voiP63aSkIhlYMV8iqnkWeqI
 UEUiNSbMDMMxyUd2rzAQ9zzqIVk6CYEgPC47u0hCdz4WF8JGb+8a3r/vaKEqqg7mIXBETb+84x
 /16HN1IAQLLnQgsl7RHImtLi
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Oct 2022 19:41:50 -0700
IronPort-SDR: /UiMRwIYBgHPjqsU3oZub/H5tJPBE1WIXuLQLKCwXvgSBIfm64SkACI2ZalQ6Owu+WRA6cVLCr
 GlcsFy0chTyY0yM1rULNGbXEi7MYiUqYB4UgoyZ7Rr6Dr7b/yS7yVexjVRQ4QNkHjaiNvmSJPv
 S03brK8sOA9kd8qoNxpUy0zqUz5DtBOH68V59ynqqi6Iz4fCass7fc9QJbCpM5CUO7FkLbj+uz
 2MnzREsB2KvCE6PRXZfeWGrpeqEhixqgFW9n5w98iPeeM98AAUopCt6TOTPKRZKhU9InJqVfg4
 VkM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Oct 2022 20:22:17 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MrMk13k02z1RwvL
        for <linux-ide@vger.kernel.org>; Sun, 16 Oct 2022 20:22:17 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1665976936; x=1668568937; bh=AmpxHBtPrMCtfK9ErF
        iTCWFNTcLn+8gXnygCT8fikds=; b=cUGWmPYrDgagYgHWORXg/qDECfoHwxItyT
        6FtOBNK11hup6LwKhURPVTN2VFd3hkNKpcLSMmduiIUULQDzkpGVy1TCz3Iw/bVP
        nMBkHc/AC/7Z/22mRAam9MT6ccrLG3cjaxvi58I+YPjwf4mPxQpXQapVgALF/wAf
        YZ5cp/fRQZrqF6T7nthBzqcuQRy6ER7sOnxhIeq/YowFm1vyv19eNjkfh2F2Trdo
        rjn2JZqubruG3AnNoriueX/Vqg3WwapGKriB/1rxYGCbtK2IKlbJ1Yv5WsULdhnA
        pGat7l/k0VTGcv3sk2Kh2SDEwfitbEHYa0k4vZcOcmsHOL2NP+ow==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id eQsn80nb9NqM for <linux-ide@vger.kernel.org>;
        Sun, 16 Oct 2022 20:22:16 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MrMjz4F4Dz1RvTp;
        Sun, 16 Oct 2022 20:22:15 -0700 (PDT)
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
Subject: [PATCH 5/6] ata: ahci_imx: Fix compilation warning
Date:   Mon, 17 Oct 2022 12:22:04 +0900
Message-Id: <20221017032205.2210188-6-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221017032205.2210188-1-damien.lemoal@opensource.wdc.com>
References: <20221017032205.2210188-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

When compiling with clang and W=3D1, the following warning is generated:

drivers/ata/ahci_imx.c:1070:18: error: cast to smaller integer type
'enum ahci_imx_type' from 'const void *'
[-Werror,-Wvoid-pointer-to-enum-cast]
        imxpriv->type =3D (enum ahci_imx_type)of_id->data;
                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Fix this by using a cast to unsigned long to match the "void *" type
size of of_id->data.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/ata/ahci_imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
index 632caa301458..a950767f7948 100644
--- a/drivers/ata/ahci_imx.c
+++ b/drivers/ata/ahci_imx.c
@@ -1067,7 +1067,7 @@ static int imx_ahci_probe(struct platform_device *p=
dev)
 	imxpriv->ahci_pdev =3D pdev;
 	imxpriv->no_device =3D false;
 	imxpriv->first_time =3D true;
-	imxpriv->type =3D (enum ahci_imx_type)of_id->data;
+	imxpriv->type =3D (unsigned long)of_id->data;
=20
 	imxpriv->sata_clk =3D devm_clk_get(dev, "sata");
 	if (IS_ERR(imxpriv->sata_clk)) {
--=20
2.37.3

