From: Dave Martin <dave.martin@linaro.org>
Subject: Re: [PATCH] pata-generic/of: Make probing via device tree non-powerpc-specific
Date: Mon, 19 Sep 2011 11:56:11 +0100
Message-ID: <CA+wbFddgygAyGedeCUjs-zfCRcaZsN2COFPJ7W4MR4Hk1tOGUA@mail.gmail.com>
References: <1316183890-13677-1-git-send-email-dave.martin@linaro.org>
	<20110916214313.GB16381@n2100.arm.linux.org.uk>
	<CA+wbFdc0SicHLN6=JQz-rRXqKovhr7=acUQi3esUU_qcXgCaAw@mail.gmail.com>
	<1316427795.3014.13.camel@hornet.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:58727 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755211Ab1ISK4N convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Sep 2011 06:56:13 -0400
Received: by yxl31 with SMTP id 31so32074yxl.19
        for <linux-ide@vger.kernel.org>; Mon, 19 Sep 2011 03:56:12 -0700 (PDT)
In-Reply-To: <1316427795.3014.13.camel@hornet.cambridge.arm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Pawel Moll <pawel.moll@arm.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Grant Likely <grant.likely@secretlab.ca>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "patches@linaro.org" <patches@linaro.org>

On Mon, Sep 19, 2011 at 11:23 AM, Pawel Moll <pawel.moll@arm.com> wrote=
:
>> > This may not be the correct way to support the CF slot on Versatil=
e
>> > Express - it depends whether the CF slot on VE supports just CF
>> > memory cards or whether it can take any CF card.
>> >
>> > If the latter, then what may be inserted could be a CF network car=
d,
>> > and that means it's probably wrong to tell the kernel that what's
>> > there is a PATA interface.
>>
>> Interesting point. =A0I don't know whether we've tried plugging anyt=
hing
>> else in...
>>
>> Pawel, can you comment?
>
> VE officially supports CF memory cards only (Arnd already referenced =
the
> spec). So in this case CF =3D=3D PATA.

OK, Il'l stick with this for now.

Cheers
---Dave
