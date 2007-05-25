From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: always use polling SETXFER
Date: Fri, 25 May 2007 06:58:12 -0400
Message-ID: <4656C144.2080705@garzik.org>
References: <20070314053338.GA15600@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53856 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753425AbXEYK6R (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 25 May 2007 06:58:17 -0400
In-Reply-To: <20070314053338.GA15600@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Tejun Heo wrote:
> Several people have reported LITE-ON LTR-48246S detection failed
> because SETXFER fails.  It seems the device raises IRQ too early after
> SETXFER.  This is controller independent.  The same problem has been
> reported for different controllers.
> 
> So, now we have pata_via where the controller raises IRQ before it's
> ready after SETXFER and a device which does similar thing.  This patch
> makes libata always execute SETXFER via polling.  As this only happens
> during EH, performance impact is nil.  Setting ATA_TFLAG_POLLING is
> also moved from issue hot path to ata_dev_set_xfermode() - the only
> place where SETXFER can be issued.
> 
> Jeff Garzik suggests that, in the long term, it might be better to
> modify libata HSM implementation such that we're more tolerant of
> erratic ATAPI IRQ behavior - e.g. default to IRQ but falling back to
> polling if the device doesn't seem ready at the point of interrupt.
> Such change might be necessary to support ancient/weird ATAPI devices.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

Since I wrote them up in IRC, I might as well post them here and get it 
archived:

We need to figure out a better polling solution.

For SAS and advanced SATA, polling really has no meaning at all, when 
you consider what polling IDENTIFY DEVICE and polling SET FEATURES are 
trying to solve.  To the advanced hardware, it's all a bunch of packets. 
  An event that appears "late" to the eyes of the PATA world is now 
presented as changing data fields in the packet stream.

We are going to have to deal with the HSM issue underlying the need to 
do SET FEATURES - XFER MODE polling, and ultimately IDENTIFY DEVICE 
polling too.

This is the main reason why I have resisted applying "[PATCH] libata: 
always use polling SETXFER" -- polling implies a model that does not 
exist on SAS/SATA and advanced SATA.  It's only luck that AHCI includes 
a real register to poll.

To illustrate:  Fixing this problem The Right Way(tm) will yield a 
result that would allow ahci.c to operate in an interrupt-driven mode, 
examining the contents of the FIS's returned. Polling status can already 
be replaced by examining the D2H and SDB FIS areas.

And by definition, on AHCI (and sata_sil24, IIRC) the status will not 
change unless a new FIS has arrived.

Polling is still fine on PCI IDE-like controllers (older ones), but 
advanced controllers require us to coalesce the polling bandaid into a 
test for a sequence of events.

We cannot escape the "hard part."  :)

	Jeff



