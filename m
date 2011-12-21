From: David Miller <davem@davemloft.net>
Subject: pata_of_platform.c cannot build on sparc
Date: Wed, 21 Dec 2011 17:38:10 -0500 (EST)
Message-ID: <20111221.173810.971054965060472866.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([198.137.202.13]:56268 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751764Ab1LUWk0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 21 Dec 2011 17:40:26 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: pawel.moll@arm.com
Cc: jgarzik@redhat.com, linux-ide@vger.kernel.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, devicetree-discuss@lists.ozlabs.org


It depends upon CONFIG_OF_IRQ which not all CONFIG_OF platforms support,
in particular sparc does not support CONFIG_OF_PLATFORM because it
precomputes all IRQs at boot time when it scans the device tree so all
of the CONFIG_OF_IRQ infrastructure to probe and resolve IRQs at driver
probe time is wrong and completely unnecessary.

Add the proper dependencies so that pata_of_platform.c doesn't get
built on sparc.

CONFIG_OF_IRQ was severely misdesigned, it should just NOP out on
platforms where the architecture has the final IRQ values already like
sparc does.  But that's not how it was implemented at all, and now
we're starting to have all of these drivers get hard dependencies on
this mechanism and it's datastructures, and the resulting sparc build
failures from time to time.

Jeff, please push something like the following to Linus so that
sparc's allmodconfig builds again.  Thanks.

--------------------
pata_of_platform: Add missing CONFIG_OF_IRQ dependency.

Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 6bdedd7..cf047c4 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -820,7 +820,7 @@ config PATA_PLATFORM
 
 config PATA_OF_PLATFORM
 	tristate "OpenFirmware platform device PATA support"
-	depends on PATA_PLATFORM && OF
+	depends on PATA_PLATFORM && OF && OF_IRQ
 	help
 	  This option enables support for generic directly connected ATA
 	  devices commonly found on embedded systems with OpenFirmware
