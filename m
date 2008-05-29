From: Jeff Garzik <jeff@garzik.org>
Subject: Re: RESEND: [PATCH] libata-sff: Fix oops reported in kerneloops.org
 for pnp devices with no ctl
Date: Thu, 29 May 2008 14:13:51 -0400
Message-ID: <483EF25F.7080005@garzik.org>
References: <20080529161453.24735.805.stgit@core> <alpine.LFD.1.10.0805290950230.2958@woody.linux-foundation.org> <483EEBE5.5030708@garzik.org> <alpine.LFD.1.10.0805291102370.2958@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:52853 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756549AbYE2SOB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 29 May 2008 14:14:01 -0400
In-Reply-To: <alpine.LFD.1.10.0805291102370.2958@woody.linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Linus Torvalds wrote:
> 
> On Thu, 29 May 2008, Jeff Garzik wrote:
>>> It may be that you meant to make it an "else if" case, ie if there was no
>>> IO-read, then you do a ndelay(400) as a last desperate case, but that's not
>>> how your ata_sdd_sync() is actually written.
>> The double-ndelay is definitely wrong, but we do need one.  Technically it
>> should -only- be a 400ns delay, but we also have a register read in there to
>> make sure any posted writes are flushed.
> 
> Well, but the "read + delay" is already in ata_sdd_pause(). 

Right, that's what I meant by double-ndelay.


> So it's "ata_sdd_sync()" that I think is bogus. Based on its name alone, 
> it shouldn't have a delay in it (except, as mentioned, possibly for the 
> fallback case where no port can be used for reading).

Agreed,

	Jeff



