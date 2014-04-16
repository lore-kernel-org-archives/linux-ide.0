From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 0/5] imx ahci DT updates + cubox-i eSATA support
Date: Wed, 16 Apr 2014 09:42:27 +0100
Message-ID: <20140416084227.GD24070@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:36117 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751107AbaDPInK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Apr 2014 04:43:10 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-ide@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@freescale.com>, Tejun Heo <tj@kernel.org>

The following series adds several DT properties to the iMX ahci driver,
which are necessary to configure the electrical characteristics of the
SATA interface.

The required electrical characteristics are board dependent, so the
existing solution where the parameters are hard-coded for the first
board(s) which came along is completely rediculous, and cause their
own set of problems: we have to default to these parameters when no
properties are given, and it means we have to use negative properties
to turn stuff off rather than positive properties to enable features.

Yes, I know that the required Documentation/devicetree file is missing,
I couldn't find the existing file to update for this driver with the
new properties. :)

 arch/arm/boot/dts/imx6q-cubox-i.dts |   4 +
 drivers/ata/ahci_imx.c              | 188 ++++++++++++++++++++++++++++++++++--
 2 files changed, 184 insertions(+), 8 deletions(-)

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
