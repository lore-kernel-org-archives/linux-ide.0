Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C833C433EF
	for <linux-ide@archiver.kernel.org>; Tue, 22 Mar 2022 06:57:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237045AbiCVG7U (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 22 Mar 2022 02:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237104AbiCVG7T (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 22 Mar 2022 02:59:19 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C548FC67
        for <linux-ide@vger.kernel.org>; Mon, 21 Mar 2022 23:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1647932271; x=1679468271;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BeJ38+CzW5xgKdVIIh0HLEWJCYoEhHO0WfDb8Fx+AX0=;
  b=IJ7UPdwgIHuY9JF0QlmqWLDNoWBgV2NgDzQ+7MhBkhK01P9qp0BgwEhF
   2gdVxt6a/O+b98vTHKcsdFtAgpCVlCy3Nc1oq15KmnSKJ2UXgOy9/O71m
   d6fgJTcPWV92i6NMCYjR5iclpEy6At1UGU1JXl7G0Kipvd3aBnbraZV2G
   FoAyXGf8oK47iUhhEEv5LjEtZk99hO7mv2ouHd5U9WqMlHdCfiSkJ9P08
   tRuvH/QBNP6PVZ+E6tgApF1/3gk2OL7JEOWP+Es852gGz8OC/6TYPTpF9
   py1UdcVJOMOXL24D9O39JcDWescZSEOZc/vc4aO1GnTCdXLB9FYUHL1MU
   g==;
X-IronPort-AV: E=Sophos;i="5.90,201,1643644800"; 
   d="scan'208";a="300084746"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Mar 2022 14:57:51 +0800
IronPort-SDR: zb4jtOZt02CCGBJ74Cgo7GLEQavQHZxolLeNo1HLGcDXDUCz3zPjFNtleZD8GlD3CUdW+5Wxe/
 jM1MJKVPOnlYkOAMhs2J0jZ+1o6XjQ9XcBV0ZaVlfM7TFu8g5FYPhm3wWnHMKgl0wc8urGUETH
 Xc5quFJty6D1ooEAyTxHWLJxLqC1sy2LEio5kZXFr3OTFQ888Fkt2l+tw2ZMoTZwHD3k4fnRy/
 VgnEcS2TfrYpSyVUsOw/wYslWtHkNExlCnm2OjO87/e//H3vAqRnFrlgiIY4GT8K1+sh9ALb5b
 iLg6C55gtot1O68BbTt4k+Jy
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 23:29:46 -0700
IronPort-SDR: I1uZBSrpl2gmJpq58V2M+g5JKe0F6/YiL7rmG9+I96uVO6X2O3IFoj3NamDrefKsrayVziVWRU
 kXKhaKthNY2GgyplINxjMVp7ysX4GO4CPmmObC6KLOXoIt7/tuF8lKml2icEQEHwoxzoC2e8qr
 tEbV7YUggmECDkIUMgMDVuAbWP4eiK/eEHSJ+B4t/EmvmD1ohMXC30wQUYJiyA5eaKdSaFotC6
 Hp0F7dmFnb81vQ6lm52LujrbKD0e0qcx5OU/Mq0SaiZZRl+SFsk14jXbj5jqSexTLdpSvsDC0x
 zdo=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 23:57:52 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KN2PC0nbSz1Rwrw
        for <linux-ide@vger.kernel.org>; Mon, 21 Mar 2022 23:57:51 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1647932270;
         x=1650524271; bh=BeJ38+CzW5xgKdVIIh0HLEWJCYoEhHO0WfDb8Fx+AX0=; b=
        Yh5dgyOwn/q9WgCMnQD8b8tzn4Irx+nQxg9kWqq2NTLbjTQipSv+qxH8rEAA6Mxf
        TtQW81agw0ZZBvMAPcfPERL/h3zaicSuCp5C2a5sTLgOCgVZVCAmG9MrjA4+C7d7
        XkzfZpVy1a4zu14jmyGQfdDiZcqr00niomz2lBaiEPhkHsZ76nrZymqdPBALEUq9
        Cjln4O73/ni9BEvYyeSaQDfb7bMBwYvXS8aJ9M4nHd1PomcUIZGR56jCb1bqpwXo
        lGtNsQ0jqajSrD5EDQvB1ImwiRDn7roOnWfx+IYjZCCjGip9zB/qEOg9ZeG1nQYS
        bSU5hJ6q+TBhHDIOVtawtQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2PoJh1bXppLM for <linux-ide@vger.kernel.org>;
        Mon, 21 Mar 2022 23:57:50 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KN2PB1gTbz1Rvlx;
        Mon, 21 Mar 2022 23:57:49 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Subject: [GIT PULL] ata changes for 5.18-rc1
Date:   Tue, 22 Mar 2022 15:56:08 +0900
Message-Id: <20220322065608.167815-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.35.1
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
ags/ata-5.18-rc1

for you to fetch changes up to d268afa1ff6f582dede1819fbed7ded7442a406c:

  ata: pata_pxa: Use platform_get_irq() to get the interrupt (2022-03-10 =
11:17:59 +0900)

----------------------------------------------------------------
ata changes for 5.18-rc1

For this cycle, no big change but many small fixes and code cleanup to
libata, the ahci driver and various pata drivers. In more details:

* Code simplification in pata_platform using platform_get_mem_or_io(),
  from Lad.

* Fix read-only arrays declarations as const in pata_atiixp and
  pata_pdc202xx_old, from Colin.

* Various cleanups and code simplification in libata-scsi, from me.

* Remove dead code in libata-acpi, from Sergey.

* Skip device scan deboune delay for Marvell 88SE9235 adapters (ahci) to
  speedup boot, from Paul.

* Simplify functions declaration and use for functions always returning
  0 in libata-core, from Sergey.

* Non-fatal error fixes and in the pata_hpt366 and pata_hpt3x2n drivers,
  from Sergey.

* Various code cleanup in the pata_artop, pata_hpt37x, pata_hpt366,
  pata_hpt3x2n, pata_samsung_cf and sata_rcar drivers, from Sergey.

* Some libata-sff and libata-scsi code cleanup (e.g. change functions
  to return "bool"), from Sergey.

* Renae ahci_board_mobile to board_ahci_low_power to be more descriptive
  of the feature as that is also used on PC and server AHCI adapters,
  from Mario.

* Cleanup of OF match tables, from Geert.

* Simplify the pata_pxa driver initialization using platform_get_irq(),
  from Minghao.

----------------------------------------------------------------
Colin Ian King (2):
      ata: pata_atiixp: make static read-only arrays const
      ata: pata_pdc202xx_old: make static read-only array pio_timing cons=
t

Damien Le Moal (4):
      ata: libata-scsi: Cleanup ata_get_xlat_func()
      ata: libata-scsi: Simplify ata_scsi_mode_select_xlat()
      ata: libata-scsi: Simplify scsi_XX_lba_len()
      ata: Kconfig: fix sata gemini compile test condition

Geert Uytterhoeven (1):
      ata: Drop commas after OF match table sentinels

Julia Lawall (1):
      ata: pata_mpc52xx: use GFP_KERNEL

Lad Prabhakar (1):
      ata: pata_platform: Make use of platform_get_mem_or_io()

Mario Limonciello (3):
      ata: ahci: Rename board_ahci_mobile
      ata: ahci: Rename `AHCI_HFLAG_IS_MOBILE`
      ata: ahci: Rename CONFIG_SATA_LPM_MOBILE_POLICY configuration item

Minghao Chi (1):
      ata: pata_pxa: Use platform_get_irq() to get the interrupt

Paul Menzel (1):
      ata: ahci: Skip 200 ms debounce delay for Marvell 88SE9235

Sergey Shtylyov (24):
      ata: libata-acpi: kill ata_acpi_on_suspend()
      ata: libata: ata_{sff|std}_prereset() always return 0
      ata: libata: make ata_host_suspend() *void*
      pata_hpt3x2n: check channel enable bits
      pata_hpt3x2n: fix writing to wrong register in hpt3x2n_bmdma_stop()
      ata: pata_artop: use *switch* in artop_init_one()
      ata: pata_artop: use *switch* in atp8xx_fixup()
      ata: pata_hpt3x2n: drop unused HPT_PCI_FAST
      ata: pata_hpt3x2n: drop unused 'struct hpt_chip'
      ata: libata-sff: make ata_devchk() return 'bool'
      ata: pata_samsung_cf: make pata_s3c_devchk() return 'bool'
      ata: sata_rcar: make sata_rcar_ata_devchk() return 'bool'
      ata: pata_hpt366: check channel enable bits
      ata: sata_rcar: drop unused #define's
      ata: pata_hpt366: disable fast interrupts in prereset() method
      ata: pata_hpt37x: disable fast interrupts in prereset() method
      ata: pata_hpt3x2n: disable fast interrupts in prereset() method
      ata: libata-sff: make ata_resources_present() return 'bool'
      ata: libata-sff: refactor ata_sff_set_devctl()
      ata: libata-sff: refactor ata_sff_altstatus()
      ata: libata-scsi: use *switch* statements to check SCSI command cod=
es
      ata: add/use ata_taskfile::{error|status} fields
      ata: libata-sff: use *switch* statement in ata_sff_dev_classify()
      ata: pata_hpt37x: merge transfer mode setting methods

 drivers/ata/Kconfig             |   8 +--
 drivers/ata/acard-ahci.c        |   2 +-
 drivers/ata/ahci.c              | 113 +++++++++++++++++----------------
 drivers/ata/ahci.h              |   4 +-
 drivers/ata/ahci_brcm.c         |   2 +-
 drivers/ata/ahci_ceva.c         |   2 +-
 drivers/ata/ahci_da850.c        |   2 +-
 drivers/ata/ahci_dm816.c        |   2 +-
 drivers/ata/ahci_imx.c          |   2 +-
 drivers/ata/ahci_mtk.c          |   2 +-
 drivers/ata/ahci_mvebu.c        |   2 +-
 drivers/ata/ahci_octeon.c       |   2 +-
 drivers/ata/ahci_platform.c     |   2 +-
 drivers/ata/ahci_qoriq.c        |   4 +-
 drivers/ata/ahci_st.c           |   2 +-
 drivers/ata/ahci_sunxi.c        |   2 +-
 drivers/ata/ahci_xgene.c        |   4 +-
 drivers/ata/ata_piix.c          |   5 +-
 drivers/ata/libahci.c           |   4 +-
 drivers/ata/libahci_platform.c  |   3 +-
 drivers/ata/libata-acpi.c       |  29 ++-------
 drivers/ata/libata-core.c       |  22 +++----
 drivers/ata/libata-eh.c         |  49 +++++++--------
 drivers/ata/libata-sata.c       |  10 +--
 drivers/ata/libata-scsi.c       |  95 ++++++++++++----------------
 drivers/ata/libata-sff.c        | 136 ++++++++++++++++++++++------------=
------
 drivers/ata/libata.h            |   2 -
 drivers/ata/pata_arasan_cf.c    |   3 +-
 drivers/ata/pata_artop.c        |  31 +++++----
 drivers/ata/pata_atiixp.c       |   4 +-
 drivers/ata/pata_cs5520.c       |   5 +-
 drivers/ata/pata_ep93xx.c       |   4 +-
 drivers/ata/pata_ftide010.c     |   6 +-
 drivers/ata/pata_hpt366.c       |  49 +++++++++++++--
 drivers/ata/pata_hpt37x.c       | 115 +++++++++------------------------
 drivers/ata/pata_hpt3x2n.c      |  38 ++++++-----
 drivers/ata/pata_imx.c          |  15 ++---
 drivers/ata/pata_ixp4xx_cf.c    |   2 +-
 drivers/ata/pata_macio.c        |  24 ++-----
 drivers/ata/pata_mpc52xx.c      |   7 ++-
 drivers/ata/pata_ns87415.c      |   4 +-
 drivers/ata/pata_octeon_cf.c    |  10 ++-
 drivers/ata/pata_of_platform.c  |   2 +-
 drivers/ata/pata_pdc202xx_old.c |   2 +-
 drivers/ata/pata_platform.c     |  18 ++----
 drivers/ata/pata_pxa.c          |  10 +--
 drivers/ata/pata_samsung_cf.c   |  12 ++--
 drivers/ata/pata_triflex.c      |   5 +-
 drivers/ata/sata_fsl.c          |  14 ++---
 drivers/ata/sata_gemini.c       |   6 +-
 drivers/ata/sata_highbank.c     |   7 ++-
 drivers/ata/sata_inic162x.c     |  10 +--
 drivers/ata/sata_mv.c           |   8 +--
 drivers/ata/sata_rcar.c         |  35 +++++------
 drivers/ata/sata_svw.c          |  10 +--
 drivers/ata/sata_vsc.c          |  10 +--
 include/linux/libata.h          |  12 +++-
 57 files changed, 456 insertions(+), 534 deletions(-)
