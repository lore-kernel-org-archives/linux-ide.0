From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] ata_piix: Remove ugly layering violation
Date: Fri, 09 Mar 2007 07:29:42 -0500
Message-ID: <45F15336.9040707@pobox.com>
References: <20070307161307.37b1e36f@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:55464 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423018AbXCIM3p (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 9 Mar 2007 07:29:45 -0500
In-Reply-To: <20070307161307.37b1e36f@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-ide@vger.kernel.org

Alan Cox wrote:
> A while ago I modified the libata code so that drivers can return -ENOENT
> for unknown ports not fiddle with the EH flags and print stuff directly.
> Somewhere along the line ata_piix didn't get fully converted.
> 
> Signed-off-by: Alan Cox <alan@redhat.com>
> 
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.21-rc2-mm2/drivers/ata/ata_piix.c linux-2.6.21-rc2-mm2/drivers/ata/ata_piix.c
> --- linux.vanilla-2.6.21-rc2-mm2/drivers/ata/ata_piix.c	2007-03-06 23:09:46.000000000 +0000
> +++ linux-2.6.21-rc2-mm2/drivers/ata/ata_piix.c	2007-03-06 23:33:53.000000000 +0000

will apply this in the next few hours


>  #define DRV_NAME	"ata_piix"
> -#define DRV_VERSION	"2.10"
> +#define DRV_VERSION	"2.10ac1"

please don't add "acX" suffixes.  that's like spraypainting "alan wuz 
here" graphitti ;-)  Just increment to the next numeric version, like 
you do with the other PATA drivers.

	Jeff



