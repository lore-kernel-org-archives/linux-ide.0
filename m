From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 4/4] libata: improve FLUSH error handling
Date: Fri, 04 Apr 2008 03:46:58 -0400
Message-ID: <47F5DCF2.2080406@garzik.org>
References: <12066128663306-git-send-email-htejun@gmail.com> <12066128661591-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:41327 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752665AbYDDHrB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 4 Apr 2008 03:47:01 -0400
In-Reply-To: <12066128661591-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, liml@rtr.ca

Tejun Heo wrote:
> When errors occur during flush, instead of writing out the rest and
> reporting the errors, ATA halts the processing and report the error,
> so FLUSH must be retried on failure.  Also, the spec says that FLUSH
> may take more than 30 secs but doesn't mention anything about the
> actual limit.
> 
> This patch improves FLUSH error handling such that...
> 
> 1. It's always retried with longer timeout (60s for now) after failure.
> 
> 2. If the device is making progress by retrying, humor it for longer
>    (20 tries for now).
> 
> 3. If the device is fails the command with the same failed sector,
>    retry fewer times (log2 of the original number of tries).
> 
> 4. If retried FLUSH fails for something other than device error, don't
>    keep retrying.  We're likely wasting time.
> 
> This patch is inspired by Alan's patch to improve ata_flush_cache().
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
> ---
>  drivers/ata/libata-eh.c |  131 ++++++++++++++++++++++++++++++++++++++++++++++-
>  include/linux/libata.h  |    5 ++-
>  2 files changed, 134 insertions(+), 2 deletions(-)

I didn't apply this, because it seemed like it was still under 
discussion a bit.

People are talking in the right direction, so I'm likely to apply 
whatever the end result is, it sounds like


