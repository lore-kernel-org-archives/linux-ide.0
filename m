From: Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v2 0/2] Add support for MediaTek AHCI SATA
Date: Mon, 7 Aug 2017 17:52:19 +0800
Message-ID: <cover.1502098458.git.ryder.lee@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailgw01.mediatek.com ([210.61.82.183]:55894 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752367AbdHGJwh (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 7 Aug 2017 05:52:37 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Tejun Heo <tj@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Long Cheng <long.cheng@mediatek.com>, Ryder Lee <ryder.lee@mediatek.com>

Hi,

This patch series add support for AHCI compatible SATA controller, and it is
compliant with the ahci 1.3 and sata 3.0 specification. This driver is slightly
different than ahci_platform.c (e.g., reset control, subsystem setting).

changes since v2:
- according to Commit a53e35db70d1 ("reset: Ensure drivers are explicit when requesting reset lines").
  replace devm_reset_control_get_optional() by devm_reset_control_get_optional_exclusive().

changes since v1:
- update binding text: add missing "specifier pairs" descriptions.
- fix kbuild test warning: fix the error handling.

Ryder Lee (2):
  ata: mediatek: add support for MediaTek SATA controller
  dt-bindings: ata: add DT bindings for MediaTek SATA controller

 Documentation/devicetree/bindings/ata/ahci-mtk.txt |  50 ++++++
 drivers/ata/Kconfig                                |  10 ++
 drivers/ata/Makefile                               |   1 +
 drivers/ata/ahci_mtk.c                             | 196 +++++++++++++++++++++
 4 files changed, 257 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ata/ahci-mtk.txt
 create mode 100644 drivers/ata/ahci_mtk.c

-- 
1.9.1

