From: kbuild test robot <fengguang.wu@intel.com>
Subject: [tj-libata:for-4.16 14/15]
 drivers/phy/broadcom/phy-brcm-sata.c:534:2-3: Unneeded semicolon
Date: Thu, 18 Jan 2018 01:51:17 +0800
Message-ID: <201801180115.oNi9KawA%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:51679 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753823AbeAQRwN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Wed, 17 Jan 2018 12:52:13 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: kbuild-all@01.org, linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tj/libata.git for-4.16
head:   eb73390ae2413bbd5d56a396dfd79fe57de6b5ae
commit: 3e507769d15e4b14b5a3688d7f5cba516cb4e72d [14/15] phy: brcm-sata: Implement calibrate callback


coccinelle warnings: (new ones prefixed by >>)

>> drivers/phy/broadcom/phy-brcm-sata.c:534:2-3: Unneeded semicolon

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
