From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/2] libata: don't flush dcache on slab pages
Date: Fri, 14 May 2010 17:50:39 -0400
Message-ID: <4BEDC5AF.7010605@pobox.com>
References: <20100321215222.GA27709@Chamillionaire.breakpoint.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:57767 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932254Ab0ENVum (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 14 May 2010 17:50:42 -0400
Received: by gwj19 with SMTP id 19so1570523gwj.19
        for <linux-ide@vger.kernel.org>; Fri, 14 May 2010 14:50:41 -0700 (PDT)
In-Reply-To: <20100321215222.GA27709@Chamillionaire.breakpoint.cc>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Cc: linux-ide@vger.kernel.org

On 03/21/2010 05:52 PM, Sebastian Andrzej Siewior wrote:
> page_mapping() check this via VM_BUG_ON(PageSlab(page)) so we bug here
> with the according debuging turned on.
>
> Signed-off-by: Sebastian Andrzej Siewior<sebastian@breakpoint.cc>
> ---
>   drivers/ata/libata-sff.c |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
> index 561dec2..83ecf48 100644
> --- a/drivers/ata/libata-sff.c
> +++ b/drivers/ata/libata-sff.c
> @@ -893,7 +893,7 @@ static void ata_pio_sector(struct ata_queued_cmd *qc)
>   				       do_write);
>   	}
>
> -	if (!do_write)
> +	if (!do_write&&  !PageSlab(page))
>   		flush_dcache_page(page);

applied #upstream, cc'ing stable@kernel.org


