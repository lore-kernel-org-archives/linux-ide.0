Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77AA4C433FE
	for <linux-ide@archiver.kernel.org>; Mon,  7 Nov 2022 00:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbiKGAuo (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 6 Nov 2022 19:50:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbiKGAuj (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 6 Nov 2022 19:50:39 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 277CFC763
        for <linux-ide@vger.kernel.org>; Sun,  6 Nov 2022 16:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667782234; x=1699318234;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nQOC0Pfd3xQkIpsrM2jqz2PO66oztnRmZbo1BOuXWN0=;
  b=M4hig+LCcXkE52h/gz2vSpSPu8tktub6beXV9cgvSaGyA8Kj8li7B1rW
   I+RHa59ISHVgn9PyeYj+MMH6DOO6YShv5bERQh0OyB3Y8/Tz0pCjzVtze
   LCmgCveylyGwm5mUUR1kGq+BfWspe5Nc1soRMt9nIza/NppSu7PH8B2/c
   5BOe7zGI3fKE8EuEi8VbnbVmjRfG9JZ/OBd3ZmNi0Kj99OAOhCjjtNEOL
   SqnUqrjyN85z8VMkcSTGJBamXeySTkNNqRY/uT5HL6jGkIp3upuq4vIvV
   SFO2qrg5xJeUMeGfhc3MW78poyg88zfN1vTG3Vl0UFwlPBtvsq3mbMeBX
   A==;
X-IronPort-AV: E=Sophos;i="5.96,143,1665417600"; 
   d="scan'208";a="215958493"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Nov 2022 08:50:33 +0800
IronPort-SDR: rQ1MIMzgNVzVH8wuCDQzu7clmwxv7a0cRjxErRfZQNzkFiA9kFgn9zB9/stOS4nuqxexeIvb7f
 KJAx+wJgort49xr06O61jdnr8EpM/Ox220A05iBpiL2/RVr99JO+JIiih6iIHKj/zHRDNjKOaz
 C9ajmT6I8Aedwh8i83+O6cioldqr1K+Cz3L71Bq2S/7nW3Xxs2g+hs1b4A0XwWSniSJgbIV8ku
 K4PXmcXNLSdotIBj6FNGbOg9oPD8R1SELpRYM2cmzHY/KDY8ww+eY3iRA1sZqbcV2HiDJsJzUg
 oVM=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Nov 2022 16:09:41 -0800
IronPort-SDR: 9V5pjfROWxclkF41gn4k6ce5L1OjHJFU3OKiJdhuvv5RPYhMHu+onNvorfKTl2YSTzxoK1uizY
 L0dTCk0fcSy0E8R+rciAMxxLf1r0JYaQZoRGX5+XM/NQbgTXoC19fRJHkgkVgnn8pyPofKeUrv
 pNEojFe04ORqd02F2xvKeXtvwRk9OQCZAUOxDbhZu9NftvjEEyPRybUqCTV263R1PRzTgNlKvk
 fVXscUiC6X7BF72C9aWIvr1i8g571Jmq60EclF3tjgecnH+bijs6tj/ZHDkTQ6xKiKCdeXjJH/
 DbM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Nov 2022 16:50:34 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N5CMF47w8z1Rwt8
        for <linux-ide@vger.kernel.org>; Sun,  6 Nov 2022 16:50:33 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1667782233; x=1670374234; bh=nQOC0Pfd3xQkIpsrM2
        jqz2PO66oztnRmZbo1BOuXWN0=; b=SdDM5nYNXvoK9pnw2cxmoQW4E5nCWcRnNP
        +wu/mFHBAvW9Gnlvk/l/Ljfejm+MfuZ+qCtTTB3bMtpzitEC8YaYxN6HkqBixc9o
        mKGEe8i3WXMUc5efYooxzTbpdYBEBwxI13eCwWEqfIx9rNkxm6EobZ+1cIPodxxD
        z3+HCi7V0fZBNPfexHChg65JUCjxE9rbMeuJ/jTf3V1OpU4CQPNB1naWglCZENFo
        jCDzXBdW69C60B3KAFZPeJDJJ8Z9cgk+jCVdAZQPab0zNbPalp4Vx/57yJ1WPyoI
        CjA2o886zCzOVTyzQEEL9AM86qPyg0BOHy4aN23zT/cOV1PZsI/w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 7dg4NdUIO7FL for <linux-ide@vger.kernel.org>;
        Sun,  6 Nov 2022 16:50:33 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N5CMD0ycRz1RvTp;
        Sun,  6 Nov 2022 16:50:31 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v5 7/7] ata: libata: Enable fua support by default
Date:   Mon,  7 Nov 2022 09:50:21 +0900
Message-Id: <20221107005021.1327692-8-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221107005021.1327692-1-damien.lemoal@opensource.wdc.com>
References: <20221107005021.1327692-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Change the default value of the fua module parameter to 1 to enable fua
support by default for all devices supporting it.

FUA support can be disabled for individual drives using the
force=3D[ID]nofua libata module argument.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 drivers/ata/libata-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 29042665c550..9e9ce1905992 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -127,9 +127,9 @@ int atapi_passthru16 =3D 1;
 module_param(atapi_passthru16, int, 0444);
 MODULE_PARM_DESC(atapi_passthru16, "Enable ATA_16 passthru for ATAPI dev=
ices (0=3Doff, 1=3Don [default])");
=20
-int libata_fua =3D 0;
+int libata_fua =3D 1;
 module_param_named(fua, libata_fua, int, 0444);
-MODULE_PARM_DESC(fua, "FUA support (0=3Doff [default], 1=3Don)");
+MODULE_PARM_DESC(fua, "FUA support (0=3Doff, 1=3Don [default])");
=20
 static int ata_ignore_hpa;
 module_param_named(ignore_hpa, ata_ignore_hpa, int, 0644);
--=20
2.38.1

