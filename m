From: Jens Axboe <axboe@suse.de>
Subject: Re: PATA handling on ICH5R in 2.6.8rc2
Date: Wed, 4 Aug 2004 19:26:10 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040804172610.GA5978@suse.de>
References: <20040804184504.21dcb386.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:10948 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S267333AbUHDR0v (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 Aug 2004 13:26:51 -0400
Content-Disposition: inline
In-Reply-To: <20040804184504.21dcb386.ak@suse.de>
List-Id: linux-ide@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: jgarzik@pobox.com, B.Zolnierkiewicz@elka.pw.edu.pl, linux-ide@vger.kernel.org, jun.nakajima@intel.com

On Wed, Aug 04 2004, Andi Kleen wrote:
> 
> Hallo,
> 
> I have a machine with a ICH5R southbridge and a PATA DVD hanging off
> it.  When I compile the kernel without CONFIG_BLK_DEV_IDE_SATA then
> the old IDE driver detects the DVD anyways, but refuses to enable DMA
> (because the PCI ID entry is not compiled into piix.c). It doesn't
> even disable -u1 which causes quite some problems when accessing the
> CD ROM: I get endless floods of "too many lost ticks", which means it
> has spent more than 100 jiffies with interrupts off doing something. I
> fixed this with hdparm -u1, but it's still quite slow with DMA off.
> 
> I could enable BLK_DEV_IDE_SATA, but then the old IDE driver would try
> to drive all SATA drives, which would be wrong I guess.
> 
> I presume the right way to fix it would be to always readd the PCI ID
> entry for 82801EB_1 to piix.c, but only let it be handled by the old
> driver when there is a PATA DVD on the controller (and leave the other
> controllers to libata). Still this could get conflicts when there is a
> real SATA device on the same controller (can this happen?) 
> 
> For that the piix.c probe function would just need to do a quick cable
> check and ignore the device when it is SATA and when BLK_DEV_IDE_SATA
> is unset. I looked through the  Intel ICH5 manuals, but it was not
> obvious to me how to probe this non intrusively. I suppose one way
> would be to go through the full IDE driver initialization for the
> drive, and then when SATA is detected bail out again and reset the
> controller and leave it for libata.
> 
> Or drive the DVD always with libata? Does it have an working ATAPI
> driver yet?
> 
> Is there a better solution for this problem? 

Can't you set it to enhanced mode in the bios, then shows up as a
seperate device id and just works. I had the same issue until Jeff
walked me through it :-)

-- 
Jens Axboe

