From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: kernel-doc fix
Date: Mon, 19 Mar 2007 12:04:27 -0400
Message-ID: <45FEB48B.5020503@pobox.com>
References: <20070316195547.cd3bb5ca.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53793 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030307AbXCSQEb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 19 Mar 2007 12:04:31 -0400
In-Reply-To: <20070316195547.cd3bb5ca.randy.dunlap@oracle.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: ide <linux-ide@vger.kernel.org>

Randy Dunlap wrote:
> From: Randy Dunlap <randy.dunlap@oracle.com>
> 
> Warning(linux-2621-rc3g7/drivers/ata/libata-core.c:842): No description found for parameter 'unknown'
> 
> Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
> ---
>  drivers/ata/libata-core.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-2621-rc4.orig/drivers/ata/libata-core.c
> +++ linux-2621-rc4/drivers/ata/libata-core.c
> @@ -826,7 +826,7 @@ static u64 ata_id_n_sectors(const u16 *i
>  /**
>   *	ata_id_to_dma_mode	-	Identify DMA mode from id block
>   *	@dev: device to identify
> - *	@mode: mode to assume if we cannot tell
> + *	@unknown: mode to assume if we cannot tell
>   *
>   *	Set up the timing values for the device based upon the identify
>   *	reported values for the DMA mode. This function is used by drivers


applied


