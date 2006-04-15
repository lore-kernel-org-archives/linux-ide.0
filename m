From: Jeff Garzik <jeff@garzik.org>
Subject: Re: ahci: ahci_host_intr() problem(s)?
Date: Sat, 15 Apr 2006 14:47:00 -0400
Message-ID: <44413FA4.8050205@garzik.org>
References: <200604151859.46130.b.jacques@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:52126 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030305AbWDOSrC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 15 Apr 2006 14:47:02 -0400
In-Reply-To: <200604151859.46130.b.jacques@planet.nl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bastiaan Jacques <b.jacques@planet.nl>
Cc: linux-ide@vger.kernel.org

Bastiaan Jacques wrote:
> I was looking at ahci_host_intr() when I noticed something strange: it always 
> returns 1. Now, that alone is odd because when a function is successful it 
> ordinarily returns 0 (zero).
> 
> But more importantly, it is called in ahci_interrupt():
> 
> 			if (!ahci_host_intr(ap, qc))
> 				if (ata_ratelimit())
> 					dev_printk(KERN_WARNING, host_set->dev,
> 					  "unhandled interrupt on port %u\n",
> 					  i);
> 
> So that if-statement is always false; this seems like a logic error to me.

Its dead code at present, yes.


> Back to ahci_host_intr itself. it does:
> 
> 	serr = readl(port_mmio + PORT_SCR_ERR);
> 	writel(serr, port_mmio + PORT_SCR_ERR);
> 
> This looks like first we are reading a value from the port, and then writing 
> the same value back without modification. Why?

Standard write-1s-to-clear register behavior.

	Jeff


