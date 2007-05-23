From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: don't consider 0xff as port empty if SStatus is available
Date: Wed, 23 May 2007 11:22:15 +0200
Message-ID: <465407C7.9020707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.230]:36647 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756223AbXEWJWZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 May 2007 05:22:25 -0400
Received: by nz-out-0506.google.com with SMTP id o37so157183nzf
        for <linux-ide@vger.kernel.org>; Wed, 23 May 2007 02:22:25 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>
Cc: Paul Mundt <lethal@linux-sh.org>, Indan Zupancic <indan@nul.nu>

Some SATA controllers (sata_sil) use 0xff to indicate port not ready
status, not port empty.  As libata interprets 0xff as port empty, this
causes unnecessary reset failure and retry.  Don't consider 0xff as
port empty if SStatus is available and indicates that port is online.

Signed-off-by: tejun Heo <htejun@gmail.com>
Cc: Paul Mundt <lethal@linux-sh.org>
Cc: Indan Zupancic <indan@nul.nu>
---

This one is for 2.6.22.  Thanks.

 libata-core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index a6de57e..5788a9d 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3022,7 +3022,7 @@ int ata_wait_ready(struct ata_port *ap,
 
 		if (!(status & ATA_BUSY))
 			return 0;
-		if (status == 0xff)
+		if (!ata_port_online(ap) && status == 0xff)
 			return -ENODEV;
 		if (time_after(now, deadline))
 			return -EBUSY;
