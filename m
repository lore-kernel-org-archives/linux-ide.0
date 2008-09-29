From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream UPDATED 2/2] libata-eh: clear UNIT ATTENTION
 after reset
Date: Mon, 29 Sep 2008 00:34:42 -0400
Message-ID: <48E05AE2.6090301@garzik.org>
References: <484E4925.30202@gmail.com> <484E4945.3050907@gmail.com> <48648B97.8000409@garzik.org> <48B93AF1.9030401@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:40957 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751328AbYI2Eep (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 Sep 2008 00:34:45 -0400
In-Reply-To: <48B93AF1.9030401@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> Resets make ATAPI devices raise UNIT ATTENTION which fails the next
> command.  As resets can happen asynchronously for unrelated reasons,
> this sometimes disrupts innocent users.  For example, reading DVD
> fails after the system wakes up from suspend or the other device
> sharing the channel went through bus error.
> 
> Clearing UA has some problems as it might clear UA which the userland
> needs to know about.  However, UA after resets can only be about the
> reset itself and benefits of clearing it overweights cons.  Missing UA
> can only delay failure to one of the following commands anyway.  For
> example, timeout while burning is in progress will trigger reset and
> reset the device state and probably corrupt the burning run.  Although
> the userland application won't get the UA, its pending writes will
> fail.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
> Ah... It slipped through the cracks somehow.  Updated to the current
> #upstream.  Thanks.
> 
>  drivers/ata/libata-eh.c |   94 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 94 insertions(+)

applied


