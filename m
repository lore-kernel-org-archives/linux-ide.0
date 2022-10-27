Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E7E9FA373D
	for <linux-ide@archiver.kernel.org>; Thu, 27 Oct 2022 07:50:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233473AbiJ0Hut (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 27 Oct 2022 03:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234420AbiJ0Huk (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 27 Oct 2022 03:50:40 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE07476DB
        for <linux-ide@vger.kernel.org>; Thu, 27 Oct 2022 00:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666857037; x=1698393037;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DO1HfZ7Ag5EzOYdGqwN2buNFK69N1HyNTp5Hs5NXi4o=;
  b=pBpEfeHjfsB1iM1D+Odu1CAwQJGd5ryjGbhMmV2FYWg1huWyHlCulm5F
   7sdr9oEZ8SBf/yTrCLWtRkaKKjRuO9kZbJYqxFaTUNpU9U1V+aRAfZ3xJ
   ajPdW7AlWqcG76w1O7310hF/JHdtI6nSyrPGO9l19l/85mstXnRhTjiRV
   yw6eIsvpyolOOME9TPRjCjOorHZartDLnfmL/bgF1Ytc1QxKZXTV9mVeC
   FILTTLC3j9GaU/cBS6n/49VxUe67xOBm34K+C0JQ4+QvCnAxaKcDZLCPS
   VVlh1uvMuVD8G5545ajdsc3HmRTnlVsovA8AnYM85LZliHFxco1CoVGY5
   A==;
X-IronPort-AV: E=Sophos;i="5.95,217,1661788800"; 
   d="scan'208";a="220023197"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Oct 2022 15:50:34 +0800
IronPort-SDR: BcxAzxig1PeE2/IwhRh+b7cl9Ar4WmQX87iPUi8HAa9xiTGxtrbqhMQaez/ArCzJrpvG0HOdhR
 QnXRuXhTiWl0R2Ig2MimQH85Mj/a7Z+tCsIxwvBbm+ftRrp/ggGhwTcHNV/7sppAmFCmBrcTKh
 Pz5VYji5vc5DNhWpzmrCwGr1RdnmSsXVrMrwwhb+k6HjkuTjzSK76Y2pi8GJswVWNXv7Y8OU09
 J1KMREojOwdjirCIzVtW4UJ9jxTBHnnutcuenqwHzOTVByYNQq+bVLnfb9F/4W5qLGmI+pK55/
 BHICCGj2wLYgs3BATqNrxVVX
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Oct 2022 00:09:55 -0700
IronPort-SDR: UyE8QFUOKp503QUFRcatFlzEY8gmIU0Ep6hY51H324kwXJHkHWZDjGTW+xG26BOo2ONe52b8U0
 hrieBqswEFxeNChQpeuoUFkTb8znDw8Q8muwISd2WTzvfU7ESH/xczIP8ypxix+gWwuCxwGdpt
 0WbYl/PavsF+YtaacXtZIUb1dlEIkDRyQEwQsG7/mVed/uSjS35ufP9+ybgzZqu+0zu+9ehtGx
 tS2BB45eCuUENxIresqCbhnjvBai04H9TmWGzpv/SI5SsIaf3ObR6c8dJZmQ4xg5sWSFH+daMs
 qHw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Oct 2022 00:50:35 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MydBx4Xf6z1Rwrq
        for <linux-ide@vger.kernel.org>; Thu, 27 Oct 2022 00:50:33 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1666857033; x=1669449034; bh=DO1HfZ7Ag5EzOYdGqw
        N2buNFK69N1HyNTp5Hs5NXi4o=; b=joTXzmgvpjsk6/hyVmJGNKlk5B0ANlGkQA
        IJObDhAseEp0R8YRidhBn2BFN/yY2hcHtu+TjcgePL0wjdqT3vLsJ551Fo4T84uX
        WazUGj3G8uN4vscvT94pcGpjbKDypmwsbTbmSlBq87YsuVCSW58dIcwtDjLtQO4A
        fhczEtknTv8/GFjY5DgfmfUP5/oAcZLF4c37pcsaK+jVc4Lbz2btoY9LuIaNCVUW
        DYKMz4D1JeMWbskZK8Dx73qY/FTulFyPJvzRHpll+ZWueyYGVDkrTDnKh1x/89u/
        Y9VYhOyXMk/SkivWWn+SquQph6i6J178RLgswRr455U5KHNw1PPg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Bh7e1J0MFDWR for <linux-ide@vger.kernel.org>;
        Thu, 27 Oct 2022 00:50:33 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MydBw3Jlyz1RvTp;
        Thu, 27 Oct 2022 00:50:32 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Cc:     Hannes Reinecke <hare@suse.de>
Subject: [PATCH v3 5/6] ata: libata: blacklist FUA support for known buggy drives
Date:   Thu, 27 Oct 2022 16:50:25 +0900
Message-Id: <20221027075026.240017-6-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221027075026.240017-1-damien.lemoal@opensource.wdc.com>
References: <20221027075026.240017-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Thread [1] reported back in 2012 problems with enabling FUA for 3
different drives. Add these drives to ata_device_blacklist[] to mark
them with the ATA_HORKAGE_NO_FUA flag. To be conservative and avoid
problems on old systems, the model number for the three new entries
are defined as to widely match all drives in the same product line.

[1]: https://lore.kernel.org/lkml/CA+6av4=3Duxu_q5U_46HtpUt=3DFSgbh3pZuAE=
Y54J5_xK=3DMKWq-YQ@mail.gmail.com/

Suggested-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 drivers/ata/libata-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index fea06f41f371..ec732c47b6fb 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4144,6 +4144,9 @@ static const struct ata_blacklist_entry ata_device_=
blacklist [] =3D {
=20
 	/* Buggy FUA */
 	{ "Maxtor",		"BANC1G10",	ATA_HORKAGE_NO_FUA },
+	{ "WDC*WD2500J*",	NULL,		ATA_HORKAGE_NO_FUA },
+	{ "OCZ-VERTEX*",	NULL,		ATA_HORKAGE_NO_FUA },
+	{ "INTEL*SSDSC2CT*",	NULL,		ATA_HORKAGE_NO_FUA },
=20
 	/* End Marker */
 	{ }
--=20
2.37.3

