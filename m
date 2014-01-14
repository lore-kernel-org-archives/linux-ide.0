From: Simon Guinot <simon.guinot@sequanux.org>
Subject: [PATCH v3 0/3] Fix SATA disk hotplug for Armada 370/XP SoCs
Date: Tue, 14 Jan 2014 20:04:38 +0100
Message-ID: <1389726281-8731-1-git-send-email-simon.guinot@sequanux.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vm1.sequanux.org ([188.165.36.56]:50412 "EHLO vm1.sequanux.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751367AbaANTFF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 14 Jan 2014 14:05:05 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@redhat.com>, Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Lior Amsalem <alior@marvell.com>, stable@vger.kernel.org

Hello,

This patch series fixes a SATA disk hotplug issue for the Armada 370/XP
SoCs: once a disk is removed from a SATA port, then the re-plug events
are not detected by the sata_mv driver.

As this hotplug issue have been emphasized by 9ae6f740b49f
"arm: mach-mvebu: add support for Armada 370 and Armada XP with DT",
then this patches should be applied to the -stable kernels 3.6 and
onwards.

Changes since v1:
- Introduces a new compatible string for the SATA IP found in Armada
  370/XP SoCs.
- Only fix the LP_PHY_CTL register (0x58) if the compatible string
  "marvell,armada-370-xp-sata" is found in the SATA DT node.
- Update compatible string in DT SATA node for Armada 370/XP SoCs. 

Changes since v2:
- Use compatible string "marvell,armada-370-sata" instead of
  "marvell,armada-370-xp-sata".
- Provide more informations for -stable.

Thanks,

Simon

Lior Amsalem (1):
  ata: sata_mv: fix disk hotplug for Armada 370/XP SoCs

Simon Guinot (2):
  ata: sata_mv: introduce compatible string "marvell,armada-370-sata"
  ARM: mvebu: update the SATA compatible string for Armada 370/XP

 Documentation/devicetree/bindings/ata/marvell.txt |  2 +-
 arch/arm/boot/dts/armada-370-xp.dtsi              |  2 +-
 drivers/ata/sata_mv.c                             | 25 +++++++++++++++++++++++
 3 files changed, 27 insertions(+), 2 deletions(-)

-- 
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Lior Amsalem <alior@marvell.com>
Cc: stable@vger.kernel.org
-- 
1.8.5.2

