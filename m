From: Willy Tarreau <w@1wt.eu>
Subject: Re: SATA update in 2.4, ICH8
Date: Fri, 22 Jun 2007 21:13:44 +0200
Message-ID: <20070622191344.GB3629@1wt.eu>
References: <87y7idiwjd.fsf@naruto.ifr.lan> <20070621182119.GB26637@1wt.eu> <87myysfqo4.fsf@naruto.ifr.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 1wt.eu ([62.212.114.60]:3085 "EHLO 1wt.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750755AbXFVTNw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 22 Jun 2007 15:13:52 -0400
Content-Disposition: inline
In-Reply-To: <87myysfqo4.fsf@naruto.ifr.lan>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Vincent Bernat <Vincent.Bernat@wallix.com>
Cc: linux-ide@vger.kernel.org, JF Taltavull <jean-francois.taltavull@wallix.com>, Jeff Garzik <jeff@garzik.org>

On Fri, Jun 22, 2007 at 08:29:15AM +0200, Vincent Bernat wrote:
> Hi Willy !
> 
> > I do not have any idea right now. I recall having had some difficulties some
> > time ago with ata_piix when piix itself was not disabled, but those were in
> > the early libata times. I *believe*  it's OK now but you might want to
> > check.
> 
> I will try to compile a kernel without piix enabled and keep you in touch.

OK, I've read your other mail, it does not work either.

> > Also, is your CDROM driver parallel ATA or SATA ? It is not clear to me from
> > your logs. Because if it is ATA, you should need to run with piix enabled just
> > for it,  and, if my memory  serves me correctly, to  start piix before
> > ata_piix.
> 
> This is a SATA CDROM. There is no PATA controller on the motherboard.

I've never tested any SATA CDROM yet. I don't even know if they work with
2.4 libata. So most likely you have more experience than me in this area.
If you have any other SATA controller on another machine on which you would
test the drive, it could help up determine whether it's the CDROM which is
causing the trouble or this specific controller+driver combination.

> > BTW, what motherboard is it ?
> 
> It is a Dell OptiPlex 745.

OK, so it's a desktop. Not that this is an excuse for it not to work, but it
generally is less of a problem to upgrade to 2.6 when changing a desktop than
it is on a server with all the applications that run on it.

> > And provided that the CDROM drive finally works,
> > or that we find a valid reason for it not to work, are you implicitly asking
> > for mainline inclusion of your patch (or a fixed one) or is it here just for
> > explanation purposes ?
> 
> If ICH8 can work with a 2.4  with just this tiny patch, yes, it could be
> included into mainline.

OK. At least I would wait for the reason of the failure to be either fixed
or known.

> In this case, we may want to  add more ICH8 PCI
> ID (I have only included the ones that appear in lspci for me).

I would prefer that we merge only things which we can test, in order to avoid
painful experiences to people who trust the 2.4 branch. The 2.4 scope is not
to support everything people have, but to reliably support what people
absolutely need. On a scale of acceptability, I would say that new notebook
drivers are unlikely to be merged, desktop drivers may still be merged provided
they are trivial, and that server drivers will be merged if they are required
to support unexpected hardware replacement.

Regards,
Willy

