From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [RFC-UGLYPATCH] ata: small optimization in linux/libata.h
Date: Fri, 15 Feb 2008 11:10:42 -0500
Message-ID: <47B5B982.8090601@garzik.org>
References: <1203016578.2748.69.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50611 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751540AbYBOQKu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 15 Feb 2008 11:10:50 -0500
In-Reply-To: <1203016578.2748.69.camel@brick>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Harvey Harrison <harvey.harrison@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@linux-foundation.org>, linux-ide <linux-ide@vger.kernel.org>

Harvey Harrison wrote:
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index 2845983..f0e1178 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -1211,7 +1211,7 @@ static inline struct ata_link *ata_port_next_link(struct ata_link *link)
>  		return ap->pmp_link;
>  	}
>  
> -	if (++link - ap->pmp_link < ap->nr_pmp_links)
> +	if ((char*)++link - (char *)ap->pmp_link < ap->nr_pmp_links * sizeof(*link))
>  		return link;


I prefer the less ugly version :)

