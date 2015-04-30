From: Hendrik Visage <hvjunk@gmail.com>
Subject: Re: Please help me to understand the interaction of the various ATA drivers
Date: Thu, 30 Apr 2015 08:00:04 +0200
Message-ID: <CADtGFvmZdBPw+JwbgjkVRax=X8U0vq5XypUQ3vSBUeMFd9XDcw@mail.gmail.com>
References: <1430343517.30346.10.camel@afalanga4.micron.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:35037 "EHLO
	mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750800AbbD3GAF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 30 Apr 2015 02:00:05 -0400
Received: by oign205 with SMTP id n205so40009257oig.2
        for <linux-ide@vger.kernel.org>; Wed, 29 Apr 2015 23:00:04 -0700 (PDT)
In-Reply-To: <1430343517.30346.10.camel@afalanga4.micron.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Andy Falanga (afalanga)" <afalanga@micron.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hi Andy,

 I'm not involved in the development etc. but just a few notes below:

On Wed, Apr 29, 2015 at 11:38 PM, Andy Falanga (afalanga)
<afalanga@micron.com> wrote:
> Jeff,
>
> I don't know if you're still the maintainer of these drivers but you're
> listed as the original author of the code in the 2.6 kernel which I'm
> working on modifying.  I have to write a driver which I can expose
> access to the various HBA and Port registers for an AHCI class HBA.  In
> addition, this driver must act as a pass through driver for my clients
> to be able to execute ATA commands.  I'd like for it to be a true pass
> through driver and not have to run through the kernel's schedules and
> such, but that's another discussion.
>
> My question for you is simply, how are these various drivers supposed to
> work together?  On the VM which I'm doing my development, I see the
> following from lsmod:
>
> # lsmod
> ...
> ahci                      41208         2

^^^This is (as you might know) the "new" ATA "standard" interface, and
that AFAIK should be the device the filesystem etc. would talk to.

> pata_acpi                  3701         0

>From *me* understanding, that would be related to the IDE, aka
Parallel ATA, interface, and acpi is the BIOS/DMI/system description
stuff, so that would tell the OS what IDE/PATA/etc. options is
inside/described by the ACPI in some or other method.

> ata_generic                3837         0

>From *my* understanding: that was one of the first/early methods to
combine the IDE/pata with SATA

> ata_piix                  24409         1

The PIIX stuff is an Intel class of chipsets with a similar interface,
and I recall the PIIX4 being a very prominent one years gone back,
providing the IDE interface, and then also the SATA interface in an
IDE emulation/compatible format/method.

> ...
>
>
> This at least shows me that none of these modules depend upon one
> another for functionality.  However, to some level, they must be
> interrelated.

What I would expect from what you've mentioned, is that your VM is
emulating an Intel PIIX(4?) chipset, with IDE and SATA options
(perhaps the CD-rom is on the IDE interface??)

>
> Thanks for any light you can shed on this for me.
>
> Andy
