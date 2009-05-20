From: Jeff Garzik <jeff@garzik.org>
Subject: Re: ibata: get rid of ATA_MAX_QUEUE loop in ata_qc_complete_multiple()
 v2
Date: Wed, 20 May 2009 03:49:35 -0400
Message-ID: <4A13B60F.8030603@garzik.org>
References: <20090520074439.GJ11363@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53263 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753518AbZETHuC (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 20 May 2009 03:50:02 -0400
In-Reply-To: <20090520074439.GJ11363@kernel.dk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <jens.axboe@oracle.com>
Cc: linux-ide@vger.kernel.org, htejun@gmail.com

Jens Axboe wrote:
> We very rarely (if ever) complete more than one command in the
> sactive mask at the time, even for extremely high IO rates. So
> looping over the entire range of possible tags is pointless,
> instead use __ffs() to just find the completed tags directly.
> 
> Updated to clear the tag from the done_mask instead of shifting
> done_mask down as suggested by From: Tejun Heo <htejun@gmail.com>
> Verified with a user space tester to produce the same results.
> 
> Signed-off-by: Jens Axboe <jens.axboe@oracle.com>
> ---
>  drivers/ata/libata-core.c |   11 +++++------
>  1 files changed, 5 insertions(+), 6 deletions(-)

Much cleaner.  Queued...

Separately, I wonder if we shouldn't add code to report when the 
hardware gives us an unknown tag.

The code always correctly handles invalid tags passed to us from 
hardware "if (qc)", but we should probably squawk when that happens, I 
suspect.

	Jeff



