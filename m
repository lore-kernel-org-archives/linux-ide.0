From: Vincent Pelletier <plr.vincent@gmail.com>
Subject: Re: [PATCH] make ata_exec_internal_sg honor DMADIR
Date: Mon, 20 May 2013 08:20:04 +0200
Message-ID: <201305200820.05239.plr.vincent@gmail.com>
References: <CA+WQ+_13jrv6eKy7j5_Y8Tj0pvfnoWVWsb5JQtyttNONk84vKw@mail.gmail.com> <201305191531.23110.plr.vincent@gmail.com> <20130519233818.GA4482@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-we0-f182.google.com ([74.125.82.182]:36495 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780Ab3ETGUK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 May 2013 02:20:10 -0400
Received: by mail-we0-f182.google.com with SMTP id t60so4917288wes.41
        for <linux-ide@vger.kernel.org>; Sun, 19 May 2013 23:20:09 -0700 (PDT)
In-Reply-To: <20130519233818.GA4482@mtj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, Csaba =?iso-8859-1?q?Hal=E1sz?= <csaba.halasz@gmail.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Le lundi 20 mai 2013 01:38:18, Tejun Heo a =E9crit :
> I don't really wanna go that way.  Those bridges always have been
> something fringe and broken in ways which aren't fundamentally
> fixable.  Fixing one would break another without anyway to properly
> detect them.
>=20
> So, I'm okay with having a knob for cases where the user knows what t=
o
> do but I don't think even that is something of much importance, and
> I'm definitely not gonna do anything which may affect !bridge case
> adversely.

I understand.

> Those bridges have always been a second-class citizen and
> their importance has waned a lot.

Just a bit of background on why I got interested in Csaba's patch:

I never used my bridges when I originally got them (serillel was bundle=
d with=20
some motherboards I bought circa 2003), because a PATA controller was=20
available anyway.
Since then, I changed all my hard drives progressively to SATA ones bec=
ause of=20
the capacity increase. But I still have many DVD drives from that time,=
=20
because there was just no motivation to change them, and I don't have a=
ny=20
optical SATA drive.
Then I bought a new motherboards a few weeks ago, without paying enough=
=20
attention: there is no PATA controller on it. So I remembered those bri=
dges=20
and finally tried to use them.

Now, given that those bridges are old and were originally IMHO very clo=
se to=20
useless, I'm indeed probably part of a fringe who didn't throw them awa=
y and=20
remember them. SATA optical drives are quite cheap, maybe there is not =
even a=20
financial motivation to look for such bridge.

> EH stands for exception handling and discovery / init definitely are
> part of exception handling in libata speak.

Thanks for the clarification.

> So, nope, I really don't want this.

Err, the body of this patch didn't change from my original submission, =
only=20
the commit message has changed.

> > +atapi_dmadir
> > +
> > +	Bitmask enabling dmadir for corresponding device if ATAPI.
> > +	1:	Enable dmadir for port's device 0
> > +	2:	Enable dmadir for port's device 1
> > +	(etc)
> > +	See also libata's atapi_dmadir module parameter.
>=20
> Shouldn't this be a device property?

Unplugging the drive would, in my understanding, loose the setting if s=
tored=20
at the device level. Is there another way to trigger a new initialisati=
on=20
attempt after changing the setting ?
Should I add a "rescan" device attribute ?

Regards,
--=20
Vincent Pelletier
