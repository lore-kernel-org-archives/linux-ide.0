From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: hardreset on SERR_INTERNAL
Date: Wed, 14 Mar 2007 05:30:30 -0400
Message-ID: <45F7C0B6.4010205@garzik.org>
References: <20070313162051.GH32687@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:38766 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030803AbXCNJac (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 14 Mar 2007 05:30:32 -0400
In-Reply-To: <20070313162051.GH32687@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> There was a rare report where SB600 reported SERR_INTERNAL and SRST
> couldn't get it out of the failure mode.  Hardreset on SERR_INTERNAL.
> As the problem is intermittent, whether this fixes the problem or not
> hasn't been verified yet, but hardresetting the channel on internal
> error is a good idea anyway.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index 7349c3d..fc11bb3 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -1055,7 +1055,7 @@ static void ata_eh_analyze_serror(struct ata_port *ap)
>  	}
>  	if (serror & SERR_INTERNAL) {
>  		err_mask |= AC_ERR_SYSTEM;
> -		action |= ATA_EH_SOFTRESET;
> +		action |= ATA_EH_HARDRESET;

How does this interact with the patch ATI just posted, which prefers to 
treat the SB600 SERR_INTERNAL differently?

	Jeff



