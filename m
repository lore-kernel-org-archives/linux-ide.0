From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] libata/pata_it821x: Improve handling of poorly
 compatible emulations
Date: Thu, 25 Oct 2007 13:11:05 -0700
Message-ID: <20071025131105.ca992a64.akpm@linux-foundation.org>
References: <20071025142116.7e38ee86@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:35772 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752563AbXJYULY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Oct 2007 16:11:24 -0400
In-Reply-To: <20071025142116.7e38ee86@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org

On Thu, 25 Oct 2007 14:21:16 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> +                if (print_info) {
> +			ata_dev_printk(dev, KERN_WARNING,
> +"Drive reports diagnostics failure. This may indicate a drive\n");
> +			ata_dev_printk(dev, KERN_WARNING,
> +"fault or invalid emulation. Contact drive vendor for information.\n");
> +		}

eww, my eyes.

It would be better to remove the first \n and use KERN_CONT in the second
printk.  Maybe.  Even better would be to do it all in one printk so that
it is atomic in the printk buffer.

But you probably have more important things to be thinking about ;)
