From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH 1/4] SATA ACPI build (applies to 2.6.16-git9)
Date: Wed, 18 Jan 2006 13:24:09 +0100
Message-ID: <20060118122409.GA17046@elf.ucw.cz>
References: <20060113224252.38d8890f.rdunlap@xenotime.net> <20060116115607.GA18307@harddisk-recovery.nl> <20060116140713.GB18307@harddisk-recovery.com> <20060116224626.GS3945@suse.de> <1137452436.15553.93.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:41378 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932324AbWARMY2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Jan 2006 07:24:28 -0500
Content-Disposition: inline
In-Reply-To: <1137452436.15553.93.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jens Axboe <axboe@suse.de>, Erik Mouw <erik@harddisk-recovery.com>, "Randy.Dunlap" <rdunlap@xenotime.net>, ide <linux-ide@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>, jgarzik <jgarzik@pobox.com>

Hi!

> > > If you really need this enabled to be able to use suspend/resume at
> > > all, you could add a line like:
> > > 
> > >   It's safe to say Y. If you say N, you might get serious disk
> > >   corruption when you suspend your machine.
> > 
> > That's simply not true. If you say N (if you could), you could risk
> > having a non-responsive disk after resume. However, it would have been
> > synced a suspend time so you wont corrupt anything.
> 
> If you do not execute the ACPI taskfiles for the device and you are
> doing an ACPI suspend you are in completely undefined space. Whether it
> eats your disk or not is a question of probabilities only. Yes its
> unlikely but you are in undefined space so "won't corrupt anything"
> indicates an inappropriate level of certainty.

Okay, but being in undefined state still does not warrant "you might
get serious disk corruption when you suspend your machine." . What about:

It's safe to say Y. If you say N, you may run into problems after you
suspend your machine.

								Pavel
-- 
Thanks, Sharp!
