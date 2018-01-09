From: Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 0/3] ata: ahci_brcm: Recover from failures to identify devices
Date: Tue,  9 Jan 2018 15:04:54 -0800
Message-ID: <1515539097-26742-1-git-send-email-f.fainelli@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:46841 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752504AbeAIXF3 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 9 Jan 2018 18:05:29 -0500
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

Thanks!

Florian Fainelli (3):
  ata: Allow having a port recovery callback
  phy: brcm-sata: Implementation calibrate callback
  ata: ahci_brcm: Recover from failures to identify devices

 drivers/ata/ahci_brcm.c              | 83 ++++++++++++++++++++++++++++++++----
 drivers/ata/libata-core.c            |  2 +
 drivers/phy/broadcom/phy-brcm-sata.c | 32 ++++++++++++++
 include/linux/libata.h               |  1 +
 4 files changed, 110 insertions(+), 8 deletions(-)

-- 
2.7.4

