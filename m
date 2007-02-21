From: Tejun Heo <htejun@gmail.com>
Subject: Re: [2.6.18,19] SATA boot problems (ICH6/ICH6W)
Date: Wed, 21 Feb 2007 21:40:10 +0900
Message-ID: <45DC3DAA.2080501@gmail.com>
References: <200612111003.39928.kovid@theory.caltech.edu> <4588877D.1000400@gmail.com> <20061220032941.GA8903@us.ibm.com> <4588B3D5.4030406@gmail.com> <20061221171035.GC6171@us.ibm.com> <20070130015507.GA30069@us.ibm.com> <45BEF492.9000000@gmail.com> <20070130233735.GA7483@us.ibm.com> <20070217003454.GA25571@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.182]:62710 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780AbXBUMkT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 21 Feb 2007 07:40:19 -0500
Received: by py-out-1112.google.com with SMTP id a29so1162227pyi
        for <linux-ide@vger.kernel.org>; Wed, 21 Feb 2007 04:40:18 -0800 (PST)
In-Reply-To: <20070217003454.GA25571@us.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gary Hade <garyhade@us.ibm.com>
Cc: Kovid Goyal <kovid@theory.caltech.edu>, linux-ide@vger.kernel.org, lcm@us.ibm.com, Jeff Garzik <jgarzik@pobox.com>, konradr@us.ibm.com

Hello, Gary.

Gary Hade wrote:
> I instrumented the code and found that for the SATA hard drive BSY was set 
> just before the call to ahci_init_port() from ahci_port_start() and clear 
> after the return from ahci_init_port().  For the GoVault BSY was still set 
> after the return from ahci_init_port() and remained set for almost 2 seconds.
> 
> The below patch which gives BSY some extra time to clear repairs the problem.  
> Unlike the extra delay for ata-piix needed by GoVault I believe this delay 
> will only be seen for attached devices that need it.  Please let me know 
> what you think.

Can you post full dmesg without the patch?  And which controller are you
using (lspci -nn please)?  How come it doesn't support CLO?

I don't think the patch is a good idea.  !BSY wait before reset is
supposed to be done in ->prereset() if possible.  ahci skips that step
because waiting for !BSY isn't reliable after hotplug and it often
wastes 30secs for no good reason after an hotplug event.

Even if you need to add that specific shorter wait, the correct place
would be ->prereset() not at the end of ->port_start().

I don't think fixing here and there for GoVault drive is a good idea.
It's not gonna be tested widely and GoValut would end up working on some
controllers while broken on others.  I think recently posted EH
improvements and faster reset patches should help here.  The first reset
will fail timely and all in all the drive should be detected in slightly
over ten secs, which isn't that bad and actually is okay if parallel
probing is implemented.

I dunno.  Maybe the correct thing to do is wait briefly for !BSY in
std_prereset() when SKIP_D2H_BSY is set.  What status value does the
controller report in that state - 0x80 or 0xff?

Thanks.

-- 
tejun
