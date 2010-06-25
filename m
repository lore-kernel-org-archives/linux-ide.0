From: Anton Vorontsov <avorontsov@mvista.com>
Subject: [PATCH] ahci_platform: Remove unneeded ahci_driver.probe assignment
Date: Fri, 25 Jun 2010 16:20:53 +0400
Message-ID: <20100625122053.GA14391@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from imap.ru.mvista.com ([213.79.90.228]:2398 "EHLO
	buildserver.ru.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754840Ab0FYMlZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 25 Jun 2010 08:41:25 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: =?utf-8?B?UmVuw6k=?= Bolldorf <xsecute@googlemail.com>, linux-ide@vger.kernel.org

The driver is using platform_driver_probe() during initialization,
so ahci_driver.probe hook is never used.

But it causes the following (harmless, luckily) section mismatch:

  WARNING: vmlinux.o(.data+0x2fb20): Section mismatch in reference
  from the variable ahci_driver to the function .init.text:ahci_probe()

This patch removes the ahci_driver.probe assignment, thus fixes
the warning.

p.s. Note that there's another patch[1] from Rene Bolldorf that
tried to solve the same issue by __refdata annotation. __refdata
says that this reference is actually OK, but in fact it is not OK,
because dereferencing .probe() will cause problems. So the proper
fix is to remove the assignment.

[1] http://kerneltrap.org/mailarchive/linux-kernel/2010/3/18/4549547

Signed-off-by: Anton Vorontsov <avorontsov@mvista.com>
---
 drivers/ata/ahci_platform.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index 5e11b16..8070615 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -166,7 +166,6 @@ static int __devexit ahci_remove(struct platform_device *pdev)
 }
 
 static struct platform_driver ahci_driver = {
-	.probe = ahci_probe,
 	.remove = __devexit_p(ahci_remove),
 	.driver = {
 		.name = "ahci",
-- 
1.7.0.5
