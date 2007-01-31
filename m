From: Mark Lord <liml@rtr.ca>
Subject: Re: [2.6.18,19] SATA boot problems (ICH6/ICH6W)
Date: Wed, 31 Jan 2007 10:30:32 -0500
Message-ID: <45C0B618.10004@rtr.ca>
References: <200612111003.39928.kovid@theory.caltech.edu> <4588877D.1000400@gmail.com>	<20061220032941.GA8903@us.ibm.com> <4588B3D5.4030406@gmail.com>	<20061221171035.GC6171@us.ibm.com> <20070130015507.GA30069@us.ibm.com>	<45BEF492.9000000@gmail.com> <20070130233735.GA7483@us.ibm.com>	<45BFE8BC.3000906@pobox.com> <45C076B9.3030106@gmail.com> <20070131122034.5b457c68@localhost.localdomain> <45C096C1.1030905@gmail.com> <45C0B4B8.4000100@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:3734 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750937AbXAaPae (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 31 Jan 2007 10:30:34 -0500
In-Reply-To: <45C0B4B8.4000100@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <htejun@gmail.com>, Alan <alan@lxorguk.ukuu.org.uk>, Gary Hade <garyhade@us.ibm.com>, Kovid Goyal <kovid@theory.caltech.edu>, linux-ide@vger.kernel.org, lcm@us.ibm.com, konradr@us.ibm.com

Jeff Garzik wrote:
> Tejun Heo wrote:
>> Alan wrote:
>>>> Some SATA controllers use 0xff to indicate empty port.  This seldomly
>>>> matters as we have the almighty SStatus register to check device
>>>> presence (there is a bug regarding this, patch pending).
>>>>
>>>> This GoVault drive fails because ata_piix doesn't have SCR while using
>>>> 0xff to indicate port not ready (dunno exact which state causes 0xff
>>>> status tho) while the GoVault drive fails to clear that state in 150ms
>>>> (not 30s).  The libata sees 0xff after SRST if GoVault drive is 
>>>> attached
>>> So we can also cut this down by only doing the extra polling on a device
>>> which is SATA and lacks SCR ?
>>
>> That's true but the offending one is ata_piix, so the cutting down is
>> not as effective.  If we can live with the extra two secs per empty port
..
> While I don't mind making changes for this device, and taking into 
> consideration Alan's recent comments that some ATAPI workarounds are 
> still yet to appear for libata, I still dislike making changes for one 
> specific device with non-standard behavior.

How does drivers/ide manage with this device, or does it?
It would be useful here to patch the PCI ID into drivers/ide
for that PIIX variant, and try it.. just to see what the
behaviour is.

There are other possible ways to avoid a 2-second per-port delay at boot.
Eg. by attempting write+readback on some of the other registers.

It all sounds very messy, but that's the ATA/ATAPI world.

Cheers
