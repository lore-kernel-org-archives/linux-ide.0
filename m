From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: cable logic
Date: Sat, 12 Apr 2008 00:35:23 -0400
Message-ID: <48003C0B.20405@garzik.org>
References: <20080408163750.32efc439@core>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:40285 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752461AbYDLEff (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 12 Apr 2008 00:35:35 -0400
In-Reply-To: <20080408163750.32efc439@core>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-ide@vger.kernel.org

Alan Cox wrote:
> The cable detect isolation patch inadvertently removed 40 wire short
> cable handling. Put it back
> 
> Signed-off-by: Alan Cox <alan@redhat.com>
> 
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.25-rc8-mm1/drivers/ata/libata-core.c linux-2.6.25-rc8-mm1/drivers/ata/libata-core.c
> --- linux.vanilla-2.6.25-rc8-mm1/drivers/ata/libata-core.c	2008-04-08 11:34:51.000000000 +0100
> +++ linux-2.6.25-rc8-mm1/drivers/ata/libata-core.c	2008-04-08 12:01:30.000000000 +0100
> @@ -4559,6 +4564,10 @@
>  	/* If the controller thinks we are 80 wire, we are */
>  	if (ap->cbl == ATA_CBL_PATA80 || ap->cbl == ATA_CBL_SATA)
>  		return 0;
> +	/* If the system is known to be 40 wire short cable (eg laptop),
> +	   then we allow 80 wire modes even if the drive isn't sure */
> +	if (ap->cbl == ATA_CBL_PATA40_SHORT)
> +		return 0;
>  	/* If the controller doesn't know we scan
>  
>  	   - Note: We look for all 40 wire detects at this point.

applied


