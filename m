From: Vasanth Ananthan <vasanthananthan@gmail.com>
Subject: Re: [PATCH 2/6] ARM: EXYNOS5: DT Support for SATA and SATA PHY
Date: Thu, 11 Oct 2012 12:19:04 +0530
Message-ID: <CAK1UHiwCQZJ--+urJmn6CURAYLx3-8uKPPLcdy7ufmKHTAm1sw@mail.gmail.com>
References: <1349783332-18467-1-git-send-email-vasanthananthan@gmail.com>
	<1349783332-18467-3-git-send-email-vasanthananthan@gmail.com>
	<20121009182828.GA20879@quad.lixom.net>
	<CAK1UHiyjyp8u-nFwU-19dds1uF7T1kkFNHyYQ6pWLFtUwGtR1w@mail.gmail.com>
	<20121010163127.GA19433@quad.lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:35599 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751335Ab2JKGtG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 Oct 2012 02:49:06 -0400
In-Reply-To: <20121010163127.GA19433@quad.lixom.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: kgene.kim@samsung.com, jgarzik@pobox.com, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-ide@vger.kernel.org, thomas.abraham@linaro.org, Vasanth Ananthan <vasanth.a@samsung.com>

Hi,

On Wed, Oct 10, 2012 at 10:01 PM, Olof Johansson <olof@lixom.net> wrote:
> Hi,
>
> On Wed, Oct 10, 2012 at 02:08:31PM +0530, Vasanth Ananthan wrote:
>
>> > > +
>> > > +             sataphy@70 {
>> >
>> > sata-phy would be a more conventional name.
>> >
>> > > +                     compatible = "samsung,i2c-phy";
>> >
>> > i2c-phy? Seems like an odd choice of name. What is this device?
>> >
>>
>> The SATA physical layer controller is both a platform device and a i2c
>> slave device.
>> This compatible string is for the i2c client driver. Hence I have used
>> i2c-phy here.
>
> Ok, but samsung,i2c-phy is much too generic. Maybe something like
> samsung,exynos5-sata-phy  (and rename the MMIO-controlled phy controls
> to ...sata-phy-controller below).
>

I'll do so..

>
>> > > +        };
>> > > +
>> > > +        sata-phy@12170000 {
>> > > +                compatible = "samsung,exynos-sata-phy";
>> > > +                reg = <0x12170000 0x1ff>;
>> > > +        };
>> >
>> > Should have binding too. How does this relate to the i2c device above.
>> >
>>
>> As mentioned earlier SATA physical layer controller is both a platform
>> device and also an i2c slave device.
>> This Node is for the SATA physical layer platform device, the previous node
>> is for i2c slave device.
>> Certain initialization settings done directly and other settings has to be
>> done through i2c.
>
> Wow, that's quite awkward. What needs to be done over i2c? I think I have
> seen use of SATA without touching the i2c side but it might have been for
> a simple setup.

40 bit Interface setting is done through i2c. Internal setting address
0x3A and data 0x0B.

>
>> > > +
>> > >       i2c@12C60000 {
>> > >               compatible = "samsung,s3c2440-i2c";
>> > >               reg = <0x12C60000 0x100>;
>> > > @@ -152,6 +164,13 @@
>> > >               #size-cells = <0>;
>> > >       };
>> > >
>> > > +     i2c@121D0000 {
>> > > +                compatible = "samsung,s3c2440-sataphy-i2c";
>> >
>> > Is this a unique i2c controller, or is it just another one like the others
>> > on
>> > the chip? If it's the latter, it should use the regular compatible string.
>> >
>>
>> Yes, its a unique i2c controller which lacks an interrupt line while others
>> are interrupt driven.
>> Hence I have used a distinct compatible string for the driver to
>> distinguish the controller.
>
> It would be better to just make the i2c bus driver handle the case where there
> is no interrupt specifier and just use polling in those cases, especially if
> the rest of the device is identical and doesn't need special handling.
>
> As a matter of fact, if that had been done for the hdmi phy, then you could
> have done this patch without modifying the driver at all, just device tree
> contents. And the same would go for the next time down the road when
> a "special" i2c bus is added.
>


Yes, It is the i2c bus driver thats handles this case. There is a
subsequent patch
that provides the polling support to the driver. As far as I know, the
i2c controller for
HDMI PHY is also interrupt driven.

>
> -Olof



-- 
Regards,

Vasanth K A
