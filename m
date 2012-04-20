From: Viresh Kumar <viresh.linux@gmail.com>
Subject: [PATCH 0/5] ata: pata_arasan and ahci_platform updates
Date: Fri, 20 Apr 2012 20:08:18 +0530
Message-ID: <cover.1334932338.git.viresh.kumar@st.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pz0-f52.google.com ([209.85.210.52]:40428 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756767Ab2DTOil (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 Apr 2012 10:38:41 -0400
Received: by dake40 with SMTP id e40so13106310dak.11
        for <linux-ide@vger.kernel.org>; Fri, 20 Apr 2012 07:38:41 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@redhat.com
Cc: spear-devel@list.st.com, viresh.linux@gmail.com, linux-ide@vger.kernel.org, Viresh Kumar <viresh.kumar@st.com>

Hi Jeff,

This patchset contains updates for pata_arasan and ahci_platform drivers.
- First patch was earlier sent alone, just included here.
- Second one was sent earlier to you and following was the discussion there:
  http://patchwork.ozlabs.org/patch/99677/

  It is used by SPEAr13xx for which i would be upstreaming support shortly. Will
  cc you there.

- Others add DT support for them.

Viresh Kumar (5):
  ata/pata_arasan_cf: Move arasan_cf_pm_ops out of #ifdef, #endif
    macros
  ata: pata_arasan: Add clk_{un}prepare() support
  ata: pata_arasan: add Device Tree probing capability
  ata: ahci_platform: Add synopsys ahci controller in DT's compatible
    list
  ata/ahci_platform: Add clock framework support

 .../ata/{calxeda-sata.txt => ahci-platform.txt}    |    5 +-
 .../devicetree/bindings/ata/pata-arasan.txt        |   17 +++++
 drivers/ata/ahci.h                                 |    4 +
 drivers/ata/ahci_platform.c                        |   64 +++++++++++++++++--
 drivers/ata/pata_arasan_cf.c                       |   16 ++++-
 5 files changed, 92 insertions(+), 14 deletions(-)
 rename Documentation/devicetree/bindings/ata/{calxeda-sata.txt => ahci-platform.txt} (90%)
 create mode 100644 Documentation/devicetree/bindings/ata/pata-arasan.txt

-- 
1.7.9

