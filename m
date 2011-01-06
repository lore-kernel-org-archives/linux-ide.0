From: mkl0301@gmail.com
Subject: [PATCH v3 0/2] add CNS3xxx AHCI support
Date: Fri,  7 Jan 2011 01:53:11 +0800
Message-ID: <1294336393-920-1-git-send-email-mkl0301@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:53352 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751030Ab1AFRxW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Jan 2011 12:53:22 -0500
Received: by yxt3 with SMTP id 3so6511074yxt.19
        for <linux-ide@vger.kernel.org>; Thu, 06 Jan 2011 09:53:22 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: cbouatmailru@gmail.com, htejun@gmail.com, linux-arm-kernel@lists.infradead.org, jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: Mac Lin <mkl0301@gmail.com>

From: Mac Lin <mkl0301@gmail.com>

v3:
 - Make the SoC-specific changes into ahci_platform.c directly.
 - Some cosmetic code changes

v2: http://www.spinics.net/lists/linux-ide/msg39766.html
 - Switch ahci_platform to module device table matching to add SoC specific support

v1: http://www.spinics.net/lists/arm-kernel/msg106236.html
 - Add CNS3xxx SoC specific AHCI support

This patchset is based on linux-2.6.37

Mac Lin (2):
      ahci_platform: switch to module device table matching
      ahci_platform: add support for CNS3xxx SoC devices

 arch/arm/mach-cns3xxx/devices.c |    2 +-
 drivers/ata/Kconfig             |   11 ++++++++
 drivers/ata/ahci_platform.c     |   52 ++++++++++++++++++++++++++++++++++++++-
 3 files changed, 63 insertions(+), 2 deletions(-)
