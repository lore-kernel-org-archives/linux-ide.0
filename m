From: Valentine Barshak <valentine.barshak@cogentembedded.com>
Subject: [PATCH 0/2] sata_rcar: Adjust DT bindings and add R-Car Gen2 PHY support (take 2)
Date: Tue, 15 Oct 2013 14:20:05 +0400
Message-ID: <1381832407-22541-1-git-send-email-valentine.barshak@cogentembedded.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-la0-f44.google.com ([209.85.215.44]:65203 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754076Ab3JOKUM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Oct 2013 06:20:12 -0400
Received: by mail-la0-f44.google.com with SMTP id eo20so6797895lab.3
        for <linux-ide@vger.kernel.org>; Tue, 15 Oct 2013 03:20:10 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-sh@vger.kernel.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Vladimir Barinov <vladimir.barinov@cogentembedded.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Tejun Heo <tj@kernel.org>, Mark Rutland <mark.rutland@arm.com>

This modifies and documents R-Car SATA device tree (DT) bindings.
The "sata-<SoC>" format is now used for the "compatible" property.
Also, a platform device id table is introduced for non-DT support.
The device id naming is consistent with the "compatible" DT
property format.

R-Car Gen2 SATA PHY support is added. PHY initialization method
is chosen, based on the device id.

Changes from the previous version:
* Kept old DT bindings for compatibility
* Amended DT bindings documentation

Valentine Barshak (2):
  sata_rcar: Adjust and document device tree bindings
  sata_rcar: Add R-Car Gen2 SATA support

 .../devicetree/bindings/ata/sata_rcar.txt          |  19 ++++
 arch/arm/boot/dts/r8a7779.dtsi                     |   2 +-
 arch/arm/mach-shmobile/clock-r8a7779.c             |   2 +-
 arch/arm/mach-shmobile/setup-r8a7779.c             |   2 +-
 drivers/ata/sata_rcar.c                            | 112 ++++++++++++++++++---
 5 files changed, 118 insertions(+), 19 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ata/sata_rcar.txt

-- 
1.8.3.1

