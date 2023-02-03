Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 729C0C636D3
	for <linux-ide@archiver.kernel.org>; Fri,  3 Feb 2023 00:03:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233131AbjBCADG (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 2 Feb 2023 19:03:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbjBCADF (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 2 Feb 2023 19:03:05 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B413A93
        for <linux-ide@vger.kernel.org>; Thu,  2 Feb 2023 16:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1675382579; x=1706918579;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0OMNtTkKXydA1DARqaQiBiaaHiEFr+lheFNjjkg+BS8=;
  b=OoX3TroXwHNEmX2r+3nF9rpJdKThLo+/nqQ4JHwWd8vvYeup2z1+ot60
   W/2rg2ng44x/alef5QkfaCKcTtmZaZc3h5hlEy1y5EsfoXQhySdo5nlf6
   Y0Iskb1KBwzH/1AiZeVQNr47hw7N4pjMs+PEWOyi3HJnjwLKsKZcnRiyZ
   MHqm08fQXzfHfBLQBG2um7DLkGI0JtYvAB17d1eOfBob+LKqXHUqGNZ+v
   qzfb8/DsdSKD7oomFgU24Oz5K+E/Dk/bMF7uv/eAF4Qa6y0cjpvcNkBud
   KvCp/UpRBk38TRo9NeorIDAaOQCP/J/ltdNlQ+cAjq7ndTdhVivjSSuY8
   A==;
X-IronPort-AV: E=Sophos;i="5.97,268,1669046400"; 
   d="scan'208";a="220731536"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 03 Feb 2023 08:02:58 +0800
IronPort-SDR: VdtTsUQ8L9CqX/wIbysAsBRSsFAn5322iMF0Tc1Q0NUU+T1GKvWDbXGyM6NpbgSn/3UmQdLMr2
 ruAZsAlYT1GE70ae+mLrJLFuuI9MeKOAWQe3b6zi4M1SNRqaMosdOmp0wIsLcKF/Bmpka7X3Ea
 ZBnzdnPO15XTC3u3vZveRXQoePKlU4xWF6E+e5j2b8re7BF3m5Xsli/PyhRCvB4NIjxz9Ota1O
 UzP9PDqAcVvgbj14dobsUNvJ3P+Zg5w/t+2om8H/wwP9U+mpXHrcLjvaMcdZrQNVVnZ9OrJ7M1
 8l4=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Feb 2023 15:20:20 -0800
IronPort-SDR: FR/huuGlG6TtzP23aQr8Er2s8NFCnWbSBHx3scDe5igYRYY23ycfoKEhBAbRycj/j6qqdm0Zaw
 uG+22yI8BIjq9v1TdpMMsHppkEv9/neoCfzZvT07WhHSoUUo4to6AcS+9pineDatBWa+4B/Ie4
 MqiVhNJ2efwQY2nSx6e8ytqA3K0CHqfdUYrUH5SZKmsgRXyT+MczW5aTgj7kcLGr3F4J0/7pye
 Wpnl2FNtrjk10IF/k3jl/1ij8dkRpGLIr88//zOqazXlJHcnzi8KzHnrWh/BJXd19YuAm19pv4
 G0Y=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Feb 2023 16:03:00 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4P7G7k43hJz1RvTp
        for <linux-ide@vger.kernel.org>; Thu,  2 Feb 2023 16:02:58 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1675382577;
         x=1677974578; bh=0OMNtTkKXydA1DARqaQiBiaaHiEFr+lheFNjjkg+BS8=; b=
        GPRvRqYRUcDaRYf5bKWK+DIT6nBHPA4U8I0paqEZ1lltoFxf7LBoLX6izJkH2jgy
        YOE3VLxUr5hQeRLLZML4bqeNmWt+n36L5rzrg7MwT9Bt8yF/hAggWQWnXfdOHNQy
        4fc1XurLRbqkhOj5k9nX//8YVOtoJPalHFsQ7stYKwPq95ogBwh8X44Z539jABX5
        DrthCofKCOJ9rj/tuMdtUL7GHQQOpYcnkeEpSTcgCo4ev+U/YH1/GIfDx3bka4ZQ
        duJ3Y9PiFou58HB6fM0TYPqnqrKFux1UUyeslWInyWcLiaJdmRnHsY7WRzcGlDQs
        rvLmVmFcbVInmzlO93bUQQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id uceO_18cxbGE for <linux-ide@vger.kernel.org>;
        Thu,  2 Feb 2023 16:02:57 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4P7G7j2yQmz1RvLy;
        Thu,  2 Feb 2023 16:02:57 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Subject: [GIT PULL] ata fixes for 6.2-rc7
Date:   Fri,  3 Feb 2023 09:02:55 +0900
Message-Id: <20230203000255.230083-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Linus,

The following changes since commit 22eebaa631c40f3dac169ba781e0de471b83bf=
45:

  ata: pata_cs5535: Don't build on UML (2023-01-14 07:38:48 +0900)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata t=
ags/ata-6.2-rc7

for you to fetch changes up to 69f2c9346313ba3d3dfa4091ff99df26c67c9021:

  ata: libata: Fix sata_down_spd_limit() when no link speed is reported (=
2023-02-02 20:26:45 +0900)

----------------------------------------------------------------
ata fixes for 6.2-rc7

A single patch for rc7, from me, to fix device probe issues with some
combination of adapters & devices that do not report a current ling
speed, leading to device probe failures if a link speed was not
previously reported and saved.

----------------------------------------------------------------
Damien Le Moal (1):
      ata: libata: Fix sata_down_spd_limit() when no link speed is report=
ed

 drivers/ata/libata-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
