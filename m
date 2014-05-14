From: Kefeng Wang <kefeng.wang@linaro.org>
Subject: [PATCH v7 0/3] ahci: add support for hisilicon sata
Date: Wed, 14 May 2014 14:13:39 +0800
Message-ID: <1400048022-15795-1-git-send-email-kefeng.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tj@kernel.org
Cc: hdegoede@redhat.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, wangkefeng.wang@huawei.com, xuwei5@hisilicon.com, kefeng.wang@linaro.org
List-Id: linux-ide@vger.kernel.org

change in v7:
1) refresh, rebased onto lastest libata/for-3.16, commit: 58eb8cd565a

change in v6:
1) type of host_flags changed from unsigned int to unsigned long,
   fix the building warning and error

channge in v5:
1) drop AHCI_HFLAGS(...) from ahci_xgene.c and do use host_flags
   in ahci_platform_init_host, it's my carelessness

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

 .../devicetree/bindings/ata/ahci-platform.txt      |    1 +
 drivers/ata/ahci.h                                 |    1 +
 drivers/ata/ahci_da850.c                           |    3 ++-
 drivers/ata/ahci_imx.c                             |    3 ++-
 drivers/ata/ahci_mvebu.c                           |    3 ++-
 drivers/ata/ahci_platform.c                        |    9 ++++++++-
 drivers/ata/ahci_st.c                              |    2 +-
 drivers/ata/ahci_sunxi.c                           |    9 ++++++---
 drivers/ata/ahci_xgene.c                           |    7 +++++--
 drivers/ata/libahci.c                              |    5 +++++
 drivers/ata/libahci_platform.c                     |    5 ++++-
 include/linux/ahci_platform.h                      |    1 +
 12 files changed, 38 insertions(+), 11 deletions(-)

-- 
1.7.9.5
