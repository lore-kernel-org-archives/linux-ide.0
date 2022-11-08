Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7469DC433FE
	for <linux-ide@archiver.kernel.org>; Tue,  8 Nov 2022 05:56:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233390AbiKHF4T (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 8 Nov 2022 00:56:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233405AbiKHF4G (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 8 Nov 2022 00:56:06 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE74317C6
        for <linux-ide@vger.kernel.org>; Mon,  7 Nov 2022 21:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667886957; x=1699422957;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MzodolIBXzjJzo8qX7vax6iZ+4wEc086CZFFgStxWSw=;
  b=fmlGCiXcgDnqA3qmwKXcbMZZVb0LijFkD+tPNH67KFlquYB3eXuRO/7g
   cFr0Ln17qC8UNSXhPEkyfISjRSt1gAM5PsOWKNGswMTbG2N65fE640HZU
   pQzBzS4rg9nj/0ttdNOJGo9PXBYanBfu/r16b+a+zoFJBxV0XX6XwkFUt
   KW5C4Yl9js5bQltlk+O0dMrMm5ZLvRpOMrzJozCbxWzXyKU6FQSO1yZP/
   Wh+6XMSQMH68hcurgToVgSvOGomWcaCi0UTK7ghDwzepqIMoO/m+rSiYp
   yFAZ6/jIe1TgWpvcF+AdOiZv3q89Yxnf3HFlek217/ulhZdNa47ONBjfC
   w==;
X-IronPort-AV: E=Sophos;i="5.96,145,1665417600"; 
   d="scan'208";a="327831374"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Nov 2022 13:55:57 +0800
IronPort-SDR: zXJZNZJ5UY2Vo+9gnvEueal/7C+sBtigGs0WZa/CP0zp+pDV/5C0PNWeTy9BjK2H8tuc6bnztp
 8T4ilHNY6FUJxv5p78nCFobbool7nQKDYfMqf4tkgPiOFuJH/J/mJNs7L/pgXUIpltRcVE4AU7
 fZQWwyd2i2iU2hbr7Gl5JSTFtZ2fLQeqPBgmQI59F8lzubxkrPFvVO8el/HSILUThGgzX2Ebzw
 YGyCVsrCYTI/12Hw0qLQoiurwT0bLPhRRckSYrbzqjT/803DoCrhIpSKb4OcgEeXWcOrUKKJER
 gTE=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Nov 2022 21:15:03 -0800
IronPort-SDR: hY1o8/9QHlbmYLX2kc00l10Fg8WchUqqqmxH4kbKKKX7YggxnVVTylXaLcCMlVPjLD3mW/jpLZ
 h9U/78dF6/c/qMSYxdxPSuZ4jpkPGqhvKH/Po2FfXC37qoeYaDmL9ZXf9SoIeKIrAMcrBshQ+E
 Cp+3IZUeEZpS9tgnNUBsoQ406rCRnb4WhAaBN+4wCaRLhuF8Z5Q5DOuKh68ci0/Z2EOhHnXjA/
 2UW2eP35eC4kaz9gvuwTMngq7FlZwEYMqlWJ853Xw+Q418EGN7lYSzTBnNZecft3Ubvo7Eyz+N
 Vbg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Nov 2022 21:55:57 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N5y586fscz1RvLy
        for <linux-ide@vger.kernel.org>; Mon,  7 Nov 2022 21:55:56 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1667886956; x=1670478957; bh=MzodolIBXzjJzo8qX7
        vax6iZ+4wEc086CZFFgStxWSw=; b=a5DHYDEOiXZLKy7A2nc8/vr7X5DowBMNue
        cojTCNemnbJh9rsDLtZOQTgrd6COznK9mNypsBskBb33d2RhyNZ+adf9Grj9YP24
        O6HHrqnlFVho2uvbo1+pTmsCcsySSH4NBealyxvwd6m2JlSV8aANq5WDiyBz+Sjq
        rdPeQ9hYkbS/Rncvf+ZrVIMmBbmRgn+GRRaeMyHc6XIGM3r2Tad5LeTK4najJXj7
        cMkHFqVUEQvmjaJzz/ODPvt/yXcShGbTenDCgo88RvRN3JkJiOkMwIu8ZnHKQnXz
        RAq5HJLTLx/miuGLG2H8LNtupNIakNsu3XUsJON6p2NQf1z0sC+w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id KvclwuW_NUVq for <linux-ide@vger.kernel.org>;
        Mon,  7 Nov 2022 21:55:56 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N5y574bhCz1RvTp;
        Mon,  7 Nov 2022 21:55:55 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v6 7/7] ata: libata: Enable fua support by default
Date:   Tue,  8 Nov 2022 14:55:44 +0900
Message-Id: <20221108055544.1481583-8-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221108055544.1481583-1-damien.lemoal@opensource.wdc.com>
References: <20221108055544.1481583-1-damien.lemoal@opensource.wdc.com>
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
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/ata/libata-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 97ade977b830..2967671131d2 100644
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

