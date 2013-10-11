From: Richard Zhu <richard.zhuhongxing@gmail.com>
Subject: [PATCH v3 0/1] ahci: imx: setup power saving methods
Date: Fri, 11 Oct 2013 18:37:10 +0800
Message-ID: <1381487831-30090-1-git-send-email-Hong-Xing.Zhu@freescale.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:46831 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751528Ab3JKKdO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 Oct 2013 06:33:14 -0400
Received: by mail-pa0-f54.google.com with SMTP id kx10so4212863pab.27
        for <linux-ide@vger.kernel.org>; Fri, 11 Oct 2013 03:33:13 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: shawn.guo@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, jgarzik@pobox.com, tj@kernel.org, linux-ide@vger.kernel.org

v3: ahci: imx: setup power saving methods
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


[v3] ahci: imx: setup power saving methods
drivers/ata/ahci_imx.c |  125 +++++++++++++++++++++++++++++++++++++++++++++++-
1 files changed, 123 insertions(+), 2 deletions(-)
