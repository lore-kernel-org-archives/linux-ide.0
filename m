From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [patch for 2.6.29? 1/4] drivers/ata/sata_sil.c needs dmi.h
Date: Wed, 11 Feb 2009 16:11:28 -0500
Message-ID: <49933F00.4050100@garzik.org>
References: <200902112108.n1BL8epu005164@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:35048 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756669AbZBKVLc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 11 Feb 2009 16:11:32 -0500
In-Reply-To: <200902112108.n1BL8epu005164@imap1.linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-ide@vger.kernel.org

akpm@linux-foundation.org wrote:
> From: Andrew Morton <akpm@linux-foundation.org>
> 
> alpha:
> 
> drivers/ata/sata_sil.c: In function 'sil_broken_system_poweroff':
> drivers/ata/sata_sil.c:713: error: implicit declaration of function 'dmi_first_match'
> 
> Cc: Jeff Garzik <jeff@garzik.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/ata/sata_sil.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff -puN drivers/ata/sata_sil.c~drivers-ata-sata_silc-needs-dmih drivers/ata/sata_sil.c
> --- a/drivers/ata/sata_sil.c~drivers-ata-sata_silc-needs-dmih
> +++ a/drivers/ata/sata_sil.c
> @@ -38,6 +38,7 @@
>  #include <linux/module.h>
>  #include <linux/pci.h>
>  #include <linux/init.h>
> +#include <linux/dmi.h>
>  #include <linux/blkdev.h>

already upstream...


