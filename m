From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 13/22] libata: implement qc->result_tf
Date: Thu, 18 May 2006 16:27:11 +0900
Message-ID: <446C21CF.3020900@gmail.com>
References: <11473487911193-git-send-email-htejun@gmail.com> <446C20A4.7020204@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.227]:39812 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750839AbWERH1T (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 18 May 2006 03:27:19 -0400
Received: by wr-out-0506.google.com with SMTP id 50so350872wri
        for <linux-ide@vger.kernel.org>; Thu, 18 May 2006 00:27:18 -0700 (PDT)
In-Reply-To: <446C20A4.7020204@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org

Albert Lee wrote:
> This patch makes qc->tf well preserved, except we still have
> qc->tf got overwritten by ata_pio_bytes().
> 
> Maybe we also need the attached follow-up patch?
> 
> --
> albert
> 
> --- 02_atapi_pio_bytes/drivers/scsi/libata-core.c	2006-05-18 14:20:32.000000000 +0800
> +++ 03_atapi_pio_bytes/drivers/scsi/libata-core.c	2006-05-18 14:25:41.000000000 +0800
> @@ -3861,10 +3861,10 @@ static void atapi_pio_bytes(struct ata_q
>  	unsigned int ireason, bc_lo, bc_hi, bytes;
>  	int i_write, do_write = (qc->tf.flags & ATA_TFLAG_WRITE) ? 1 : 0;
>  
> -	ap->ops->tf_read(ap, &qc->tf);
> -	ireason = qc->tf.nsect;
> -	bc_lo = qc->tf.lbam;
> -	bc_hi = qc->tf.lbah;
> +	ap->ops->tf_read(ap, &qc->result_tf);
> +	ireason = qc->result_tf.nsect;
> +	bc_lo = qc->result_tf.lbam;
> +	bc_hi = qc->result_tf.lbah;
>  	bytes = (bc_hi << 8) | bc_lo;
>  
>  	/* shall be cleared to zero, indicating xfer of data */
> 

I actually think above should be done with local variable.  It's not 
comannd TF nor result TF.

-- 
tejun
