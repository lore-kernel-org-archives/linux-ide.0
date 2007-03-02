From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] pata_cmd64x - various fixes
Date: Fri, 02 Mar 2007 18:17:54 -0500
Message-ID: <45E8B0A2.5020905@garzik.org>
References: <20070301175939.3dfc25e6@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:54590 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992726AbXCBXR4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 Mar 2007 18:17:56 -0500
In-Reply-To: <20070301175939.3dfc25e6@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Alan wrote:
> This driver still needs more work but for the moment
> 
> - It's a CMD not ATI driver
> - Clean up code by using cable method
> 
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.21-rc2/drivers/ata/pata_cmd64x.c linux-2.6.21-rc2/drivers/ata/pata_cmd64x.c
> --- linux.vanilla-2.6.21-rc2/drivers/ata/pata_cmd64x.c	2007-03-01 13:36:03.000000000 +0000
> +++ linux-2.6.21-rc2/drivers/ata/pata_cmd64x.c	2007-03-01 14:49:51.491226440 +0000
> @@ -1,5 +1,5 @@
>  /*
> - * pata_cmd64x.c 	- ATI PATA for new ATA layer
> + * pata_cmd64x.c 	- CMD64x PATA for new ATA layer
>   *			  (C) 2005 Red Hat Inc
>   *			  Alan Cox <alan@redhat.com>
>   *

applied this tiny bit, will await resend of the rest in the jumbo 
cable-detect-driver-update patch

