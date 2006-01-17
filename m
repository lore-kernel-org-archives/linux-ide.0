From: Erik Mouw <erik@harddisk-recovery.com>
Subject: Re: [PATCH 1/4] SATA ACPI build (applies to 2.6.16-git9)
Date: Tue, 17 Jan 2006 10:01:01 +0100
Message-ID: <20060117090101.GA25963@harddisk-recovery.nl>
References: <20060113224252.38d8890f.rdunlap@xenotime.net> <20060116115607.GA18307@harddisk-recovery.nl> <20060116140713.GB18307@harddisk-recovery.com> <20060116210418.GG29663@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from dtp.xs4all.nl ([80.126.206.180]:1841 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S932352AbWAQJBI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Jan 2006 04:01:08 -0500
Content-Disposition: inline
In-Reply-To: <20060116210418.GG29663@stusta.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, ide <linux-ide@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>, jgarzik <jgarzik@pobox.com>

On Mon, Jan 16, 2006 at 10:04:18PM +0100, Adrian Bunk wrote:
> On Mon, Jan 16, 2006 at 03:07:13PM +0100, Erik Mouw wrote:
> > On Mon, Jan 16, 2006 at 12:56:07PM +0100, Erik Mouw wrote:
> > > Could you add some help text over here? At first glance I got the
> > > impression this was a host driver that works through ACPI calls, but by
> > > reading the rest of your patches it turns out it is a suspend/resume
> > > helper.
> > 
> > Something like this should already be enough:
> > 
> >   This option enables support for SATA suspend/resume using ACPI.
> > 
> > If you really need this enabled to be able to use suspend/resume at
> > all, you could add a line like:
> > 
> >   It's safe to say Y. If you say N, you might get serious disk
> >   corruption when you suspend your machine.
> >...
> 
> Why?
> 
> This is not a user-visible option...

Just curious, how do you see it's not user visible?


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
| Data lost? Stay calm and contact Harddisk-recovery.com
