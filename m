Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 842E3C433EF
	for <linux-ide@archiver.kernel.org>; Fri, 28 Jan 2022 09:32:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347644AbiA1JcN (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 28 Jan 2022 04:32:13 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:4555 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347664AbiA1JcK (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 28 Jan 2022 04:32:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1643362328; x=1674898328;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/U44msC7ZHRjcDuVc5EfmbYQf3jPxv+/+qCKO5oS+n4=;
  b=joRPUbhT2tfT/1jw+CLfIXWNr+0NioNLK9yf+dKC+VFAj/JB4fUosdjn
   CckltUGUJPUE35FwmkSphYkWNDltcgFtBa3qNZhm3DEd46zbo8wrYj8dU
   RZCiBSrnBj4XZKYgMCyoB3K0u+edXxelu6YOnAIlZSbReM6i5dbaJPNE3
   n9sEctCfcFR55GABozoJbe2M0PnfPbkl/WBm/c1fAVEJTvVtDFekX8Bra
   h+a/1hOHhIbgQJ+m6Fl9IjYR4GxOtDY2qp3cwvSqwoDBma6YkzwbtwYTK
   0hzjRZJJSULZN12ZaG7F60fC6flShZjTlo2BN056IJqCW/CTevTcDhnk0
   A==;
X-IronPort-AV: E=Sophos;i="5.88,323,1635177600"; 
   d="scan'208";a="191618287"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2022 17:32:07 +0800
IronPort-SDR: Sciop8UXzR9Y83uLyKbeBpk+Sw4BMMm/t8tdj3U8/CurjqOwn0CMyJ3VZXA4itjKAqVPseV0WD
 cZB7HBbnAUcLK1K4ufmgPjAhXdsZQkK4zAfDp3vKQw03e8JsQirurH4q0Z71+lhymF5fOWsIqd
 uKpVNMWA3OxnCmpm0f8RCTml04tvfvYtdzjQI7yX7ozHRjEkeSsAmbSlftoaEMt7tZ/XqffwFA
 84X3wvRxO2lSGTBoDEGPgfQlSmOzocVz7FhlS0uG/IYKxicnklms2SLjMZ+rkdT5KYu3NR/hAj
 MgPN4PNV9+ha2H1inGDpAibV
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 01:04:11 -0800
IronPort-SDR: sD9kKXNNLHHf9D/MJwlqmWEQNc5t8Jq+4qXGYm47TJ4eV6Vv9IHrr9tqT4JCME2VHtmy2wFC+u
 kVZNthNMml6y2Mh3fXyd8LjYs65LVWk/hANtkEggW8D5CDvxJX/Bs8I/BVHfP2gIbBKsdus4+d
 IKVkKBVCjQgtX4mgoSom7zzGgTizLAmQod/vTC5rflxiDicckdIU+PF7PLi3HfDkn2kM9CHe+m
 nPB6wCnHW/h7Izl5TDwcCk7shwSIPKwMRM/DkBFR54EiXrW+rVJ+5vs0d/eFpI+mi1y0jeuPe8
 1nc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 01:32:09 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JlXKh4DHYz1Rwrw
        for <linux-ide@vger.kernel.org>; Fri, 28 Jan 2022 01:32:08 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1643362328;
         x=1645954329; bh=/U44msC7ZHRjcDuVc5EfmbYQf3jPxv+/+qCKO5oS+n4=; b=
        btb+EkjTvOq2LVllbG8qgcdv5jEA7qNDoD6kSl5EMRzO1oS2Axgr1Vi40tPQMLh5
        zO2OaA6Q51epNfm8b57ESrxvujX8mC35GTGdzF4oBISQftLm1pI1aa6JhZ4TlkPg
        ISlo7W9eGzUs2rOlxDuuohCLwccdH1JeJQIXFCCvZuEr8e7JTO3sD7UOL5fnv8HZ
        EVezOf8Y1o3+IS0bf9GAGceY4VjBkAz07y1kTrRAC7RAlMmaOSzXXePoIIadFsjk
        zjUOVEXGPf08o8l9Uyluu94j8B8n9uVsRPOQGoVHCILtxon/kTeIp/g8p00edE8g
        empjo99wVKQGPcdGH3733w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id exuCcxUgbjXq for <linux-ide@vger.kernel.org>;
        Fri, 28 Jan 2022 01:32:08 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JlXKg5Bhlz1RvlN;
        Fri, 28 Jan 2022 01:32:07 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Subject: [GIT PULL] ata fixes for 5.17.0-rc2
Date:   Fri, 28 Jan 2022 18:32:04 +0900
Message-Id: <20220128093204.33882-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Linus,

The following changes since commit 0280e3c58f92b2fe0e8fbbdf8d386449168de4=
a8:

  Merge tag 'nfs-for-5.17-1' of git://git.linux-nfs.org/projects/anna/lin=
ux-nfs (2022-01-25 20:16:03 +0200)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata t=
ags/ata-5.17-rc2

for you to fetch changes up to 9b6d90e2085ca2ce72ef9ea78658bf270855e62e:

  ata: pata_platform: Fix a NULL pointer dereference in __pata_platform_p=
robe() (2022-01-27 11:22:43 +0900)

----------------------------------------------------------------
ATA fixes for 5.17.0-rc2

A single fix for 5.17-rc2, adding a missing resource allocation error
check in the pata_platform driver, from Zhou.

----------------------------------------------------------------
Zhou Qingyang (1):
      ata: pata_platform: Fix a NULL pointer dereference in __pata_platfo=
rm_probe()

 drivers/ata/pata_platform.c | 2 ++
 1 file changed, 2 insertions(+)
