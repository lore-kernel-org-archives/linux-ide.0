From: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH 1/4] SATA ACPI build (applies to 2.6.16-git9)
Date: Tue, 17 Jan 2006 00:10:05 +0100
Message-ID: <20060116231005.GV3945@suse.de>
References: <20060113224252.38d8890f.rdunlap@xenotime.net> <20060116115607.GA18307@harddisk-recovery.nl> <20060116140713.GB18307@harddisk-recovery.com> <20060116224626.GS3945@suse.de> <1137452436.15553.93.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:15443 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751201AbWAPXIM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Jan 2006 18:08:12 -0500
Content-Disposition: inline
In-Reply-To: <1137452436.15553.93.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Erik Mouw <erik@harddisk-recovery.com>, "Randy.Dunlap" <rdunlap@xenotime.net>, ide <linux-ide@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>, jgarzik <jgarzik@pobox.com>

On Mon, Jan 16 2006, Alan Cox wrote:
> On Llu, 2006-01-16 at 23:46 +0100, Jens Axboe wrote:
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

Sorry, but I think that is FUD. The disk better well be in a synced and
idle state when you power it down, regardless of how you do it. It may
refuse to talk to you after resuming, if that by some weird strike of
lightning causes corruption then you are really unlucky. It definitely
doesn't warrant a nasty warning which, as pointed out by someone else,
isn't even visible as the config selects itself.

> Fortunately it is better than the old PATA layer where as far as I can
> tell if the BIOS resume restores the BIOS HPA setup you may actually end
> up doing more damage by running ACPI taskfiles as we don't appear to
> restore enough drive state.

That is indeed a nasty bug, I have a pending fix for that. It's a pretty
easy fix, just introduce a another resume step that issues the hpa
reinit like we do on boot.

-- 
Jens Axboe

