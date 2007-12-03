From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] sata_mv:  Fix broken Marvell 7042 support.
Date: Mon, 03 Dec 2007 13:14:56 -0500
Message-ID: <475447A0.2010101@rtr.ca>
References: <4751A2DA.6030403@rtr.ca>	<BD261180E6D35F4D9D32F3E44FD3D9010ADF2E30@EMPBEDEX.empirix.com> <20071203154749.6lah7pulw8ow0s84@email.syntomax.com> <47543C58.4040106@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3939 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751458AbXLCSO5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 3 Dec 2007 13:14:57 -0500
In-Reply-To: <47543C58.4040106@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: hp@syntomax.com
Cc: "Morrison, Tom" <tmorrison@empirix.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>

Mark Lord wrote:
> hp@syntomax.com wrote:
>> It doesn't quite work for me, the system locks up without discernible 
>> error messages (Highpoint RocketRaid 2300 PCIe) . The drives come up, 
>> and immediately get hyper active, and I get dumped in an initrd 
>> busybox shell, when I try to tail /dev/sda it hangs, pvscan doesn't 
>> find any physical volumes for LVM, on the upside, I don't get the PCI 
>> ERROR messages anymore :) I'll try and get netconsole to work to get a 
>> proper log.
> ...
> 
> Before this, you were booting from some other device,
> and the sata_mv mostly worked for you there, right ?
> 
> Specifically, you wrote:
>> Now, because the chip on the thing is a Marvell 7042 I figured I just
>> add the PCI ID to the driver. I tried this, and, if I do not boot from
>> the device it does seem to work. I did however get the following errors
>> (a lot):
>>
>> 02:00.0 sata_mv PCI ERROR; PCI IRQ reason=0x00000000
>>
>> I write this from memory, but the numbers are correct, sorry if they do
>> not EXACTLY match.
>>
>> The disk drives do work, but they are dog slow, and when I try to boot
>> my ubuntu 7.10 system with this driver, it hangs during boot, right
>> after it tried to enable my software raid volumes.
>> I have tried both the 'stock' ubuntu kernel 2.6.22-14-generic (I guess
>> that won't mean much) but I also tried vanilla kernel.org 2.6.23.1
> ..
> 
> So at least that much should now be working much better for you.
> 
> I have not actually ever booted from a sata_mv controller yet,
> so maybe there's still something peculiar about libata::sata_mv
> early in the boot stages ?
> 
> I'm using sata_mv as a module here, but I *never* use initrd/initramfs 
> images.
> They just complicate things needlessly once I know my hardware config.
> But it should work.  I'll try booting from a sata_mv drive here
> on your board and see what's up.
..

Okay, I've attempted to boot from the RocketRAID 2300 card
using a known-good boot hard disk.

No such luck.

The BIOS on the Highpoint RR 2300 *corrupts* the GRUB image,
so GRUB won't boot for me there.  I actually have to re-install
GRUB after each attempt so that the drive is usable again
with the onboard Intel (ahci) ports.

So one then wonders exactly what the Highpoint BIOS is overwriting,
and how that might affect your particular configuration..

???

I'll try booting from another (non-Highpoint) 7042 board next.
After I repair GRUB again, that is.

Cheers
