From: Martin Michlmayr <tbm@cyrius.com>
Subject: [PATCH] Make sure we scan SWARM IDE interface for devices
Date: Thu, 20 Jul 2006 23:04:49 +0200
Message-ID: <20060720210449.GA5447@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sorrow.cyrius.com ([65.19.161.204]:26641 "EHLO
	sorrow.cyrius.com") by vger.kernel.org with ESMTP id S1030306AbWGTVE5
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 20 Jul 2006 17:04:57 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

From: Peter Horton <pdh@colonel-panic.org>

[PATCH] Make sure we scan SWARM IDE interface for devices

Signed-off-by: Peter Horton <pdh@colonel-panic.org>
Signed-off-by: Martin Michlmayr <tbm@cyrius.com>


--- linux.git.orig/drivers/ide/mips/swarm.c	2006-01-23 22:48:58.000000000 +0000
+++ linux.git/drivers/ide/mips/swarm.c	2006-01-24 08:32:45.000000000 +0000
@@ -127,6 +127,7 @@
 	memcpy(hwif->io_ports, hwif->hw.io_ports, sizeof(hwif->io_ports));
 	hwif->irq = hwif->hw.irq;
 
+	probe_hwif_init(hwif);
 	dev_set_drvdata(dev, hwif);
 
 	return 0;


-- 
Martin Michlmayr
http://www.cyrius.com/
