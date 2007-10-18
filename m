From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [git patch] another libata fix
Date: Thu, 18 Oct 2007 16:26:26 -0400
Message-ID: <4717C172.1030104@garzik.org>
References: <20071018202432.GA16160@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53810 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763799AbXJRU0d (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 18 Oct 2007 16:26:33 -0400
In-Reply-To: <20071018202432.GA16160@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Jeff Garzik wrote:
> NOTE:  This is appended to the previous libata fixes, in a linear
> history.  If you pull this, and have not pulled yesterday's submission,
> you will get -both-.  If you pulled yesterday's fixes, you will only get
> the single changeset below.
> 
> Please pull from 'upstream-linus' branch of
> master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git upstream-linus
> 
> to receive the following updates:
> 
>  drivers/ata/pdc_adma.c   |    9 +-
>  drivers/ata/sata_mv.c    |   26 +-
>  drivers/ata/sata_sil24.c |   11 +-
>  drivers/scsi/ipr.c       |   11 +-
>  include/linux/libata.h   |   12 -
>  11 files changed, 1567 insertions(+), 90 deletions(-)
>  create mode 100644 drivers/ata/sata_fsl.c
> 
> 
> [libata] kill ata_sg_is_last()
> 
> Short term, this works around a bug introduced by early sg-chaining
> work.
> 
> Long term, removing this function eliminates a branch from a hot
> path loop in each scatter/gather table build.  Also, as this code
> demonstrates, we don't need to _track_ the end of the s/g list, as
> long as we mark it in some way.  And doing so programatically is nice.
> So its a useful cleanup, regardless of its short term effects.
> 
> Based conceptually on a quick patch by Jens Axboe.
> 
> Signed-off-by: Jeff Garzik <jgarzik@redhat.com>


And if it wasn't clear from the flurry of emails, this is independent 
from and parallel to Jens' current work.

So, it should not conflict, and it fixes several do-not-work-at-all 
drivers broken by sg-chaining.

	Jeff



