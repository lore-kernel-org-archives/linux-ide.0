From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: Update on problems creating iteraid driver disk
Date: Sun, 25 Apr 2004 13:28:18 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200404251328.18467.bzolnier@elka.pw.edu.pl>
References: <408B270C.1050201@gear.dyndns.org> <1082890181.24757.12.camel@m64.net81-64-154.noos.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:32945 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261530AbUDYL3A
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 25 Apr 2004 07:29:00 -0400
In-Reply-To: <1082890181.24757.12.camel@m64.net81-64-154.noos.fr>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Nicolas Mailhot <Nicolas.Mailhot@laPoste.net>, fedora-devel-list@redhat.com
Cc: fedora-list@redhat.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Sunday 25 of April 2004 12:49, Nicolas Mailhot wrote:
> Le dim, 25/04/2004 =C3=A0 12:48 +1000, Paul Gear a =C3=A9crit :
> > Hi folks,
> >
> > A while back i posted about trying to create iteraid driver disks f=
or
> > FC1.  With the help of David Kewley's instructions
> > (http://www.klab.caltech.edu/~kewley/driverdisk/dd.html) on using D=
oug
> > Ledford's driver kit (http://people.redhat.com/dledford/), i manage=
d to
> > create a proper driver disk.
>
> Frankly if you really want to bother with ite hardware (the SII680 is
> available here for the same price and is perfectly supported under
> Linux) you should focus on getting their driver inside the kernel.org

ITE docs are _publicly_ available unlike SiI ones.

> sources.

Yep.

> ie make diffs, submit them to LKM, make the changes people request, e=
tc
> (ite is GPLed if  I remember well).
>
> This may seem more difficult but remember the kernel is a moving
> target : after six months you'll have spent more energy getting this
> out-of-tree driver work than getting it in-tree now.

Well, I still have ITE (libata!) driver on my TODO,
but due to lack of free drives and time it is not yet done.

Cheers.

