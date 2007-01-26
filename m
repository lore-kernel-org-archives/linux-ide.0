From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: fix ata_eh_suspend() return value
Date: Fri, 26 Jan 2007 20:10:25 +0900
Message-ID: <20070126111025.GH8606@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.226]:32420 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933158AbXAZLKb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 26 Jan 2007 06:10:31 -0500
Received: by nz-out-0506.google.com with SMTP id s1so669108nze
        for <linux-ide@vger.kernel.org>; Fri, 26 Jan 2007 03:10:30 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

ata_eh_suspend() was returning 0 regardless of failure.  This bug has
potential to lose data on suspend.  Fix it.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
Jeff, this one is definitely for 2.6.20.  Thanks.

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index eee3525..52c85af 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1791,7 +1791,7 @@ static int ata_eh_suspend(struct ata_port *ap, struct ata_device **r_failed_dev)
 		*r_failed_dev = dev;
 
 	DPRINTK("EXIT\n");
-	return 0;
+	return rc;
 }
 
 /**
