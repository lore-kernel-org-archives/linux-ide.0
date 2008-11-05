From: Phil Sutter <n0-1@freewrt.org>
Subject: Re: [PATCH] pata-rb532-cf: read and write data in 4-byte blocks
Date: Wed, 5 Nov 2008 13:52:47 +0100
Message-ID: <20081105125247.GB14551@nuty>
References: <490E1A63.3040507@ru.mvista.com> <1225718954-8307-1-git-send-email-n0-1@freewrt.org> <490FE535.8080109@garzik.org> <20081104123504.GA14551@nuty> <49118984.7090004@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from orbit.nwl.cc ([81.169.176.177]:34291 "EHLO
	mail.ifyouseekate.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750876AbYKEMvZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Nov 2008 07:51:25 -0500
Content-Disposition: inline
In-Reply-To: <49118984.7090004@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Jeff Garzik <jeff@garzik.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org

Hi,

On Wed, Nov 05, 2008 at 02:54:44PM +0300, Sergei Shtylyov wrote:
> Phil Sutter wrote:
> 
> >Well, Sergei Shtylyov pointed out that the original driver does transfer
> >data at 4-byte blocks, so I changed it accordingly and tested it.
> >Hopefully this will provide a performance gain, though I did not do any
> >performance tests and therefore can't tell if that's really the case.
> >  
> 
>   Might've been worth to put this into separate patch, apart from the 
> fix for the function prototype.

Ok, I will do that.

> >I had interpreted Sergei's response to my BUG_ON() statement for it to
> >be unnecessary, which may be wrong.
> 
>   You misintepreted my response. :-)

Oh well, if only communication was as easy as programming C. :)

> >I don't know if it's possible to
> >connect ATAPI devices to the on board CompactFlash slot, maybe you can
> 
>   I don't think so.

What about those devices for PDAs like GPS mice or UMTS modems? The
platform for dangerous half knowledge talks about "CF I/O". Is this
something completely different?

> >give me some hints on this. OTOH I see that the sector size is hard
> >coded in the original driver to 0x200, so I guess either ATAPI is not
> >possible or at least not with the original driver, right?
> 
>   If ATAPI was indeed possible, BUG() wouldn't have been an option.
>   I've just remembered about the READ/WRITE LONG commands which might 
> cause byte count to not be divisible by 4 (although by default ECC is 
> 4-byte entity and CF 1.4 says that this is the ony option).

Sure, I added it because it's an assumption made on the algorithm to
function correctly and I wasn't sure if that's the case.

So what's the final solution to this? Transfer byte-wise if buflen is
not a multiple of four (I doubt this would provide full ATAPI
compatibility, though I have no idea) or maybe transfer (buflen % 4)
bytes less and return something different than buflen?

I sadly don't have any hardware to test with other than a CF-disk, which
of course is an ATA device.

Thanks, Phil


