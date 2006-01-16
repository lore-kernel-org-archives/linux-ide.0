From: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH 1/4] SATA ACPI build (applies to 2.6.16-git9)
Date: Mon, 16 Jan 2006 17:02:24 +0100
Message-ID: <20060116160224.GM3945@suse.de>
References: <20060113224252.38d8890f.rdunlap@xenotime.net> <20060116123112.GZ3945@suse.de> <1137426710.15553.0.camel@localhost.localdomain> <Pine.LNX.4.58.0601160757480.24990@shark.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751067AbWAPQA3@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0601160757480.24990@shark.he.net>
Sender: linux-kernel-owner@vger.kernel.org
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, ide <linux-ide@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>, jgarzik <jgarzik@pobox.com>
List-Id: linux-ide@vger.kernel.org

On Mon, Jan 16 2006, Randy.Dunlap wrote:
> On Mon, 16 Jan 2006, Alan Cox wrote:
> 
> > On Llu, 2006-01-16 at 13:31 +0100, Jens Axboe wrote:
> > > On Fri, Jan 13 2006, Randy.Dunlap wrote:
> > > > From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
> > > >
> > > > Add ata_acpi in Makefile and Kconfig.
> > > > Add ACPI obj_handle.
> > > > Add ata_acpi.c to libata kernel-doc template file.
> > >
> > > Randy,
> > >
> > > Any chance you can add PATA support as well for this?
> >
> > It should just work with pata devices using libata.
> 
> ACPI namespace is different for PATA and SATA devices.
> Once the device is found in the namespace, it may be very
> similar (or it may not, I dunno yet).

The naming seems different (eg IDEC -> PRID on SATA, IDE0 -> MSTR on
PATA).

-- 
Jens Axboe
