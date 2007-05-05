From: Jim Paris <jim@jtan.com>
Subject: Re: Data corruption with sata_sil (Sil 3112)
Date: Fri, 4 May 2007 22:40:04 -0400
Message-ID: <20070505024004.GA17765@jim.sh>
References: <20070504085955.GA5937@hostway.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from NEUROSIS.MIT.EDU ([18.95.3.133]:38553 "EHLO neurosis.jim.sh"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755437AbXEECkN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 4 May 2007 22:40:13 -0400
Content-Disposition: inline
In-Reply-To: <20070504085955.GA5937@hostway.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Simon Kirby <sim@netnation.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

> I've been having problems with Sil 3112 cards I purchased for additional
> SATA ports resulting in read data corruption, about 3-5 instances over
> 2 GB of data, 100% reproducible.
..
> I just rebuilt the entire box with the remains of another (went from
> A7V8X (VIA) to A7N8X (NVidia), new CPU, new RAM, new power supply),
> thinking the problem was related to the motherboard.  The issue followed
> to the new box.

Have you tried different disks?  I recently spent a long time trying
to track down the same sort of problem and it ended up being a bad
HD (not a media failure, so SMART didn't report it).

> This new motherboard has an onboard Sil 3112 as well.  The old onboard
> was VIA SATA, which did not corrupt anything.  The Sil 3112 onboard now
> does too.

Maybe the VIA controller was only 1.5 Gbps and your 3112 controllers
are running at 3.0 Gbps?  Some drives have a jumper that lets you
limit their operation to 1.5, which you could try.

> Scipt used to md5sum to find corruption:
> 
> 	find $* -type f -print0 | sort -z | xargs -0 md5sum

Can you figure out the nature of the corruption?  Flipped bit, entire
blocks corrupted, etc?  Maybe make two big identical files and use
"cmp -l" to see how they read differently.

-jim

