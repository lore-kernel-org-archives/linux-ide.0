From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: [PATCH] libata: kill illegal kfree(id)
Date: Tue, 28 Feb 2006 13:43:31 -0800 (PST)
Message-ID: <Pine.LNX.4.58.0602281342580.28727@shark.he.net>
References: <Pine.LNX.4.58.0602271015370.22195@shark.he.net>
 <20060228083810.GA16942@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:43480 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932508AbWB1Vnf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Feb 2006 16:43:35 -0500
Received: from shark.he.net ([66.160.160.2]) by xenotime.net for <linux-ide@vger.kernel.org>; Tue, 28 Feb 2006 13:43:31 -0800
In-Reply-To: <20060228083810.GA16942@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, jgarzik@pobox.com, linux-ide@vger.kernel.org

On Tue, 28 Feb 2006, Tejun Heo wrote:

> Kill kfree(id) in failure path of ata_dev_read_id().  id is not
> dynamically allocated yet.
>
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Randy Dunlap <rdunlap@xenotime.net>

Acked-by: Randy Dunlap <rdunlap@xenotime.net>
matches my patch.

> ---
>
> That was a leftover from patch reordering.
>
> Jeff, I'll regenerate patches #3-6 of reorganize ata_dev_identify()
> patchset ASAP.  So, at the moment, there's no pending patch waiting
> for your review.
>
> Sorry.
>
> Index: work/drivers/scsi/libata-core.c
> ===================================================================
> --- work.orig/drivers/scsi/libata-core.c	2006-02-28 17:25:39.000000000 +0900
> +++ work/drivers/scsi/libata-core.c	2006-02-28 17:33:05.000000000 +0900
> @@ -1036,7 +1036,6 @@ static int ata_dev_read_id(struct ata_po
>   err_out:
>  	printk(KERN_WARNING "ata%u: dev %u failed to IDENTIFY (%s)\n",
>  	       ap->id, dev->devno, reason);
> -	kfree(id);
>  	return rc;
>  }
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

-- 
~Randy
