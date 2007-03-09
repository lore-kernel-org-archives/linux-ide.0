From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 01/12] libata: allocate ap separately from shost
Date: Fri, 09 Mar 2007 10:00:16 -0500
Message-ID: <45F17680.9010006@garzik.org>
References: <11734389351381-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:56767 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992824AbXCIPAU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 9 Mar 2007 10:00:20 -0500
In-Reply-To: <11734389351381-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Don't embed ap inside shost.  Allocate it separately and point it back
> from shosts's hostdata.  This makes port allocation more flexible and
> allows regular ATA and SAS share host alloc/init paths.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/libata-core.c |   15 +++++++++++----
>  include/linux/libata.h    |    2 +-
>  2 files changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 6e124bd..fab488c 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -5646,14 +5646,17 @@ static struct ata_port * ata_port_add(const struct ata_probe_ent *ent,
>  		return NULL;
>  	}
>  
> -	shost = scsi_host_alloc(ent->sht, sizeof(struct ata_port));
> +	ap = kzalloc(sizeof(struct ata_port), GFP_KERNEL);
> +	if (!ap)
> +		return NULL;
> +
> +	shost = scsi_host_alloc(ent->sht, sizeof(struct ata_port *));
>  	if (!shost)
>  		return NULL;

memory leak on error

otherwise OK


