From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata-core: fix kernel-doc warning
Date: Sun, 24 Feb 2008 00:30:20 -0500
Message-ID: <47C100EC.5030803@garzik.org>
References: <20080222122137.bd81d2a0.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:36129 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752302AbYBXFaW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 24 Feb 2008 00:30:22 -0500
In-Reply-To: <20080222122137.bd81d2a0.randy.dunlap@oracle.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: ide <linux-ide@vger.kernel.org>

Randy Dunlap wrote:
> From: Randy Dunlap <randy.dunlap@oracle.com>
> 
> Fix libata-core kernel-doc warning:
> Warning(linux-2.6.25-rc2-git6//drivers/ata/libata-core.c:168): No description found for parameter 'ap'
> 
> Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
> ---
>  drivers/ata/libata-core.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-2.6.25-rc2-git6.orig/drivers/ata/libata-core.c
> +++ linux-2.6.25-rc2-git6/drivers/ata/libata-core.c
> @@ -153,7 +153,7 @@ MODULE_VERSION(DRV_VERSION);
>  
>  /**
>   *	ata_force_cbl - force cable type according to libata.force
> - *	@link: ATA link of interest
> + *	@ap: ATA port of interest
>   *

applied


