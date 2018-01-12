From: Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH v2 0/2] ata: ahci_brcm: Recover from failures to identify devices
Date: Thu, 11 Jan 2018 17:31:06 -0800
Message-ID: <1515720668-4860-1-git-send-email-f.fainelli@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:42852 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932340AbeALBb1 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 11 Jan 2018 20:31:27 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bcm-kernel-feedback-list@broadcom.com
Cc: Florian Fainelli <f.fainelli@gmail.com>, Tejun Heo <tj@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Heiko Stuebner <heiko@sntech.de>, Srinath Mannam <srinath.mannam@broadcom.com>, Krzysztof Kozlowski <krzk@kernel.org>, Vivek Gautam <vivek.gautam@codeaurora.org>, Dan Carpenter <dan.carpenter@oracle.com>, "open list:LIBATA SUBSYSTEM Serial and
        Parallel ATA drivers" <linux-ide@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

Hi Tejun, Kishon,

This patch series implement a recovery mechanism to work around a HW bug
on Broadcom AHCI SATA controller subject to noise triggering a failure to
identify hard drives.

I would like to make this this is okay with you as an approach on how to solve
this.

This should likely go through Tejun's tree to make sure the SATA controller
and PHY changes are bundled together.

Thanks!

Changes in v2:

- avoid introducing an unnecessary port_recovery callback and instead
  override read_id directly

Florian Fainelli (2):
  phy: brcm-sata: Implement calibrate callback
  ata: ahci_brcm: Recover from failures to identify devices

 drivers/ata/ahci_brcm.c              | 95 +++++++++++++++++++++++++++++++++---
 drivers/phy/broadcom/phy-brcm-sata.c | 32 ++++++++++++
 2 files changed, 119 insertions(+), 8 deletions(-)

-- 
2.7.4

