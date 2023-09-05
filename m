Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A6FDC83F2C
	for <linux-ide@archiver.kernel.org>; Tue,  5 Sep 2023 16:21:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343751AbjIEQUz (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 5 Sep 2023 12:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353674AbjIEHML (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 5 Sep 2023 03:12:11 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3166CCCB
        for <linux-ide@vger.kernel.org>; Tue,  5 Sep 2023 00:12:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 51D7CCE10AF
        for <linux-ide@vger.kernel.org>; Tue,  5 Sep 2023 07:12:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39526C433C8;
        Tue,  5 Sep 2023 07:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693897923;
        bh=7g1ifMrfvCF57osZsx6cfyzLKmrBKUVcyn3S7gC6kIY=;
        h=From:To:Subject:Date:From;
        b=hbNawfSy6URxYc446Vb/V5lFGQvSjLpGIok6dJ4UCNE793awKAzc88O535+G82pev
         U2h8hhfTMjX1R7NNGy5/h9TerIlPiv701PV//h4DLPUZ51wh00m/SOd+PxMTfaQvsr
         4GMmbtBAvcq4FeUM5EWegWjG+AzxmPlIwqVB1Yy1t0EkuhcTGTouPSckYg+/cxUfDQ
         VACrLx0dYZ+0TTxJIz4j0prA0ZItjHtbxuMmsmGz228lxhQdS6vCeFV1VPTSbuyf3j
         kiIqgYz6YTAuqAc5EyUTQoZgQ8UkvCQy/eK2ynsuRHQj5DJA+By7rrq00vkz8IpIba
         Dbh8Gh9SOYg7w==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ide@vger.kernel.org
Subject: [GIT PULL] ata changes for 6.6-rc1
Date:   Tue,  5 Sep 2023 16:11:54 +0900
Message-ID: <20230905071201.277320-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Linus,

The following changes since commit 5d0c230f1de8c7515b6567d9afba1f196fb4e2f4:

  Linux 6.5-rc4 (2023-07-30 13:23:47 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata tags/ata-6.6-rc1

for you to fetch changes up to 27fd071040e3a5bbea9f44548c93f1092b451714:

  ata: libata-core: Disable NCQ_TRIM on Micron 1100 drives (2023-09-02 12:04:51 +0900)

----------------------------------------------------------------
ata changes for 6.6

 - Fix OF include file for ata platform drivers (Rob).

 - Simplify various ahci, sata and pata platform drivers using the
   function devm_platform_ioremap_resource() (Yangtao).

 - Cleanup libata time related argument types (e.g. timeouts values)
   (Sergey).

 - Cleanup libata code around error handling as all ata drivers now
   define a error_handler operation (Hannes and Niklas).

 - Remove functions intended for libsas that are in fact unused
   (Niklas).

 - Change the remove device callback of platform drivers to a null
   function (Uwe).

 - Simplify the pata_imx driver using devm_clk_get_enabled() (Li).

 - Remove old and uinused remnants of the ide code in arm, parisc,
   powerpc, sparc and m68k architectures and associated drivers
   (pata_buddha, pata_falcon and pata_gayle) (Geert).

 - Add missing MODULE_DESCRIPTION() in the sata_gemini and pata_ftide010
   drivers (me).

 - Several fixes for the pata_ep93xx and pata_falcon drivers (Nikita,
   Michael).

 - Add Elkhart Lake AHCI controller support to the ahci driver (Werner).

 - Disable NCQ trim on Micron 1100 drives (Pawel).

----------------------------------------------------------------
Damien Le Moal (2):
      ata: pata_ftide010: Add missing MODULE_DESCRIPTION
      ata: sata_gemini: Add missing MODULE_DESCRIPTION

Geert Uytterhoeven (9):
      ARM: Remove <asm/ide.h>
      parisc: Remove <asm/ide.h>
      powerpc: Remove <asm/ide.h>
      sparc: Remove <asm/ide.h>
      asm-generic: Remove ide_iops.h
      ata: pata_buddha: Remove #include <asm/ide.h>
      ata: pata_falcon: Remove #include <asm/ide.h>
      ata: pata_gayle: Remove #include <asm/ide.h>
      m68k: Remove <asm/ide.h>

Hannes Reinecke (6):
      ata: libata: remove references to non-existing error_handler()
      ata,scsi: remove ata_sas_port_{start,stop} callbacks
      ata,scsi: remove ata_sas_port_destroy()
      ata: libata-sata: remove ata_sas_sync_probe()
      ata: libata-core: inline ata_port_probe()
      ata,scsi: cleanup __ata_port_probe()

Li Zetao (1):
      ata: pata_imx: Use helper function devm_clk_get_enabled()

Michael Schmitz (2):
      ata: pata_falcon: fix IO base selection for Q40
      ata: pata_falcon: add data_swab option to byte-swap disk data

Nikita Shubin (2):
      ata: pata_ep93xx: fix error return code in probe
      ata: pata_ep93xx: use soc_device_match for UDMA modes

Niklas Cassel (4):
      ata,scsi: remove ata_sas_port_init()
      ata: sata_sx4: drop already completed TODO
      ata: libata-core: remove ata_bus_probe()
      ata: libata: remove deprecated EH callbacks

Pawel Zmarzly (1):
      ata: libata-core: Disable NCQ_TRIM on Micron 1100 drives

Rob Herring (1):
      ata: Explicitly include correct DT includes

Sergey Shtylyov (8):
      ata: libata: fix parameter type of ata_deadline()
      ata: libata-core: fix parameter types of ata_wait_register()
      ata: libata-eh: fix reset timeout type
      ata: fix debounce timings type
      ata: libata-scsi: fix timeout type in ata_scsi_park_store()
      ata: libahci: fix parameter type of ahci_exec_polled_cmd()
      ata: ahci_xgene: fix parameter types of xgene_ahci_poll_reg_val()
      ata: sata_sil24: fix parameter type of sil24_exec_polled_cmd()

Uwe Kleine-König (12):
      ata: pata_arasan_cf: Convert to platform remove callback returning void
      ata: pata_ep93xx: Convert to platform remove callback returning void
      ata: pata_ftide010: Convert to platform remove callback returning void
      ata: pata_imx: Convert to platform remove callback returning void
      ata: pata_mpc52xx: Convert to platform remove callback returning void
      ata: pata_pxa: Convert to platform remove callback returning void
      ata: pata_rb532_cf: Convert to platform remove callback returning void
      ata: sata_dwc_460ex: Convert to platform remove callback returning void
      ata: sata_fsl: Convert to platform remove callback returning void
      ata: sata_gemini: Convert to platform remove callback returning void
      ata: sata_mv: Convert to platform remove callback returning void
      ata: sata_rcar: Convert to platform remove callback returning void

Werner Fischer (1):
      ata: ahci: Add Elkhart Lake AHCI controller

Yangtao Li (11):
      ata: ahci_octeon: Convert to devm_platform_ioremap_resource()
      ata: ahci_seattle: Convert to devm_platform_ioremap_resource()
      ata: ahci_xgene: Convert to devm_platform_ioremap_resource()
      ata: ahci_tegra: Convert to devm_platform_ioremap_resource()
      ata: sata_rcar: drop useless initializer
      ata: sata_rcar: Remove unnecessary return value check
      ata: sata_rcar: Convert to devm_platform_ioremap_resource()
      ata: pata_ixp4xx: Use devm_platform_get_and_ioremap_resource()
      ata: pata_ixp4xx: Remove unnecessary return value check
      ata: pata_ftide010: Use devm_platform_get_and_ioremap_resource()
      ata: pata_imx: Use devm_platform_get_and_ioremap_resource()

 Documentation/driver-api/libata.rst   |  38 +---
 arch/arm/include/asm/ide.h            |  24 ---
 arch/m68k/include/asm/ide.h           |  67 -------
 arch/parisc/include/asm/ide.h         |  54 -----
 arch/powerpc/include/asm/ide.h        |  18 --
 arch/sparc/include/asm/ide.h          |  97 ---------
 drivers/ata/ahci.c                    |   4 +-
 drivers/ata/ahci_ceva.c               |   2 +-
 drivers/ata/ahci_dwc.c                |   2 +-
 drivers/ata/ahci_mtk.c                |   1 +
 drivers/ata/ahci_mvebu.c              |   2 +-
 drivers/ata/ahci_octeon.c             |   4 +-
 drivers/ata/ahci_qoriq.c              |   4 +-
 drivers/ata/ahci_seattle.c            |   4 +-
 drivers/ata/ahci_sunxi.c              |   2 +-
 drivers/ata/ahci_tegra.c              |   5 +-
 drivers/ata/ahci_xgene.c              |  16 +-
 drivers/ata/libahci.c                 |   7 +-
 drivers/ata/libahci_platform.c        |   1 +
 drivers/ata/libata-core.c             | 367 +++++++++-------------------------
 drivers/ata/libata-eh.c               | 158 ++++++---------
 drivers/ata/libata-sata.c             | 112 +----------
 drivers/ata/libata-scsi.c             | 165 ++-------------
 drivers/ata/libata-sff.c              |  32 +--
 drivers/ata/libata.h                  |   3 -
 drivers/ata/pata_arasan_cf.c          |   6 +-
 drivers/ata/pata_buddha.c             |   1 -
 drivers/ata/pata_ep93xx.c             |  25 ++-
 drivers/ata/pata_falcon.c             |  63 +++---
 drivers/ata/pata_ftide010.c           |  16 +-
 drivers/ata/pata_gayle.c              |   1 -
 drivers/ata/pata_imx.c                |  37 +---
 drivers/ata/pata_ixp4xx_cf.c          |  24 +--
 drivers/ata/pata_mpc52xx.c            |  10 +-
 drivers/ata/pata_pxa.c                |   6 +-
 drivers/ata/pata_rb532_cf.c           |   6 +-
 drivers/ata/pata_sl82c105.c           |   3 +-
 drivers/ata/sata_dwc_460ex.c          |   8 +-
 drivers/ata/sata_fsl.c                |  12 +-
 drivers/ata/sata_gemini.c             |  10 +-
 drivers/ata/sata_highbank.c           |   4 +-
 drivers/ata/sata_inic162x.c           |   2 +-
 drivers/ata/sata_mv.c                 |   7 +-
 drivers/ata/sata_nv.c                 |   2 +-
 drivers/ata/sata_rcar.c               |  17 +-
 drivers/ata/sata_sil24.c              |   4 +-
 drivers/ata/sata_sx4.c                |   1 -
 drivers/scsi/hisi_sas/hisi_sas_main.c |   2 +-
 drivers/scsi/libsas/sas_ata.c         |   9 +-
 drivers/scsi/libsas/sas_discover.c    |   2 +-
 include/asm-generic/ide_iops.h        |  39 ----
 include/linux/libata.h                |  40 ++--
 52 files changed, 355 insertions(+), 1191 deletions(-)
 delete mode 100644 arch/arm/include/asm/ide.h
 delete mode 100644 arch/m68k/include/asm/ide.h
 delete mode 100644 arch/parisc/include/asm/ide.h
 delete mode 100644 arch/powerpc/include/asm/ide.h
 delete mode 100644 arch/sparc/include/asm/ide.h
 delete mode 100644 include/asm-generic/ide_iops.h
