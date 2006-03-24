From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 5/5] libata: add @disable_on_err argument to
	ata_set_mode()
Date: Fri, 24 Mar 2006 15:51:33 +0000
Message-ID: <1143215493.18986.11.camel@localhost.localdomain>
References: <11431815313764-git-send-email-htejun@gmail.com>
	 <44240A67.7030001@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:22975 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751094AbWCXPpv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 24 Mar 2006 10:45:51 -0500
In-Reply-To: <44240A67.7030001@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <htejun@gmail.com>, albertcc@tw.ibm.com, linux-ide@vger.kernel.org

On Gwe, 2006-03-24 at 10:04 -0500, Jeff Garzik wrote:
> * set features - xfer mode fails

We should retry here btw but don't

> * we offline failed device
> * we talk to another device on the same bus
> * now the PATA cable is possibly spewing something the failed device 
> won't like

The only thing that will matter is address setup timings. Since we
compute the acceptable modes and set modes according to the pair of
drives if present I would expect the disabling to risk us setting a
wrong mode. A deferred disable would behave better perhaps

> Another scenario:  some of the drivers/ide hardware supported only by 
> the 'generic' driver.  Some of the hardware, we can do what the device 
> is already programmed to do, and that's it.  It might be in DMA mode, in 
> which case we can DMA.  But we can't [re]tune it at all.

All handled by the PATA patches which don't use the usual mode compute
path at all but their own setup function replacement.

> Thus if set features - xfer mode fails, we can do the easy thing -- stop 
> talking to the port completely -- or the hard thing, recovery.  Recovery 
> should involve attempting to see if the device, which by definition 
> responded to IDENTIFY DEVICE successfully, will once again respond to 
> IDENTIFY DEVICE. 

We don't care what mode the other device is in, we just care that any
shared timing address setup is the slower of the pair on the cable. We
could just assume its in PIO_0 for timing purposes then offline it after
timing set up.

