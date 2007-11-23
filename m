From: "Morrison, Tom" <tmorrison@empirix.com>
Subject: RE: [PATCH] sata_nv: fix ADMA ATAPI issues with memory over 4GB (v3)
Date: Fri, 23 Nov 2007 12:30:42 -0500
Message-ID: <BD261180E6D35F4D9D32F3E44FD3D901053E8542@EMPBEDEX.empirix.com>
References: <47463534.9010100@shaw.ca> <4746F02D.2060204@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from empbedex1.empirix.com ([12.38.203.54]:14369 "EHLO
	empbedex1.empirix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752877AbXKWRfD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Nov 2007 12:35:03 -0500
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>, Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, ide <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>

I am hopeful that the sata_mv has this bug (I proved that the
problem I was experiencing was due to the sata_mv driver 
with 3.75Gig or more of memory)...
 
I am on vacation for a week or more ...or I'd tell you today
if it did have this bug!

________________________________

From: linux-ide-owner@vger.kernel.org on behalf of Mark Lord
Sent: Fri 11/23/2007 10:22 AM
To: Robert Hancock
Cc: linux-kernel; ide; Jeff Garzik; Tejun Heo
Subject: Re: [PATCH] sata_nv: fix ADMA ATAPI issues with memory over 4GB (v3)



Robert Hancock wrote:
> This fixes some problems with ATAPI devices on nForce4 controllers in ADMA mode
> on systems with memory located above 4GB. We need to delay setting the 64-bit
> DMA mask until the PRD table and padding buffer are allocated so that they don't
> get allocated above 4GB and break legacy mode (which is needed for ATAPI
> devices).
...

Mmm.. I wonder how many other libata drivers have this exact same bug,
whether noticed yet or not ?

Cheers
-
To unsubscribe from this list: send the line "unsubscribe linux-ide" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html


