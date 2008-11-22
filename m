From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH] amd74xx: workaround unreliable AltStatus register for
	nVidia controllers
Date: Sat, 22 Nov 2008 12:33:42 +0100
Message-ID: <20081122113342.GA8593@gollum.tnic>
References: <200811212238.51161.bzolnier@gmail.com>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.158]:32962 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756984AbYKVLdi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 22 Nov 2008 06:33:38 -0500
Received: by fg-out-1718.google.com with SMTP id 19so1039078fgg.17
        for <linux-ide@vger.kernel.org>; Sat, 22 Nov 2008 03:33:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <200811212238.51161.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Remy LABENE <remy.labene@free.fr>

On Fri, Nov 21, 2008 at 10:38:50PM +0100, Bartlomiej Zolnierkiewicz wrote:
> It seems that on some nVidia controllers using AltStatus register
> can be unreliable so default to Status register if the PCI device
> is in Compatibility Mode.  In order to achieve this:
> 
> * Add ide_pci_is_in_compatibility_mode() inline helper to <linux/ide.h>.
> 
> * Add IDE_HFLAG_BROKEN_ALTSTATUS host flag and set it in amd74xx host
>   driver for nVidia controllers in Compatibility Mode.
> 
> * Teach actual_try_to_identify() and drive_is_ready() about the new flag.
> 
> This fixes the regression caused by removal of CONFIG_IDEPCI_SHARE_IRQ
> config option in 2.6.25 and using AltStatus register unconditionally when
> available (kernel.org bug #11659).  [ Moreover for CONFIG_IDEPCI_SHARE_IRQ=y
> (which is what most distributions/people use) it never worked correctly. ]

Looks good.

Acked-by: Borislav Petkov <petkovbb@gmail.com>

> 
> Thanks to Remy LABENE for help with debugging the problem.
> 
> More info at:
> http://bugzilla.kernel.org/show_bug.cgi?id=11659

Bugzilla entry can be closed now.

[.. ]

-- 
Regards/Gruss,
    Boris.
