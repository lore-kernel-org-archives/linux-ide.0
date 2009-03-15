From: Frans Pop <elendil@planet.nl>
Subject: Re: [PATCH,v2][1/2] sata-mv: enable HDD led blinking when NCQ is active for GenIIe
Date: Sun, 15 Mar 2009 11:18:49 +0100
Message-ID: <200903151118.51056.elendil@planet.nl>
References: <200903110813.25650.elendil@planet.nl> <200903141257.43628.elendil@planet.nl> <49BBC4E9.3080708@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from Cpsmtpm-eml106.kpnxchange.com ([195.121.3.10]:55762 "EHLO
	CPSMTPM-EML106.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752872AbZCOKSy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 15 Mar 2009 06:18:54 -0400
In-Reply-To: <49BBC4E9.3080708@rtr.ca>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: linux-arm@vger.kernel.org, linux-ide@vger.kernel.org, Saeed Bishara <saeed@marvell.com>, Nicolas Pitre <nico@cam.org>, Lennert Buytenhek <buytenh@wantstofly.org>

On Saturday 14 March 2009, Mark Lord wrote:
> > It seems that with libata-based drivers disabling dma is only
> > possible at boot time and not dynamically, so this isn't possible
> > anyway. I don't know if access errors could cause the driver to fall
> > back to PIO, but I don't really want to test that :-)
>
> Yeah, tricky to see that.  With sata_mv, though, DMA is disabled
> for any irregular (non block layer R/W) commands.
>
> So the code path is being exercised, just too quickly to see if
> the LED actually blinks much in non-DMA modes.
> I think you could test the non-DMA mode with this:
>
>   #!/bin/bash
>   i=0
>   while ( sleep 0.3 ) ; do hdparm --read-sector $i --direct /dev/sda ;
> i=$((i + 1)) ; done

Tried that. The blinking behavior is the same as with 2.6.25, so blink 
mode does get disabled correctly.

It's funny though that, as you expected, with that particular command you 
don't really get any blinking (varying sleep times don't make any real 
difference), so for this particular case it would actually be better to 
have blink mode enabled (I tested that also) even when not using DMA/NCQ. 
But I suggest not to go there.

> I'll queue up the patch for 2.6.29 now, but if you could try the above
> then that would also be cool.

Somehow I doubt you'll manage that, but .30 would be nice :-)

Cheers,
FJP
