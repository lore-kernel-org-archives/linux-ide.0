From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH,v2][1/2] sata-mv: enable HDD led blinking when NCQ is
 active for GenIIe
Date: Sat, 14 Mar 2009 10:53:29 -0400
Message-ID: <49BBC4E9.3080708@rtr.ca>
References: <200903110813.25650.elendil@planet.nl> <49BA59FA.1020205@rtr.ca> <200903131919.09525.elendil@planet.nl> <200903141257.43628.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:38909 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751765AbZCNOxe (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 14 Mar 2009 10:53:34 -0400
In-Reply-To: <200903141257.43628.elendil@planet.nl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
Cc: linux-arm@vger.kernel.org, linux-ide@vger.kernel.org, Saeed Bishara <saeed@marvell.com>, Nicolas Pitre <nico@cam.org>, Lennert Buytenhek <buytenh@wantstofly.org>

Frans Pop wrote:
> I missed the fact that you now call mv_edma_cfg from mv_stop_edma, so the 
> simplification is now indeed possible.
> 
> Tested and everything still works.
> 
>> I have so far not tested the led bahavior when DMA is disabled (not
>> even sure if that's possible for a running system).
> 
> It seems that with libata-based drivers disabling dma is only possible at 
> boot time and not dynamically, so this isn't possible anyway.
> I don't know if access errors could cause the driver to fall back to PIO, 
> but I don't really want to test that :-)
..

Yeah, tricky to see that.  With sata_mv, though, DMA is disabled
for any irregular (non block layer R/W) commands.

So the code path is being exercised, just too quickly to see if
the LED actually blinks much in non-DMA modes.
I think you could test the non-DMA mode with this:

  #!/bin/bash
  i=0
  while ( sleep 0.3 ) ; do hdparm --read-sector $i --direct /dev/sda ; i=$((i + 1)) ; done

That should work.
you could even vary the sleep value to change the observed LED blinking rate.

I'll queue up the patch for 2.6.29 now, but if you could try the above
then that would also be cool.

Thanks

