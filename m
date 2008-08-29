From: Thomas Renninger <trenn@suse.de>
Subject: Re: Promise 300-TX 4-channel SATA disk going dead under load 2.6.24-7
Date: Fri, 29 Aug 2008 13:39:58 +0200
Message-ID: <200808291339.59785.trenn@suse.de>
References: <48A35FE6.1080903@tlinx.org> <200808281436.30089.trenn@suse.de> <48B7CD5E.1050701@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.suse.de ([195.135.220.2]:41470 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753889AbYH2LkC (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 29 Aug 2008 07:40:02 -0400
In-Reply-To: <48B7CD5E.1050701@kernel.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Linda Walsh <lkml@tlinx.org>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux acpi <linux-acpi@vger.kernel.org>

On Friday 29 August 2008 12:20:14 Tejun Heo wrote:
> Thomas Renninger wrote:
> > Also the system is really old. Why don't you stick to pci=noacpi or
> > even acpi=off?
> > What advantage do you want to get with ACPI (SATA works?)?
>
> I think this is the second time I see ACPI IRQ routing doesn't work on
> old ACPI.
Hey, that's great. I expected you have seen much more (you inflicted me
on more than two? :) ).
There is a cut (date) when it makes sense to use ACPI and when to not
use it. Ideally one would like to choose for what the machine got
tested and certified, but you can only guess.
Thus a lot old machines need acpi=force or acpi=off.
> Is it possible to detect this and turn off automatically?  Or 
> does that risk breaking even more machines?
I do not know the very IRQ and PCI details, but I expect the
problem is you cannot detect whether an interrupt is wrongly set up.

While apic vs pic is a real HW switch and once done there is no way back,
acpi vs legacy IRQ setup, should just be about different ways of parsing and 
getting info how to set up the irq.
If you set up the IRQ using ACPI information and you detect that something
went wrong, it should be no problem (hmm, maybe a solvable design problem in 
the pci layer) to use PCI config or whatever legacy info to re-set up the
IRQ.
But as said, I expect it's not easy/possible to detect when the IRQ is
wrongly set up. Maybe you can add in the devices:
test_irq_activity(..)
If this fails you can try to set it up again..., no I do not think you want
to do that.

Also beside old machines which might need the noacpi or acpi=off, pci=noacpi 
and related boot params we do rather good IMO.
I remember:
    - legacy IDE problems, one boiled down to a BIOS Bug
    - No PCI domain support, that broke one HP machine which seemed to be the
      only one using it. Maybe it's already supported, rather old.
    - yeah and some older machines I do not really remember
where pci=noacpi helped. IMO not worth an automated detection.
Especially for those old machines..., people know which param to use, you will
produce more grief than any good.

There were several acpipnp problems recently, but this is another topic and 
that needs fixing anyway, Bjorn is doing a real good job here.

    Thomas
