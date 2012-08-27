From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 Resend 0/3] ata: pata_arasan and ahci_platform updates
Date: Mon, 27 Aug 2012 10:37:16 +0530
Message-ID: <cover.1346042344.git.viresh.kumar@linaro.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:33925 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751584Ab2H0FH0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 27 Aug 2012 01:07:26 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@redhat.com
Cc: linux-ide@vger.kernel.org, sshtylyov@mvista.com, spear-devel@list.st.com, viresh.linux@gmail.com, Viresh Kumar <viresh.kumar@linaro.com>

From: Viresh Kumar <viresh.kumar@linaro.com>

Jeff,

This patchset contains updates for pata_arasan and ahci_platform drivers. I=
 have
updated it as per earlier discussions for following patchset:
"clk: Add non CONFIG_HAVE_CLK routines"

It is used by SPEAr13xx V1 for which is:
http://comments.gmane.org/gmane.linux.ports.arm.kernel/163042

V2->V3:
- Updated "ata/ahci_platform: Add clock framework support" as per latest pa=
tch
  for dummy clk APIs applied by Andrew Morton
- Dropped two patches, already got applied.

V1->V2:
- Removed covering #ifdef CONFIG_HAVE_CLK, #endifs around clk code in
ahci_platform.

Viresh Kumar (3):
  ata: pata_arasan: Add clk_{un}prepare() support
  ata: pata_arasan: add Device Tree probing capability
  ata/ahci_platform: Add clock framework support

 .../devicetree/bindings/ata/pata-arasan.txt        | 17 +++++++
 drivers/ata/ahci.h                                 |  2 +
 drivers/ata/ahci_platform.c                        | 57 ++++++++++++++++++=
+---
 drivers/ata/pata_arasan_cf.c                       | 14 +++++-
 4 files changed, 81 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ata/pata-arasan.txt

--=20
1.7.12.rc2.18.g61b472e


