From: Jeff Garzik <jeff@garzik.org>
Subject: Re: libata fails to recover from HSM violation involving DRQ status
Date: Sat, 28 Apr 2007 17:38:47 -0400
Message-ID: <4633BEE7.8020005@garzik.org>
References: <4633AB75.7070107@rtr.ca>	<4633B0A6.6090705@garzik.org> <20070428222502.26fc9bbc@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:54627 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030862AbXD1Viw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 28 Apr 2007 17:38:52 -0400
In-Reply-To: <20070428222502.26fc9bbc@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Mark Lord <liml@rtr.ca>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Alan Cox wrote:
>> I am reluctant to do anything about this.
> 
> This one does need dealing with. It happens in the real world and the old
> IDE paths for this do get triggered and used now and then (we know this
> because bugs in them were found). All it takes is a device and a
> controller disagreeing about the length of a data transfer to get in a

How would they disagree (excluding human error)?


> mess. In theory resetting the bus should get you out of this, I'm
> suprised we didn't get out that way.

Indeed.


>> All manner of things can go wrong, if the taskfile protocol specified 
>> disagrees with the taskfile contents.
> 
> True but at the point you are trying to do error recovery and DRQ is
> wedged on its a good idea to pull remaining data out of the fifo. 

It's not really a good idea for SATA.  The "FIFO" often co-emulated by 
the SATA controller and SATA phy.  You just want to kick SATA really 
hard (i.e. bus reset and friends).

	Jeff



