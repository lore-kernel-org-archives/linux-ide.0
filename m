Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A0DC433EF
	for <linux-ide@archiver.kernel.org>; Thu, 27 Jan 2022 07:29:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234114AbiA0H3X (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 27 Jan 2022 02:29:23 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:23782 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234008AbiA0H3W (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 27 Jan 2022 02:29:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1643268562; x=1674804562;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=JFHlJxjD7NFzg77KraOpb0tP6oP/7kgVp/rn+FyJAXw=;
  b=pgriexnXVPrfy0FdBe08JqJJIkOtcEYJZtbuwNPtLMlvDPo0u45ATT62
   2ZZmKUj1ZN7bMgLHMuGv0cikrENpGsREXJObIZ+2BZ/w+AwDHb/rNzCTD
   KmFu0RAdL3VjHTPtl6eBEs7Hr/Dm8b8MYm3hXGp27LYs6Siz6GtzN+M3E
   ydgOtPyJfzfMWzXLSCmoHXPz3pEhxu1LZZTkHBxzFt9SoUcd0npLF24Si
   /9Ns/qKs+IyOBUgA67RMbtccmBkuVEXzBS+kqzSHEzbfXx+f8Qn1Ppk+F
   ey3UofGBd60w13aQtZ+bMqIquJnFuxY0J7yG6iSIruunDDABdjU/CCUOB
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,320,1635177600"; 
   d="scan'208";a="295583695"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jan 2022 15:29:22 +0800
IronPort-SDR: ahIwcMhxEav88hkCmjym5GKOW//Q710+XDsEPfD4Du55rJzBfaf+7glfEFwHmyoZEapKPHsko+
 pvani2cQPCRHD2LdojRpTjrB0JBhan9AtKle2xyzwiwiUhYCmNXQ0+rBY+/UreJ9q/89aavQcd
 iGI7z3/Lndf9lZaNrQZW3vdn3fzmUJAusMOeE7fFp9PD17uHy5F7CS+OnjNagAnAr+7A6tTLPx
 A31wEA0Vc6wbC8Ca9UzMRTXxSLQtOUj5PHhwVoc4cV+KZIhcaq1CSGPSX+x7yvXl4mrM2nkx0D
 z2dMkQpI/tLycwWkvdxjuprg
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 23:02:41 -0800
IronPort-SDR: BMYKikbtXQkbZUnSc7y0qM8A41xmFzB7bkljpsCHIfNQJAAi7eYxk6+8OBkqx4PZU8kaZG5wx6
 3I/r9B/LEKT1pSGxQ6nBS1IoJ7kuCdegFKR/SxhBynG2XJDf0smI+rC+lEJwsKLoJhqi6E+UUm
 AXEhMW6210FZDNiI3wPNks3zAINRRi0XtBbdwDaobjoR9TBbrcTAjZVcVRbuzXrhh0zrVU5PLL
 +ze/RzLfnf5KQ4rl2bNW+kcEssse6oveQF7dsLgRJabeXelJiSp1dh7gFOdfvEHbfh/6XJPE09
 DHw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 23:29:23 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JksfV2fdMz1SHwl
        for <linux-ide@vger.kernel.org>; Wed, 26 Jan 2022 23:29:22 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1643268562; x=1645860563; bh=JFHlJxjD7NFzg77Kra
        Opb0tP6oP/7kgVp/rn+FyJAXw=; b=KEK7yLnN4bhWmP030rU4hCLNtwYDqTPKwe
        SOXp73kdlgUGUx588PS5INCd4yAdqsjqiA46Kmsmn/t4A3/4ON+U+1Kw2ga2Of/f
        KNJ0eXwHuK6i2KL2MW855StKSLMO9JUz4VPXYKH8g7G/zIrdSqfBLHofC4dZGK6s
        zW2/q/gHAr4hcPOoRZ9l7s4l2xvJmmX7jmlhaOnPEFBJhUYZvdUbF+AY4N0sLEmM
        CZLrVeHS5ehKJJ3L9wxbYGIKd9qqqcnAfn/suOJiM2OAxiv8YSBTVynjhIToSiVj
        u/ES/QoooctlyLabYn1eg2DXuI1N62WuesPpXOlStYyKHES7DFGg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Nh54itvedR5i for <linux-ide@vger.kernel.org>;
        Wed, 26 Jan 2022 23:29:22 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JksfT5MYDz1Rwrw
        for <linux-ide@vger.kernel.org>; Wed, 26 Jan 2022 23:29:21 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Subject: [PATCH 1/3] ata: libata-scsi: Cleanup ata_get_xlat_func()
Date:   Thu, 27 Jan 2022 16:29:17 +0900
Message-Id: <20220127072919.139615-2-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220127072919.139615-1-damien.lemoal@opensource.wdc.com>
References: <20220127072919.139615-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Remove the unnecessary "break" after the return statement in the
MODE_SELECT/MODE_SELECT_10 case.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/ata/libata-scsi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index ed8be585a98f..c73e94c06147 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3933,7 +3933,6 @@ static inline ata_xlat_func_t ata_get_xlat_func(str=
uct ata_device *dev, u8 cmd)
 	case MODE_SELECT:
 	case MODE_SELECT_10:
 		return ata_scsi_mode_select_xlat;
-		break;
=20
 	case ZBC_IN:
 		return ata_scsi_zbc_in_xlat;
--=20
2.34.1

