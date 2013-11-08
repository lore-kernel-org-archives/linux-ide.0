From: Valentine Barshak <valentine.barshak@cogentembedded.com>
Subject: [PATCH V3 0/2] sata_rcar: Add Gen2 PHY support and document existing DT bindings
Date: Fri,  8 Nov 2013 16:09:28 +0400
Message-ID: <1383912570-8393-1-git-send-email-valentine.barshak@cogentembedded.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:51072 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753126Ab3KHMJf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 Nov 2013 07:09:35 -0500
Received: by mail-la0-f45.google.com with SMTP id el20so1649252lab.4
        for <linux-ide@vger.kernel.org>; Fri, 08 Nov 2013 04:09:33 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-sh@vger.kernel.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Kumar Gala <galak@codeaurora.org>, Tejun Heo <tj@kernel.org>, Vladimir Barinov <vladimir.barinov@cogentembedded.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Mark Rutland <mark.rutland@arm.com>

This adds SATA R-Car Gen2 PHY support and documents existing DT bindings.

Changes in version 2:
* Minor whitespace clean-up to make both array terminators "{ },".

Changes in version 3:
* Used "address" instead of "offset" in DT bindings documentation
* Used "IRQ_TYPE_LEVEL_HIGH" instead of "0x4" in DT bindings documentation

Valentine Barshak (2):
  sata_rcar: Add R-Car Gen2 SATA PHY support
  dt: Document sata_rcar bindings

 .../devicetree/bindings/ata/sata_rcar.txt          |  18 ++++
 drivers/ata/sata_rcar.c                            | 118 ++++++++++++++++++---
 2 files changed, 120 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ata/sata_rcar.txt

-- 
1.8.3.1

