Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2452C433F5
	for <linux-ide@archiver.kernel.org>; Fri,  4 Feb 2022 08:41:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237897AbiBDIlr (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 4 Feb 2022 03:41:47 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:19668 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232586AbiBDIlq (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 4 Feb 2022 03:41:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1643964106; x=1675500106;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SsshPJbFkCXqmvDBy15gzHt7tm+C4mrKQo91h7gdPtk=;
  b=XiE5Dvnb5Xctms7L2jbl1ecp0zzXaXbdrSssudzLYDIyJ8yfE6u18mPS
   /ChC/8ODKlVSL0ZWswtRMvUG2/3LfrEbEqDtHkonKTSzFJZHj488A0i16
   vPhsnnqlsFsBSJnj4moFbSrcLxjm/5PTKZILBeYcTJA3QfWcRM9ECDa7m
   2e9yMx7rCLy4f5VPtjUEOiEbxWRF4GR4T66QxoSgEC7mVLw6c1QK36Mfu
   KqzrqbNQFCIefgRtwQZudtkkvHmyw58npGGD3wyN8MFyjmgd4U5WcDe7E
   t7/cgJr2Mt+aa6kBzS618OFA01xqfIf0EwMSeTe3M7iJ3AtI1Dy6lBiFj
   w==;
X-IronPort-AV: E=Sophos;i="5.88,342,1635177600"; 
   d="scan'208";a="193139432"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Feb 2022 16:41:46 +0800
IronPort-SDR: 1vDvBGp1XWQBcbUdUhXcMHvyPT0rmxhs6I5JrSrlqIE0yrumrDc6oKxkr+B58lN8mif3kvtoyX
 HNQtiTpkEQR9CCnZZXaHpdRbZBxeE00sjnZTTmENar1k5uOAwgy8ESAXyfghpsHtl2FBaSDW4V
 JUsyG/G8PA6m5ikoh1LV4iVTn4Qub2pBvu3ihz1SYdA9t0/Ckwn6KGsafHvoxevoCF8cR5E4Tm
 Z3SeWTFuwT6TIqT0/xhiJ8LB3fQc4teHOATcP2/Dfszqst3TNjDL+Um/RaR7qZTPRvUuweFB68
 yopn7ZaLFLtg843n/3AJKLaJ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 00:13:40 -0800
IronPort-SDR: dXpzKn0IQz8cu+pcqtmoBWK/9SRkLI3P//fdG3q6QvsHY+GdW+1zj3hZLzpgEeR4LD5m3N3jsb
 97NDpKMPT3VshmFstTJteFePc4k5pVfTgQsjF50J5iw3cqBohclY+nx/EpniBgwIzIFoYgqpsC
 rjutyGazaIVsAHVruKsP5nbT1jOWBqHI21/S0LLBedeh1Pm7b+n8SWehMMlFIm9pm0936FyzP1
 lLxk/4mghT2oJeBUEodLDzbDwu1CmGymSwC+uR2lYs6CEO1CWKLSeKCo3Ek4qiXCmgqD8ggoLi
 q2A=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 00:41:46 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JqptK50LFz1SVnx
        for <linux-ide@vger.kernel.org>; Fri,  4 Feb 2022 00:41:45 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1643964105;
         x=1646556106; bh=SsshPJbFkCXqmvDBy15gzHt7tm+C4mrKQo91h7gdPtk=; b=
        D3AmnWe+RKgVddwH43RgLPleeEiGx54pvgl3jttuM0thP8jn0NgorSOSWbg0CY3T
        WIQOIvlWWwdw8XT2ubYnXde47vJU5fA7vCYNskFPsK6XkZGC3I7p2O5DI1CN9uQX
        brU3h6tod4iTpRq7GOV3m1Npqo3jGrU6EM1Zdl/smQ6vkvRagYM0nX/EGd9Wg8lB
        iM3Wd59GkygyOgyWMLCWOCpWG+BYgn2+yIpLWjEFg7+RspAuTKwRihUdyOW/zuQc
        AF9D/13MD/OH/CTQNsq69jiWML1UNGigazeT/Xo1wnM5zCOPwLf0cyVCzwz7tmzi
        g5dEBVcZ/haRGbD3z2mSKQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id d_LGaCAjqZvw for <linux-ide@vger.kernel.org>;
        Fri,  4 Feb 2022 00:41:45 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JqptJ6VXqz1Rwrw;
        Fri,  4 Feb 2022 00:41:44 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Subject: [GIT PULL] ata fixes for 5.17-rc3
Date:   Fri,  4 Feb 2022 17:41:41 +0900
Message-Id: <20220204084141.720789-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Linus,

The following changes since commit 26291c54e111ff6ba87a164d85d4a4e134b731=
5c:

  Linux 5.17-rc2 (2022-01-30 15:37:07 +0200)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata t=
ags/ata-5.17-rc3

for you to fetch changes up to ac9f0c810684a1b161c18eb4b91ce84cbc13c91d:

  ata: libata-core: Introduce ATA_HORKAGE_NO_LOG_DIR horkage (2022-02-04 =
16:44:23 +0900)

----------------------------------------------------------------
ata fixes for 5.17-rc3

* Sergey volunteered to be a reviewer for the Renesas R-Car SATA
  driver and PATA drivers. Update the MAINTAINERS file accordingly.

* Regression fix: add a horkage flag to prevent accessing the log
  directory log page with SATADOM-ML 3ME SATA devices as they react
  badly to reading that log page (from Anton).

----------------------------------------------------------------
Anton Lundin (1):
      ata: libata-core: Introduce ATA_HORKAGE_NO_LOG_DIR horkage

Sergey Shtylyov (2):
      MAINTAINERS: add myself as PATA drivers reviewer
      MAINTAINERS: add myself as Renesas R-Car SATA driver reviewer

 MAINTAINERS               | 14 ++++++++++++++
 drivers/ata/libata-core.c | 10 ++++++++++
 include/linux/libata.h    |  1 +
 3 files changed, 25 insertions(+)
