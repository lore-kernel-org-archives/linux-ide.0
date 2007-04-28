From: Mark Lord <liml@rtr.ca>
Subject: Re: libata fails to recover from HSM violation involving DRQ status
Date: Sat, 28 Apr 2007 17:35:00 -0400
Message-ID: <4633BE04.2030201@rtr.ca>
References: <4633AB75.7070107@rtr.ca>	<4633B0A6.6090705@garzik.org> <20070428222502.26fc9bbc@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:1315 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030814AbXD1VfF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 28 Apr 2007 17:35:05 -0400
In-Reply-To: <20070428222502.26fc9bbc@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Alan Cox wrote:
>> I am reluctant to do anything about this.
> 
> This one does need dealing with. It happens in the real world and the old
> IDE paths for this do get triggered and used now and then (we know this
> because bugs in them were found). All it takes is a device and a
> controller disagreeing about the length of a data transfer to get in a
> mess. In theory resetting the bus should get you out of this, I'm
> suprised we didn't get out that way.
..
> SG_IO and other userspace interfaces can mean we issue a command that
> ends up causing variants of this kind of confusion.

That last one doesn't really worry me -- it has to be deliberately
done by the sysadmin.

But the history of real-world cases are definitely of concern,
especially since it's quite likely a rather simple fix.

I think failed WRITE_DMA requests (IDNF or ECC faults) were one source.

Cheers
