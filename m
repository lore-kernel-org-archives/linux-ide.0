From: Brian King <brking@us.ibm.com>
Subject: [PATCH 1/1] libata: Convert from module_init to subsys_initcall (resend)
Date: Mon, 13 Nov 2006 16:32:36 -0600
Message-ID: <200611132232.kADMWbFx004476@d01av04.pok.ibm.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e5.ny.us.ibm.com ([32.97.182.145]:37338 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S933086AbWKMWcj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Nov 2006 17:32:39 -0500
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id kADMWcBE018670
	for <linux-ide@vger.kernel.org>; Mon, 13 Nov 2006 17:32:38 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id kADMWcF0303332
	for <linux-ide@vger.kernel.org>; Mon, 13 Nov 2006 17:32:38 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id kADMWbDb004490
	for <linux-ide@vger.kernel.org>; Mon, 13 Nov 2006 17:32:38 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org, jwboyer@linux.vnet.ibm.com, akpm@osdl.org, torvalds@osdl.org, brking@us.ibm.com


When building a monolithic kernel, the load order of drivers
does not work for SAS libata users, resulting in a kernel
oops. Convert libata to use subsys_initcall instead of
module_init, which ensures that libata gets loaded before
any LLDD. This is the same thing that scsi core does
to solve the problem. The load order problem was observed on
ipr SAS adapters and should exist for other SAS users as well.

Signed-off-by: Brian King <brking@us.ibm.com>
---

Jeff,

This is needed for 2.6.19 since without it monolithic kernels
on lots of PPC64 machines oops at boot time.
Please ack/nack as appropriate.

Thanks,

Brian
---

 linux-2.6-bjking1/drivers/ata/libata-core.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/ata/libata-core.c~libata_subsys_init drivers/ata/libata-core.c
--- linux-2.6/drivers/ata/libata-core.c~libata_subsys_init	2006-11-13 15:39:35.000000000 -0600
+++ linux-2.6-bjking1/drivers/ata/libata-core.c	2006-11-13 15:39:35.000000000 -0600
@@ -5957,7 +5957,7 @@ static void __exit ata_exit(void)
 	destroy_workqueue(ata_aux_wq);
 }
 
-module_init(ata_init);
+subsys_initcall(ata_init);
 module_exit(ata_exit);
 
 static unsigned long ratelimit_time;
_
