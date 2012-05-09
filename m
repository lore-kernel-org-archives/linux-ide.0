From: Viresh Kumar <viresh.kumar@st.com>
Subject: [PATCH V3 0/3] ata: pata_arasan and ahci_platform updates
Date: Wed, 9 May 2012 09:38:58 +0530
Message-ID: <cover.1336536285.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from eu1sys200aog113.obsmtp.com ([207.126.144.135]:48773 "EHLO
	eu1sys200aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751261Ab2EIEJY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 May 2012 00:09:24 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@redhat.com
Cc: linux-ide@vger.kernel.org, sshtylyov@mvista.com, spear-devel@list.st.com, viresh.linux@gmail.com, Viresh Kumar <viresh.kumar@st.com>

Jeff,
 
This patchset contains updates for pata_arasan and ahci_platform drivers. I have
updated it as per earlier discussions for following patchset:
"clk: Add non CONFIG_HAVE_CLK routines"

It is used by SPEAr13xx V1 for which is:
http://comments.gmane.org/gmane.linux.ports.arm.kernel/163042

V2->V3:
- Updated "ata/ahci_platform: Add clock framework support" as per latest patch
  for dummy clk APIs applied by Andrew Morton
- Dropped two patches, already got applied.

V1->V2:
- Removed covering #ifdef CONFIG_HAVE_CLK, #endifs around clk code in
ahci_platform.

Viresh Kumar (3):
  ata: pata_arasan: Add clk_{un}prepare() support
  ata: pata_arasan: add Device Tree probing capability
  ata/ahci_platform: Add clock framework support

 .../devicetree/bindings/ata/pata-arasan.txt        |   17 ++++++
 drivers/ata/ahci.h                                 |    2 +
 drivers/ata/ahci_platform.c                        |   57 +++++++++++++++++---
 drivers/ata/pata_arasan_cf.c                       |   14 ++++-
 4 files changed, 81 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ata/pata-arasan.txt

-- 
1.7.9

