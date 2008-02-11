From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] pata_legacy: typo fix
Date: Mon, 11 Feb 2008 14:31:24 -0500
Message-ID: <47B0A28C.5050400@garzik.org>
References: <20080208152338.7c1fcaa7@core>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:55293 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760881AbYBKTb0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 11 Feb 2008 14:31:26 -0500
In-Reply-To: <20080208152338.7c1fcaa7@core>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

Alan Cox wrote:
> Signed-off-by: Alan Cox <alan@redhat.com>
> 
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.24-mm1/drivers/ata/pata_legacy.c linux-2.6.24-mm1/drivers/ata/pata_legacy.c
> --- linux.vanilla-2.6.24-mm1/drivers/ata/pata_legacy.c	2008-02-06 14:14:39.000000000 +0000
> +++ linux-2.6.24-mm1/drivers/ata/pata_legacy.c	2008-02-06 14:38:54.000000000 +0000
> @@ -127,7 +127,7 @@
>  static int opti82c46x;		/* Opti 82c465MV present(pri/sec autodetect) */
>  static int qdi;			/* Set to probe QDI controllers */
>  static int winbond;		/* Set to probe Winbond controllers,
> -					give I/O port if non stdanard */
> +					give I/O port if non standard */
>  static int autospeed;		/* Chip present which snoops speed changes */
>  static int pio_mask = 0x1F;	/* PIO range for autospeed devices */
>  static int iordy_mask = 0xFFFFFFFF;	/* Use iordy if available */

applied


