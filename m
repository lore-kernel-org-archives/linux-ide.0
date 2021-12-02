Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 474FDC43217
	for <linux-ide@archiver.kernel.org>; Thu,  2 Dec 2021 08:37:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345430AbhLBIlQ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 2 Dec 2021 03:41:16 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:26402 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345453AbhLBIlK (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 2 Dec 2021 03:41:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1638434268; x=1669970268;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=ASppelyGQbvTXoIDYOirm2iseD5H0RmIAaw69nP72sI=;
  b=rHA2m5lnRfymFwoPhzvT1BBavWZH2jhoO/oh8KlH+nz0THVqlJ17UxzT
   1jyCR8Hk6udFtvZM8fggJw0NQEIYjoYZZR62pkOWJGWwcyYD2H6xkM7e2
   0gPsuDrxiIc9+Y5nNIbSFPe0HSWPZCJu07IeNCz/sdheJw6grhw22XqiQ
   O0VpNYPIUPOoAWHUWFn7fA7K9nZnI7DHfG8IwXCJiypQjs3NfjBs+kts6
   GZAg0391wjlm+tsLVMI4S4jv9t4TR5z0hWpxYBSl4SH9FOXemBx6bM0R0
   A47Kx+94ETEWasGkz16yug3KdEHt7zQ9JFSq0Z/U8AP3WOw666v5ybi3e
   w==;
X-IronPort-AV: E=Sophos;i="5.87,281,1631548800"; 
   d="scan'208";a="299105716"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Dec 2021 16:37:47 +0800
IronPort-SDR: 1+51huxkW9AZOcyPZPCe90mSMlqoRfRpAVu0pLc4lDAUYrMm3DGepyXRrFFLIqFk/2Wpe1eDzh
 A+qkQKUzs0MpuyW5MB6we80Qqtr+LRniLBQ1TIhsRBYziNBkpDFv/hYPxCaAJEHOR/D2SDgrNr
 Qr5sI6rCcKHtBgy+/z2/VmjCSzwwD8gvAuDTCkeeJIV2wbiPc5GZbBGkipTon0ryTTk0Az57EZ
 wRiD+Adskji0vUQ6I2Gw6+tx8nl66EjfDRICpyY7mIx676zHfliAqa1UF0SzvNYb8HzLnPvfiV
 VizJjDtOMA3LgHoU465Dw8jD
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 00:12:30 -0800
IronPort-SDR: ENEUdZGlh0zzOhmmEQhUFc+bWftOZZHDzLrT9fu2JEcM4Pk9GrcV53FMWq1U4orNa1toj+ArFU
 W54j5nYtr18dyjcXvJeN4zYMogxs/G6oPm3wfCEZHtyoaUVekokbnVWgBt7jvitOzKLHBsGd+U
 hOyMkiS1QDvf9NXOQhA24cVFCVJJ/y3gAFSF+xEPXayOg85bTfpM5ejQPSHCBLVeXciclHvMNM
 YRrR7bySl2NLbRjHR0xPB2set5an+t+LnSSkOG9DX0qOIgKmtSOZw3A6rGQbO9vBCksByxTQ8o
 W2Q=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 00:37:48 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4J4TqH3wvBz1RtVp
        for <linux-ide@vger.kernel.org>; Thu,  2 Dec 2021 00:37:47 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1638434267; x=1641026268; bh=ASppelyGQbvTXoIDYO
        irm2iseD5H0RmIAaw69nP72sI=; b=brZhQqVizWgx7pYpinETg0GlbKDK3CIau1
        NIOvr/rjI+c6ebF2OuIW2CMwVLrImmdTHxQDwrBs4hpnZWmsB4ZfXRRW3/iy8bdX
        8T7amtGV3MkKe9/XDQCtUPr85m6FTgXZuxsDoS6FgDUBO2kfaB3mkIaEboZtWCrH
        +SwNWKvFEdk/eFbimVmRE8FOGw1zuJv7viUoUA7L49n0ZTrQ6vIXDSq4987Tlh8M
        aBoBWPN7ajgUbZ63CYKm1aTiykww+5RwsVfhWcww+0GmRif41wn8wOJBKBfQ8ep0
        3lyO1uLLY3LU3WOPSigx8T90YFVhF24NcfUcXCaz7VqsrSb7wKfg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id JwpcK4QOYEqn for <linux-ide@vger.kernel.org>;
        Thu,  2 Dec 2021 00:37:47 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4J4TqG6LT0z1RtVm
        for <linux-ide@vger.kernel.org>; Thu,  2 Dec 2021 00:37:46 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Subject: [PATCH 3/4] ata: ahci: use sysfs_emit()
Date:   Thu,  2 Dec 2021 17:37:42 +0900
Message-Id: <20211202083743.645391-5-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211202083743.645391-1-damien.lemoal@opensource.wdc.com>
References: <20211202083743.645391-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Use sysfs_emit() instead of sprintf in remapped_nvme_show().

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/ata/ahci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 1e1167e725a4..98d04a780458 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1657,7 +1657,7 @@ static ssize_t remapped_nvme_show(struct device *de=
v,
 	struct ata_host *host =3D dev_get_drvdata(dev);
 	struct ahci_host_priv *hpriv =3D host->private_data;
=20
-	return sprintf(buf, "%u\n", hpriv->remapped_nvme);
+	return sysfs_emit(buf, "%u\n", hpriv->remapped_nvme);
 }
=20
 static DEVICE_ATTR_RO(remapped_nvme);
--=20
2.31.1

