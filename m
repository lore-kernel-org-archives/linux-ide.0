From: "Morrison, Tom" <tmorrison@empirix.com>
Subject: RE: Revisiting - 2.6.23.8 - Hang with sata_mv (7042) + Flat 4Gig (no holes) Memory
Date: Mon, 10 Dec 2007 11:46:49 -0500
Message-ID: <BD261180E6D35F4D9D32F3E44FD3D9010AFB051A@EMPBEDEX.empirix.com>
References: <BD261180E6D35F4D9D32F3E44FD3D901053E84BD@EMPBEDEX.empirix.com> <45ED682A.9040408@garzik.org> <BD261180E6D35F4D9D32F3E44FD3D9010A7E1B45@EMPBEDEX.empirix.com> <4728A816.8020608@garzik.org> <BD261180E6D35F4D9D32F3E44FD3D9010AAE852F@EMPBEDEX.empirix.com> <473B36D7.8000205@rtr.ca> <BD261180E6D35F4D9D32F3E44FD3D9010AAE8585@EMPBEDEX.empirix.com> <473B44CB.6010209@rtr.ca> <BD261180E6D35F4D9D32F3E44FD3D9010AAE89CA@EMPBEDEX.empirix.com> <473B76E0.7010500@rtr.ca> <BD261180E6D35F4D9D32F3E44FD3D9010AAE911D@EMPBEDEX.empirix.com> <473C7625.2040300@rtr.ca> <BD261180E6D35F4D9D32F3E44FD3D9010AB2CFF0@EMPBEDEX.empirix.com> <473CC4B8.4090607@rtr.ca> <BD261180E6D35F4D9D32F3E44FD3D9010AEF6982@EMPBEDEX.empirix.com> <475D6CC3.2080400@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [12.38.203.54] ([12.38.203.54]:18352 "EHLO
	empbedex1.empirix.com" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1751071AbXLJQqo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 10 Dec 2007 11:46:44 -0500
Content-class: urn:content-classes:message
In-Reply-To: <475D6CC3.2080400@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>, hp@syntomax.com

I'll try - it will take me a little while to get back to this - had to
reconfigure my target for a different test...more later~!

Tom


-----Original Message-----
From: Mark Lord [mailto:liml@rtr.ca] 
Sent: Monday, December 10, 2007 11:44 AM
To: Morrison, Tom
Cc: Jeff Garzik; linux-ide@vger.kernel.org; Tejun Heo; hp@syntomax.com
Subject: Re: Revisiting - 2.6.23.8 - Hang with sata_mv (7042) + Flat
4Gig (no holes) Memory

Morrison, Tom wrote:
..
> To re-state the problem....
> 
> Hardware/Configuration:
>    MPC8548E with a 7042 (rev 2 - connected internal via a PEX switch) 
>    2.6.23.8 (using PHYS_64BIT & PTE_64BIT - for 36 bit addressing
>              & MSI is NOT compiled in)
>    Flat 4Gig Memory Map (no holes - 0 - 0x0_FFFF_FFFF defined -
special
>  	                   low reserve memory is also used)
> 
>    Local Bus & PCI Express IOMem mapped to unique space in 
> 		0xC_xxxx_xxxx with extensions to the ioremap routines 
> 		to create the appropriate requested physical address...
> 		This is (and should be) transparent to the requesting 
> 		function that calls ioremap.
> 		
>    2 SATA hard drives connected.
> 
> To recreate:
>    Write a large file (now greater than >310Mbytes) - hangs
>    and soft lockup is detected by kernel - no useful info 
>    in stack trace...
> 
> Of interest:
>    a) Replace sata_mv.c - with the 'old' Marvell's reference 
>       driver and it works perfectly!!
> 
>    b) Also, sata_mv works perfectly in all conditions - if we boot
with 
>       less than the ~3750M from the command line (which I note is
~below
>       where its PEX IOmemory space is located).
..

Tom:  could you please try and follow the recent thread here (linux-ide)
entitled "Bug: get EXT3-fs error Allocating block in system zone".

Somebody there has a similar problem on x86-32 with RAM above 4GB
using a standard AHCI SATA controller.

Jens has posted a couple of debugging patches there to try and isolate
things.
(patches attached here for convenience, though you'll have to
modify/hack
 the first one for sata_mv instead of ahci).

-ml

