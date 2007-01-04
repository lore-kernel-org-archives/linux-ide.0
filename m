From: "Dan Williams" <dan.j.williams@gmail.com>
Subject: Re: Initial Promise SX4 hw docs opened
Date: Thu, 4 Jan 2007 11:52:39 -0700
Message-ID: <e9c3a7c20701041052u487929c0o2e7c79a5a8355327@mail.gmail.com>
References: <459C61BB.70205@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.243]:4916 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750946AbXADSwk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 4 Jan 2007 13:52:40 -0500
Received: by an-out-0708.google.com with SMTP id b33so256703ana
        for <linux-ide@vger.kernel.org>; Thu, 04 Jan 2007 10:52:40 -0800 (PST)
In-Reply-To: <459C61BB.70205@garzik.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>

On 1/3/07, Jeff Garzik <jeff@garzik.org> wrote:
> The first open hardware docs for the Promise SX4 (sata_sx4) series are
> now available:
> http://gkernel.sourceforge.net/specs/promise/pdc20621-pguide-dimm-1.6.pdf.bz2
> http://gkernel.sourceforge.net/specs/promise/pdc20621-pguide-pll-ata-timing-1.2.pdf.bz2
>
> These are only small, ancillary guides; the main hardware doc should be
> opened soon.
>
> However, I would like to take this opportunity to point hackers looking
> for a project at this hardware.  The Promise SX4 is pretty neat, and it
> needs more attention than I can give, to reach its full potential.
>
> Here's a braindump:
>
> * It's an older chipset/board, probably not actively sold anymore
>
> * ATA programming interface very close to sata_promise (PDC2037x)
>
> * Contains on-board DIMM, to be used for any purpose the driver desires
>
> * Contains on-board RAID5 XOR, also fully programmable
>
> A key problem is that, under Linux, sata_sx4 cannot fully exploit the
> RAID-centric power of this hardware by driving the hardware in "dumb ATA
> mode" as it does.
>
> A better driver would notice when a RAID1 or RAID5 array contains
> multiple components attached to the SX4, and send only a single copy of
> the data to the card (saving PCI bus bandwidth tremendously).
> Similarly, a better driver would take advantage of the RAID5 XOR offload
> capabilities, to offload the entire RAID5 read or write transaction to
> the card.
>
> All this is difficult within either the MD or DM RAID frameworks,
> because optimizing each RAID transaction requires intimate knowledge of
> the hardware.  We have the knowledge...  but I don't have good ideas --
> aside from an SX4-specific RAID 0/1/5/6 driver -- on how to exploit this
> knowledge.
>
Can the XOR engines on the card access host memory or do they only
operate on the card's local memory?  And are there DMA (copy) engines?

> Traditionally the vendor has distributed a SCSI driver that implements
> the necessary RAID stack pieces entirely in the hardware driver itself.
>   That sort of approach definitely works, but is traditionally rejected
> by upstream maintainers because it essentially requires a third (if h/w
> specific) RAID stack.
>
[ brainstorming ]
For the RAID5 case: With the hardware acceleration patches the part of
MD that actually operates on the stripe cache is factored out of
handle_stripe5.  So MD can be used to handle all of the cache state
information and then use a SX4 specific operations routine to handle
the data transfers.  However this assumes that all the members of the
array are behind the SX4 (which is the same assumption the vendor
driver makes so maybe its not so bad).

The part I am lost at it is how do you tell libata and the lldd that
data for a transaction is coming from or headed to device local memory
and not host memory?  It seems there would need to be changes to the
dma api to handle this distinction?

>         Jeff
>

Dan
