From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [git patches] libata fixes
Date: Tue, 30 Oct 2007 15:12:06 -0400
Message-ID: <47278206.2080601@garzik.org>
References: <20071030184502.GA27246@havoc.gtf.org> <alpine.LFD.0.999.0710301151000.30120@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:42915 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752636AbXJ3TML (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 30 Oct 2007 15:12:11 -0400
In-Reply-To: <alpine.LFD.0.999.0710301151000.30120@woody.linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mikael Pettersson <mikpe@it.uu.se>, Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Linus Torvalds wrote:
> 
> On Tue, 30 Oct 2007, Jeff Garzik wrote:
>> Mikael Pettersson (2):
>>       sata_promise: ASIC PRD table bug workaround, take 2
>>       sata_promise: cleanups
> 
> You and Mikael need to sort out the way you send/accept patches. 
> 
> Both of these commits had stuff like this:
> 
>     Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>
>     --
>     Changes since previous version:
>     * use new PDC_MAX_PRD constant to initialise sg_tablesize
>     
>      drivers/ata/sata_promise.c |   87 ++++++++++++++++++++++++++++++++++++++++++---
>      1 files changed, 83 insertions(+), 4 deletions(-)
>     Signed-off-by: Jeff Garzik <jeff@garzik.org>
> 
> which seems to be because Mikael uses two dashes instead of three to 
> separate his "real message" from the stuff you have.
> 
> So either you need to teach Mikael to use the proper separators, or you 
> need to edit these things down to be something readable instead of keeping 
> the extraneous commentary around...
> 
> Pulled, but I'm hoping for cleaner commit messages in the future..

Can we change git-am to accept two dashes as well as three?  :)

It seems pretty common, not just with Mikael but several others who send 
patches to me.

	Jeff



