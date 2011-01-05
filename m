From: mkl0301@gmail.com
Subject: [PATCH v2 0/3] add CNS3xxx AHCI support
Date: Wed,  5 Jan 2011 13:43:04 +0800
Message-ID: <1294206187-11487-1-git-send-email-mkl0301@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:50433 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750802Ab1AEFnS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Jan 2011 00:43:18 -0500
Received: by gyb11 with SMTP id 11so5794490gyb.19
        for <linux-ide@vger.kernel.org>; Tue, 04 Jan 2011 21:43:17 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: cbouatmailru@gmail.com, htejun@gmail.com, linux-arm-kernel@lists.infradead.org, jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: Mac Lin <mkl0301@gmail.com>

From: Mac Lin <mkl0301@gmail.com>

v2:
 - Switch ahci_platform to module device table matching to add SoC specific support

v1: http://www.spinics.net/lists/arm-kernel/msg106236.html
 - Add CNS3xxx SoC specific AHCI support

This patchset is based on linux-2.6.37-rc2

Mac Lin (3):
      ahci_platform: rename to ahci_pltfm, but keep the original module name
      ahci_pltfm: switch to module device table matching
      ahci_platform: add support for CNS3xxx SoC devices

 arch/arm/mach-cns3xxx/devices.c |    2 +-
 drivers/ata/Kconfig             |   11 ++
 drivers/ata/Makefile            |    5 +-
 drivers/ata/ahci_cns3xxx.c      |   62 +++++++++++
 drivers/ata/ahci_platform.c     |  197 ------------------------------------
 drivers/ata/ahci_pltfm.c        |  212 +++++++++++++++++++++++++++++++++++++++
 drivers/ata/ahci_pltfm.h        |   19 ++++
 7 files changed, 309 insertions(+), 199 deletions(-)
 create mode 100644 drivers/ata/ahci_cns3xxx.c
 delete mode 100644 drivers/ata/ahci_platform.c
 create mode 100644 drivers/ata/ahci_pltfm.c
 create mode 100644 drivers/ata/ahci_pltfm.h
