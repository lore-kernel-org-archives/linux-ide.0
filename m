From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/1] libata: rearrange dmesg info to add full ATA revision
Date: Tue, 06 Feb 2007 19:42:20 -0500
Message-ID: <45C9206C.10202@garzik.org>
References: <20070131021051.GA3403@bounceswoosh.org> <20070131060040.GA3361@bounceswoosh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:56930 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933113AbXBGAmW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Feb 2007 19:42:22 -0500
In-Reply-To: <20070131060040.GA3361@bounceswoosh.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: edmudama@gmail.com
Cc: linux-ide@vger.kernel.org

Eric D. Mudama wrote:
> Per Jeff's suggestion, this patch rearranges the info printed for ATA
> drives into dmesg to add the full ATA firmware revision and model
> information, while keeping the output to 2 lines.
> 
> Signed-off-by: Eric D. Mudama <edmudama@gmail.com>

> diff --git a/include/linux/ata.h b/include/linux/ata.h
> index 1df9416..aa9c1fd 100644
> --- a/include/linux/ata.h
> +++ b/include/linux/ata.h
> @@ -60,6 +60,8 @@ enum {
>  
>  	ATA_PCI_CTL_OFS		= 2,
>  	ATA_SERNO_LEN		= 20,
> +	ATA_ID_PROD_LEN         = 40,
> +	ATA_ID_FW_REV_LEN       = 16,
>  	ATA_UDMA0		= (1 << 0),
>  	ATA_UDMA1		= ATA_UDMA0 | (1 << 1),
>  	ATA_UDMA2		= ATA_UDMA1 | (1 << 2),

applied to netdev#upstream, sans the above part.  I'm not sure where you 
got 16 there?  It's 8 ASCII chars in the spec.

	Jeff


