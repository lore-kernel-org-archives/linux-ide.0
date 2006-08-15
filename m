From: Roger Heflin <rheflin@atipa.com>
Subject: Re: What determines which interrupts are shared under Linux?
Date: Tue, 15 Aug 2006 12:47:25 -0500
Message-ID: <44E208AD.8060505@atipa.com>
References: <44E1D760.6070600@atipa.com>	 <1155654379.24077.286.camel@localhost.localdomain>	 <44E1E719.6020005@atipa.com> <1155657316.24077.293.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 125.14.cm.sunflower.com ([24.124.14.125]:56499 "EHLO
	mail.atipa.com") by vger.kernel.org with ESMTP id S1030400AbWHORrR
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 15 Aug 2006 13:47:17 -0400
In-Reply-To: <1155657316.24077.293.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

Alan Cox wrote:
> Ar Maw, 2006-08-15 am 10:24 -0500, ysgrifennodd Roger Heflin:
> 
>> I am currently retesting under 2.6.17.8 to see if I have similar issues
>> there, under that it show interrupts like below, different interrupt 
>> numbers,
>> but similar sharing as ata1/ata2, and ata3/ata4 are on the same interrupt.
> 
> Thats what I would expect to see - two channels per PCI device is the
> normal layout and they will always share the IRQ.
> 
> 

After looking at other information that looks correct.

It looks like the older DMA recovery code never works on this chipset,
once it goes into DMA recovery it never comes out of it.    I am looking
at that to see if anything can be done about it.

The problem I am having is that we cannot use a later kernel because it
has some other issues (MPT fusion driver is 1/4 the speed of the older
one for some unknown reason-this is in 2.6.17, the older MPT fusion works
fine on exactly the same machine/cards/bios-I am not sure of the
actual underlying casue of this slowdown).

On the specific kernel that I have I appear to have both IDE and
sata_nv drivers, is there a way to force things to use sata_nv/libata
rather than the older ide driver for the NVIDIA sata controller?

                                   Roger

