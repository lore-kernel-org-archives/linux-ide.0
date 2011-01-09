From: mkl0301@gmail.com
Subject: [PATCH v4 0/3] add CNS3xxx AHCI support
Date: Sun,  9 Jan 2011 09:49:32 +0800
Message-ID: <1294537775-21714-1-git-send-email-mkl0301@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:54323 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751831Ab1AIBtp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 8 Jan 2011 20:49:45 -0500
Received: by pva4 with SMTP id 4so3240702pva.19
        for <linux-ide@vger.kernel.org>; Sat, 08 Jan 2011 17:49:45 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: htejun@gmail.com, cbouatmailru@gmail.com, linux-arm-kernel@lists.infradead.org, jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: Mac Lin <mkl0301@gmail.com>

From: Mac Lin <mkl0301@gmail.com>

v4:
 - v2 basically, which make SoC-specific changes into separate files
 - Rename module ahci_platform to ahci_platforms, into which link the ahci_platform and the SoC-specific changes
 - No rename of ahci_platform.c
 - Some cosmetic code changes since v2

v3: http://www.spinics.net/lists/arm-kernel/msg109924.html
 - Make the SoC-specific changes into ahci_platform.c directly.
 - Some cosmetic code changes
=> ahci_platform.c is less readable due to SoC-specific changes and macro

v2: http://www.spinics.net/lists/linux-ide/msg39766.html
 - Renaming ahci_platform.c to ahci_pltfm.c for linking SoC specific changes into ahci_platform, while not changing the module name.
 - Switch ahci_platform to module device table matching to add SoC specific support
 - Add CNS3xxx SoC specific AHCI support to ahci_cns3xxx.c

v1: http://www.spinics.net/lists/arm-kernel/msg106236.html
 - Add CNS3xxx SoC specific AHCI support to arch/arm/mach-cns3xxx
=> The changes depends on libahci and libata, i.e. both of them need to be built into kernel

This patchset is based on linux-2.6.37

Mac Lin (3):
      ahci_platform: rename module ahci_platform to ahci_platforms
      ahci_platform: switch to module device table matching
      ahci_platforms: add support for CNS3xxx SoC devices

 arch/arm/mach-cns3xxx/devices.c |    2 +-
 drivers/ata/Kconfig             |   11 ++++++++
 drivers/ata/Makefile            |    5 +++-
 drivers/ata/ahci_cns3xxx.c      |   51 +++++++++++++++++++++++++++++++++++++++
 drivers/ata/ahci_platform.c     |   17 ++++++++++++-
 drivers/ata/ahci_platforms.h    |   18 +++++++++++++
 6 files changed, 101 insertions(+), 3 deletions(-)
 create mode 100644 drivers/ata/ahci_cns3xxx.c
 create mode 100644 drivers/ata/ahci_platforms.h
