From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] pata_ali: Add Mitac 8317 and derivatives
Date: Fri, 23 Nov 2007 19:35:52 -0500
Message-ID: <474771E8.7000000@garzik.org>
References: <20071119143628.022703e8@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:34150 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752496AbXKXAfz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 23 Nov 2007 19:35:55 -0500
In-Reply-To: <20071119143628.022703e8@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-ide@vger.kernel.org

Alan Cox wrote:
> Signed-off-by: Alan Cox <alan@redhat.com>
> 
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.24-rc2-mm1/drivers/ata/pata_ali.c linux-2.6.24-rc2-mm1/drivers/ata/pata_ali.c
> --- linux.vanilla-2.6.24-rc2-mm1/drivers/ata/pata_ali.c	2007-11-16 17:55:11.000000000 +0000
> +++ linux-2.6.24-rc2-mm1/drivers/ata/pata_ali.c	2007-11-16 18:12:21.000000000 +0000
> @@ -63,6 +63,9 @@
>  	/* Fujitsu P2000 */
>  	if (pdev->subsystem_vendor == 0x10CF && pdev->subsystem_device == 0x10AF)
>  	   	return 1;
> +	/* Mitac 8317 (Winbook-A) and relatives */
> +	if (pdev->subsystem_vendor == 0x1071  && pdev->subsystem_device == 0x8317)
> +		return 1;

applied #upstream-fixes


