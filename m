From: Brian King <brking@us.ibm.com>
Subject: Re: [PATCH 1/1] libata: Convert from module_init to subsys_initcall
Date: Wed, 08 Nov 2006 14:07:05 -0600
Message-ID: <455238E9.3050301@us.ibm.com>
References: <200610241414.k9OEEUjd009012@d01av04.pok.ibm.com>
Reply-To: brking@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e4.ny.us.ibm.com ([32.97.182.144]:52447 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1422874AbWKHU0o (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 8 Nov 2006 15:26:44 -0500
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id kA8KQh6N029404
	for <linux-ide@vger.kernel.org>; Wed, 8 Nov 2006 15:26:43 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id kA8KM6bb230936
	for <linux-ide@vger.kernel.org>; Wed, 8 Nov 2006 15:26:42 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id kA8K76QU028122
	for <linux-ide@vger.kernel.org>; Wed, 8 Nov 2006 15:07:06 -0500
In-Reply-To: <200610241414.k9OEEUjd009012@d01av04.pok.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Jeff,

Any chance of pushing this into 2.6.19? I've been had several
people hit this oops.

Thanks,

Brian


Brian King wrote:
> When building a monolithic kernel, the load order of drivers
> does not work for SAS libata users, resulting in driver load
> failures. Convert libata to use subsys_initcall instead of
> module_init, which ensures that libata gets loaded before
> any LLDD. This is the same thing that scsi core does
> to solve the problem. The load order problem was observed on
> ipr SAS adapters and should exist for other SAS users as well.
> 
> Signed-off-by: Brian King <brking@us.ibm.com>
> ---
> 
>  linux-2.6-bjking1/drivers/ata/libata-core.c |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff -puN drivers/ata/libata-core.c~libata_subsys_init drivers/ata/libata-core.c
> --- linux-2.6/drivers/ata/libata-core.c~libata_subsys_init	2006-10-23 16:48:15.000000000 -0500
> +++ linux-2.6-bjking1/drivers/ata/libata-core.c	2006-10-23 16:48:15.000000000 -0500
> @@ -5957,7 +5957,7 @@ static void __exit ata_exit(void)
>  	destroy_workqueue(ata_aux_wq);
>  }
>  
> -module_init(ata_init);
> +subsys_initcall(ata_init);
>  module_exit(ata_exit);
>  
>  static unsigned long ratelimit_time;
> _


-- 
Brian King
eServer Storage I/O
IBM Linux Technology Center
