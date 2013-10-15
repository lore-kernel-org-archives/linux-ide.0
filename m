From: Richard Zhu <richard.zhuhongxing@gmail.com>
Subject: [PATCH v4 0/1] ahci: imx: setup power saving methods
Date: Tue, 15 Oct 2013 10:44:53 +0800
Message-ID: <1381805094-14723-1-git-send-email-Hong-Xing.Zhu@freescale.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pb0-f53.google.com ([209.85.160.53]:56370 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752529Ab3JOCkx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 Oct 2013 22:40:53 -0400
Received: by mail-pb0-f53.google.com with SMTP id up15so8151387pbc.12
        for <linux-ide@vger.kernel.org>; Mon, 14 Oct 2013 19:40:52 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: shawn.guo@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, jgarzik@pobox.com, tj@kernel.org, linux-ide@vger.kernel.org

v4: ahci: imx: setup power saving methods
 - Thanks for Tejun's review and comments firstly.
 - add copyright modification note in the commit message
 - export ahci_error_handler and ahci_platform_ops
 - add more detailed comments.

v3: http://www.spinics.net/lists/linux-ide/msg46641.html
 - Thanks for Tejun's suggestions.
 override the error_handler by ahci_imx_error_handler, to do
 the complete SATA device detection, enter into PDDQ mode,
 if there is no any SATA device.

 - minor modifications:
   - The format of the copyright is changed, because that the
   original one can't pass fsl internal patch reivew without
   the character '(c)'.
   - Change the module parameters to be more readable.

V2: http://www.spinics.net/lists/linux-ide/msg46606.html
 - kernel build option is replaced by the module parameter(ahci-imx.hp) 

v1: http://www.spinics.net/lists/linux-ide/msg46389.html
 * Disable sata phy internal pll reference clock when
 sysetem enter into suspend mode, enable it after resume.
 * Enter into test power down mode when there is no sata disk
 detected on the port and 'AHCI_IMX_PHY_POWER_DOWN_MODE' is
 enabled.

This patch is based on for-next branch of
"http://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git"


[v4] ahci: imx: setup power saving methods
---
 drivers/ata/ahci.h          |    2 +
 drivers/ata/ahci_imx.c      |  101 ++++++++++++++++++++++++++++++++++++++++++-
 drivers/ata/ahci_platform.c |    3 +-
 drivers/ata/libahci.c       |    4 +-
 4 files changed, 106 insertions(+), 4 deletions(-)
