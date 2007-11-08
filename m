From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 1/4] libata sata_qstor fix oops on rmmod
Date: Thu, 08 Nov 2007 08:45:43 -0500
Message-ID: <47331307.9000903@rtr.ca>
References: <4731DF06.3050202@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:2064 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756153AbXKHNpo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 8 Nov 2007 08:45:44 -0500
In-Reply-To: <4731DF06.3050202@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> sata_qstor fix oops on rmmod.
> 
> sata_qstor likes to disable the chip on module unload,
> so it provides a libata "host_stop" method to do this.
> But in recent kernels, this routine is now called too late,
> after the PCI mmio resources have already been released.
> Which produces an oops.
> 
> This really needs to be fixed higher up.
> For an interim workaround, we disable this function for now.
> 
> This belongs in 2.6.24.
> 
> Signed-off-by:  Mark Lord <mlord@pobox.com>
> ---
> 
> --- old/drivers/ata/sata_qstor.c    2007-10-12 12:43:44.000000000 -0400
> +++ linux/drivers/ata/sata_qstor.c    2007-11-06 22:32:34.000000000 -0500
> @@ -523,10 +523,20 @@
..

Tejun Heo wrote:
>[PATCH #upstream-fixes] libata: port and host should be stopped before hardware resources are released
..

Once Tejun's fix is applied, this particular sata_qstor patch [1/4]
is no longer necessary and should be dropped.

-ml
