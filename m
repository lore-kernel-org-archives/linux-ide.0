From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] pata_legacy: multiple updates (rediff as asked)
Date: Fri, 01 Feb 2008 11:57:09 -0500
Message-ID: <47A34F65.6000401@garzik.org>
References: <20080128161001.1ceab333@core>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:60662 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755253AbYBAQ5L (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 1 Feb 2008 11:57:11 -0500
In-Reply-To: <20080128161001.1ceab333@core>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

Alan Cox wrote:
> - Fix probe logic to support multiple devices better
> - Fold in qdi and winbond support
> - Fix promise 202C30 probe
> - Restructure

hrm, some of this is already in #upstream (and thus -mm, though maybe 
akpm has not yet regenerated his stuff).

patch(1) seems to think I already have this stuff, and indeed the most 
recent changesets in pata_legacy are


commit b832548773b0cd98216534caa31b9ed7607c4e76
Author: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date:   Sat Jan 19 15:47:23 2008 +0000

     pata_legacy: Merge winbond support

     This puts winbond VLB in with the other ISA/VLB support and means 
we can
     lose pata_winbond.c. With all the VLB/ISA probe in one space (and 
out of
     the core libata) this makes legacy probing work sanely.

     Also switch to devm_ for resource handling on the ports post probe

     Signed-off-by: Alan Cox <alan@redhat.com>
     Signed-off-by: Jeff Garzik <jeff@garzik.org>

commit defc9cd826e4a99f550504a744f9407b518828ae
Author: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date:   Thu Jan 10 14:33:10 2008 -0800

     pata_legacy: resychronize with upstream changes and resubmit

     Update the legacy driver so it can handle VLB ports nicely, and has an
     internal structure for nailing new ISA/VLB forms in.  Anyone got an 
ALI14xx
     and a spare day ;)

     Also adds an "all" parameter so you can load this driver after all 
the PCI
     ones in a boot time kernel and tell it to grab anything ST412 
compatible
     even if it is an unknown PCI device.  That allows libata to offer 
the same
     "just get me a disk somehow" fallback that old IDE did.

     Obsoletes pata_qdi.

     Signed-off-by: Alan Cox <alan@redhat.com>
     Cc: Tejun Heo <htejun@gmail.com>
     Cc: Jeff Garzik <jeff@garzik.org>
     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
     Signed-off-by: Jeff Garzik <jeff@garzik.org>



