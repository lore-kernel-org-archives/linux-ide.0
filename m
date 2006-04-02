From: Mark Hahn <hahn@physics.mcmaster.ca>
Subject: Re: sata_sil or libata?
Date: Sun, 2 Apr 2006 00:30:29 -0500 (EST)
Message-ID: <Pine.LNX.4.44.0604012339040.11461-100000@coffee.psychology.mcmaster.ca>
References: <a8b98fc60604011752m67727f9chf2f5e11d6ed2a3eb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from coriana6.CIS.McMaster.CA ([130.113.128.17]:63877 "EHLO
	coriana6.cis.mcmaster.ca") by vger.kernel.org with ESMTP
	id S1750786AbWDBFad (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 2 Apr 2006 00:30:33 -0500
In-Reply-To: <a8b98fc60604011752m67727f9chf2f5e11d6ed2a3eb@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Wesley Lim <wesleylim@gmail.com>
Cc: David Greaves <david@dgreaves.com>, linux-ide@vger.kernel.org

> > >     Additional sense: Unrecovered read error - auto reallocate failed
> > > end_request: I/O error, dev sdb, sector 393692817
> >
> > this sort of thing would make me want to sanity-check the drives,
> > since it certainly sounds like a media/heat/vibration/power problem.
> >
> > have you run a SMART selftest on these drives?
> 
> I've done badblocks on the drive and it's fine. I haven't tried
> smartctl as I read -d ata can cause problems because of some SCSI
> queuing thing? Can I safely use smartd yet?

afaikt, the smart thing had to do with incomplete locking of 
the scsi passthrough stuff.  it was never an issue in a testing
situation (without other IO), and I'd guess it's been fixed since.

