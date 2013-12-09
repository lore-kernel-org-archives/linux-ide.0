From: Richard Zhu <richard.zhuhongxing@gmail.com>
Subject: [discussion] pci: imx: enable pcie msi support
Date: Mon,  9 Dec 2013 17:25:18 +0800
Message-ID: <1386581119-2962-1-git-send-email-richard.zhuhongxing@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pb0-f48.google.com ([209.85.160.48]:49843 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760715Ab3LIJUM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 9 Dec 2013 04:20:12 -0500
Received: by mail-pb0-f48.google.com with SMTP id md12so5046872pbc.21
        for <linux-ide@vger.kernel.org>; Mon, 09 Dec 2013 01:20:12 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: marex@denx.de
Cc: jbe@pengutronix.de, hrhaan@gmail.com, shawn.guo@linaro.org, jgarzik@pobox.com, tj@kernel.org, linux-ide@vger.kernel.org, Richard Zhu <richard.zhuhongxing@gmail.com>

eanble pcie msi support on imx6 platforms
* add check_device api in the msi chip.
* add the quirks into pcie_port struct for the deviation
from standard routines.

Signed-off-by: Richard Zhu <richard.zhuhongxing@gmail.com>
---
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi |    6 +++
 arch/arm/mach-imx/Kconfig              |    1 +
 drivers/pci/host/pci-imx6.c            |   34 +++++++++++++++++-
 drivers/pci/host/pcie-designware.c     |   60 +++++++++++++++++++++++---------
 drivers/pci/host/pcie-designware.h     |    5 +++
 5 files changed, 88 insertions(+), 18 deletions(-)
