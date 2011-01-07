From: Lin Mac <mkl0301@gmail.com>
Subject: Re: [PATCH v2 0/3] add CNS3xxx AHCI support
Date: Sat, 8 Jan 2011 07:44:29 +0800
Message-ID: <AANLkTikMZvCEjd86Rk9dXs4yGhtg0NUcj4BsCgH3XxwF@mail.gmail.com>
References: <1294206187-11487-1-git-send-email-mkl0301@gmail.com>
	<4D24B53C.4020009@pobox.com>
	<AANLkTinxNtzpzUn0=-iph_N7tffM6Nu++J9qNNhcp8pX@mail.gmail.com>
	<20110106105157.GA9560@oksana.dev.rtsoft.ru>
	<4D264DA4.6040308@pobox.com>
	<20110107154714.GA27055@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:56873 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751649Ab1AGXoa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 7 Jan 2011 18:44:30 -0500
Received: by fxm20 with SMTP id 20so17410321fxm.19
        for <linux-ide@vger.kernel.org>; Fri, 07 Jan 2011 15:44:29 -0800 (PST)
In-Reply-To: <20110107154714.GA27055@oksana.dev.rtsoft.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Anton Vorontsov <cbouatmailru@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, htejun@gmail.com, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org

2011/1/7 Anton Vorontsov <cbouatmailru@gmail.com>:
> On Thu, Jan 06, 2011 at 06:17:56PM -0500, Jeff Garzik wrote:
>> >[...]
>> >>>It is overkill to rename the entirety of ahci_platform just for o=
ne override
>> >>>function.
>> >>>This sort of thing I would have expected to be added directly to
>> >>>ahci_platform.c.
>> >>It might be overkill for only one controller. but it is more clean=
 and
>> >>readable to have different SoC specific changes in separate files,
>> >>especially when more SoCs need to make similar changes.
>> >
>> >I think that renaming the file is not necessary. You can just
>> >rename the module in the makefile.
>> >
>> >Personally I like the current approach more than putting
>> >controller-specific fixups directly into ahci_platform.
>>
>> My main objection is the renaming. =A0If ahci_platform wants to expo=
rt
>> some symbols for SoC modules like ahci_platform_cns, that's ok.
>>
>> In general, follow the library approach rather than linking modules
>> together in strange ways.
>
> In ahci_platform case there's almost nothing to factor out to a
> library. Each platform just needs its own small "fixups" that we
> normally pass via platform data.
>
> We would happily pass them via platform data, and initially Mac
> did exactly this, see:
>
> http://ns3.spinics.net/lists/linux-ide/msg39554.html
>
> You may notice that all platform-specific quirks are in the
> platform code, which is neat. But there is a problem: once
> the platform code needs to use libata, then we have to
> build libata into the kernel (no modules possible), i.e.
>
> http://ns3.spinics.net/lists/linux-ide/msg39656.html
>
> It's not something new, we have the same "problem" with SDHCI,
> USB and plenty other drivers. But the solution is simple, for
> example see drivers/mmc/host/sdhci-pltfm.c and sdhci-cns3xxx.c
> (and sdhci-esdhc-imx.c as another example of platform-specific
> hooks for sdhci-pltfm).
>
> Of course, we could make full-fledged platform driver just for
> CNS3xxx, but that's kind of overkill. IMO, it's better to make
> ahci_platform flexible and suitable for generic use.

Thanks for explaining all this.

> As for renaming, I agree that ahci_platform.c file does not
> need to be renamed, I still think that we could just rename
> the module (so far it is used only on CNS3xxx platforms, so
> no big deal even if anybody rely on the module name, which
> I doubt.)
Yes, you're right.
cns3xxx seems like the only platform that uses ahci_platform driver.
Keeping the same module name is not necessary.

We could rename the module ahci_platform to ahci_platforms(?), into
which link ahci_platform and SoC specific changes.
Is it acceptable?

Best Regards,
Mac Lin
