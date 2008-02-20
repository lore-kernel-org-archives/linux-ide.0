From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] ata: fix sparse warning in libata.h
Date: Wed, 20 Feb 2008 12:12:55 -0500
Message-ID: <47BC5F97.6070800@garzik.org>
References: <1203016578.2748.69.camel@brick>	 <20080215223250.0f229dbe@weinigel.se> <1203111692.15275.50.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:56990 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764772AbYBTRNC (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 20 Feb 2008 12:13:02 -0500
In-Reply-To: <1203111692.15275.50.camel@brick>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Harvey Harrison <harvey.harrison@gmail.com>
Cc: Christer Weinigel <christer@weinigel.se>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@linux-foundation.org>, linux-ide <linux-ide@vger.kernel.org>

Harvey Harrison wrote:
> Avoids lots of these, also is more readable.
> include/linux/libata.h:1210:13: warning: potentially expensive pointer subtraction
> 
> Change the subtraction to addition on the other side of the comparison.
> 
> Thanks to Christer Weinigel for the suggestion.
> 
> Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
> ---
>  include/linux/libata.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index bc5a8d0..a6243bb 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -1207,7 +1207,7 @@ static inline struct ata_link *ata_port_next_link(struct ata_link *link)
>  		return ap->pmp_link;
>  	}
>  
> -	if (++link - ap->pmp_link < ap->nr_pmp_links)
> +	if (++link < ap->nr_pmp_links + ap->pmp_link)
>  		return link;

applied


