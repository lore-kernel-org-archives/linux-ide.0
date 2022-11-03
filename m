Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8932CC433FE
	for <linux-ide@archiver.kernel.org>; Thu,  3 Nov 2022 21:43:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbiKCVnl (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 3 Nov 2022 17:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiKCVnk (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 3 Nov 2022 17:43:40 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1640EDD
        for <linux-ide@vger.kernel.org>; Thu,  3 Nov 2022 14:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667511819; x=1699047819;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2lWhfqga4/fFXjjNT44/WJxlkHVLd+9xHu0xZnKbfgk=;
  b=RAPfLtr/V9zOrkt7zWNWN4qkJu88AOeRt43QPNx0yZpNwTVc0vl31ynF
   /9ETgYQgvQlsbLjdw6dx+vW3yY1WiiIkMH1dSaCgRjEPFLi5T5BOhVQ/2
   c10OP0nHe9NDGooI0IwicDqBApuAl35l8ByxDgQXU+Z8hELEdMjDMGY6k
   WWoBbuaOAD8myk11PwEu/MVyvnbfF3y7FCH4Goz4JsIFSPupZWYSN/cHW
   D5N3SapHl/wUCQIsy6y5FS2ucMJgN/BxcjWQ5JjWHrxcrt1+S83+t4MdC
   4Rbo9PUFR1Y/Rev0ay4Pu8DOX7zlWMLW8qxGl8kot3nQ0BVMbQ1eKAWiK
   w==;
X-IronPort-AV: E=Sophos;i="5.96,135,1665417600"; 
   d="scan'208";a="319779181"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 Nov 2022 05:43:38 +0800
IronPort-SDR: O0nsLR5yUs7sttJ6yRnIDxeKkGt9Ulk5OWQAdHGpRh8Ayx1CBzecVs60QMt1PpqLHsuNxVt2Jm
 MItQJbhVZai6v/FevBB07A+swkaMuMunDYRUA6vaPQKvuFqo9hduRT9vdCUsY6l9fEmZLQ1mQy
 6S+ri4zNvi7zE2GyByrmBMy44vVl65twT63iegtcxG/Sl2tR9WKzoNFvGJ3s1OlEj8nRuOX7Xf
 IMhELFTMkX1ag3n9ZCuBiEZg3qwWLISIKokyAthDDs/19jQc8C6HlWyZ4ml27Wf9JVrOQtLBnm
 2t0=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Nov 2022 14:02:49 -0700
IronPort-SDR: iRRGuGi9X1ceqPrcqrdU7+mC01Xu9+DOtSZXVsNozB4FvAbHFqx7H2rQBrPCbGfOyhfcphh2BU
 ulRJPMjmA7k8eR18L2Aj572Qt8Sn+QMMDmq8dJfp7patCFMwtJEQIYVntf5qQx0CXJgMkJnCUs
 279ArvtioO+z0bhk56Qq/EYfsXUaMDKGEJWg+I88Ky+vYbi8H8ll9R+DE3vHueFaI3mGHQAsts
 wjemt7qHdr2v9BN+lNvVy8deH7ZUvcLmwXBK+fc833XcWpy+KSyj11N0mWnDQcLNBmTd+UFdPu
 JPc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Nov 2022 14:43:38 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N3HLy19PDz1RvTr
        for <linux-ide@vger.kernel.org>; Thu,  3 Nov 2022 14:43:38 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1667511817;
         x=1670103818; bh=2lWhfqga4/fFXjjNT44/WJxlkHVLd+9xHu0xZnKbfgk=; b=
        LWTRkLAwL2lNBls0oOmMAk6Pwi2q9yuBJxBY7JFOwGoP5gYtGHPqtkYBOg92s1Mi
        vP0nLdMdaIizU4bd42dY3q4bcTajTx15uWxgdmnq1oCsjMNsfZnvi+OHwLk1NX+K
        qe9LxuVV4V/++Dymnex1RDOCk2JrGjDMbLwnG/VLvA+OPfY/4TaiuAN3QLMKWftu
        gwJOL6Q0dkhtx47dch5E3Zjp2OS98x30ubCz//deSXQZxXduKPHpV3z/yCiDdTrw
        rYS12azP2+N1XEWas+uMYrr5j+d7bYMzPiWniLKPMyGEPbeYPa71dZv5QNYwWAPr
        GsaCm36/GBDOX8vJXEIV7A==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id wiqvmiSNxKhQ for <linux-ide@vger.kernel.org>;
        Thu,  3 Nov 2022 14:43:37 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N3HLx2DR8z1RvLy;
        Thu,  3 Nov 2022 14:43:37 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Subject: [GIT PULL] ata fixes for 6.1-rc4
Date:   Fri,  4 Nov 2022 06:43:35 +0900
Message-Id: <20221103214335.1126889-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Linus,

The following changes since commit 2ce3a0bf2010b16c78b78cc35a97fa913f1be0=
ca:

  ata: ahci_qoriq: Fix compilation warning (2022-10-18 08:02:14 +0900)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata t=
ags/ata-6.1-rc4

for you to fetch changes up to 015618c3ec19584c83ff179fa631be8cec906aaf:

  ata: palmld: fix return value check in palmld_pata_probe() (2022-10-31 =
20:28:05 +0900)

----------------------------------------------------------------
ata fixes for 6.1-rc4

2 driver fixes for rc4:

 - Fix the PIO mode configuration of the pdc20230 (pata_legacy) driver.
   This also removes a compilation warning with clang and W=3D1, from
   Sergey.

 - Fix devm_platform_ioremap_resource() return value check in the palmld
   driver, from Yang.

----------------------------------------------------------------
Sergey Shtylyov (1):
      ata: pata_legacy: fix pdc20230_set_piomode()

Yang Yingliang (1):
      ata: palmld: fix return value check in palmld_pata_probe()

 drivers/ata/pata_legacy.c | 5 +++--
 drivers/ata/pata_palmld.c | 4 ++--
 2 files changed, 5 insertions(+), 4 deletions(-)
