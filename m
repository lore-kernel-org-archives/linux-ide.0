From: Erik Mouw <erik@harddisk-recovery.com>
Subject: Re: [PATCH 1/4] SATA ACPI build (applies to 2.6.16-git9)
Date: Tue, 17 Jan 2006 10:09:03 +0100
Message-ID: <20060117090903.GB25963@harddisk-recovery.nl>
References: <20060113224252.38d8890f.rdunlap@xenotime.net> <20060116115607.GA18307@harddisk-recovery.nl> <20060116140713.GB18307@harddisk-recovery.com> <20060116224626.GS3945@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from dtp.xs4all.nl ([80.126.206.180]:56371 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S932363AbWAQJJE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Jan 2006 04:09:04 -0500
Content-Disposition: inline
In-Reply-To: <20060116224626.GS3945@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, ide <linux-ide@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>, jgarzik <jgarzik@pobox.com>

On Mon, Jan 16, 2006 at 11:46:27PM +0100, Jens Axboe wrote:
> On Mon, Jan 16 2006, Erik Mouw wrote:
> > Something like this should already be enough:
> > 
> >   This option enables support for SATA suspend/resume using ACPI.
> > 
> > If you really need this enabled to be able to use suspend/resume at
> > all, you could add a line like:
> > 
> >   It's safe to say Y. If you say N, you might get serious disk
> >   corruption when you suspend your machine.
> 
> That's simply not true. If you say N (if you could), you could risk
> having a non-responsive disk after resume. However, it would have been
> synced a suspend time so you wont corrupt anything.

That's what I mean: I have no idea if it eats your disks or not. The
point is that if it does, it should be mentioned in the help text.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
| Data lost? Stay calm and contact Harddisk-recovery.com
