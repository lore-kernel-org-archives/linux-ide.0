From: Roberto Oppedisano <roppedisano@infracomspa.it>
Subject: Re: [PATCH] Don't fail ata device revalidation for bad _GTF methods
Date: Fri, 09 Nov 2007 13:29:30 +0100
Message-ID: <473452AA.7080503@infracomspa.it>
References: <4731C86B.1040704@infracomspa.it> <20071107121355.5eaf4496.akpm@linux-foundation.org> <47333CCF.1050403@infracomspa.it> <20071108094958.5c9b1b22.akpm@linux-foundation.org> <20071108180256.GB3491@havoc.gtf.org> <20071108101341.6c4f88d4.akpm@linux-foundation.org> <20071108182217.GA2685@srcf.ucam.org> <20071108183707.GA3008@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailgw.infracomspa.it ([217.12.183.244]:3756 "EHLO
	svkmg019i.infracomspa.it" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751368AbXKIM3n (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Nov 2007 07:29:43 -0500
In-Reply-To: <20071108183707.GA3008@srcf.ucam.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, rjw@sisk.pl, linux-acpi@vger.kernel.org

I can confirm that this patch solves the problem with s2ram on my laptop.

R

Matthew Garrett wrote:
> Experience suggests that the _GTF method may be bad. We currently fail 
> device revalidation in that case, which seems excessive.
>
> Signed-off-by: Matthew Garrett <mjg59@srcf.ucam.org>
>
> ---
>
> diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
> index 08a52dd..545ea86 100644
> --- a/drivers/ata/libata-acpi.c
> +++ b/drivers/ata/libata-acpi.c
> @@ -312,7 +312,7 @@ EXPORT_SYMBOL_GPL(ata_acpi_stm);
>   *
>   * RETURNS:
>   * Number of taskfiles on success, 0 if _GTF doesn't exist or doesn't
> - * contain valid data.  -errno on other errors.
> + * contain valid data.
>   */
>  static int ata_dev_get_GTF(struct ata_device *dev, struct ata_acpi_gtf **gtf,
>  			   void **ptr_to_free)
> @@ -339,7 +339,6 @@ static int ata_dev_get_GTF(struct ata_device *dev, struct ata_acpi_gtf **gtf,
>  			ata_dev_printk(dev, KERN_WARNING,
>  				       "_GTF evaluation failed (AE 0x%x)\n",
>  				       status);
> -			rc = -EIO;
>  		}
>  		goto out_free;
>  	}
> @@ -359,7 +358,6 @@ static int ata_dev_get_GTF(struct ata_device *dev, struct ata_acpi_gtf **gtf,
>  		ata_dev_printk(dev, KERN_WARNING,
>  			       "_GTF unexpected object type 0x%x\n",
>  			       out_obj->type);
> -		rc = -EINVAL;
>  		goto out_free;
>  	}
>  
> @@ -367,7 +365,6 @@ static int ata_dev_get_GTF(struct ata_device *dev, struct ata_acpi_gtf **gtf,
>  		ata_dev_printk(dev, KERN_WARNING,
>  			       "unexpected _GTF length (%d)\n",
>  			       out_obj->buffer.length);
> -		rc = -EINVAL;
>  		goto out_free;
>  	}
>  
> @@ -511,10 +508,7 @@ static int ata_acpi_exec_tfs(struct ata_device *dev)
>  	int gtf_count, i, rc;
>  
>  	/* get taskfiles */
> -	rc = ata_dev_get_GTF(dev, &gtf, &ptr_to_free);
> -	if (rc < 0)
> -		return rc;
> -	gtf_count = rc;
> +	gtf_count = ata_dev_get_GTF(dev, &gtf, &ptr_to_free);
>  
>  	/* execute them */
>  	for (i = 0, rc = 0; i < gtf_count; i++) {
>   
