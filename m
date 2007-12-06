From: "Morrison, Tom" <tmorrison@empirix.com>
Subject: Revisiting - 2.6.23.8 - Hang with sata_mv (7042) + Flat 4Gig (no holes) Memory
Date: Thu, 6 Dec 2007 08:57:36 -0500
Message-ID: <BD261180E6D35F4D9D32F3E44FD3D9010AEF6982@EMPBEDEX.empirix.com>
References: <BD261180E6D35F4D9D32F3E44FD3D901053E84BD@EMPBEDEX.empirix.com> <45ED682A.9040408@garzik.org> <BD261180E6D35F4D9D32F3E44FD3D9010A7E1B45@EMPBEDEX.empirix.com> <4728A816.8020608@garzik.org> <BD261180E6D35F4D9D32F3E44FD3D9010AAE852F@EMPBEDEX.empirix.com> <473B36D7.8000205@rtr.ca> <BD261180E6D35F4D9D32F3E44FD3D9010AAE8585@EMPBEDEX.empirix.com> <473B44CB.6010209@rtr.ca> <BD261180E6D35F4D9D32F3E44FD3D9010AAE89CA@EMPBEDEX.empirix.com> <473B76E0.7010500@rtr.ca> <BD261180E6D35F4D9D32F3E44FD3D9010AAE911D@EMPBEDEX.empirix.com> <473C7625.2040300@rtr.ca> <BD261180E6D35F4D9D32F3E44FD3D9010AB2CFF0@EMPBEDEX.empirix.com> <473CC4B8.4090607@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from empbedex1.empirix.com ([12.38.203.54]:33186 "EHLO
	empbedex1.empirix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751629AbXLFN5n convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Dec 2007 08:57:43 -0500
Content-class: urn:content-classes:message
In-Reply-To: <473CC4B8.4090607@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>, hp@syntomax.com

Well, I thought my problems were solved with the latest set of
patches - and it definitely improved the behavior - but I have 
found out that it just delayed the problem - and I still get a 
soft lockup (no good info in the soft lockup trace) creating 
large (>300Meg) when using the sata_mv/7042 driver in 2.6.23.8

I am very embarrassed that I didn't do more testing before 
declaring victory...humbly apologies to all...

To re-state the problem....

Hardware/Configuration:
   MPC8548E with a 7042 (rev 2 - connected internal via a PEX switch) 
   2.6.23.8 (using PHYS_64BIT & PTE_64BIT - for 36 bit addressing
             & MSI is NOT compiled in)
   Flat 4Gig Memory Map (no holes - 0 - 0x0_FFFF_FFFF defined - special
 	                   low reserve memory is also used)

   Local Bus & PCI Express IOMem mapped to unique space in 
		0xC_xxxx_xxxx with extensions to the ioremap routines 
		to create the appropriate requested physical address...
		This is (and should be) transparent to the requesting 
		function that calls ioremap.
		
   2 SATA hard drives connected.

To recreate:
   Write a large file (now greater than >310Mbytes) - hangs
   and soft lockup is detected by kernel - no useful info 
   in stack trace...

Of interest:
   a) Replace sata_mv.c - with the 'old' Marvell's reference 
      driver and it works perfectly!!

   b) Also, sata_mv works perfectly in all conditions - if we boot with 
      less than the ~3750M from the command line (which I note is ~below

      where its PEX IOmemory space is located).


My thoughts (besides @#$@#$@#$#@#$@#)

	In the old Marvell reference driver - we had to modify 
	the EDMA setup to configure the dma_high request/response 
	addresses to point to the proper (0xC_xxxx_xxxx) location.
	No other modifications were required - so it's a little 
	confusing what is going on here.

	It is obvious from #b above that this has something to 
	do with accessing/reading/writing data to/from this chip,
	and when this happens - it scribbles on important internal
	information and/or gets into a confused state where it 
	just locks up...

Again, sorry for my inadequate testing reports before...and I look
forward
to anyone's input on this!

Sincerely,


Tom Morrison
Principal S/W Engineer
Empirix, Inc (www.empirix.com)
tmorrison@empirix.com
(781) 266 - 3567
 




