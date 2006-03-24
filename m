From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 5/5] libata: add @disable_on_err argument to ata_set_mode()
Date: Fri, 24 Mar 2006 10:04:07 -0500
Message-ID: <44240A67.7030001@pobox.com>
References: <11431815313764-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:36074 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750742AbWCXPEO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 24 Mar 2006 10:04:14 -0500
In-Reply-To: <11431815313764-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: albertcc@tw.ibm.com, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Tejun Heo wrote:
> ata_set_mode() used to disable whole port on failure.  This patch adds
> @disable_on_err which makes ata_set_mode() disable failing devices
> when non-zero, and simply return when zero.  Due to the port-wide
> characteristic of ATA xfer mode configuration, ata_mode_set() is the
> final place to determine device offlining; thus, the @disable_on_err
> mechanism to tell it which action to take on failure.
> 
> Now port is disabled only if all devices on the port is disabled.
> This behavior change is intentional.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

What about this scenario:

* set features - xfer mode fails
* we offline failed device
* we talk to another device on the same bus
* now the PATA cable is possibly spewing something the failed device 
won't like

Another scenario:  some of the drivers/ide hardware supported only by 
the 'generic' driver.  Some of the hardware, we can do what the device 
is already programmed to do, and that's it.  It might be in DMA mode, in 
which case we can DMA.  But we can't [re]tune it at all.

Thus if set features - xfer mode fails, we can do the easy thing -- stop 
talking to the port completely -- or the hard thing, recovery.  Recovery 
should involve attempting to see if the device, which by definition 
responded to IDENTIFY DEVICE successfully, will once again respond to 
IDENTIFY DEVICE.  That will tell us what mode the drive is in, tell us 
if its responding, and allow us to decide how safe it is to program the 
OTHER device at a higher speed.

	Jeff


