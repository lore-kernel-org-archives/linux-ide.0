From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: PATCH: blacklist update
Date: Mon, 20 Feb 2006 15:38:37 -0500
Message-ID: <43FA28CD.8080603@pobox.com>
References: <1140449118.26526.21.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:9448 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1161161AbWBTUio (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 Feb 2006 15:38:44 -0500
In-Reply-To: <1140449118.26526.21.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

Alan Cox wrote:
> A long time after testing confirmed the SN-124 was ok Klaas Gadeyne
> discovered that early revision N001 is not.
> 
> Signed-off-by: Alan Cox <alan@redhat.com>
> 
> 
> --- linux.vanilla-2.6.16-rc4/drivers/ide/ide-dma.c	2006-02-20 11:16:39.000000000 +0000
> +++ linux-2.6.16-rc4/drivers/ide/ide-dma.c	2006-02-20 15:01:02.238144320 +0000
> @@ -129,6 +129,7 @@
>  	{ "SanDisk SDP3B-64"	,	"ALL"		},
>  	{ "ATAPI CD-ROM DRIVE 40X MAXIMUM",	"ALL"		},
>  	{ "_NEC DV5800A",               "ALL"           },  
> +	{ "SAMSUNG CD-ROM SN-124",	"N001"		},
>  	{ NULL			,	NULL		}

Could you gin up the same patch for libata?

	Jeff



