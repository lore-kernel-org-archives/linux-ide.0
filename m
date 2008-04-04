From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 12/27] libata: restructure SFF post-reset readiness waits
Date: Fri, 04 Apr 2008 02:58:01 -0400
Message-ID: <47F5D179.5010705@garzik.org>
References: <1206451025926-git-send-email-htejun@gmail.com> <1206451027353-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:56705 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755522AbYDDG6R (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 4 Apr 2008 02:58:17 -0400
In-Reply-To: <1206451027353-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, liml@rtr.ca, alan@lxorguk.ukuu.org.uk, James.Bottomley@HansenPartnership.com, brking@us.ibm.com, ashish.kalra@freescale.com, leoli@freescale.com

Tejun Heo wrote:
> Previously, post-softreset readiness is waited as follows.
> 
> 1. ata_sff_wait_after_reset() waits for 150ms and then for
>    ATA_TMOUT_FF_WAIT if status is 0xff and other conditions meet.
> 
> 2. ata_bus_softreset() finishes with -ENODEV if status is still 0xff.
>    If not, continue to #3.
> 
> 3. ata_bus_post_reset() waits readiness of dev0 and/or dev1 depending
>    on devmask using ata_sff_wait_ready().
> 
> And for post-hardreset readiness,
> 
> 1. ata_sff_wait_after_reset() waits for 150ms and then for
>    ATA_TMOUT_FF_WAIT if status is 0xff and other conditions meet.
> 
> 2. sata_sff_hardreset waits for device readiness using
>    ata_sff_wait_ready().
> 
> This patch merges and unifies post-reset readiness waits into
> ata_sff_wait_ready() and ata_sff_wait_after_reset().
> 
> ATA_TMOUT_FF_WAIT handling is merged into ata_sff_wait_ready().  If TF
> status is 0xff, link status is unknown and the port is SATA, it will
> continue polling till ATA_TMOUT_FF_WAIT.
> 
> ata_sff_wait_after_reset() is updated to perform the following steps.
> 
> 1. waits for 150ms.
> 
> 2. waits for dev0 readiness using ata_sff_wait_ready().  Note that
>    this is done regardless of devmask, as ata_sff_wait_ready() handles
>    0xff status correctly, this preserves the original behavior except
>    that it may wait longer after softreset if link is online but
>    status is 0xff.  This behavior change is very unlikely to cause any
>    actual difference and is intended.  It brings softreset behavior to
>    that of hardreset.
> 
> 3. waits for dev1 readiness just the same way ata_bus_post_reset() did.
> 
> Now both soft and hard resets call ata_sff_wait_after_reset() after
> reset to wait for readiness after resets.  As
> ata_sff_wait_after_reset() contains calls to ->sff_dev_select(),
> explicit call near the end of sata_sff_hardreset() is removed.
> 
> This change makes reset implementation simpler and more consistent.
> 
> While at it, make the magical 150ms wait post-reset wait duration a
> constant and ata_sff_wait_ready() and ata_sff_wait_after_reset() take
> @link instead of @ap.  This is to make them consistent with other
> reset helpers and ease core changes.
> 
> pata_scc is updated accordingly.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/ahci.c          |   11 +--
>  drivers/ata/libata-sff.c    |  161 ++++++++++++++++++-------------------------
>  drivers/ata/pata_scc.c      |   91 ++++++++++++++-----------
>  drivers/ata/sata_inic162x.c |    6 +-
>  drivers/ata/sata_via.c      |    2 +-
>  include/linux/libata.h      |   18 ++++-
>  6 files changed, 139 insertions(+), 150 deletions(-)

This could definitely use some focused PATA testing...  master/slave and 
slave-only setups can be tricky and annoying, and this area is very very 
fragile.

I'm applying, but just a note to watch for bug reports related to 
probing caused by this (hopefully none...)

	Jeff




