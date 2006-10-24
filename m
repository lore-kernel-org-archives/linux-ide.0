From: Brian King <brking@us.ibm.com>
Subject: [PATCH 1/1] libata: Convert from module_init to subsys_initcall
Date: Tue, 24 Oct 2006 09:14:27 -0500
Message-ID: <200610241414.k9OEEUjd009012@d01av04.pok.ibm.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e1.ny.us.ibm.com ([32.97.182.141]:7111 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030213AbWJXOO4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 24 Oct 2006 10:14:56 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id k9OEEtLg008457
	for <linux-ide@vger.kernel.org>; Tue, 24 Oct 2006 10:14:55 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id k9OEEWWc041876
	for <linux-ide@vger.kernel.org>; Tue, 24 Oct 2006 10:14:33 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k9OEEU3j009101
	for <linux-ide@vger.kernel.org>; Tue, 24 Oct 2006 10:14:31 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, brking@us.ibm.com


When building a monolithic kernel, the load order of drivers
does not work for SAS libata users, resulting in driver load
failures. Convert libata to use subsys_initcall instead of
module_init, which ensures that libata gets loaded before
any LLDD. This is the same thing that scsi core does
to solve the problem. The load order problem was observed on
ipr SAS adapters and should exist for other SAS users as well.

Signed-off-by: Brian King <brking@us.ibm.com>
---

 linux-2.6-bjking1/drivers/ata/libata-core.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/ata/libata-core.c~libata_subsys_init drivers/ata/libata-core.c
--- linux-2.6/drivers/ata/libata-core.c~libata_subsys_init	2006-10-23 16:48:15.000000000 -0500
+++ linux-2.6-bjking1/drivers/ata/libata-core.c	2006-10-23 16:48:15.000000000 -0500
@@ -5957,7 +5957,7 @@ static void __exit ata_exit(void)
 	destroy_workqueue(ata_aux_wq);
 }
 
-module_init(ata_init);
+subsys_initcall(ata_init);
 module_exit(ata_exit);
 
 static unsigned long ratelimit_time;
_
