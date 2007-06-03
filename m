From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: always use polling SETXFER
Date: Sun, 03 Jun 2007 12:00:51 -0400
Message-ID: <4662E5B3.4020205@garzik.org>
References: <46598350.6030403@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:38448 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752692AbXFCQAy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 3 Jun 2007 12:00:54 -0400
In-Reply-To: <46598350.6030403@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>

Tejun Heo wrote:
> Several people have reported LITE-ON LTR-48246S detection failed
> because SETXFER fails.  It seems the device raises IRQ too early after
> SETXFER.  This is controller independent.  The same problem has been
> reported for different controllers.
> 
> So, now we have pata_via where the controller raises IRQ before it's
> ready after SETXFER and a device which does similar thing.  This patch
> makes libata always execute SETXFER via polling.  As this only happens
> during EH, performance impact is nil.  Setting ATA_TFLAG_POLLING is
> also moved from issue hot path to ata_dev_set_xfermode() - the only
> place where SETXFER can be issued.
> 
> Note that ATA_TFLAG_POLLING applies only to drivers which implement
> SFF TF interface and use libata HSM.  More advanced controllers ignore
> the flag.  This doesn't matter for this fix as SFF TF controllers are
> the problematic ones.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/libata-core.c |   13 ++++---------
>  drivers/ata/pata_via.c    |   12 ++++++------
>  include/linux/libata.h    |    1 -
>  3 files changed, 10 insertions(+), 16 deletions(-)

To Linus and Andrew:

After discussion and a minor revision (mostly to the description), I am 
OK with this patch.

At this point, I am only reluctant to push it for 2.6.22 since it is so 
late in the -rc series.

If we have another -rc, I would probably be OK with pushing it for 
2.6.22, otherwise I would prefer to wait for 2.6.23.

Comments solicited, from all involved...

	Jeff


