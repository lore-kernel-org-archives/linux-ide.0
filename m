From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: sata_promise ata exceptions (2.6.20.6)
Date: Fri, 13 Apr 2007 23:21:27 +0200 (MEST)
Message-ID: <200704132121.l3DLLRDb020449@harpo.it.uu.se>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:64488 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030490AbXDMVVe (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 13 Apr 2007 17:21:34 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tomi.Orava@ncircle.nullnet.fi, linux-ide@vger.kernel.org

On Fri, 13 Apr 2007 21:36:41 +0300 (EEST), Tomi Orava wrote:
> Related to my previous tests, it seems that after I changed the order of the
> hard-disks connected to Promise Sata300TX4 the errors followed both of the
> 7200.10 disks. I swapped the power supply and the SATA-cables at the same
> time
> and still get the following kind of errors (and only with 7200.10, _never_
> with
> the older 7200.7 disks):

Thanks. This tells us that it's not a power or cabling issue, but some
kind of interface or programming incompatibility with the 7200.10 disks.

My theory is that either TBG clocking (which drives the SATA interfaces)
or SET FEATURE snooping (which adjusts internal parameters for different
PIO/(U)DMA modes) is borked for SATAII/3Gbps. I hope to have time to
investigate that soon. If you can limit transfer speeds to 1.5Gpbs then
that may provide a workaround for now.

/Mikael
