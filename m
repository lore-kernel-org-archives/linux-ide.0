Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C43C48BC2
	for <linux-ide@archiver.kernel.org>; Sun, 27 Jun 2021 18:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D53EE6162C
	for <linux-ide@archiver.kernel.org>; Sun, 27 Jun 2021 18:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbhF0Sor (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 27 Jun 2021 14:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbhF0Sor (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 27 Jun 2021 14:44:47 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D87C061574
        for <linux-ide@vger.kernel.org>; Sun, 27 Jun 2021 11:42:23 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id k5so15176099ilv.8
        for <linux-ide@vger.kernel.org>; Sun, 27 Jun 2021 11:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=3iwN3CRJyejcz7UUWE4xG/hSSoa8xVMp8YvUWWKD9KM=;
        b=w7uaO8Ydy7YslDesjGG0YmxbttCLu0bE6pJ2l+pf5ubQJYJxYPGECUiqg7oPWYu94N
         yz1Ws716iGGZHByaAFz41kwIRh4hV9q2/QgVfYqS8RPSPt97p8iXAAZWahyLQBnTPY3y
         UCi902YEKRx6fRkQGErK3IAk6N+n+uBBIYI3zqkCWw5unS3rQ0tkHYguhRAlmuVGnF3q
         A6lQXx8aIXNjp+/ydYO+Bs/VGBHo44hkczwlRJewgd061KMupV14Jy2Sf0IHWAT3FH5c
         JDRfeQZN9CtsQCX6L69go73tuZtPxUtor+8uQs0BfHXDwz9bp0NEg39eYHFVeL3e5IM/
         Xvmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=3iwN3CRJyejcz7UUWE4xG/hSSoa8xVMp8YvUWWKD9KM=;
        b=JFBaab28FyLkBbIPMdXI8PaIuA/edquBxq7GBU+0o5sEes+7vfS8pJEBlrsUMBlnMD
         kdIia33/VYSwBVGWlYSIUUgCgqm/W5a8ao5H2Jp69x1BF+7Y+HyJs83O+kPdvyLtN/gq
         07m0sHY62lW1bDQ4t3FasEWD0DDcjKtUyQYE6YzzTqVGU0l5YLYBHbZRpziXhBD8zyyE
         JEk59C43/W0FeEctg/W8udwtjaE9GPRGzLxzTRX0Cq2RJwldWXW3WlnhQgtjNNahzMsL
         YRc3/o8UMiTGfhyEjcHCqrTNNZ10u8ShJZrSUVvggUR+30f8ZV78h1Fjz6phBnsX+4Pf
         We9w==
X-Gm-Message-State: AOAM531Ig35h8qWaLk1Cb4kk2PILVkx7FPGmG/SKtx+mNO5LuFW0HBIY
        u8lfpLbM4ke/OiRTQgNgQaQNtysTcxFmbQ==
X-Google-Smtp-Source: ABdhPJzk71E65gl6pH6zaIjWdyKsm7eIUguQ8TH2WwijXTdVcpWOGIJG6vR6aRZCSDWbiY20p8AgfA==
X-Received: by 2002:a92:1942:: with SMTP id e2mr15866532ilm.4.1624819342264;
        Sun, 27 Jun 2021 11:42:22 -0700 (PDT)
Received: from [192.168.1.134] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id j17sm7333368ilc.39.2021.06.27.11.42.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Jun 2021 11:42:21 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-ide@vger.kernel.org
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] libata changes for 5.14-rc1
Message-ID: <6791b727-5820-b8a6-32de-2cd57cebecf6@kernel.dk>
Date:   Sun, 27 Jun 2021 12:42:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi Linus,

Sending this one a bit early, to avoid any potential conflicts with
documentation etc patches for drivers/ide/. 

The big change in this round is that we're finally in a position where
we can sanely remove the old drivers/ide/ code, as libata everything we
need by now. This is exciting for two reasons: 1) we delete a lot of
legacy code that doesn't really meet the standards we have today, and 2)
it enables us to clean up various bits in the block layer that exist
only because of the old IDE code.

Outside of that, just a few minor fixes here, fixups for warnings, etc.

Please pull!


The following changes since commit d07f6ca923ea0927a1024dfccafc5b53b61cfecc:

  Linux 5.13-rc2 (2021-05-16 15:27:44 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/for-5.14/libata-2021-06-27

for you to fetch changes up to 1af11d098db18bfda5168dc407513726e1b1bdb3:

  ata: rb532_cf: remove redundant codes (2021-06-24 18:49:01 -0600)

----------------------------------------------------------------
for-5.14/libata-2021-06-27

----------------------------------------------------------------
Andy Shevchenko (1):
      ata: Replace inclusion of kernel.h by bits.h in the header

Arnd Bergmann (2):
      sata: fsl: fix DPRINTK format string
      sata: nv: fix debug format string mismatch

Charles Rose (1):
      ahci: Add support for Dell S140 and later controllers

Christoph Hellwig (6):
      pata_cypress: add a module option to disable BM-DMA
      alpha: use libata instead of the legacy ide driver
      ARM: disable CONFIG_IDE in footbridge_defconfig
      ARM: disable CONFIG_IDE in pxa_defconfig
      m68k: use libata instead of the legacy ide driver
      ide: remove the legacy ide driver

Finn Thain (2):
      m68k/mac: Replace macide driver with generic platform drivers
      m68k/q40: Replace q40ide driver with pata_falcon and falconide

Lee Jones (11):
      ata: include: libata: Move fields commonly over-written to separate MACRO
      ata: ahci: Ensure initialised fields are not overwritten in AHCI_SHT()
      ata: sata_sil24: Do not over-write initialise fields in 'sil24_sht'
      ata: sata_mv: Do not over-write initialise fields in 'mv6_sht'
      ata: sata_nv: Do not over-write initialise fields in 'nv_adma_sht' and 'nv_swncq_sht'
      ata: pata_atiixp: Avoid overwriting initialised field in 'atiixp_sht'
      ata: pata_cs5520: Avoid overwriting initialised field in 'cs5520_sht'
      ata: pata_cs5530: Avoid overwriting initialised field in 'cs5530_sht'
      ata: pata_sc1200: sc1200_sht'Avoid overwriting initialised field in '
      ata: pata_serverworks: Avoid overwriting initialised field in 'serverworks_osb4_sht
      ata: pata_macio: Avoid overwriting initialised field in 'pata_macio_sht'

Sergey Shtylyov (4):
      sata_highbank: fix deferred probing
      pata_rb532_cf: fix deferred probing
      pata_octeon_cf: avoid WARN_ON() in ata_host_activate()
      pata_ep93xx: fix deferred probing

Timo Sigurdsson (1):
      ata: ahci_sunxi: Disable DIPM

gushengxian (1):
      ata: rb532_cf: remove redundant codes

 Documentation/userspace-api/ioctl/hdio.rst |  845 +----------
 MAINTAINERS                                |   16 -
 arch/alpha/configs/defconfig               |   13 +-
 arch/arm/configs/footbridge_defconfig      |    1 -
 arch/arm/configs/pxa_defconfig             |    2 -
 arch/m68k/atari/config.c                   |   12 +-
 arch/m68k/configs/amiga_defconfig          |   10 +-
 arch/m68k/configs/atari_defconfig          |    8 +-
 arch/m68k/configs/mac_defconfig            |    9 +-
 arch/m68k/configs/multi_defconfig          |   16 +-
 arch/m68k/configs/q40_defconfig            |    8 +-
 arch/m68k/mac/config.c                     |   24 +-
 arch/m68k/q40/config.c                     |   37 +-
 drivers/Kconfig                            |    2 -
 drivers/Makefile                           |    1 -
 drivers/ata/Kconfig                        |    6 +-
 drivers/ata/ahci.c                         |    4 +
 drivers/ata/ahci.h                         |    7 +-
 drivers/ata/ahci_sunxi.c                   |    2 +-
 drivers/ata/pata_atiixp.c                  |    3 +-
 drivers/ata/pata_cs5520.c                  |    3 +-
 drivers/ata/pata_cs5530.c                  |    3 +-
 drivers/ata/pata_cypress.c                 |   10 +-
 drivers/ata/pata_ep93xx.c                  |    2 +-
 drivers/ata/pata_falcon.c                  |   62 +-
 drivers/ata/pata_macio.c                   |    5 +-
 drivers/ata/pata_octeon_cf.c               |    5 +-
 drivers/ata/pata_rb532_cf.c                |    8 +-
 drivers/ata/pata_sc1200.c                  |    3 +-
 drivers/ata/pata_serverworks.c             |    3 +-
 drivers/ata/sata_fsl.c                     |    2 +-
 drivers/ata/sata_highbank.c                |    6 +-
 drivers/ata/sata_mv.c                      |    6 +-
 drivers/ata/sata_nv.c                      |   12 +-
 drivers/ata/sata_sil24.c                   |    5 +-
 drivers/ide/Kconfig                        |  849 ------------
 drivers/ide/Makefile                       |  111 --
 drivers/ide/aec62xx.c                      |  331 -----
 drivers/ide/ali14xx.c                      |  250 ----
 drivers/ide/alim15x3.c                     |  602 --------
 drivers/ide/amd74xx.c                      |  343 -----
 drivers/ide/atiixp.c                       |  212 ---
 drivers/ide/buddha.c                       |  238 ----
 drivers/ide/cmd640.c                       |  848 -----------
 drivers/ide/cmd64x.c                       |  452 ------
 drivers/ide/cs5520.c                       |  168 ---
 drivers/ide/cs5530.c                       |  295 ----
 drivers/ide/cs5535.c                       |  216 ---
 drivers/ide/cs5536.c                       |  294 ----
 drivers/ide/cy82c693.c                     |  234 ----
 drivers/ide/delkin_cb.c                    |  181 ---
 drivers/ide/dtc2278.c                      |  155 ---
 drivers/ide/falconide.c                    |  197 ---
 drivers/ide/gayle.c                        |  188 ---
 drivers/ide/hpt366.c                       | 1545 ---------------------
 drivers/ide/ht6560b.c                      |  383 -----
 drivers/ide/icside.c                       |  692 ---------
 drivers/ide/ide-4drives.c                  |   65 -
 drivers/ide/ide-acpi.c                     |  622 ---------
 drivers/ide/ide-atapi.c                    |  756 ----------
 drivers/ide/ide-cd.c                       | 1858 -------------------------
 drivers/ide/ide-cd.h                       |  123 --
 drivers/ide/ide-cd_ioctl.c                 |  468 -------
 drivers/ide/ide-cd_verbose.c               |  362 -----
 drivers/ide/ide-cs.c                       |  364 -----
 drivers/ide/ide-devsets.c                  |  192 ---
 drivers/ide/ide-disk.c                     |  795 -----------
 drivers/ide/ide-disk.h                     |   30 -
 drivers/ide/ide-disk_ioctl.c               |   33 -
 drivers/ide/ide-disk_proc.c                |  125 --
 drivers/ide/ide-dma-sff.c                  |  336 -----
 drivers/ide/ide-dma.c                      |  551 --------
 drivers/ide/ide-eh.c                       |  443 ------
 drivers/ide/ide-floppy.c                   |  551 --------
 drivers/ide/ide-floppy.h                   |   42 -
 drivers/ide/ide-floppy_ioctl.c             |  339 -----
 drivers/ide/ide-floppy_proc.c              |   34 -
 drivers/ide/ide-gd.c                       |  432 ------
 drivers/ide/ide-gd.h                       |   43 -
 drivers/ide/ide-generic.c                  |  139 --
 drivers/ide/ide-io-std.c                   |  262 ----
 drivers/ide/ide-io.c                       |  904 ------------
 drivers/ide/ide-ioctls.c                   |  306 ----
 drivers/ide/ide-iops.c                     |  536 -------
 drivers/ide/ide-legacy.c                   |   59 -
 drivers/ide/ide-lib.c                      |  146 --
 drivers/ide/ide-park.c                     |  155 ---
 drivers/ide/ide-pci-generic.c              |  203 ---
 drivers/ide/ide-pio-blacklist.c            |   96 --
 drivers/ide/ide-pm.c                       |  261 ----
 drivers/ide/ide-pnp.c                      |   92 --
 drivers/ide/ide-probe.c                    | 1623 ----------------------
 drivers/ide/ide-proc.c                     |  633 ---------
 drivers/ide/ide-scan-pci.c                 |  113 --
 drivers/ide/ide-sysfs.c                    |  143 --
 drivers/ide/ide-tape.c                     | 2083 ----------------------------
 drivers/ide/ide-taskfile.c                 |  668 ---------
 drivers/ide/ide-timings.c                  |  198 ---
 drivers/ide/ide-xfer-mode.c                |  267 ----
 drivers/ide/ide.c                          |  415 ------
 drivers/ide/ide_platform.c                 |  133 --
 drivers/ide/it8172.c                       |  165 ---
 drivers/ide/it8213.c                       |  217 ---
 drivers/ide/it821x.c                       |  715 ----------
 drivers/ide/jmicron.c                      |  176 ---
 drivers/ide/macide.c                       |  161 ---
 drivers/ide/ns87415.c                      |  350 -----
 drivers/ide/opti621.c                      |  179 ---
 drivers/ide/palm_bk3710.c                  |  387 ------
 drivers/ide/pdc202xx_new.c                 |  557 --------
 drivers/ide/pdc202xx_old.c                 |  362 -----
 drivers/ide/piix.c                         |  476 -------
 drivers/ide/pmac.c                         | 1703 -----------------------
 drivers/ide/q40ide.c                       |  168 ---
 drivers/ide/qd65xx.c                       |  446 ------
 drivers/ide/qd65xx.h                       |  145 --
 drivers/ide/rapide.c                       |  106 --
 drivers/ide/rz1000.c                       |  100 --
 drivers/ide/sc1200.c                       |  355 -----
 drivers/ide/serverworks.c                  |  456 ------
 drivers/ide/setup-pci.c                    |  682 ---------
 drivers/ide/siimage.c                      |  843 -----------
 drivers/ide/sis5513.c                      |  637 ---------
 drivers/ide/sl82c105.c                     |  367 -----
 drivers/ide/slc90e66.c                     |  182 ---
 drivers/ide/tc86c001.c                     |  270 ----
 drivers/ide/triflex.c                      |  143 --
 drivers/ide/trm290.c                       |  374 -----
 drivers/ide/tx4938ide.c                    |  209 ---
 drivers/ide/tx4939ide.c                    |  628 ---------
 drivers/ide/umc8672.c                      |  184 ---
 drivers/ide/via82cxxx.c                    |  532 -------
 include/linux/ata.h                        |    2 +-
 include/linux/ide.h                        | 1623 ----------------------
 include/linux/libata.h                     |   13 +-
 include/linux/pci_ids.h                    |    2 +
 136 files changed, 224 insertions(+), 41635 deletions(-)
 delete mode 100644 drivers/ide/Kconfig
 delete mode 100644 drivers/ide/Makefile
 delete mode 100644 drivers/ide/aec62xx.c
 delete mode 100644 drivers/ide/ali14xx.c
 delete mode 100644 drivers/ide/alim15x3.c
 delete mode 100644 drivers/ide/amd74xx.c
 delete mode 100644 drivers/ide/atiixp.c
 delete mode 100644 drivers/ide/buddha.c
 delete mode 100644 drivers/ide/cmd640.c
 delete mode 100644 drivers/ide/cmd64x.c
 delete mode 100644 drivers/ide/cs5520.c
 delete mode 100644 drivers/ide/cs5530.c
 delete mode 100644 drivers/ide/cs5535.c
 delete mode 100644 drivers/ide/cs5536.c
 delete mode 100644 drivers/ide/cy82c693.c
 delete mode 100644 drivers/ide/delkin_cb.c
 delete mode 100644 drivers/ide/dtc2278.c
 delete mode 100644 drivers/ide/falconide.c
 delete mode 100644 drivers/ide/gayle.c
 delete mode 100644 drivers/ide/hpt366.c
 delete mode 100644 drivers/ide/ht6560b.c
 delete mode 100644 drivers/ide/icside.c
 delete mode 100644 drivers/ide/ide-4drives.c
 delete mode 100644 drivers/ide/ide-acpi.c
 delete mode 100644 drivers/ide/ide-atapi.c
 delete mode 100644 drivers/ide/ide-cd.c
 delete mode 100644 drivers/ide/ide-cd.h
 delete mode 100644 drivers/ide/ide-cd_ioctl.c
 delete mode 100644 drivers/ide/ide-cd_verbose.c
 delete mode 100644 drivers/ide/ide-cs.c
 delete mode 100644 drivers/ide/ide-devsets.c
 delete mode 100644 drivers/ide/ide-disk.c
 delete mode 100644 drivers/ide/ide-disk.h
 delete mode 100644 drivers/ide/ide-disk_ioctl.c
 delete mode 100644 drivers/ide/ide-disk_proc.c
 delete mode 100644 drivers/ide/ide-dma-sff.c
 delete mode 100644 drivers/ide/ide-dma.c
 delete mode 100644 drivers/ide/ide-eh.c
 delete mode 100644 drivers/ide/ide-floppy.c
 delete mode 100644 drivers/ide/ide-floppy.h
 delete mode 100644 drivers/ide/ide-floppy_ioctl.c
 delete mode 100644 drivers/ide/ide-floppy_proc.c
 delete mode 100644 drivers/ide/ide-gd.c
 delete mode 100644 drivers/ide/ide-gd.h
 delete mode 100644 drivers/ide/ide-generic.c
 delete mode 100644 drivers/ide/ide-io-std.c
 delete mode 100644 drivers/ide/ide-io.c
 delete mode 100644 drivers/ide/ide-ioctls.c
 delete mode 100644 drivers/ide/ide-iops.c
 delete mode 100644 drivers/ide/ide-legacy.c
 delete mode 100644 drivers/ide/ide-lib.c
 delete mode 100644 drivers/ide/ide-park.c
 delete mode 100644 drivers/ide/ide-pci-generic.c
 delete mode 100644 drivers/ide/ide-pio-blacklist.c
 delete mode 100644 drivers/ide/ide-pm.c
 delete mode 100644 drivers/ide/ide-pnp.c
 delete mode 100644 drivers/ide/ide-probe.c
 delete mode 100644 drivers/ide/ide-proc.c
 delete mode 100644 drivers/ide/ide-scan-pci.c
 delete mode 100644 drivers/ide/ide-sysfs.c
 delete mode 100644 drivers/ide/ide-tape.c
 delete mode 100644 drivers/ide/ide-taskfile.c
 delete mode 100644 drivers/ide/ide-timings.c
 delete mode 100644 drivers/ide/ide-xfer-mode.c
 delete mode 100644 drivers/ide/ide.c
 delete mode 100644 drivers/ide/ide_platform.c
 delete mode 100644 drivers/ide/it8172.c
 delete mode 100644 drivers/ide/it8213.c
 delete mode 100644 drivers/ide/it821x.c
 delete mode 100644 drivers/ide/jmicron.c
 delete mode 100644 drivers/ide/macide.c
 delete mode 100644 drivers/ide/ns87415.c
 delete mode 100644 drivers/ide/opti621.c
 delete mode 100644 drivers/ide/palm_bk3710.c
 delete mode 100644 drivers/ide/pdc202xx_new.c
 delete mode 100644 drivers/ide/pdc202xx_old.c
 delete mode 100644 drivers/ide/piix.c
 delete mode 100644 drivers/ide/pmac.c
 delete mode 100644 drivers/ide/q40ide.c
 delete mode 100644 drivers/ide/qd65xx.c
 delete mode 100644 drivers/ide/qd65xx.h
 delete mode 100644 drivers/ide/rapide.c
 delete mode 100644 drivers/ide/rz1000.c
 delete mode 100644 drivers/ide/sc1200.c
 delete mode 100644 drivers/ide/serverworks.c
 delete mode 100644 drivers/ide/setup-pci.c
 delete mode 100644 drivers/ide/siimage.c
 delete mode 100644 drivers/ide/sis5513.c
 delete mode 100644 drivers/ide/sl82c105.c
 delete mode 100644 drivers/ide/slc90e66.c
 delete mode 100644 drivers/ide/tc86c001.c
 delete mode 100644 drivers/ide/triflex.c
 delete mode 100644 drivers/ide/trm290.c
 delete mode 100644 drivers/ide/tx4938ide.c
 delete mode 100644 drivers/ide/tx4939ide.c
 delete mode 100644 drivers/ide/umc8672.c
 delete mode 100644 drivers/ide/via82cxxx.c
 delete mode 100644 include/linux/ide.h

-- 
Jens Axboe

