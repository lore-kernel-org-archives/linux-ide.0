From: akpm@linux-foundation.org
Subject: [patch 04/25] libata-add-irq_flags-to-struct-pata_platform_info-fix
Date: Fri, 10 Aug 2007 13:59:33 -0700
Message-ID: <200708102059.l7AKxXkS008578@imap1.linux-foundation.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:49629 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756762AbXHJVAT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Aug 2007 17:00:19 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org, alan@lxorguk.ukuu.org.uk, htejun@gmail.com, sonic.adi@gmail.com

From: Andrew Morton <akpm@linux-foundation.org>

Remove unneeded, undesirable cast of void*.

Cc: Jeff Garzik <jeff@garzik.org>
Cc: Sonic Zhang <sonic.adi@gmail.com>
Cc: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/ata/pata_platform.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/ata/pata_platform.c~libata-add-irq_flags-to-struct-pata_platform_info-fix drivers/ata/pata_platform.c
--- a/drivers/ata/pata_platform.c~libata-add-irq_flags-to-struct-pata_platform_info-fix
+++ a/drivers/ata/pata_platform.c
@@ -209,7 +209,7 @@ static int __devinit pata_platform_probe
 
 	ap->ioaddr.altstatus_addr = ap->ioaddr.ctl_addr;
 
-	pp_info = (struct pata_platform_info *)(pdev->dev.platform_data);
+	pp_info = pdev->dev.platform_data;
 	pata_platform_setup_port(&ap->ioaddr, pp_info);
 
 	/* activate */
_
