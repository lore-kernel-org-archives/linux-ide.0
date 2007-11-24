From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata-sff: tf_load
Date: Fri, 23 Nov 2007 19:43:57 -0500
Message-ID: <474773CD.4000603@garzik.org>
References: <20071119143456.380042a1@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:56694 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751971AbXKXAoC (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 23 Nov 2007 19:44:02 -0500
In-Reply-To: <20071119143456.380042a1@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-ide@vger.kernel.org

Alan Cox wrote:
> Jeff said he preferred that the SFF tf_load followed the spec and we
> documented that anyone who needed different overrode it, rather than it
> using the ->check_status methods. No driver relies on the current behaviour.
> 
> Signed-off-by: Alan Cox <alan@redhat.com>
> 
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.24-rc2-mm1/drivers/ata/libata-sff.c linux-2.6.24-rc2-mm1/drivers/ata/libata-sff.c
> --- linux.vanilla-2.6.24-rc2-mm1/drivers/ata/libata-sff.c	2007-11-16 17:55:11.000000000 +0000
> +++ linux-2.6.24-rc2-mm1/drivers/ata/libata-sff.c	2007-11-16 18:11:51.000000000 +0000
> @@ -147,7 +147,9 @@
>   *	@tf: ATA taskfile register set for storing input
>   *
>   *	Reads ATA taskfile registers for currently-selected device
> - *	into @tf.
> + *	into @tf. Assumes the device has a fully SFF compliant task file
> + *	layout and behaviour. If you device does not (eg has a different
> + *	status method) then you will need to provide a replacement tf_read
>   *
>   *	LOCKING:
>   *	Inherited from caller.
> @@ -156,7 +158,7 @@
>  {
>  	struct ata_ioports *ioaddr = &ap->ioaddr;
>  
> -	tf->command = ata_chk_status(ap);
> +	tf->command = ata_check_status(ap);

applied #upstream, thanks


