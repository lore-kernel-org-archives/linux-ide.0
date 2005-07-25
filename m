From: Mark Lord <liml@rtr.ca>
Subject: Re: libata total system lockup fix
Date: Mon, 25 Jul 2005 11:53:13 -0400
Message-ID: <42E50AE9.3000207@rtr.ca>
References: <42E4ED70.1050501@pobox.com> <42E4FC75.70006@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:56581 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S261239AbVGYPxM
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 25 Jul 2005 11:53:12 -0400
In-Reply-To: <42E4FC75.70006@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Mark Lord <mlord@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, hare@suse.de

 >The problem with this patch is that is causes leaks, and doesn't actually ready the devices because scsi_eh_ready_devs() is never called: scsi_eh_abort_cmds() is guaranteed to fail out every time its called.

MMmm.. bummer if that's the case, but it does execute here
on my machine about once every two seconds, continuously,
for hours on end, and the DVD-RW drive still works when
I eventually do place a disc into it later on.

I suppose the bug isn't seen more commonly because libata is
the only (?) SCSI LLD that supplies it's own eh strategy function.
Or are there other users of that interface now?

I'm off on holiday for the next while, but I'll check in on this
again when I get back.  Perhaps the originator of this patch could
chip in with some of the fixes, if you point out where the "leaks" are.

 >Ahha.. here's the header from the original email for this patch
 >Subject: [PATCH] Fix SATA ATAPI error handling
 >From: Hannes Reinecke <hare@suse.de>
 >Date: Wed, 23 Mar 2005 16:28:16 +0100
 >To: SCSI Mailing List <linux-scsi@vger.kernel.org>
 >CC: linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
 >Jens Axboe <axboe@suse.de>, Kurt Garloff <garloff@suse.de>:

Cheers
