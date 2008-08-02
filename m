From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH] ide-generic: skip automatic probing of legacy iobases
	(was: Re: [PATCH] ide-floppy fix)
Date: Sat, 2 Aug 2008 20:32:53 +0200
Message-ID: <20080802183253.GA2239@gollum.tnic>
References: <20080715053356.GA18628@gollum.tnic> <200807232051.12226.bzolnier@gmail.com> <20080801054831.GA14636@gollum.tnic> <200808021902.12191.bzolnier@gmail.com>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:23918 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753215AbYHBSc7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 2 Aug 2008 14:32:59 -0400
Received: by fg-out-1718.google.com with SMTP id 19so742943fgg.17
        for <linux-ide@vger.kernel.org>; Sat, 02 Aug 2008 11:32:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200808021902.12191.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Sat, Aug 02, 2008 at 07:02:12PM +0200, Bartlomiej Zolnierkiewicz wrote:

[.. ]

> Why not try <linux/ata.h> + inline trick instead?
> 
> [ <linux/ata.h> is shared by both stacks so by moving the function there
>   + making it inline it can also be shared without the need for dependency
>   on libata. ]

I hadn't thought of that, will try it out later.

> > As a result, i have now a new bool-Kconfig option BLK_DEV_GENERIC_ONLY which
> > gets reverse-selected only when no pci ide controller which is using the generic
> > ide_host_register() from within ide_pci_init_one() is selected in Kconfig. This
> > is tested both with and without a pci ide driver selected in addition to
> > ide-generic.
> 
> How's about just leaving the final decision up to the user with changing
> probe_mask in ide_generic from 0x3 to 0x0 and automatically probing for
> ports 0-1 iff there is no IDE PCI controller present (otherwise check
> probe_mask).

Wait, let me get this straight: you want to set probe_mask to 0x0 as a default,
which skips probing of the primary and secondary ports, and to do the checking
whether the IDE PCI controller uses legacy iobases only when the user has
enforced it by setting probe_mask to 0x3? At least this is how i understand
it...

> This is should remove the need for Kconfig magic and is a sane default
> since a lot of people get caught using ide_generic by mistake and not by
> intent (IOW they forgot to enable the right IDE PCI host driver).

[.. ]

-- 
Regards/Gruss,
    Boris.
