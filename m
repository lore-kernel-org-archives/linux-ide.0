From: Alan Cox <alan@redhat.com>
Subject: Re: IDE hackery: lock fixes and hotplug controller stuff
Date: Thu, 12 Aug 2004 14:56:14 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040812185614.GC866@devserv.devel.redhat.com>
References: <20040810161911.GA10565@devserv.devel.redhat.com> <200408101916.17489.bzolnier@elka.pw.edu.pl> <20040810182353.GA17364@devserv.devel.redhat.com> <200408121912.35507.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:19365 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268659AbUHLS7U (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 12 Aug 2004 14:59:20 -0400
Content-Disposition: inline
In-Reply-To: <200408121912.35507.bzolnier@elka.pw.edu.pl>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Thu, Aug 12, 2004 at 07:12:35PM +0200, Bartlomiej Zolnierkiewicz wrote:
> It is a correct analysis for /proc/ide/hdx/settings:ide-scsi but not 
> for /proc/ide/hdx/driver which works just fine (modulo being racy)
> and your patch removes both interfaces...

I see no viable way to fix it, and I see nobody using it so it should
die. If someone does want to keep it then they can rewrite the ide layer
to make it work.

BTW I've been over the proc stuff and fixed that up including all the
locking. I can now happily insmod it8212, rmmod it8212, insmod it8212 etc
and the /proc files behave. I did have to make a couple of tweaks to cover
the locking cases not covered. 

I also have the it8212 working in smart but non raid now. Seems issuing an
LBA 48 cache flush (0xEF) crashes the firmware which is why it died on load 
for some users.  To do that I've added hwif->raw_taskfile() so that an
interface can filter commands.

Next stop disk hot plugging.

Alan

