From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] pata_atiixp: Simplex clear
Date: Thu, 27 Mar 2008 01:34:38 -0700
Message-ID: <20080327013438.cc2a69b6.akpm@linux-foundation.org>
References: <20080326113503.7c0218ce@core>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:47000 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756002AbYC0IfU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 27 Mar 2008 04:35:20 -0400
In-Reply-To: <20080326113503.7c0218ce@core>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org

On Wed, 26 Mar 2008 11:35:03 +0000 Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> Some of the other quirks changes seem to have left some users with the
> simplex bits mis-set by the time the driver loads. Clear simplex mode
> before we probe the controller therefore
> 

Changelog whine: I am unable to work out from the above whether this patch
is appropriate to 2.6.24.x and/or 2.6.25.  It _looks_ like this change will
unbreak some people's stuff, but that's a mad guess.

> 
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.25-rc5-mm1/drivers/ata/pata_atiixp.c linux-2.6.25-rc5-mm1/drivers/ata/pata_atiixp.c
> --- linux.vanilla-2.6.25-rc5-mm1/drivers/ata/pata_atiixp.c	2008-03-18 15:52:08.000000000 +0000
> +++ linux-2.6.25-rc5-mm1/drivers/ata/pata_atiixp.c	2008-03-26 09:41:09.000000000 +0000
> @@ -22,7 +22,7 @@
>  #include <linux/libata.h>
>  
>  #define DRV_NAME "pata_atiixp"
> -#define DRV_VERSION "0.4.6"
> +#define DRV_VERSION "0.4.7"
>  
>  enum {
>  	ATIIXP_IDE_PIO_TIMING	= 0x40,
> @@ -282,6 +282,9 @@
>  		.port_ops = &atiixp_port_ops
>  	};
>  	const struct ata_port_info *ppi[] = { &info, NULL };
> +	/* Some of the quirk reconfiguration messes up the simplex
> +	   flag, so clear it again */
> +	ata_pci_clear_simplex(dev);
>  	return ata_pci_init_one(dev, ppi);
>  }

Patch whine: I got a reject here (libata-all changes) and when fixing it I
was pretty confident that the above hunk was in atiixp_init_one(), but
sometimes these things go wrong.  Please change your scripts to use `diff
-p'.  It helps.

