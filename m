Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D253EC6FD1F
	for <linux-ide@archiver.kernel.org>; Thu, 23 Mar 2023 03:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjCWDit (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 22 Mar 2023 23:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjCWDip (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 22 Mar 2023 23:38:45 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B542B10EF
        for <linux-ide@vger.kernel.org>; Wed, 22 Mar 2023 20:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679542723; x=1711078723;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KXBN5JGmxAlBHEMq2epnFEr6uvT+wtm6pf6xMORBgHs=;
  b=ewMZo5aDy558PlwyhmVYa3X1X/WzeXRD1vTHU9PihInZrAGLhIpGIP3q
   P+2QOCi4JSghUsqDzyzHnewKXCO07GTDHHf6susb7HLSoikGYMZYBBxKB
   FKG6c3bNrhWjkw17Tg46XYTCNh/A0naKr9yVi5Ms+zM9gzdcNXF/shGus
   whofhN3JgLo2U0wixz4TEVkEs1WkfHMRB6XyRGwBwCTGSmMpGVlJKA8i4
   aaLWLg4GmBlxl+kc6iW9ZPVelwyDhfkEIftQLSdSO5GFxLl/m9FXxjPQf
   Yn8tItxcMYQS9eCfqsGjw4kGyCPstwjYL/GaKooiWHcYfn28hAinFn9vG
   w==;
X-IronPort-AV: E=Sophos;i="5.98,283,1673884800"; 
   d="scan'208";a="330711519"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 23 Mar 2023 11:38:39 +0800
IronPort-SDR: WHWhiVrwYrgdbmF9KtlXlDm2BiJxhbh/EHIGvhKraRlLt3XHKsZITn9qNLyp654wx7UzeiVMbo
 mTSqNbMnrsbQvO8SPnXr5p9DPM8trtULxfD/G0nbh7AaF+Obbz6xKqstUc8GOXZL+d0M/CHLZU
 iGko69wySEo9POuRwPWnu1PLOoPOIpIYPIjjH+rWXs5Lsnk851vB8jseEKv1UAlqXk8UuWh7o7
 BstNq6aLWbEo/gliRredFx2zJY1VQ/63g43VnqNeVc4r1oEoxSxB8VhWnhdwUIej6jtikborHt
 G34=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Mar 2023 19:49:16 -0700
IronPort-SDR: zUO87GwSNesL7sotDJy+4kml4a+DzyGO7ylcS3pY7oWvPpM/3xSXRkCQDqWsQ3FJsLLq47Koc7
 UhRnOm7O6aAT4PeTcP2yLt1g8x4tScYVZ2PNFJTPwPnYhcgxWiXC1rpOo1bQ98rtt6tViGbLBm
 ENVoiviLmsUs0NZ+CBI6GWdT7OkunPqszfKDojbe6L4mjXYLkT+0/qF1u0JODuXBX1RZlEiun0
 212CQ2Sh9IsKgtWmOv3n71o/yI0cuiQkKhfe8mDexn49t/TtYd6WZXuO6uWj2OPbNHOv+3MU7S
 FnI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Mar 2023 20:38:40 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PhrfR5NWBz1RtVq
        for <linux-ide@vger.kernel.org>; Wed, 22 Mar 2023 20:38:39 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1679542719; x=1682134720; bh=KXBN5JGmxAlBHEMq2e
        pnFEr6uvT+wtm6pf6xMORBgHs=; b=X9wSWXQki4Y1gK5K03hqEjLPWCWvKxhG9k
        f4Cnwd0asQtBB+yWZOc9yOfYBrTwFVczGSUeWodPQutNj1gZX9CPn935nhLevzaG
        ZoC+QJwwktyC/F2qtcVQ9ui35ujdB6/lfcRHPUXvpGxN8fOlmhgbszJBl9U7yFhB
        12b1lwLaH6FJBCKiQ+3rquE1xxthGlWPGLC06nrx+BzhUsZlmIn9xxgv+wz1tvcj
        9uiyviQi1ml3jDTqWDkhC31y6SXrpZIR6/AZb05cgVYsT4WZEbbiYkk8VCQ634NB
        HNWedXu+CqKyAiBg50O+QsbtGofwwNET7cvM1mRGgILaGPEl59Lw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Auw4HJuv9l-l for <linux-ide@vger.kernel.org>;
        Wed, 22 Mar 2023 20:38:39 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PhrfQ5WF0z1RtVn;
        Wed, 22 Mar 2023 20:38:38 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org, Ondrej Zary <linux@zary.sk>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH 1/2] ata: pata_parport-bpck6: Remove dependency on 64BIT
Date:   Thu, 23 Mar 2023 12:38:35 +0900
Message-Id: <20230323033836.352672-2-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230323033836.352672-1-damien.lemoal@opensource.wdc.com>
References: <20230323033836.352672-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

There is no reason to have compilation of the bpck6 protocol module
being dependent on 64BIT. Remove this dependency.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/ata/pata_parport/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_parport/Kconfig b/drivers/ata/pata_parport/=
Kconfig
index 0893a13e7979..2c953f5d1396 100644
--- a/drivers/ata/pata_parport/Kconfig
+++ b/drivers/ata/pata_parport/Kconfig
@@ -25,7 +25,7 @@ config PATA_PARPORT_BPCK
=20
 config PATA_PARPORT_BPCK6
 	tristate "MicroSolutions backpack (Series 6) protocol"
-	depends on (PATA_PARPORT) && !64BIT
+	depends on PATA_PARPORT
 	help
 	  This option enables support for the Micro Solutions BACKPACK
 	  parallel port Series 6 IDE protocol.  (Most BACKPACK drives made
--=20
2.39.2

