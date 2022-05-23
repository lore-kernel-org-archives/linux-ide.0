Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1847FC433F5
	for <linux-ide@archiver.kernel.org>; Mon, 23 May 2022 04:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiEWEjJ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 23 May 2022 00:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiEWEjI (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 23 May 2022 00:39:08 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571E6F36
        for <linux-ide@vger.kernel.org>; Sun, 22 May 2022 21:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1653280746; x=1684816746;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+7WdggKFnmXXU7xDLwxjlA+PlR4W72mXw1KewH85BxU=;
  b=F7MxrcPdMb8mCbq7WfttAQvRsNFY6tl9jgK3ndbtac9DF1tL2oUs7EXh
   dYWkG1kQFA7LJN03KCHFmvm5LojFlMXog5ohJ/rvnSNHIUXfbNV6fffQj
   esl2KR5fmz/er5snFWDqHgAAfd6egyZpslQCu910SXWr0m51kYaf93Epm
   rZNp49B18lr/EpJy8KN3yLKiOcKqQT3pWhBLtvQVefOMhojtr1UDWOvs7
   wESJaDrjOx3tKDsvgmFvGPVa/JiUIi2bFNsDOQpwUpgfcs0yrJPjqQFdN
   hQJ+OD+4Vy5vGJpfzpSVatfTo8RxsqXBFJQtMDoFuzUXzXQitxl2IPe10
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,245,1647273600"; 
   d="scan'208";a="201121979"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 May 2022 12:39:06 +0800
IronPort-SDR: DSN1uAYOL1YP3wFhblqug7ZuK3WORx2+HQc+/aWkF8Bn9g9SKpJl4c12jeVovxWNOjgIA1ALjS
 GX3g72asnqfA6r3wm9JJI4j30H2mAzEYfL77mwkM4oq9xL6bLOCtuuh6JEFcor0GIW1J5UrWZN
 ly+gW69BFE08lG0zVzjGaImNX3VRPIwBKCCPVt6l/cFGNBCzuhPVWSF6eEeAHLj3yq7GyDK4Lh
 T1Z+mZyQTjcucfW+3FW9BGSwyMfggVnEbpDwxspAwS4nWErDBUX/4QyWRZfTxXcLcWwK7+D4U/
 YHH3/MTbnKGRfn1TnExSnhRL
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 May 2022 21:03:06 -0700
IronPort-SDR: cA42hTA25bGoWRIbV/JAammrEf1F2qAUcFREn0VlQSUifbdz2Au4uKXPJkx/zcWeKHODKYavBm
 ShnGwiTFBP+prFxOjxPIUpx912NDFxCz5rAwgFvbXPxCofeCTSW/SoOIcASCkS1ZZgGf/FvEGl
 P81vHpMsVejpQCAY+Y+Y9HqLgYOAQazFQyQg33FBjD0UA9ohHRGkxsj2Y3Skqfc0u5bSW4xrRW
 Eecht9OGau+9o4Buy7VAKoKRNfjjL+kKOOzmOXv/2rvM8RsmFlJBpgYRbvVkKSz9VngXRMyijf
 NJE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 May 2022 21:39:07 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4L64NV1ZX8z1Rvlx
        for <linux-ide@vger.kernel.org>; Sun, 22 May 2022 21:39:06 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1653280745;
         x=1655872746; bh=+7WdggKFnmXXU7xDLwxjlA+PlR4W72mXw1KewH85BxU=; b=
        VNBaStA90DgCJNhPUiQaO/gcoWDVquAjJnsUVyflnisWxRkRDAOItWGAyY4N/RwI
        tyGJBAgaX10plklylsgYO6gTKY90PLfru5F/FAVysMnrIZqmn8YLOi8mVD3YlzNQ
        jjvgYHXdEYcwOdf77t8pcAYqlUE6u2Oi8VIqusu0XtZbo74hMJLNRlg2q5HcD6Q/
        mIdE16jXjn4ekZPHcT3tZBcZvnrYiaoXRoIL067b02Wi+A0EK7sBP85wkMzMz0SW
        ZpMf7Fum1OWGAEQngNHAKzwjeBCHdek56bKT1ijKfTRenKmycWHkcotXxOvBA7Hz
        BuWyJhF6EhoUYtcaRRzAZA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id iLH8O6RXp6dH for <linux-ide@vger.kernel.org>;
        Sun, 22 May 2022 21:39:05 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4L64NT1cCRz1Rvlc;
        Sun, 22 May 2022 21:39:04 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Subject: [GIT PULL] ata changes for 5.19-rc1
Date:   Mon, 23 May 2022 13:39:03 +0900
Message-Id: <20220523043903.328279-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Linus,

The following changes since commit ce522ba9ef7e2d9fb22a39eb3371c0c64e2a43=
3e:

  Linux 5.18-rc2 (2022-04-10 14:21:36 -1000)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata t=
ags/ata-5.19-rc1

for you to fetch changes up to 71abb4df29815d17f3dff98dce553fc1732d9738:

  ata: pata_ftide010: Remove unneeded ERROR check before clk_disable_unpr=
epare (2022-05-16 20:22:37 +0900)

----------------------------------------------------------------
ata changes for 5.19-rc1

For this cycle, the libata.force kernel parameter changes stand out.
Beside that, some small cleanups in various drivers. In more details:

* Changes to the pata_mpc52xx driver in preparation for powerpc's
  asm/prom.h cleanup, from Christophe.

* Improved ATA command allocation, from John.

* Various small cleanups to the pata_via, pata_sil680, pata_ftide010,
  sata_gemini, ahci_brcm drivers and to libata-core, from Sergey, Diego,
  Ruyi, Mighao and Jiabing.

* Add support for the RZ/G2H SoC to the rcar-sata driver, from Lad.

* AHCI RAID ID cleanup, from Dan.

* Improvement to the libata.force kernel parameter to allow most horkage
  flags to be manually forced for debugging drive issues in the field
  without needing recompiling a kernel, from me.

----------------------------------------------------------------
Christophe Leroy (1):
      ata: pata_mpc52xx: Prepare cleanup of powerpc's asm/prom.h

Damien Le Moal (5):
      ata: libata-core: cleanup ata_device_blacklist
      ata: libata-core: Refactor force_tbl definition
      ata: libata-core: Improve link flags forced settings
      ata: libata-core: Allow forcing most horkage flags
      doc: admin-guide: Update libata kernel parameters

Dan Williams (1):
      ahci: Add a generic 'controller2' RAID id

Diego Viola (1):
      ata: libata-core: replace "its" with "it is"

John Garry (1):
      libata: Improve ATA queued command allocation

Lad Prabhakar (1):
      dt-bindings: ata: renesas,rcar-sata: Add r8a774e1 support

Lv Ruyi (1):
      ata: Make use of the helper function devm_platform_ioremap_resource=
()

Minghao Chi (1):
      ata: simplify the return expression of brcm_ahci_remove

Sergey Shtylyov (3):
      ata: libata-core: fix parameter type in ata_xfer_mode2shift()
      ata: pata_sil680: fix result type of sil680_sel{dev|reg}()
      ata: pata_via: fix sloppy typing in via_do_set_mode()

Wan Jiabing (1):
      ata: pata_ftide010: Remove unneeded ERROR check before clk_disable_=
unprepare

 Documentation/admin-guide/kernel-parameters.txt    |  71 ++++-
 .../devicetree/bindings/ata/renesas,rcar-sata.yaml |   1 +
 Documentation/driver-api/libata.rst                |  11 -
 drivers/ata/ahci.c                                 |   5 +-
 drivers/ata/ahci_brcm.c                            |   7 +-
 drivers/ata/libata-core.c                          | 327 +++++++++++----=
------
 drivers/ata/libata-sata.c                          |  25 --
 drivers/ata/libata-scsi.c                          |  46 ++-
 drivers/ata/libata.h                               |  13 -
 drivers/ata/pata_ftide010.c                        |   7 +-
 drivers/ata/pata_mpc52xx.c                         |   3 +-
 drivers/ata/pata_sil680.c                          |  30 +-
 drivers/ata/pata_via.c                             |   6 +-
 drivers/ata/sata_gemini.c                          |   7 +-
 include/linux/libata.h                             |   3 +-
 15 files changed, 285 insertions(+), 277 deletions(-)
