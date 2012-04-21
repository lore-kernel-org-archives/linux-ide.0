From: Viresh Kumar <viresh.linux@gmail.com>
Subject: [PATCH V2 0/5] ata: pata_arasan and ahci_platform updates
Date: Sat, 21 Apr 2012 17:40:08 +0530
Message-ID: <cover.1335009631.git.viresh.kumar@st.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pz0-f52.google.com ([209.85.210.52]:52398 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751725Ab2DUMKh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 21 Apr 2012 08:10:37 -0400
Received: by dake40 with SMTP id e40so14092262dak.11
        for <linux-ide@vger.kernel.org>; Sat, 21 Apr 2012 05:10:36 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@redhat.com
Cc: spear-devel@list.st.com, viresh.linux@gmail.com, linux-ide@vger.kernel.org, sshtylyov@mvista.com, Viresh Kumar <viresh.kumar@st.com>

Jeff,
 
This patchset contains updates for pata_arasan and ahci_platform drivers.
- First patch was earlier sent alone, just included here.
- Second one was sent earlier to you and following was the discussion there:
  http://patchwork.ozlabs.org/patch/99677/

It is used by SPEAr13xx V1 for which is:
http://comments.gmane.org/gmane.linux.ports.arm.kernel/163042

- Others add DT support for them.

V1->V2:
- Removed covering #ifdef CONFIG_HAVE_CLK, #endifs around clk code in
  ahci_platform.
  
  Patch to create non CONFIG_HAVE_CLK clk_*() routines is already floated with
  following subject line:
  clk: Add non CONFIG_HAVE_CLK routines

Viresh Kumar (5):
  ata/pata_arasan_cf: Move arasan_cf_pm_ops out of #ifdef, #endif
    macros
  ata: pata_arasan: Add clk_{un}prepare() support
  ata: pata_arasan: add Device Tree probing capability
  ata: ahci_platform: Add synopsys ahci controller in DT's compatible
    list
  ata/ahci_platform: Add clock framework support

 .../ata/{calxeda-sata.txt => ahci-platform.txt}    |    5 +-
 .../devicetree/bindings/ata/pata-arasan.txt        |   17 ++++++
 drivers/ata/ahci.h                                 |    2 +
 drivers/ata/ahci_platform.c                        |   56 +++++++++++++++++---
 drivers/ata/pata_arasan_cf.c                       |   16 ++++--
 5 files changed, 82 insertions(+), 14 deletions(-)
 rename Documentation/devicetree/bindings/ata/{calxeda-sata.txt => ahci-platform.txt} (90%)
 create mode 100644 Documentation/devicetree/bindings/ata/pata-arasan.txt

-- 
1.7.9

