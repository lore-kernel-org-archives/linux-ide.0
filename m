From: Mark Lord <liml@rtr.ca>
Subject: Re: sata_mv: trial fix for lost NCQ interrupts
Date: Wed, 14 Jan 2009 17:06:32 -0500
Message-ID: <496E61E8.5010602@rtr.ca>
References: <496D04EB.3060803@rtr.ca> <496E53DD.6040408@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:60307 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755164AbZANWGe (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 14 Jan 2009 17:06:34 -0500
In-Reply-To: <496E53DD.6040408@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Harri Olin <harri.olin@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Brian Rademacher <rad@radfiles.net>, Eamonn Hamilton <EAMONN.HAMILTON@saic.com>

Harri Olin wrote:
..
> I tried the patch and it works as well as it did without the patch. That 
> is to say, timeouts still happen, every couple of minutes on moderate 
..

Yup.  On reflection, that patch has no effect, other than speeding things up.

However, I think I *have* found the actual bug this time.
Try this patch and report back again.

--- linux-2.6.28/drivers/ata/sata_mv.c	2009-01-13 15:57:11.000000000 -0500
+++ linux/drivers/ata/sata_mv.c	2009-01-14 16:56:38.000000000 -0500
@@ -883,7 +883,7 @@
 		struct mv_host_priv *hpriv = ap->host->private_data;
 		int hardport = mv_hardport_from_port(ap->port_no);
 		void __iomem *hc_mmio = mv_hc_base_from_port(
-					mv_host_base(ap->host), hardport);
+					mv_host_base(ap->host), ap->port_no);
 		u32 hc_irq_cause, ipending;
 
 		/* clear EDMA event indicators, if any */
