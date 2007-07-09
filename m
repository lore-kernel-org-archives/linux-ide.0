From: Matt Sealey <matt@genesi-usa.com>
Subject: Re: CHRP PCI fixup for Pegasos IDE (looking for testers)
Date: Mon, 09 Jul 2007 17:05:16 +0100
Message-ID: <46925CBC.1020100@genesi-usa.com>
References: <46924C27.8020100@genesi-usa.com> <20070709160656.2666ef61@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mithrandir.softwarenexus.net ([66.98.186.96]:3494 "EHLO
	mail.genesi-usa.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753160AbXGIQE0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 9 Jul 2007 12:04:26 -0400
In-Reply-To: <20070709160656.2666ef61@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

Well, not looking for a cookie.

I don't understand what you mean by the ifdef being wrong. I don't
see how else I can make any kind of check for it. If the fix needs
to be that early, it can't be done in libata or pata_via directly
as it stands.

The viaide->irq check is just me being careful. I know for a fact the
only way the Pegasos is set up on every firmware revision is that
the PCI interrupt line for the IDE controller is set to 14. If it's
not set to that, the fixup would have to be more complicated than
zeroing out 4 bits, but the chances of it happening are 0. It's
basically to protect the system from having IRQ steering set to 14,
when the PCI interrupt line could be set to 10, or 11 or 15.

Obviously as the fix matures that'll all get fixed, but I haven't
even tried it yet, so I am not going to overcomplicate it.

As for it being the PCI IRQ instead of legacy, I don't see how it
matters. What we want is the IDE steering to match the PCI interrupt
line register so native mode works. That's the whole problem as I
see it - we configure the controller in PCI native mode, but ISA
IDE IRQ steering is still set to 14,15.

The quirk fixup won't work for both, the whole REASON the firmware
sets the chip up this way is that the old Via driver and the old
PCI block layer somewhere, somehow freaks out if the primary and
secondary channel are set to the same IRQ. It just cannot deal with
it. At least, this was the case for the last check we did on it,
in a couple of years, it may have started working.

I want to know if it fixes libata first. Making the old block
driver is something we can do when we find out if libata works.

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

Alan Cox wrote:
> On Mon, 09 Jul 2007 15:54:31 +0100
> Matt Sealey <matt@genesi-usa.com> wrote:
> 
>> Hi guys,
>>
>> Just a heads up here, I hammered out this little bit of code over the
>> weekend which "solves" the Pegasos IDE problem by making PCI native
>> mode work like PCI native mode should (it tweaks the ISA bridge to
>> steer both IDE IRQs to 14)
>>
>> http://www.powerdeveloper.org/files/Pegasos/ide_fixup.c
>>
>> I definitely need someone to test it though. I can't compile it and
>> I can't run it on a Pegasos here, and I am not sure if the fix is
>> being done early enough (Alan said "before pci_setup_device"..).
> 
> Close but no cookie. The fixup is done at a sensible point, the fixup
> makes sense.
> 
> The ifdef is wrong (could be modular PATA_VIA)
> The viaide->irq check is iffy as this is the PCI IRQ rather than the
> legacy one. Probably you should just force it to 14 if you know that is
> the correct behaviour.
> 
> Otherwise looks a good basis. If it works sanely then I'd bump the other
> fix out of the old IDE driver and use the quirk fixup for both.
> 
> Alan
