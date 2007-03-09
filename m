From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH]: libata-core: Add support for ATA_HORKAGE_DIAGNOSTIC
Date: Fri, 09 Mar 2007 07:48:01 -0500
Message-ID: <45F15781.7090402@garzik.org>
References: <20070308231804.110f76a0@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:55648 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1767221AbXCIMsE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 9 Mar 2007 07:48:04 -0500
In-Reply-To: <20070308231804.110f76a0@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org

Alan Cox wrote:
> If we find the device has broken diagnostics then don't report this if we
> expect it to. Needed for the Gigabyte i-RAM.
> 
> Signed-off-by: Alan Cox <alan@redhat.com>
> 
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.21-rc3-mm2/drivers/ata/libata-core.c linux-2.6.21-rc3-mm2/drivers/ata/libata-core.c
> --- linux.vanilla-2.6.21-rc3-mm2/drivers/ata/libata-core.c	2007-03-08 16:01:10.000000000 +0000
> +++ linux-2.6.21-rc3-mm2/drivers/ata/libata-core.c	2007-03-08 16:02:52.000000000 +0000
> @@ -1751,7 +1765,7 @@
>  		/* Let the user know. We don't want to disallow opens for
>  		   rescue purposes, or in case the vendor is just a blithering
>  		   idiot */
> -                if (print_info) {
> +                if (print_info && !(ata_device_blacklisted(dev) & ATA_HORKAGE_DIAGNOSTIC)) {
>  			ata_dev_printk(dev, KERN_WARNING,
>  "Drive reports diagnostics failure. This may indicate a drive\n");
>  			ata_dev_printk(dev, KERN_WARNING,

I don't understand this one at all.

The original point of the message was to poke people so that they poke 
their vendors into fixing the firmware, which is indeed non-spec.  I 
would rather not silence a "your device is operating out-of-spec" warning.

	Jeff



