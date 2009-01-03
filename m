From: Mark Lord <liml@rtr.ca>
Subject: Re: marvell sata status?
Date: Sat, 03 Jan 2009 09:46:59 -0500
Message-ID: <495F7A63.9010509@rtr.ca>
References: <20090101051038.GD3386@pimb.org> <alpine.DEB.1.10.0901010444440.427@p34.internal.lan> <495CCE0F.7010002@rtr.ca> <20090101184450.GG3386@pimb.org> <alpine.DEB.1.10.0901011411140.20575@p34.internal.lan> <20090101194302.GH3386@pimb.org> <495E3C92.2070304@rtr.ca> <alpine.DEB.1.10.0901021302560.26159@p34.internal.lan> <495E769B.8000407@rtr.ca> <alpine.DEB.1.10.0901021518150.8210@p34.internal.lan> <495EF1D5.1020106@rtr.ca> <alpine.DEB.1.10.0901030411510.11184@p34.internal.lan> <495F79B4.2050309@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:43649 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751151AbZACOp2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 3 Jan 2009 09:45:28 -0500
In-Reply-To: <495F79B4.2050309@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: Jody Belka <lists-lkml@pimb.org>, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>

Mark Lord wrote:
> Justin Piszcz wrote:
>>
> ..
>> One would think if the controller overwrites bits on the device when 
>> mdadm assembles the raid device it would kick it out of the array for 
>> being unclean or find a lot of mismatches on the array or is that the 
>> wrong idea?
> ..
> 
> No, there's nothing in mdadm that I know of which will detect this.
> You'd basically need to run a job in the background, reading/comparing
> all of the mirrors with each other.
> 
> But even that mightn't work, since the BIOS would have corrupted the
> exact same sector on every drive attached to it, quite possibly with
> the same contents, so the mirror-compare wouldn't see anything different.
> 
> The only way to know for sure is to test it manually,
> by zeroing the entire drive, power/reboot, scan the entire
> drive for non-zero.  Then repeat with a different pattern
> just in case "zero" is what the BIOS wrote.
> 
> Very very messy, at least for the Highpoint RAID cards.
> But we really don't know about what the others do,
> apart from some historical data in the dm code.
..

Oh, and from the existing sata_mv.c driver code:

if (pdev->vendor == PCI_VENDOR_ID_TTI &&
    (pdev->device == 0x2300 || pdev->device == 0x2310))
{
   /*
    * Highpoint RocketRAID PCIe 23xx series cards:
    *
    * Unconfigured drives are treated as "Legacy"
    * by the BIOS, and it overwrites sector 8 with
    * a "Lgcy" metadata block prior to Linux boot.
    *
    * Configured drives (RAID or JBOD) leave sector 8
    * alone, but instead overwrite a high numbered
    * sector for the RAID metadata.  This sector can
    * be determined exactly, by truncating the physical
    * drive capacity to a nice even GB value.
    *
    * RAID metadata is at: (dev->n_sectors & ~0xfffff)
    *
    * Warn the user, lest they think we're just buggy.
    */
   printk(KERN_WARNING DRV_NAME ": Highpoint RocketRAID"
           " BIOS CORRUPTS DATA on all attached drives,"
           " regardless of if/how they are configured."
           " BEWARE!\n");
   printk(KERN_WARNING DRV_NAME ": For data safety, do not"
           " use sectors 8-9 on \"Legacy\" drives,"
           " and avoid the final two gigabytes on"
           " all RocketRAID BIOS initialized drives.\n");
}
