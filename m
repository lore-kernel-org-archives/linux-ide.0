From: Olof Johansson <olof@lixom.net>
Subject: [PATCH] pata_of_platform: Move electra-ide support over to new
	framework
Date: Tue, 4 Dec 2007 14:44:32 -0600
Message-ID: <20071204204432.GD8099@lixom.net>
References: <20071204170442.GA10460@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lixom.net ([66.141.50.11]:47127 "EHLO mail.lixom.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751847AbXLDUka (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Dec 2007 15:40:30 -0500
Content-Disposition: inline
In-Reply-To: <20071204170442.GA10460@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, Arnd Bergmann <arnd@arndb.de>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Kumar Gala <galak@kernel.crashing.org>, Jeff Garzik <jeff@garzik.org>

[POWERPC] Move electra-ide support over to new pata_of_platform framework

Move electra-ide glue over to the new pata_of_platform framework, and
add the quirks needed to that driver.


Signed-off-by: Olof Johansson <olof@lixom.net>

---

I'll remove the electra-ide stuff from arch/powerpc/platforms/pasemi
once this hits a common tree, since otherwise I'd be without IDE until
they converge (i.e.  2.6.25 merge window).


-Olof

diff --git a/drivers/ata/pata_of_platform.c b/drivers/ata/pata_of_platform.c
index 4daf118..3e9675a 100644
--- a/drivers/ata/pata_of_platform.c
+++ b/drivers/ata/pata_of_platform.c
@@ -34,11 +34,20 @@ static int __devinit pata_of_platform_probe(struct of_device *ofdev,
 		return -EINVAL;
 	}
 
-	ret = of_address_to_resource(dn, 1, &ctl_res);
-	if (ret) {
-		dev_err(&ofdev->dev, "can't get CTL address from "
-			"device tree\n");
-		return -EINVAL;
+	if (of_device_is_compatible(dn, "electra-ide")) {
+		/* Altstatus is really at offset 0x3f6 from the primary window
+		 * on electra-ide. Adjust ctl_res and io_res accordingly.
+		 */
+		ctl_res = io_res;
+		ctl_res.start = ctl_res.start+0x3f6;
+		io_res.end = ctl_res.start-1;
+	} else {
+		ret = of_address_to_resource(dn, 1, &ctl_res);
+		if (ret) {
+			dev_err(&ofdev->dev, "can't get CTL address from "
+				"device tree\n");
+			return -EINVAL;
+		}
 	}
 
 	ret = of_irq_to_resource(dn, 0, &irq_res);
@@ -76,6 +85,7 @@ static int __devexit pata_of_platform_remove(struct of_device *ofdev)
 
 static struct of_device_id pata_of_platform_match[] = {
 	{ .compatible = "ata-generic", },
+	{ .compatible = "electra-ide", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, pata_of_platform_match);
