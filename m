From: Valentine Barshak <valentine.barshak@cogentembedded.com>
Subject: [PATCH V2 0/2] sata_rcar: Add Gen2 PHY support and document existing DT bindings
Date: Fri,  8 Nov 2013 00:04:00 +0400
Message-ID: <1383854642-21660-1-git-send-email-valentine.barshak@cogentembedded.com>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Kumar Gala <galak@codeaurora.org>, Tejun Heo <tj@kernel.org>, Vladimir Barinov <vladimir.barinov@cogentembedded.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-ide@vger.kernel.org

This adds SATA R-Car Gen2 PHY support and documents existing DT bindings.
Changes from the previous version:
* Minor whitespace clean-up to make both array terminators "{ },".

Valentine Barshak (2):
  sata_rcar: Add R-Car Gen2 SATA PHY support
  dt: Document sata_rcar bindings

 .../devicetree/bindings/ata/sata_rcar.txt          |  18 ++++
 drivers/ata/sata_rcar.c                            | 118 ++++++++++++++++++---
 2 files changed, 120 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ata/sata_rcar.txt

-- 
1.8.3.1

