From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/4] SATA ACPI build (applies to 2.6.16-git9)
Date: Mon, 16 Jan 2006 23:00:36 +0000
Message-ID: <1137452436.15553.93.camel@localhost.localdomain>
References: <20060113224252.38d8890f.rdunlap@xenotime.net>
	 <20060116115607.GA18307@harddisk-recovery.nl>
	 <20060116140713.GB18307@harddisk-recovery.com>
	 <20060116224626.GS3945@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:8915 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751250AbWAPW45 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 16 Jan 2006 17:56:57 -0500
In-Reply-To: <20060116224626.GS3945@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: Erik Mouw <erik@harddisk-recovery.com>, "Randy.Dunlap" <rdunlap@xenotime.net>, ide <linux-ide@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>, jgarzik <jgarzik@pobox.com>

On Llu, 2006-01-16 at 23:46 +0100, Jens Axboe wrote:
> > If you really need this enabled to be able to use suspend/resume at
> > all, you could add a line like:
> > 
> >   It's safe to say Y. If you say N, you might get serious disk
> >   corruption when you suspend your machine.
> 
> That's simply not true. If you say N (if you could), you could risk
> having a non-responsive disk after resume. However, it would have been
> synced a suspend time so you wont corrupt anything.

If you do not execute the ACPI taskfiles for the device and you are
doing an ACPI suspend you are in completely undefined space. Whether it
eats your disk or not is a question of probabilities only. Yes its
unlikely but you are in undefined space so "won't corrupt anything"
indicates an inappropriate level of certainty.

Fortunately it is better than the old PATA layer where as far as I can
tell if the BIOS resume restores the BIOS HPA setup you may actually end
up doing more damage by running ACPI taskfiles as we don't appear to
restore enough drive state.

Alan


