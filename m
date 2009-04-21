From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH 4/6] PalmLD IDE
Date: Tue, 21 Apr 2009 16:01:18 +0200
Message-ID: <200904211601.19232.marek.vasut@gmail.com>
References: <200903222223.10572.marek.vasut@gmail.com> <f17812d70904202102m6ea8c701xa7aa04b234c062d3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.185]:29937 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753571AbZDUOBQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 21 Apr 2009 10:01:16 -0400
Received: by mu-out-0910.google.com with SMTP id g7so918703muf.1
        for <linux-ide@vger.kernel.org>; Tue, 21 Apr 2009 07:01:14 -0700 (PDT)
In-Reply-To: <f17812d70904202102m6ea8c701xa7aa04b234c062d3@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.arm.linux.org.uk, linux-ide@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

On Tuesday 21 of April 2009 06:02:59 Eric Miao wrote:
> On Mon, Mar 23, 2009 at 5:23 AM, Marek Vasut <marek.vasut@gmail.com> =
wrote:
> >> Dne Saturday 16 of August 2008 11:08:03 Russell King - ARM Linux=20
napsal(a):
> >> > On Wed, Aug 13, 2008 at 10:52:23PM +0200, Marek Vasut wrote:
> >> > > This patch adds palmld ide channel support, same as previous p=
atch,
> >> > > I think this can be merged since it wont break anything.
> >> >
> >> > I think this one also needs review by the Linux ATA folk. =C2=A0=
Mention to
> >> > them that it's part of a patchset for ARM and that you'd prefer =
it
> >> > to be merged into the ARM tree.
> >> >
> >> > > +static const char drvname[] =3D "pata_palmld";
> >> > > +MODULE_ALIAS("platform: "drvname);
> >> >
> >> > Have you tried building this as a module? =C2=A0Also, IIRC, ther=
e isn't
> >> > supposed to be a space after the colon...
> >>
> >> Ok, I fixed the issues and CCed linux-ide and the maintainer.
> >>
> >> Thanks
> >
> > Hi, Im resending this patch since it was totally ignored last time.=
 It
> > still applies correctly. It'd be for the best to push this through
> > arm-kernel tree.
>
> I wonder if this driver can be implemented in a more generic way so
> that other boards can be benefited. The only specific things I see ar=
e:
>
> 1. I/O mapping address space
> 2. IRQ
> 3. PowerON
>
> IRQ can be specified by platform_data, and power_on can be implemente=
d
> by callbacks in platform_data. I/O mapping should be OK by resources =
in
> platform_device.
>
> So what's else to make this specific to PalmLD?

Will there be anyone who would use that other than palmld then ? I doub=
t=20
anyone has that obscure hardware. That's why I see no point in making t=
his=20
generic.
