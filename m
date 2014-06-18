From: Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH 0/2] add ahci_platform_get_of_property
Date: Wed, 18 Jun 2014 12:54:07 +0800
Message-ID: <1403067249-8021-1-git-send-email-zhangfei.gao@linaro.org>
References: <xuwei5@hisilicon.com, kefeng.wang@linaro.org,>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:57767 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756586AbaFREyT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Jun 2014 00:54:19 -0400
Received: by mail-pd0-f176.google.com with SMTP id ft15so289723pdb.21
        for <linux-ide@vger.kernel.org>; Tue, 17 Jun 2014 21:54:18 -0700 (PDT)
In-Reply-To: <xuwei5@hisilicon.com, kefeng.wang@linaro.org,>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org, hdegoede@redhat.com, arnd@arndb.de, mark.rutland@arm.com
Cc: linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Zhangfei Gao <zhangfei.gao@linaro.org>

Instead of setting hflags in different files,  
ahci_platform_get_of_property set hpriv->flags when ahci_platform_init_host

Any other property required?

Zhangfei Gao (2):
  libahci_platform: add ahci_platform_get_of_property
  ahci: remove AHCI_HFLAG_NO_FBS setting

 .../devicetree/bindings/ata/ahci-platform.txt      |    9 +++++
 drivers/ata/ahci_platform.c                        |    3 --
 drivers/ata/libahci_platform.c                     |   39 ++++++++++++++++++++
 3 files changed, 48 insertions(+), 3 deletions(-)

-- 
1.7.9.5

