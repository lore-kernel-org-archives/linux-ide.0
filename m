From: Andre Hedrick <andre@linux-ide.org>
Subject: Re: HPT372 DMA corruption
Date: Thu, 22 Jan 2004 18:27:46 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.10.10401221821170.9012-100000@master.linux-ide.org>
References: <yw1xu12z9yyq.fsf@kth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:17425
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S265215AbUAWCaP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Jan 2004 21:30:15 -0500
In-Reply-To: <yw1xu12z9yyq.fsf@kth.se>
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org


It has NOTHING to do with VIA!

It has everything to do with a missing function th hpt366.c code.

It is all about what the FIFO thresholds are wrt to when interrupts are
issued and a pre-emptive like notification.

I am waiting on one of my customers report they are happy with the fix =
and
will ship the fix before I release it to the public.  I have this serio=
us
problem on not testing volitale patches on the general masses.

In my opinion, after several weeks of hard-on testing, the changes are
clean, correct, and exact.

Noting this type of patch would not be doable, had I not split the
individual dma operations way back when.

And yes for the remainder of the peanut gallery, I will "SHUT UP" for n=
ow.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

On Wed, 14 Jan 2004, M=E5ns Rullg=E5rd wrote:

> Chuck Berg <chuck@encinc.com> writes:
>=20
> > On Fri, Jan 09, 2004 at 03:24:28PM -0500, Richard B. Johnson wrote:
> > [cmp -l bad good]
> >> >  89260029   0  31
> >> >  89260030   0 327
> >> >  89260031   0 200
> >> >  89260032   0  13
> >>=20
> >> Since whole bytes are not written, this looks strangely like
> >> an attempt to DMA to cached RAM! Since the CPU didn't write
> >
> > I tested this by reading with O_DIRECT, and immediately after each =
read(),
> > read all of a 1MB array (my cache is only 256kB), and then checking=
 the
> > data. The same corruption occurs.=20
> >
> > Via had a DMA corruption bug a couple years ago with similar sympto=
ms,
> > apparently with the VT82C686B southbridge. Mine is a VT82C586B (whi=
ch some
> > people also reported problems with). My board dates long after thes=
e
> > problems were discovered, so I sure hope it's not the same bug. I'l=
l try
> > upgrading my BIOS to the latest version in case Soyo's changelog is=
 not
> > entirely honest.
>=20
> Well, VIA never did have a good reputation.
>=20
> > I did learn some more about the pattern of corruption. The data is =
not
> > being written to memory - the "bad" data is whatever happened to be=
 there
> > before. It usually happens in 4, but sometimes 64 or 32 byte chunks=
=2E
>=20
> Is it always a multiple of 4 bytes?  Is there any pattern in the
> position of the corruption, such as always aligned to some value?
>=20
> > When I read from the device with O_DIRECT, the corruption only
> > appears at the very end of the read. I've confirmed this for reads
> > of 512 bytes through 256k at multiples of 512 bytes.
>=20
> Could something be cutting off the DMA transfer too early?
>=20
> --=20
> M=E5ns Rullg=E5rd
> mru@kth.se
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>=20

