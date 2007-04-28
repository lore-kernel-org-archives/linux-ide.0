From: Jeff Garzik <jeff@garzik.org>
Subject: Re: libata fails to recover from HSM violation involving DRQ status
Date: Sat, 28 Apr 2007 16:37:58 -0400
Message-ID: <4633B0A6.6090705@garzik.org>
References: <4633AB75.7070107@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:54184 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753952AbXD1UiC (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 28 Apr 2007 16:38:02 -0400
In-Reply-To: <4633AB75.7070107@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> Tejun,
> 
> While working on the new hdparm (version 7.0, released today),
> I ran into trouble when a buggy SG_IO/ATA_16 packet caused
> the libata EH to get confused.
> 
> I triggered this by accident, issuing an IDENTIFY command
> which incorrectly specified ATA_PROT_NODATA.  My error, for sure,
> but libata never recovered from the "stuck DRQ bit" that resulted.
> 
> In the IDE driver, we had code to try and cope with stuck DRQ,
> by just looping and reading from the data port a few times.
> That could have been done better, but it worked a lot of the time,
> back in those simpler days.
> 
> I don't know what you try in libata-eh, but perhaps it can be tweaked?
> Below is the 'dmesg' from that system before I hit the big red button.

I am reluctant to do anything about this.

All manner of things can go wrong, if the taskfile protocol specified 
disagrees with the taskfile contents.

At that point you are in undefined territory, since libata will happily 
ARM a DMA controller or otherwise program controller registers in 
preparation for the requested taskfile protocol.  Data corruption, hard 
locks, anything could happen at that point.

Maybe we do need to recover from a stuck DRQ bit, but I'll wait until 
that symptom shows up with a different catalyst.

	Jeff



