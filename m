From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: Fwd: CMD 64x regression from 2.6.21 to 2.6.22 and 2.6.23?
Date: Wed, 17 Oct 2007 00:14:26 +0200
Message-ID: <200710170014.28037.bzolnier@gmail.com>
References: <200710142211.03382.marogge@onlinehome.de> <4714A625.8040306@ru.mvista.com> <4714B1E6.9070308@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ik-out-1112.google.com ([66.249.90.176]:49195 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965887AbXJPWKS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 16 Oct 2007 18:10:18 -0400
Received: by ik-out-1112.google.com with SMTP id c28so1164452ika
        for <linux-ide@vger.kernel.org>; Tue, 16 Oct 2007 15:10:16 -0700 (PDT)
In-Reply-To: <4714B1E6.9070308@rtr.ca>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, Martin Rogge <marogge@onlinehome.de>, linux-ide@vger.kernel.org


Hi,

On Tuesday 16 October 2007, Mark Lord wrote:
> Sergei Shtylyov wrote:
> > Martin Rogge wrote:
> > 
> >>>    Could you git-bisect this?
> >>>    Although I have a couple of patch suspects (dealing with interrupts),
> >>> all worked fine with PCI-649 just fine. PCI-648 is not really much
> >>> different from 649 according to specs...
> > 
> >> Yes, I found the same when I managed to send the CMD 648 into UDMA-100 
> >> mode years ago (by treating it like a 649).
> > 
> >> Anyway, I found the git patches on kernel.org and bisected away. For 
> >> completeness, this is the table containing all my results.
> > 
> >> Kernel         System reaction
> >> ============================================================================ 
> >>
> >> 2.6.21         CMD 648 working fine
> >> 2.6.21-git4    CMD 648 working fine
> >> 2.6.21-git5    CMD 648 working fine
> >> 2.6.21-git6    irg 15: nobody cared [...] Disabling IRQ #15 etc.
> >> 2.6.21-git8    irg 15: nobody cared [...] Disabling IRQ #15 etc.
> >> 2.6.22-rc1     irg 15: nobody cared [...] Disabling IRQ #15 etc.
> >> 2.6.22         irg 15: nobody cared [...] Disabling IRQ #15 etc.
> >> 2.6.23         irg 15: nobody cared [...] Disabling IRQ #15 etc.
> > 
> >> Well, most likely the CMD related patches in git6 are the culprit. 
> > 
> >    Erm... usually bisection leaves you with one patch startting from 
> > which kernel was broken.  It seems you've done sort iof manual 
> > bisecting. Thanks anyway. :-)
> 
> He's certainly provided way more than enough information here to find/fix
> the bug.  The onus for hours of slaving away here is really on the person
> who *broke* it, not the innocent reporter!

Find the guilty and we will make him atone his sins in IDE quarry! ;)

Now speaking seriously: 2.6.21-git5 to 2.6.21-git6 still means 375 commits
and almost 2MB patch (with five patches for cmd64x alone - and looking
at the bugreport we really can't be 100% sure if this is IDE regression,
it could be IRQ routing as well).  However you are right that Martin
has already provided us with a lot of information, so...

Martin, could you run git-bisect (http://kerneltrap.org/node/11753 - sorry
for not explaining the procudure myself but Linus did it really well)
starting with:

	git bisect good 688a87d145e04f6761c63e7f2e19fd9b3e4ca060
	git bisect bad 826a1b6502d0d1d67fc41043fc831e90f2ef5835

The "good" one is the last commit before cmd64x changes and the "bad" one
is the first commit after them.  Since there is only 5 commits in between it
should be really quick find the bad one (worst-case: 3 recompiles/reboots).

If this "fastpath" doesn't work we are back to bisecting all 375 commits
between 2.6.21-git5 and 2.6.21-git6 with:

	git bisect good 62ea6d80211ecc88ef516927ecebf64cb505be3f 
	git bisect bad b7405e16435f710edfae6ba32bef4ca20d3de145

Which still doesn't look (that) bad with worst-case being 9 recompile/reboot
cycles.

> In this case, there are two very likely commits:
> 
> 7670df73fba373d19471a2ebedb3302ea0607be0 ide: mode limiting fixes for user requested speed changes
> 26bcb879c03254545a19c6700fe5bcef6f21e7b1 ide: add ide_set{_max}_pio() (take 4)

These two were merged just few days ago (probably some git related issue).

Thanks,
Bart
