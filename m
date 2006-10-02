From: "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: [patch] 2.6.18: Initialize the SWARM IDE driver
Date: Mon, 2 Oct 2006 12:17:14 +0100 (BST)
Message-ID: <Pine.LNX.4.64N.0610021206520.1359@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:29194 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP
	id S1750885AbWJBLRQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 2 Oct 2006 07:17:16 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: B.Zolnierkiewicz@elka.pw.edu.pl
Cc: linux-ide@vger.kernel.org

Hello,

 Sending again to make a formal update.

  Maciej

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>

---------- Forwarded message ----------
Message-ID: <Pine.LNX.4.64N.0609291849570.1573@blysk.ds.pg.gda.pl>
Date: Fri, 29 Sep 2006 18:56:07 +0100 (BST)
From: Maciej W. Rozycki <macro@linux-mips.org>
To: B.Zolnierkiewicz@elka.pw.edu.pl
Cc: linux-ide@vger.kernel.org
Subject: [patch] 2.6.18: Initialize the SWARM IDE driver

Hello,

 The following patch is required for the SWARM GenBus IDE interface to be 
recognized.  Please apply.

  Maciej

patch-mips-2.6.18-20060920-swarm-ide-0
diff -up --recursive --new-file linux-mips-2.6.18-20060920.macro/drivers/ide/mips/swarm.c linux-mips-2.6.18-20060920/drivers/ide/mips/swarm.c
--- linux-mips-2.6.18-20060920.macro/drivers/ide/mips/swarm.c	2005-11-18 05:58:14.000000000 +0000
+++ linux-mips-2.6.18-20060920/drivers/ide/mips/swarm.c	2006-09-28 23:35:42.000000000 +0000
@@ -4,6 +4,7 @@
  *	Author:	Manish Lachwani, mlachwani@mvista.com
  * Copyright (C) 2004  MIPS Technologies, Inc.  All rights reserved.
  *	Author: Maciej W. Rozycki <macro@mips.com>
+ * Copyright (c) 2006  Maciej W. Rozycki
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License
@@ -127,6 +128,7 @@ static int __devinit swarm_ide_probe(str
 	memcpy(hwif->io_ports, hwif->hw.io_ports, sizeof(hwif->io_ports));
 	hwif->irq = hwif->hw.irq;
 
+	probe_hwif_init(hwif);
 	dev_set_drvdata(dev, hwif);
 
 	return 0;
