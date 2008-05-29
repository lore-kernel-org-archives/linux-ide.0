From: Holger Macht <hmacht@suse.de>
Subject: Re: [PATCH] libata: Handle bay devices in dock stations
Date: Thu, 29 May 2008 16:14:21 +0200
Message-ID: <20080529141421.GC9268@homac.suse.de>
References: <20080528143857.GB5585@homac.suse.de> <20080529132253.GA22309@srcf.ucam.org> <483EB33D.6010101@gmail.com> <20080529140213.GA23373@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.suse.de ([195.135.220.2]:34527 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751183AbYE2OL0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 29 May 2008 10:11:26 -0400
Content-Disposition: inline
In-Reply-To: <20080529140213.GA23373@srcf.ucam.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Tejun Heo <htejun@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, linux-acpi@vger.kernel.org, akpm@linux-foundation.org

On Thu 29. May - 15:02:13, Matthew Garrett wrote:
> On Thu, May 29, 2008 at 10:44:29PM +0900, Tejun Heo wrote:
> > Does this fix the problem?
> 
> No, I'm seeing an identical hang. Mainline works fine.

Maybe you could also try this on top of Tejun's patch?

--- linux-2.6/drivers/ata/libata-acpi.c.orig	2008-05-29 16:13:00.000000000 +0200
+++ linux-2.6/drivers/ata/libata-acpi.c	2008-05-29 16:13:04.000000000 +0200
@@ -237,10 +237,8 @@
 
 	spin_unlock_irqrestore(ap->lock, flags);
 
-	if (wait) {
+	if (wait)
 		ata_port_wait_eh(ap);
-		ata_acpi_eject_device(handle);
-	}
 
 	if (kobj && !is_dock_event) {
 		sprintf(event_string, "BAY_EVENT=%d", event);

