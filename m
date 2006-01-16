From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/4] SATA ACPI build (applies to 2.6.16-git9)
Date: Mon, 16 Jan 2006 15:51:50 +0000
Message-ID: <1137426710.15553.0.camel@localhost.localdomain>
References: <20060113224252.38d8890f.rdunlap@xenotime.net>
	 <20060116123112.GZ3945@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:37032 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751034AbWAPPs2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 16 Jan 2006 10:48:28 -0500
In-Reply-To: <20060116123112.GZ3945@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, ide <linux-ide@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>, jgarzik <jgarzik@pobox.com>

On Llu, 2006-01-16 at 13:31 +0100, Jens Axboe wrote:
> On Fri, Jan 13 2006, Randy.Dunlap wrote:
> > From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
> > 
> > Add ata_acpi in Makefile and Kconfig.
> > Add ACPI obj_handle.
> > Add ata_acpi.c to libata kernel-doc template file.
> 
> Randy,
> 
> Any chance you can add PATA support as well for this? 

It should just work with pata devices using libata.

Alan

