From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/6] libata: fix timing computation in ata_eh_reset()
Date: Sat, 03 Nov 2007 08:48:51 -0400
Message-ID: <472C6E33.9000402@garzik.org>
References: <11937934273607-git-send-email-htejun@gmail.com> <11937934272494-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:35188 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753865AbXKCMsx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 3 Nov 2007 08:48:53 -0400
In-Reply-To: <11937934272494-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> As jiffies changes asynchronously, it needs to be cached if unchanging
> timestamp is needed.  The code in ata_eh_reset() intended to do that
> with @now but never actually did it.  Fix it.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/libata-eh.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index 496edaf..f1c0117 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -2184,7 +2184,7 @@ int ata_eh_reset(struct ata_link *link, int classify,
>  		unsigned long now = jiffies;
>  
>  		if (time_before(now, deadline)) {
> -			unsigned long delta = deadline - jiffies;
> +			unsigned long delta = deadline - now;

applied 1-6 to #upstream-fixes


