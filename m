From: Dan Aloni <da-x@monatomic.org>
Subject: Re: sata_mv: module reloading doesn't work
Date: Tue, 4 Apr 2006 09:08:28 +0300
Message-ID: <20060404060828.GA11996@localdomain>
References: <20060402155647.GB20270@localdomain> <311601c90604021059jcdf56e4ja35e3507ab291179@mail.gmail.com> <20060403215729.GA17731@localdomain> <4431DE2B.1020306@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from noname.neutralserver.com ([70.84.186.210]:32360 "EHLO
	noname.neutralserver.com") by vger.kernel.org with ESMTP
	id S1751290AbWDDGHC (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Apr 2006 02:07:02 -0400
Content-Disposition: inline
In-Reply-To: <4431DE2B.1020306@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: "Eric D. Mudama" <edmudama@gmail.com>, Linux Kernel List <linux-kernel@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, Mark Lord <lkml@rtr.ca>, IDE/ATA development list <linux-ide@vger.kernel.org>

On Mon, Apr 03, 2006 at 10:47:07PM -0400, Mark Lord wrote:
> Dan Aloni wrote:
> >
> > * Normal boot
> > * insmod sata_mv
> > * all is okay, as expected
> > * rmmod sata_mv
> > * insmod sata_mv 
> > * all is bad, as expected
> > * kexec
> > * insmod sata_mv
> > * all is bad!
> >
> >Conclusion: sata_mv's shutdown does something bad.
> 
> sata_mv seems to just use the default libata shutdown sequence,
> so perhaps it's leaving the device in EDMA mode with interrupt
> coalescing still on (from the BIOS), and interrupts are still
> coming in or something..
> 
> I suppose it really ought to shut down the device before exiting,
> and maybe the default of pci_disable_device() is not enough.. ?

BTW, can you tell what firmware version are you using? I'm 
using rev 9, perhaps it also plays some role in this problem.

-- 
Dan Aloni, Linux specialist
XIV LTD, http://www.xivstorage.com
da-x@monatomic.org, da-x@colinux.org, da-x@gmx.net, dan@xiv.co.il
