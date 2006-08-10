From: "Fortier,Vincent [Montreal]" <Vincent.Fortier1@EC.GC.CA>
Subject: RE: ASUS A8V Deluxe, x86_64
Date: Thu, 10 Aug 2006 10:03:27 -0400
Message-ID: <8E8F647D7835334B985D069AE964A4F7028FDE12@ECQCMTLMAIL1.quebec.int.ec.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fwstl1-1.wul.qc.ec.gc.ca ([205.211.132.24]:65506 "EHLO
	ecqcmtlbh.quebec.int.ec.gc.ca") by vger.kernel.org with ESMTP
	id S1161291AbWHJODf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Aug 2006 10:03:35 -0400
content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: r.brandstaedter@gmx.at, albertl@mail.com
Cc: linux-ide@vger.kernel.org

> > >>Reinhard has a Plextor PX-712SA + svia.
> > >>Maybe he can also help to check whether the patch fixes the
problem on
> > >> his box.
> > >
> > > What I finally ended up with was solving the problem on the
hardware
> > > side:
> > >
> > > The Plextor PX-712SA is a normal ATA device wich a IDE:SATA
adapter
> > > plugged in at the back. I openend the DVDR Device (2 srews at the
back)
> > > repoved the adapter (1 screw) and then u get the normal IDE
Interface
> > > (with master/slave jumpers, audio interface and normal ower plug).
You
> > > can use this device on an normal IDE interface then. Works perfect
for
> > > me, maybe the 716SA Drive is similar
> > > This was the only solution that fixed the problem for me, any
submitted
> > > kernel patches didn't work.
> >
> > I'm curious what's the PATA-to-SATA bridge chip used on the Plextor
> > PX-712SA. (Maybe it is not compatible with the VIA chip.)
> > Could you please check the IC on the IDE-SATA adapter?

I'm also having an ASUS A8V Deluxe, running x86_64 with a 716SA plextor
drive.

Since 2.6.17 it's been working really well.  I don't think there is an
PATA-to-SATA interface into it but I can check that out tonight if
needed.

Cheers.

- vin
