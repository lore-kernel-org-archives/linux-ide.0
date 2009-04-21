From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: [PATCH 4/6] PalmLD IDE
Date: Tue, 21 Apr 2009 12:02:59 +0800
Message-ID: <f17812d70904202102m6ea8c701xa7aa04b234c062d3@mail.gmail.com>
References: <200903222223.10572.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.27]:18590 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750695AbZDUEDA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 21 Apr 2009 00:03:00 -0400
Received: by qw-out-2122.google.com with SMTP id 5so1252356qwd.37
        for <linux-ide@vger.kernel.org>; Mon, 20 Apr 2009 21:02:59 -0700 (PDT)
In-Reply-To: <200903222223.10572.marek.vasut@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marek Vasut <marek.vasut@gmail.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.arm.linux.org.uk, linux-ide@vger.kernel.org, bzolnier@gmail.com

On Mon, Mar 23, 2009 at 5:23 AM, Marek Vasut <marek.vasut@gmail.com> wr=
ote:
>> Dne Saturday 16 of August 2008 11:08:03 Russell King - ARM Linux nap=
sal(a):
>> > On Wed, Aug 13, 2008 at 10:52:23PM +0200, Marek Vasut wrote:
>> > > This patch adds palmld ide channel support, same as previous pat=
ch, I
>> > > think this can be merged since it wont break anything.
>> >
>> > I think this one also needs review by the Linux ATA folk. =C2=A0Me=
ntion to
>> > them that it's part of a patchset for ARM and that you'd prefer it
>> > to be merged into the ARM tree.
>> >
>> > > +static const char drvname[] =3D "pata_palmld";
>> > > +MODULE_ALIAS("platform: "drvname);
>> >
>> > Have you tried building this as a module? =C2=A0Also, IIRC, there =
isn't
>> > supposed to be a space after the colon...
>>
>> Ok, I fixed the issues and CCed linux-ide and the maintainer.
>>
>> Thanks
>
> Hi, Im resending this patch since it was totally ignored last time. I=
t still
> applies correctly. It'd be for the best to push this through arm-kern=
el tree.
>

I wonder if this driver can be implemented in a more generic way so
that other boards can be benefited. The only specific things I see are:

1. I/O mapping address space
2. IRQ
3. PowerON

IRQ can be specified by platform_data, and power_on can be implemented
by callbacks in platform_data. I/O mapping should be OK by resources in
platform_device.

So what's else to make this specific to PalmLD?
