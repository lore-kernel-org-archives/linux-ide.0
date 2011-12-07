From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: DMA bug with ata_piix on ICH7-M
Date: Tue, 06 Dec 2011 21:10:25 -0600
Message-ID: <4EDED921.6030207@gmail.com>
References: <1323176998.2687.35.camel@Sparkler>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:45559 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751744Ab1LGDK2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Dec 2011 22:10:28 -0500
Received: by ghbz2 with SMTP id z2so98050ghb.19
        for <linux-ide@vger.kernel.org>; Tue, 06 Dec 2011 19:10:27 -0800 (PST)
In-Reply-To: <1323176998.2687.35.camel@Sparkler>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ben Whitten <benwhitten@gmail.com>
Cc: linux-ide@vger.kernel.org

On 12/06/2011 07:09 AM, Ben Whitten wrote:
> Hi,
> I seem to have found a problem with DMA on a motherboard using an ICH7-M
> chipset, this bug prevents me from installing to the harddrive and I
> have been unable to find a workaround.
> The motherboard is a Unicorn computers ENDAT-2794A motherboard[1]
> When I try to run the Ubuntu 11.10 USB install image which is using
> kernel 3.0 the system jams for a good few minutes at a stage in boot
> then eventually comes up. In the dmesg I see the following;
>
> [  332.656551] ata1.01: configured for UDMA/33
> [  332.656590] ata1: EH complete
> [  332.716560] ata1.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6
> frozen
> [  332.716776] ata1.01: BMDMA stat 0x44
> [  332.716887] ata1.01: failed command: READ DMA
> [  332.717029] ata1.01: cmd c8/00:08:78:03:00/00:00:00:00:00/f0 tag 0
> dma 4096 in
> [  332.717034]          res 50/00:00:7f:03:00/00:00:12:00:00/f0 Emask
> 0x2 (HSM violation)
> [  332.717435] ata1.01: status: { DRDY }
> [  332.717564] ata1: soft resetting link
> [  332.900593] ata1.01: configured for UDMA/33
> [  332.900631] ata1: EH complete
> [  332.949133] ata1.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6
> frozen
> [  332.949344] ata1.01: BMDMA stat 0x44
> [  332.949454] ata1.01: failed command: READ DMA
> [  332.949593] ata1.01: cmd c8/00:08:90:03:00/00:00:00:00:00/f0 tag 0
> dma 4096 in
> [  332.949598]          res 50/00:00:97:03:00/00:00:12:00:00/f0 Emask
> 0x2 (HSM violation)
> [  332.950006] ata1.01: status: { DRDY }
> [  332.950130] ata1: soft resetting link
>
> Prior to this it gets configured for UDMA/133 which I believe is out of
> spec for the ICH7 following information on a previous fixed bug[2]. It
> eventually backs it down to 33, which is probably where the system
> unlocks and can continue to boot.

That speed limitation only applies to PATA ports. The UDMA speed 
selection doesn't really do much or anything with SATA devices. It 
doesn't look like it has any effect on this issue since from the dmesg 
on the Launchpad report, the problems continue after we speed down to 
UDMA33.

>
> I have also tried this with a development snapshot of Ubuntu 12.04 using
> kernel 3.2 with the same result.
> I have attached a screen shot of the IDE BIOS options in case a default
> is wrong or there is a workaround until the bug is fixed. Further system
> information and logs can be found on the generated ubuntu launchpad bug
> report [3].

Is this hardware setup known to be working? Is there a previous kernel 
or other OS that worked?

