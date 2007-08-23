From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] pata_sis: Add the FSC Amilo and friends
Date: Thu, 23 Aug 2007 05:32:29 -0400
Message-ID: <46CD542D.60009@garzik.org>
References: <20070822225643.1192cdf4@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:48544 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751260AbXHWJcd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 23 Aug 2007 05:32:33 -0400
In-Reply-To: <20070822225643.1192cdf4@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-ide@vger.kernel.org

Alan Cox wrote:
> More short cables
> 
> Signed-off-by: Alan Cox <alan@redhat.com>
> 
> 
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.23rc3-mm1/drivers/ata/pata_sis.c linux-2.6.23rc3-mm1/drivers/ata/pata_sis.c
> --- linux.vanilla-2.6.23rc3-mm1/drivers/ata/pata_sis.c	2007-08-22 17:23:00.000000000 +0100
> +++ linux-2.6.23rc3-mm1/drivers/ata/pata_sis.c	2007-08-22 17:46:53.000000000 +0100
> @@ -54,6 +54,7 @@
>  static const struct sis_laptop sis_laptop[] = {
>  	/* devid, subvendor, subdev */
>  	{ 0x5513, 0x1043, 0x1107 },	/* ASUS A6K */
> +	{ 0x5513, 0x1734, 0x105F },	/* FSC Amilo A1630 */
>  	/* end marker */
>  	{ 0, }

applied


