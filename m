From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: IDE hackery: lock fixes and hotplug controller stuff
Date: Thu, 12 Aug 2004 21:46:56 +0200 (CEST)
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <Pine.GSO.4.58.0408122122190.12534@mion.elka.pw.edu.pl>
References: <20040810161911.GA10565@devserv.devel.redhat.com>
 <200408101916.17489.bzolnier@elka.pw.edu.pl> <20040810182353.GA17364@devserv.devel.redhat.com>
 <200408121912.35507.bzolnier@elka.pw.edu.pl> <20040812185614.GC866@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:44712 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S268675AbUHLTsY
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 12 Aug 2004 15:48:24 -0400
In-Reply-To: <20040812185614.GC866@devserv.devel.redhat.com>
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org


On Thu, 12 Aug 2004, Alan Cox wrote:

> On Thu, Aug 12, 2004 at 07:12:35PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > It is a correct analysis for /proc/ide/hdx/settings:ide-scsi but not
> > for /proc/ide/hdx/driver which works just fine (modulo being racy)
> > and your patch removes both interfaces...
>
> I see no viable way to fix it, and I see nobody using it so it should
> die. If someone does want to keep it then they can rewrite the ide layer
> to make it work.

"driver" interface _works_ (tested earlier today with 2.6.8-rc3-bk3)
and how do you know that there are no users of it, from the magic ball?

Also aren't you the one who has made "ide-scsi" interface non-functional
by introducing ide_setting_sem, he? 8)

http://lkml.org/lkml/2003/2/18/146

I fully agree that both interfaces should be removed nowadays but this
should be done with some (minimal) care...

> I also have the it8212 working in smart but non raid now. Seems issuing an
> LBA 48 cache flush (0xEF) crashes the firmware which is why it died on load
> for some users.  To do that I've added hwif->raw_taskfile() so that an
> interface can filter commands.

Ouch, they should really fix this in the firmware.

Bartlomiej
