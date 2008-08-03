From: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
Subject: Re: Kernel Summit request for Discussion of future of ATA (libata) and IDE
Date: Sun, 3 Aug 2008 22:09:25 +0200
Message-ID: <58cb370e0808031309n54052c51m744c479aa69b2f4a@mail.gmail.com>
References: <1217779055.4179.10.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:38696 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752761AbYHCUJ1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 3 Aug 2008 16:09:27 -0400
Received: by fg-out-1718.google.com with SMTP id 19so861747fgg.17
        for <linux-ide@vger.kernel.org>; Sun, 03 Aug 2008 13:09:25 -0700 (PDT)
In-Reply-To: <1217779055.4179.10.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: ksummit-2008-discuss@lists.linux-foundation.org, linux-kernel <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>

I'm using gmail's interface (I don't have access to my laptop ATM) so
the mail may look a bit weird...

On Sun, Aug 3, 2008 at 5:57 PM, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
> Right at the moment, we have two separate subsystems for running IDE
> type devices:  driver/ide and drivers/ata.  The claim I've seen is that
> drivers/ata can do everything drivers/ide can do plus it does sata.  I

This claim doesn't seem to have confirmation in facts:

* There is still hardware that is simply not-supported by libata at all:

  - architecture specific hardware (ppc, m68k, mips, arm)

  - "difficult" legacy PC-class hardware (i.e. secondary interface on
CY82C693 etc)

* There are still regressions in many libata PCI host drivers dating back
  to their rushed introduction.

* There are still corner case in libata core - PIO is dead slow
compared to drivers/ide/,
  "serialized" hosts are not supported, some quirks for obsolete
hardware got lost...

> also note that no major distribution seems to enable anything in
> drivers/ide anymore, so given this is it time to deprecate drivers/ide?

Major distributions make their own decisions (I don't remeber anybody from
these distros discussing the conversion on linux-kernel or linux-ide) which
sometimes don't match with what kernel.org kernels are doing.

[ Actually one distro went so far as CONFIG_IDE=n even before support for
  all PC-class IDE PCI hardware present in drivers/ide was available
in libata. ]

Also the same major distros that use libata on x86 are using
drivers/ide on non-x86.

> A counter argument to the above is that not all drivers (particularly
> the older ones where hw is scarce) are converted to drivers/ata, so
> drivers/ide seems to be needed for some legacy systems (in which case it
> can be deprecated but not removed).  I've also noted that some embedded
> distributions seem to be using drivers/ide, but I'm not really sure
> whether this is inertia or some overriding need.

drivers/ide deprecation would be a premature thing.

> The proposal is to discuss the future of these two subsystems and arrive
> at a consensus what's happening to each going forwards.

Well, I'm looking forward to discuss the future of Linux ATA support.

Thanks,
Bart
