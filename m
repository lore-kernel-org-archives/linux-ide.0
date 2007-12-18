From: Zsolt Barat <zsolt@softmonsters.com>
Subject: Re: ATA bus error with external hd on esata
Date: Tue, 18 Dec 2007 14:14:30 +0100
Message-ID: <4767C7B6.9000009@softmonsters.com>
References: <47642D9A.4080600@softmonsters.com>	 <476434C7.6040307@softmonsters.com>	 <20071217025321.2f7507db.akpm@linux-foundation.org> <87f94c370712170909y691dc2e3rf7f23c64eff8da22@mail.gmail.com> <4766B100.3010203@dupondje.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756017AbXLRNOr@vger.kernel.org>
In-Reply-To: <4766B100.3010203@dupondje.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean-Louis Dupond <info@dupondje.be>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Jean-Louis Dupond schrieb:
> Greg Freemyer schreef:
> > On Dec 17, 2007 5:53 AM, Andrew Morton <akpm@linux-foundation.org> =
wrote:
> >  =20
> >> On Sat, 15 Dec 2007 21:10:47 +0100 Zsolt Barat <zsolt@softmonsters=
=2Ecom> wrote:
> >>
> >>    =20
> >>> Zsolt Barat schrieb:
> >>>      =20
> >>>> hi list,
> >>>>        =20
> >> Let's cc the IDE development list.
> >>
> >>    =20
> >>>> i just bought a "MyBook" called external HD with a fixed enclosu=
re, from
> >>>> WD. Connected to the SATA port i constantly get "ATA bus error" =
messages
> >>>> in the kernel log. Is this a known issue?
> >>>>
> >>>>        =20
> >
> > As an FYI: I've had a lot of problems with the big prepackaged driv=
es
> > in the last 6 months even from Windows, so I would not be too quick=
 to
> > blame Linux.
> >
> > ie.
> > I bought several 500GB / 1000GB Buffalo Drives last month with plan=
s
> > to use them from Windows via USB.
> >
> > I attempted to do a lot of heavy file copying to/from them.  I was
> > getting a bunch of "Delayed Write Failures",
> >
> > I finally gave up.
> >
> > The 500GB drives had a single hard drive internally, so I opened th=
e
> > case, removed the drive and connected them via standalone external
> > carriers I had around.  In that mode the drives worked fine (from
> > Windows).  I've used both standalone eSata external carriers and
> > standalone USB external carriers with these same physical drives wi=
th
> > no issues.
> >
> > My conclusion is that the electronics in the prepackaged external
> > units is just not up to the job if your doing heavy i/o.
> >
> > Greg
> >  =20
> Could u check the temps of the disk ? I had that error in windows als=
o with to=20
> hot disks ! If temp is >50=B0C I would start to worry :)
>  =20
hi,
thanks for your answer. i can't check the temps via software tools, but
i doubt it's the temperature, since it seems to have a fan inbuilt into
the case.

best regards

zsolt


--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
