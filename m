From: Kefeng Wang <kefeng.wang@linaro.org>
Subject: [PATCH v5 0/3] ahci: add support for hisilicon sata
Date: Wed, 23 Apr 2014 20:36:40 +0800
Message-ID: <1398256603-20160-1-git-send-email-kefeng.wang@linaro.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pb0-f51.google.com ([209.85.160.51]:33943 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755573AbaDWMhC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 Apr 2014 08:37:02 -0400
Received: by mail-pb0-f51.google.com with SMTP id uo5so747736pbc.10
        for <linux-ide@vger.kernel.org>; Wed, 23 Apr 2014 05:37:01 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: wangkefeng.wang@huawei.com, kefeng.wang@linaro.org

channge in v5:

1) drop AHCI_HFLAGS(...) from ahci_xgene.c and do use host_flags
   in ahci_platform_init_host, it's my carelessness.

changes in v4:

1) add a dynamic host_flags parameter in ahci_platform_init_host
   to make it more flexible, modify some driver to use new
   way to pass host flags, suggested by Hans

changes in v3:

1) move NO_FBS chunk after YES_FBS, Tejun's suggestion
2) use ata_port_info pointer to avoid struct ata_port_info
   on the stack twice

changes in v2:

1) make code more concise according to Hans's advice

Kefeng Wang (3):
  ata: ahci: append new hflag AHCI_HFLAG_NO_FBS
  libahci_platform: add host_flags parameter in
    ahci_platform_init_host()
  ahci: add support for Hisilicon sata

 .../devicetree/bindings/ata/ahci-platform.txt      |    3 ++-
 drivers/ata/ahci.h                                 |    1 +
 drivers/ata/ahci_da850.c                           |    3 ++-
 drivers/ata/ahci_imx.c                             |    3 ++-
 drivers/ata/ahci_platform.c                        |    8 +++++++-
 drivers/ata/ahci_st.c                              |    2 +-
 drivers/ata/ahci_sunxi.c                           |    9 ++++++---
 drivers/ata/ahci_xgene.c                           |    7 +++++--
 drivers/ata/libahci.c                              |    5 +++++
 drivers/ata/libahci_platform.c                     |    5 ++++-
 include/linux/ahci_platform.h                      |    1 +
 11 files changed, 36 insertions(+), 11 deletions(-)

-- 
1.7.9.5

