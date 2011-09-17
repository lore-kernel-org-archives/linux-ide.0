From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2] pata-generic/of: Make probing via device tree non-powerpc-specific
Date: Sat, 17 Sep 2011 15:30:25 -0600
Message-ID: <CACxGe6u8a0HbCSisVadhasMKpdmgmVP1OZOo0+pLWcNncJozbQ@mail.gmail.com>
References: <1316183890-13677-1-git-send-email-dave.martin@linaro.org>
 <1316190120-17010-1-git-send-email-dave.martin@linaro.org>
 <20110917153732.GR3523@ponder.secretlab.ca> <2615461.zA8fCfbHH2@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vw0-f42.google.com ([209.85.212.42]:53695 "EHLO
	mail-vw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754105Ab1IQVaq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 17 Sep 2011 17:30:46 -0400
Received: by vwl1 with SMTP id 1so9058002vwl.1
        for <linux-ide@vger.kernel.org>; Sat, 17 Sep 2011 14:30:45 -0700 (PDT)
In-Reply-To: <2615461.zA8fCfbHH2@wuerfel>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: devicetree-discuss@lists.ozlabs.org, Dave Martin <dave.martin@linaro.org>, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, linux-arm-kernel@lists.infradead.org, patches@linaro.org

On Sat, Sep 17, 2011 at 12:40 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Saturday 17 September 2011 09:37:32 Grant Likely wrote:
>> What driver is normally used for versatile express pata? =A0This dri=
ver
>> is kind of legacy in that it was created when there was a split
>> between platform_device and of_platform_devices. =A0But that split w=
as a
>> bad idea and the same driver should be used regardless of whether or
>> not DT is enabled. =A0pata_of_platform.c really should be removed.
>
> It normally uses the plain pata_platform.c driver.
>
> Note that the pata_of_platform driver is already just a shim on
> top of the regular pata_platform driver. They could easily be combine=
d,
> but the current state is also ok, since there is very little code
> duplication.

A bunch of the code is actually redundant since the resource table is
no populated for DT devices.  I also see some directly references to
reg-shift and pio-mode property values without using be32_to_cpu(), so
that will also need to be fixed.  The of_irq_to_resource() and
of_address_to_resource() calls are now redundant since
platform_get_*() works for DT sourced platform device (with one quirk
for the electra-ide device).  Given that the conversion is straight
forward, I'd rather see pata_of_platform.c dropped and rolled into
pata_platform.c.  I've hacked together a patch to do so, but I've only
compile tested it.  Dave, if I send it to you, can you take care of
testing it?

Thanks,
g.
