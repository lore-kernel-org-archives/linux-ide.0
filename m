Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C56C4708E
	for <linux-ide@archiver.kernel.org>; Thu,  8 Dec 2022 02:39:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiLHCjd (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 7 Dec 2022 21:39:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiLHCjc (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 7 Dec 2022 21:39:32 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6271057D
        for <linux-ide@vger.kernel.org>; Wed,  7 Dec 2022 18:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1670467171; x=1702003171;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zowUcjk7V0vDXAXxT9uk1iTiK4ZauCgbOHhF+9CHF+Y=;
  b=Ba7lSv7u6ZDYjXQ0PNDkUWji83Uzkfshyk9xoUjDkxNEsgW2rhy4G1/o
   crnPfEKI+/LxUkBz4ClQtt/tlsAytl/T7nhhl4uZpjSo+lf0Q4+cm7pUv
   ZFAEBtxeTg7gq87L01IbQ4TLd/mKPPSTnofg3yUniLR4isvtKsB3nx00q
   DLfvlz8ciM1MdaDqIGk9cqwpHEeVSAsJE8fQqFGRTI3Zbag734L+wLWId
   DCxeF2QEmylZUY5PSYXaOU6rC9DR0DdJ4jmGnEwEs2prEO94nGSbZsnMi
   NBAG28SdQX1bF1fnfr6549ofkVd1ntZl0OxxvPWYqPStmFltuMp1yW4Jr
   g==;
X-IronPort-AV: E=Sophos;i="5.96,226,1665417600"; 
   d="scan'208";a="223301509"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Dec 2022 10:39:30 +0800
IronPort-SDR: 8QxHl5JULwqnXXR+YtoBXpO0v2fpUEShZ1u8yassoRLRp9chN10Z8s51Zqlp2e3lH05JgsxrdA
 ZuL7fmGm/3/diHE7YIQqqG9Lub1Nws86t3eqBP0KUfbj1DViLVaK8WC8GmZ+8rhxRnwP1grr53
 c0o1G6T17lD4pNFkXH7VeBp+pqXudgwqLYp9KbbnCfsMFEzrTJt7FpquxCAAjoELehYH11qATq
 udzBVkqYTmwJzE3bKmf1MDtce3u8o/9ZyRz0SulEpMgnH0xFxVP1zJH8NvyOKwM6qhjUB+igef
 ODw=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Dec 2022 17:58:00 -0800
IronPort-SDR: cFfdSCZMv26EIBvMqCYZ1eUzNSiXFocLhLyPILLIxpi38as4Vl4vU1dhYLOTv3hbjL9b9AtqYd
 Y+i2THBzwOWtjQJ39vkbBtWpLnRCV32EJoLccG9H5ZvqyExFJX9G9TbXI60na6weDl1NlzLRCH
 guclpVTj3SzvKBON8jF3Y+Unx5QSZG6ZTeJCUKwqWZH2+Fb3ZkRwnunX9S0ExSg3SeBt6m6lHD
 /ZHWMtypCFSfpt34toOGOLKHJSk66Lqz7762PP49sXRQN31TwnFte+HOlJngfDHwjm/zfJI49E
 hbk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Dec 2022 18:39:31 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NSJJf2gWTz1RvTr
        for <linux-ide@vger.kernel.org>; Wed,  7 Dec 2022 18:39:30 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1670467170;
         x=1673059171; bh=zowUcjk7V0vDXAXxT9uk1iTiK4ZauCgbOHhF+9CHF+Y=; b=
        lLIm7FNwQBtoQn9yybJpzD9t/EV4gmojlfw8WF0E5GEHohYZhU7ooJGTKq4bl0xZ
        FF8v87BptfoGZqeQr6IEq99yWuZLVVkaPWipmpVoCVeg7ggLvP+umHC1GT0LNpMi
        USoYHH8TKP0EX4jzjSo2CUrdbDisipYT8qZKSF+EHX3vw/5tfLaVbQGolAJg2RWD
        zx6vp68/axO2P+0fsbu++Briu59mUeGGx2EF7FBJiREcvsm2TuVSx6V3ZLxvmago
        CikOAiOyI2CvFky/BevdgnmRSVef7UahSLxKV/5acCPZeznhDhe2Q68B7Z3yjra7
        BiG90TdVlCtKD6hXvavxiw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ipgyK-6qgIMm for <linux-ide@vger.kernel.org>;
        Wed,  7 Dec 2022 18:39:30 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NSJJd3nHvz1RvLy;
        Wed,  7 Dec 2022 18:39:29 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Subject: [GIT PULL] ata fixes for 6.1-rc8
Date:   Thu,  8 Dec 2022 11:39:27 +0900
Message-Id: <20221208023927.3982-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Linus,

The following changes since commit e20e81a24a4d58744a29715aac2f795cd16519=
55:

  ata: libata-core: do not issue non-internal commands once EH is pending=
 (2022-11-12 07:51:06 +0900)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata t=
ags/ata-6.1-rc8

for you to fetch changes up to d95d140e83634e7914277862dee841564d02879f:

  ata: libahci_platform: ahci_platform_find_clk: oops, NULL pointer (2022=
-12-07 08:36:37 +0900)

----------------------------------------------------------------
ATA fixes for 6.1-rc8

A single fix for this final PR for 6.1-rc:

  - Avoid a NULL pointer dereference in the libahci platform code that
    can happen on initialization when a device tree does not specify
    names for the adapter clocks (from Anders).

----------------------------------------------------------------
Anders Roxell (1):
      ata: libahci_platform: ahci_platform_find_clk: oops, NULL pointer

 drivers/ata/libahci_platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
