From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 0/8] iMX6 SATA configuration
Date: Tue, 24 Jun 2014 11:19:01 +0100
Message-ID: <20140624101901.GL32514@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-doc-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org
Cc: devicetree@vger.kernel.org, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Randy Dunlap <rdunlap@infradead.org>, Rob Herring <robh+dt@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@freescale.com>
List-Id: linux-ide@vger.kernel.org

Another round of these patches.  I've integrated Shawn's patch to split
the documentation into this series so I can add the DT documentation
on top of it.

 .../devicetree/bindings/ata/ahci-platform.txt      |   6 -
 Documentation/devicetree/bindings/ata/imx-sata.txt |  36 ++++
 arch/arm/boot/dts/imx6q-cubox-i.dts                |   4 +
 drivers/ata/ahci_imx.c                             | 184 ++++++++++++++++++++-
 4 files changed, 216 insertions(+), 14 deletions(-)

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
