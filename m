From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [2.6.18,19] SATA boot problems (ICH6/ICH6W)
Date: Wed, 31 Jan 2007 10:24:40 -0500
Message-ID: <45C0B4B8.4000100@pobox.com>
References: <200612111003.39928.kovid@theory.caltech.edu> <4588877D.1000400@gmail.com>	<20061220032941.GA8903@us.ibm.com> <4588B3D5.4030406@gmail.com>	<20061221171035.GC6171@us.ibm.com> <20070130015507.GA30069@us.ibm.com>	<45BEF492.9000000@gmail.com> <20070130233735.GA7483@us.ibm.com>	<45BFE8BC.3000906@pobox.com> <45C076B9.3030106@gmail.com> <20070131122034.5b457c68@localhost.localdomain> <45C096C1.1030905@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:57640 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030191AbXAaPYt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 31 Jan 2007 10:24:49 -0500
In-Reply-To: <45C096C1.1030905@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan <alan@lxorguk.ukuu.org.uk>, Gary Hade <garyhade@us.ibm.com>, Kovid Goyal <kovid@theory.caltech.edu>, linux-ide@vger.kernel.org, lcm@us.ibm.com, konradr@us.ibm.com

Tejun Heo wrote:
> Alan wrote:
>>> Some SATA controllers use 0xff to indicate empty port.  This seldomly
>>> matters as we have the almighty SStatus register to check device
>>> presence (there is a bug regarding this, patch pending).
>>>
>>> This GoVault drive fails because ata_piix doesn't have SCR while using
>>> 0xff to indicate port not ready (dunno exact which state causes 0xff
>>> status tho) while the GoVault drive fails to clear that state in 150ms
>>> (not 30s).  The libata sees 0xff after SRST if GoVault drive is attached
>> So we can also cut this down by only doing the extra polling on a device
>> which is SATA and lacks SCR ?
> 
> That's true but the offending one is ata_piix, so the cutting down is
> not as effective.  If we can live with the extra two secs per empty port
> for some of ata_piix for the time being (maybe two or three releases),
> the delay can be added now.  One more thing to consider is GoVault is
> the only known device to show this behavior till now.
> 
> Hmm... What do you (Alan and Jeff) think?

That last factor weighs on my mind.

While I don't mind making changes for this device, and taking into 
consideration Alan's recent comments that some ATAPI workarounds are 
still yet to appear for libata, I still dislike making changes for one 
specific device with non-standard behavior.

	Jeff



