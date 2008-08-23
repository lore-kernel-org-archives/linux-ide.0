From: "Mark Nelson" <mdnelson8@gmail.com>
Subject: Re: Driver for Promise PDC42819 SATA/SAS controller
Date: Sat, 23 Aug 2008 19:23:59 +1000
Message-ID: <65a6ef750808230223t6da2560fx1799dbf271e95959@mail.gmail.com>
References: <65a6ef750808141846h1104bc1cj9a9c0bb721b62f58@mail.gmail.com>
	 <18597.25642.934859.944853@harpo.it.uu.se>
	 <65a6ef750808210557o1cf07c5fj9d273413003037f8@mail.gmail.com>
	 <18605.27969.933718.902876@harpo.it.uu.se>
	 <65a6ef750808211710k4f1e18b5y74b8d51e30c5900@mail.gmail.com>
	 <18606.60604.356878.363677@harpo.it.uu.se>
	 <48AF282B.4090904@garzik.org>
	 <18607.14142.979717.852078@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.178]:2680 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752378AbYHWJYB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 23 Aug 2008 05:24:01 -0400
Received: by py-out-1112.google.com with SMTP id p76so571091pyb.10
        for <linux-ide@vger.kernel.org>; Sat, 23 Aug 2008 02:24:00 -0700 (PDT)
In-Reply-To: <18607.14142.979717.852078@harpo.it.uu.se>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

On Sat, Aug 23, 2008 at 8:01 AM, Mikael Pettersson <mikpe@it.uu.se> wrote:
> Jeff Garzik writes:
>  > Mikael Pettersson wrote:
>  > > Mark Nelson writes:
>  > >  > > But without docs or a reference driver I cannot really say what it
>  > >  > > would take to support it, sorry.
>  > >  >
>  > >  > Yeah, I figured as much after reading that hardware docs
>  > >  > are only available under NDA... I do have Promise's "partial
>  > >  > open source driver" all working with the controller; but I
>  > >  > don't think that's what you meant by reference driver, is it?
>  > >
>  > > No. Promise's partial-source drivers sometimes contain some useful
>  > > information, like register definitions, but the only useful info
>  > > in the TX4650 driver is the PCI ID list for the T3 chip family.
>  >
>  > FWIW there's always the chance it belongs to drivers/scsi/stex.c...
>
> True, but unfortunately I doubt it as the PCI IDs in the tx4650
> (partial) sources bear no resemblance to the ones in stex.c.

Would the other PCI IDs that are found in the tx4650 driver give any
clue as to which other chips the T3 controller is similar to (or does
that just show that Promise likes to reuse the open source wrapper
around their binary blob)?

>
> The tx4650 driver lists 35xx for octopusII, 630x for napa_fpga, 377x/3Fxx
> for T3 (the chip in question), and 662x for SX4, whereas stex.c lists
> x350/4302 for shasta, 7250 for vsc (vitesse?), and 8650 for yosemite.
>

I was hopeful when I first found the STEX4650 as it at least had a similar
model number, but upon further inspection the stex cards all seem to
have Intel XScale I/O processors onboard...

Forgive my ignorance, but does the fact that the T3 controller can also
use SAS disks mean we should be looking for a SCSI driver?

Thanks!

Mark
