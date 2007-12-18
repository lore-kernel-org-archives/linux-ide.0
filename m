From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [patch 1/9] drivers/ata/libata-eh.c: fix printk warning
Date: Tue, 18 Dec 2007 16:20:23 -0500
Message-ID: <47683997.9090608@garzik.org>
References: <200712140001.lBE01bbR025425@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:45060 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754687AbXLRVU1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 18 Dec 2007 16:20:27 -0500
In-Reply-To: <200712140001.lBE01bbR025425@imap1.linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-ide@vger.kernel.org

akpm@linux-foundation.org wrote:
> From: Andrew Morton <akpm@linux-foundation.org>
> 
> drivers/ata/libata-eh.c: In function `ata_port_pbar_desc':
> drivers/ata/libata-eh.c:215: warning: long long unsigned int format, long unsigned int arg (arg 4)
> 
> Cc: Jeff Garzik <jeff@garzik.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/ata/libata-eh.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff -puN drivers/ata/libata-eh.c~drivers-ata-libata-ehc-fix-printk-warning drivers/ata/libata-eh.c
> --- a/drivers/ata/libata-eh.c~drivers-ata-libata-ehc-fix-printk-warning
> +++ a/drivers/ata/libata-eh.c
> @@ -231,7 +231,8 @@ void ata_port_pbar_desc(struct ata_port 
>  	if (offset < 0)
>  		ata_port_desc(ap, "%s %s%llu@0x%llx", name, type, len, start);
>  	else
> -		ata_port_desc(ap, "%s 0x%llx", name, start + offset);
> +		ata_port_desc(ap, "%s 0x%llx", name,
> +				start + (unsigned long long)offset);
>  }

applied #upstream


