From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: PATA drivers queued for 2.6.19
Date: Tue, 05 Sep 2006 17:46:37 +0400
Message-ID: <44FD7FBD.2060309@ru.mvista.com>
References: <44FC0779.9030405@garzik.org>	<1157371363.30801.31.camel@localhost.localdomain> <17661.31750.457301.687508@smtp.charter.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965071AbWIENob@vger.kernel.org>
In-Reply-To: <17661.31750.457301.687508@smtp.charter.net>
Sender: linux-kernel-owner@vger.kernel.org
To: John Stoffel <john@stoffel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
List-Id: linux-ide@vger.kernel.org

John Stoffel wrote:
>>>>>>"Alan" == Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
> 
> 
> Alan> Ar Llu, 2006-09-04 am 07:01 -0400, ysgrifennodd Jeff Garzik:
> 
>>>The following must be in all caps, though:
>>>
>>>drivers/ide IS STILL THE PATA DRIVER SET THAT USERS AND DISTROS SHOULD 
>>>CHOOSE.
> 
> 
> Alan> Except optionally for the following for chips not handled by or broken
> Alan> totally in drivers/ide:
> 
> Alan> 	pata_mpiix - some early pentium era laptops
> Alan> 	pata_oldpiix - original "PIIX" chipset
> Alan> 	pata_radisys - embedded chipset
> 
> What about pata_hpt37x and it's failure to work with my HPT302 Rev one
> controller?  I admit it could be just an IRQ problem, but since
> 2.6.18-rc5-mm1 works with the old ide/pci/hpt366.c, but not with the

    Hm, I believe this driver hasn't been updated since 2.617-mm4 (I have one 
patch pending still).

> new version?  It's using the same interrupt each time too.

    What's up with it?
