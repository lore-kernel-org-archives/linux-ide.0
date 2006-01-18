From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: [PATCH] libata-scsi: fix sparse warnings
Date: Tue, 17 Jan 2006 21:33:51 -0800
Message-ID: <20060117213351.56f7d3f2.rdunlap@xenotime.net>
References: <20060117213114.59ac90ad.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:42173 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1030257AbWARFdy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Jan 2006 00:33:54 -0500
Received: from zx64.site ([71.111.157.99]) by xenotime.net for <linux-ide@vger.kernel.org>; Tue, 17 Jan 2006 21:33:53 -0800
In-Reply-To: <20060117213114.59ac90ad.rdunlap@xenotime.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik <jgarzik@pobox.com>
Cc: ide <linux-ide@vger.kernel.org>


I had a question about the patch block below:

> drivers/scsi/libata-scsi.c:204:20: warning: cast removes address space of expression
> ---
>  drivers/scsi/libata-scsi.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> --- linux-2616-rc1.orig/drivers/scsi/libata-scsi.c
> +++ linux-2616-rc1/drivers/scsi/libata-scsi.c
> @@ -201,7 +201,7 @@ int ata_cmd_ioctl(struct scsi_device *sc
>  	/* Need code to retrieve data from check condition? */
>  
>  	if ((argbuf)
> -	 && copy_to_user((void *)(arg + sizeof(args)), argbuf, argsize))
> +	 && copy_to_user(arg + sizeof(args), argbuf, argsize))
>  		rc = -EFAULT;
>  error:
>  	if (argbuf)

What are the semantics of the user <arg>?
Does it point to an input u8 args[4] which must be immediately followed
by an output u8 args[4]?  That's what it seems to be.  Just checking.

Thanks,
---
~Randy
