From: Thierry Vignaud <tvignaud@mandriva.com>
Subject: Re: [Fwd: [BUG] sata_via doesn't detect anymore my disks (broken between rc1 and rc3)]
Date: Mon, 28 Aug 2006 17:43:13 +0200
Message-ID: <m264gcdfxq.fsf@vador.mandriva.com>
References: <m2wt98bio1.fsf@vador.mandriva.com>
	<m2sljwbil7.fsf@vador.mandriva.com> <44E37BD4.8010709@pobox.com>
	<m23bbva9cs.fsf@vador.mandriva.com> <44E46E0E.4060703@gmail.com>
	<m2fyfv7a8s.fsf@vador.mandriva.com> <44EB32AD.1080305@gmail.com>
	<m2fyfnciky.fsf@vador.mandriva.com> <m2d5aprtw0.fsf@vador.mandriva.com>
	<44EEEA29.1010008@gmail.com> <20060825135540.GE21866@htj.dyndns.org>
	<m2ac5soqjl.fsf@vador.mandriva.com> <44EF1158.1040507@gmail.com>
	<m2r6z1c4k9.fsf@vador.mandriva.com> <44F30ABE.2050803@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ezoffice.mandriva.com ([84.14.106.134]:31758 "EHLO
	office.mandriva.com") by vger.kernel.org with ESMTP
	id S1751083AbWH1PnP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 28 Aug 2006 11:43:15 -0400
In-Reply-To: <44F30ABE.2050803@gmail.com> (Tejun Heo's message of "Tue, 29 Aug 2006 00:24:46 +0900")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Tejun Heo <htejun@gmail.com> writes:

> >>>>> The second patch is essentially identical to what you did the
> >>>>> one liner.  Can you please check it once more?  I'll prepare
> >>>>> old-sequence hardreset in the meantime.
> >>>> Okay, here's the old-sequence hardreset patch.  This should
> >>>> have the highest chance of working.  This patch should be
> >>>> applied on top of the vt6420 patch.
> >>> On top of which patch?
> >>> I just tried to apply it on top of:
> >>> - your last week patch
> >>> - your two patches of this week
> >>> and it does *not* apply on top of anyone...
> >> Arghh... Sorry.  I sent the wrong version.  This patch is against
> >> #upstream while I should have sent the one against
> >> #upstream-fixes.
> >>
> >>> Couldn't you either check first your patch or (better) just send
> >>> a patch against vanilla 2.6.18-rc4-mm2?
> >> I've attached whole sata_via.c to the other mail.  I think that
> >> should do the trick.
> > It didn't (tested by overwriting 2.6.18-rc4-mm2's driver).
> > I tried a few reset methods combinations w/os success.
> > Like in other faillure cases, the driver saw the two links but
> > failed to see the hd attached to the second sata link.
> 
> Hmmm.. That's very weird.  The detection sequence is almost
> identical to the original code.  Argh.....  Any ideas?

It looks like the error managment has effects on the disc discovering.
You wrote "vt6421 fails to detect attached device if SCR registers are
accessed with the wrong timing".
Maybe should we increase the timing?
