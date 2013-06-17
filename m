From: Richard Zhu <richard.zhuhongxing@gmail.com>
Subject: [PATCH V1 0/3] ahci: enable ahci sata support on imx6q
Date: Mon, 17 Jun 2013 17:52:44 +0800
Message-ID: <1371462767-16630-1-git-send-email-r65037@freescale.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33902 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932201Ab3FQJuq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 17 Jun 2013 05:50:46 -0400
Received: by mail-pa0-f49.google.com with SMTP id ld11so2654187pab.8
        for <linux-ide@vger.kernel.org>; Mon, 17 Jun 2013 02:50:45 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: shawn.guo@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, jgarzik@pobox.com, linux-ide@vger.kernel.org

v1: add imx6q specific ahci sata support to arch/arm/mach-imx/mach-imx6q.c

These patches is based on imx/dt branch of
"http://git.linaro.org/git-ro/people/shawnguo/linux-2.6.git"

[v1 1/3] ARM: dtsi: enable ahci sata on imx6q platforms
[v1 2/3] ata: ahci_platform: enable imx6q ahci sata support
[v1 3/3] imx: ahci: enable ahci sata on imx6q platforms
