From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: Kernel problem or faulty drive?
Date: Tue, 30 Nov 2010 18:26:20 +1030 (CST)
Message-ID: <201011300756.oAU7uK8x027396@mercury.physics.adelaide.edu.au>
References: <20101122140755.3b02abe6@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from adelphi.physics.adelaide.edu.au ([129.127.102.1]:48442 "EHLO
	adelphi.physics.adelaide.edu.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754157Ab0K3H4e (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Nov 2010 02:56:34 -0500
In-Reply-To: <20101122140755.3b02abe6@lxorguk.ukuu.org.uk> from "Alan Cox" at Nov 22, 2010 02:07:55 PM
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, linux-ide@vger.kernel.org

> > At various times the drive seems to get into a state whereby it has repeated
> > trouble communicating with the kernel.  The drive clicks once, there's some
> > seek activity by the drive and the following set of messages (along with
> > variations) are written to the log:
> > 
> >   ata3: exception Emask 0x50 SAct 0x0 SErr 0x4010800 action 0xe frozen
> >   ata3: irq_stat 0x00400040, connection status changed
> >   ata3: SError: { HostInt PHYRdyChg DevExch }
> 
> It reported the drive being hot plugged.
> 
> >   ata3: hard resetting link
> >   ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
> >   ata3.00: configured for UDMA/33
> 
> And a slightly odd choice of speed.
> 
> > This can occur a dozen or more times before the drive settles down, or it
> > may occur only once.  All this is while Linux is not accessing the drive and
> > none of its partitions are mounted.
> 
> Check the cables their connections and check your power is sufficient, a
> drive dropping off the bus is a classic symptom of insufficient power on
> the supply line it is using (with some PSUs moving to a different
> 'strand' of cable from the PSU box may be enough.

Thanks for the suggestions everyone.  I ended up changing the PSU over to a
new one since I've seen other odd things on the machine from time to time
which *may* have been due to a flaky power supply.  Since making the change
to a new Vantec Ion2+ 600W unit I have not yet had a recurrance of the SATA
symptoms so it may have been a slightly faulty PSU (it was an Antec 550W,
which should have been enough in this system).

I'll probably need to wait for another few weeks before declaring the
problem solved because it has in the past gone away of its own accord for
several weeks on end.  If things return I'll post again after pursuing the
other options which have been suggested.

Regards
  jonathan
