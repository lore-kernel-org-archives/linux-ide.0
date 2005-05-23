From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: enable-reads-on-plextor-712-sa-on-26115.patch added to -mm tree
Date: Mon, 23 May 2005 19:09:02 -0400
Message-ID: <4292628E.4090209@pobox.com>
References: <200505232245.j4NMjtk4024089@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:8651 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261165AbVEWXJG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 May 2005 19:09:06 -0400
In-Reply-To: <200505232245.j4NMjtk4024089@shell0.pdx.osdl.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org
Cc: andystewart@comcast.net, Linux Kernel <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

akpm@osdl.org wrote:
> The patch titled
> 
>      Enable reads on Plextor 712-SA on 2.6.11.5
> 
> has been added to the -mm tree.  Its filename is
> 
>      enable-reads-on-plextor-712-sa-on-26115.patch
> 
> Patches currently in -mm which might be from andystewart@comcast.net are
> 
> enable-reads-on-plextor-712-sa-on-26115.patch

Andrew -- The use of the word 'hack' didn't trigger any response??

By hardcoding so much of the inquiry data, this patch -overwrites- valid 
inquiry data provided by the device, with generic data.  This patch 
makes generic the probe data that the SCSI layer -depends on to be 
different-.

Effectively you made one CD-ROM device work, killed all the others, and 
enabled an oops generator.

Good show.

Even if this patch worked, you still need to fix the following:

* Patch INQUIRY data -slightly- to fool the SCSI layer into working 
correctly.  This is what Andy's patch [poorly] attempts to address.
* Handling DRQ interrupts (early patch exists)
* Padding DMA data (50% patch exists)
* Fix error handling (patch exists)
* Fix all FIS-based drivers so that an error doesn't cause an oops
* Implement non-polled REQUEST SENSE error handling for FIS-based drivers

