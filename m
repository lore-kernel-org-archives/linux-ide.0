From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: [PATCH 1/4] SATA ACPI build (applies to 2.6.16-git9)
Date: Mon, 16 Jan 2006 07:58:36 -0800 (PST)
Message-ID: <Pine.LNX.4.58.0601160757480.24990@shark.he.net>
References: <20060113224252.38d8890f.rdunlap@xenotime.net>
 <20060116123112.GZ3945@suse.de> <1137426710.15553.0.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:49859 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751031AbWAPP6j (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Jan 2006 10:58:39 -0500
Received: from shark.he.net ([66.160.160.2]) by xenotime.net for <linux-ide@vger.kernel.org>; Mon, 16 Jan 2006 07:58:36 -0800
In-Reply-To: <1137426710.15553.0.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jens Axboe <axboe@suse.de>, "Randy.Dunlap" <rdunlap@xenotime.net>, ide <linux-ide@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>, jgarzik <jgarzik@pobox.com>

On Mon, 16 Jan 2006, Alan Cox wrote:

> On Llu, 2006-01-16 at 13:31 +0100, Jens Axboe wrote:
> > On Fri, Jan 13 2006, Randy.Dunlap wrote:
> > > From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
> > >
> > > Add ata_acpi in Makefile and Kconfig.
> > > Add ACPI obj_handle.
> > > Add ata_acpi.c to libata kernel-doc template file.
> >
> > Randy,
> >
> > Any chance you can add PATA support as well for this?
>
> It should just work with pata devices using libata.

ACPI namespace is different for PATA and SATA devices.
Once the device is found in the namespace, it may be very
similar (or it may not, I dunno yet).

-- 
~Randy
