From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] sata_via: style clean up, no indirect method call in LLD
Date: Fri, 26 Jan 2007 14:57:31 +0900
Message-ID: <20070126055731.GF8606@htj.dyndns.org>
References: <20070125114659.GD8606@htj.dyndns.org> <45B92E07.2040904@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.225]:59515 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030764AbXAZF5h (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 26 Jan 2007 00:57:37 -0500
Received: by wx-out-0506.google.com with SMTP id h31so740736wxd
        for <linux-ide@vger.kernel.org>; Thu, 25 Jan 2007 21:57:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <45B92E07.2040904@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, j.taimr@chello.nl

Call ata_bmdma_irq_clear() directly instead of through
ap->ops->irq_clear() according to libata style guideline.

Signed-off-by: Tejun Heo <htejun@gmail.com>

diff --git a/drivers/ata/sata_via.c b/drivers/ata/sata_via.c
index 55b0123..d3d5c0d 100644
--- a/drivers/ata/sata_via.c
+++ b/drivers/ata/sata_via.c
@@ -211,7 +211,7 @@ static void svia_noop_freeze(struct ata_port *ap)
 	 * certain way.  Leave it alone and just clear pending IRQ.
 	 */
 	ata_chk_status(ap);
-	ap->ops->irq_clear(ap);
+	ata_bmdma_irq_clear(ap);
 }
 
 /**
