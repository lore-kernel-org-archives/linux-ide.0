From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH v2 0/3] add CNS3xxx AHCI support
Date: Fri, 7 Jan 2011 18:47:14 +0300
Message-ID: <20110107154714.GA27055@oksana.dev.rtsoft.ru>
References: <1294206187-11487-1-git-send-email-mkl0301@gmail.com>
 <4D24B53C.4020009@pobox.com>
 <AANLkTinxNtzpzUn0=-iph_N7tffM6Nu++J9qNNhcp8pX@mail.gmail.com>
 <20110106105157.GA9560@oksana.dev.rtsoft.ru>
 <4D264DA4.6040308@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:57139 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751475Ab1AGPrU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 7 Jan 2011 10:47:20 -0500
Received: by eye27 with SMTP id 27so7687943eye.19
        for <linux-ide@vger.kernel.org>; Fri, 07 Jan 2011 07:47:19 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D264DA4.6040308@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Lin Mac <mkl0301@gmail.com>, htejun@gmail.com, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org

On Thu, Jan 06, 2011 at 06:17:56PM -0500, Jeff Garzik wrote:
> >[...]
> >>>It is overkill to rename the entirety of ahci_platform just for one override
> >>>function.
> >>>This sort of thing I would have expected to be added directly to
> >>>ahci_platform.c.
> >>It might be overkill for only one controller. but it is more clean and
> >>readable to have different SoC specific changes in separate files,
> >>especially when more SoCs need to make similar changes.
> >
> >I think that renaming the file is not necessary. You can just
> >rename the module in the makefile.
> >
> >Personally I like the current approach more than putting
> >controller-specific fixups directly into ahci_platform.
> 
> My main objection is the renaming.  If ahci_platform wants to export
> some symbols for SoC modules like ahci_platform_cns, that's ok.
> 
> In general, follow the library approach rather than linking modules
> together in strange ways.

In ahci_platform case there's almost nothing to factor out to a
library. Each platform just needs its own small "fixups" that we
normally pass via platform data.

We would happily pass them via platform data, and initially Mac
did exactly this, see:

http://ns3.spinics.net/lists/linux-ide/msg39554.html

You may notice that all platform-specific quirks are in the
platform code, which is neat. But there is a problem: once
the platform code needs to use libata, then we have to
build libata into the kernel (no modules possible), i.e.

http://ns3.spinics.net/lists/linux-ide/msg39656.html

It's not something new, we have the same "problem" with SDHCI,
USB and plenty other drivers. But the solution is simple, for
example see drivers/mmc/host/sdhci-pltfm.c and sdhci-cns3xxx.c
(and sdhci-esdhc-imx.c as another example of platform-specific
hooks for sdhci-pltfm).

Of course, we could make full-fledged platform driver just for
CNS3xxx, but that's kind of overkill. IMO, it's better to make
ahci_platform flexible and suitable for generic use.

As for renaming, I agree that ahci_platform.c file does not
need to be renamed, I still think that we could just rename
the module (so far it is used only on CNS3xxx platforms, so
no big deal even if anybody rely on the module name, which
I doubt.)

Thanks,

-- 
Anton Vorontsov
Email: cbouatmailru@gmail.com
