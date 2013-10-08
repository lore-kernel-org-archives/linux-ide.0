From: Richard Zhu <richard.zhuhongxing@gmail.com>
Subject: [PATCH v2 0/1] ahci: imx: setup power saving methods
Date: Tue,  8 Oct 2013 17:29:21 +0800
Message-ID: <1381224562-2378-1-git-send-email-Hong-Xing.Zhu@freescale.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:61265 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751958Ab3JHJZ3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Oct 2013 05:25:29 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq2so8322074pbb.5
        for <linux-ide@vger.kernel.org>; Tue, 08 Oct 2013 02:25:28 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: shawn.guo@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, jgarzik@pobox.com, tj@kernel.org, linux-ide@vger.kernel.org

v2: ahci: imx: setup power saving methods
 - kernel build option is replaced by the module parameter(ahci-imx.hp) 

v1: http://www.spinics.net/lists/linux-ide/msg46389.html
 * Disable sata phy internal pll reference clock when
 sysetem enter into suspend mode, enable it after resume.
 * Enter into test power down mode when there is no sata disk
 detected on the port and 'AHCI_IMX_PHY_POWER_DOWN_MODE' is
 enabled.

This patche is based on for-next branch of
"http://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git"


[v2] ahci: imx: setup power saving methods
drivers/ata/ahci_imx.c |   85 ++++++++++++++++++++++++++++++++++++++++++++++--
1 files changed, 82 insertions(+), 3 deletions(-)
