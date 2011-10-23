From: Chris Dunlop <chris@onthe.net.au>
Subject: [PATCH] sata_sis.c: trivial spelling fix
Date: Mon, 24 Oct 2011 10:38:18 +1100
Message-ID: <20111019053337.GA30312@onthe.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.onthe.net.au ([203.22.196.249]:36060 "EHLO
	smtp1.onthe.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751987Ab1JWXpJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 23 Oct 2011 19:45:09 -0400
Received: from localhost (localhost [127.0.0.1])
	by smtp1.onthe.net.au (Postfix) with ESMTP id 619E360FAA
	for <linux-ide@vger.kernel.org>; Mon, 24 Oct 2011 10:39:04 +1100 (EST)
Received: from smtp1.onthe.net.au ([127.0.0.1])
	by localhost (smtp1.onthe.net.au [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Nk7eoS9UJ+cy for <linux-ide@vger.kernel.org>;
	Mon, 24 Oct 2011 10:39:03 +1100 (EST)
Received: from o1.office.otn.net.au (unknown [180.148.179.26])
	by smtp1.onthe.net.au (Postfix) with ESMTP id C763460DB6
	for <linux-ide@vger.kernel.org>; Mon, 24 Oct 2011 10:39:03 +1100 (EST)
Received: from achates.office.onthe.net.au (achates.office.onthe.net.au [10.1.32.53])
	by o1.office.otn.net.au (Postfix) with ESMTP id A96B87A636
	for <linux-ide@vger.kernel.org>; Mon, 24 Oct 2011 10:39:03 +1100 (EST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Trivial spelling fix.

Signed-off-by: Chris Dunlop <chris@onthe.net.au>

diff --git a/drivers/ata/sata_sis.c b/drivers/ata/sata_sis.c
index 447d9c0..95ec435 100644
--- a/drivers/ata/sata_sis.c
+++ b/drivers/ata/sata_sis.c
@@ -104,7 +104,7 @@ static const struct ata_port_info sis_port_info = {
 };
 
 MODULE_AUTHOR("Uwe Koziolek");
-MODULE_DESCRIPTION("low-level driver for Silicon Integratad Systems SATA controller");
+MODULE_DESCRIPTION("low-level driver for Silicon Integrated Systems SATA controller");
 MODULE_LICENSE("GPL");
 MODULE_DEVICE_TABLE(pci, sis_pci_tbl);
 MODULE_VERSION(DRV_VERSION);
