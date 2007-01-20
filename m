From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] sata_uli: ignore SIMPLEX
Date: Fri, 19 Jan 2007 23:05:29 -0500
Message-ID: <45B19509.6080606@pobox.com>
References: <20070116055551.GN10987@htj.dyndns.org> <45B15F7E.2080807@pobox.com> <45B18F7F.7000900@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:54995 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965158AbXATEFf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 19 Jan 2007 23:05:35 -0500
In-Reply-To: <45B18F7F.7000900@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> Jeff Garzik wrote:
>> Tejun Heo wrote:
>>> Some uli controllers have stuck SIMPLEX bit which can't be cleared
>>> with ata_pci_clear_simplex(), but the controller is capable of doing
>>> DMAs on both channels simultaneously.  Ignore it.
>>>
>>> Signed-off-by: Tejun Heo <htejun@gmail.com>
>> This is going to be the common case going forward.  Please create an
>> 'ignore simplex bit' flag, and set it in sata_uli
> 
> I'm a little bit hesitant to do that.
> 
> 1. I don't think we're gonna have a lot of drivers which need this.
> Just a few.  We've just found one now.
> 
> 2. I think libata core layer (sff included) is burdened with too much
> already.  Also, now that devres is acked, we can easily transition to
> alloc - init - register model which gives LLDs much more flexibility and
> this kind of stuff can easily be done in init_one()'s.  It just fits there.

We need to correct a false assumption in the core.

The PCI IDE spec specifies the simplex bit, but a /vast majority/ of 
controllers, PATA as well as SATA, hardwire the bit, or program it to a 
value set by BIOS.  As such, most drivers really should /just know/ that 
their hardware need never worry about this odd simplex concept.

	Jeff


