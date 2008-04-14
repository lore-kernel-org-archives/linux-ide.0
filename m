From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: No IDE drivers loaded for Toshiba Satellite 320 CDS
Date: Mon, 14 Apr 2008 14:56:07 +0100
Message-ID: <20080414145607.3ae98a6f@core>
References: <200804021524.27222.elendil@planet.nl>
	<200804031947.07674.elendil@planet.nl>
	<48017248.4030600@gmail.com>
	<200804131559.21664.elendil@planet.nl>
	<20080414135214.GC7385@csclub.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:49837 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750808AbYDNOAS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 Apr 2008 10:00:18 -0400
In-Reply-To: <20080414135214.GC7385@csclub.uwaterloo.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: Frans Pop <elendil@planet.nl>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

> > 1) ide-generic is only loaded _after_ any otherwise detected modules

That is the correct approach, as with libata and ata_generic/pata_legacy

> > 2) it is only loaded if an ISA bus is present

All PC class systems have an ISA bus, it may be on the main board and
called LPC but it is there.

> > 3) it is only included in the initrd for the installed system if loading it
> >    in the installer resulted in additional block devices appearing
> 
> OK, great for x86 perhaps, what about other systems?

Should be valid for all sane ISA bus systems. The IDE legacy code as per
arch probe rules.

> > I would unload ide-generic in the installer if no additional block devices 
> > appear, but unfortunately that's not possible as it is marked "permanent".

Yes - old IDE doesn't do hotplugging, libata can so your approach would
work there.


Alan
