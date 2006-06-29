From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 5/9] libata-eh.c conversion
Date: Fri, 30 Jun 2006 01:56:17 +0900
Message-ID: <44A40631.5070200@gmail.com>
References: <20060629161008.GF23122@zmei.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.232]:60527 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750969AbWF2Qz4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 29 Jun 2006 12:55:56 -0400
Received: by wr-out-0506.google.com with SMTP id i21so112616wra
        for <linux-ide@vger.kernel.org>; Thu, 29 Jun 2006 09:55:55 -0700 (PDT)
In-Reply-To: <20060629161008.GF23122@zmei.tnic>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <bbpetkov@yahoo.de>
Cc: linux-ide <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>

Hi!

Borislav Petkov wrote:
> @@ -516,7 +518,7 @@ void ata_port_schedule_eh(struct ata_por
>  	ap->flags |= ATA_FLAG_EH_PENDING;
>  	scsi_schedule_eh(ap->host);
>  
> -	DPRINTK("port EH scheduled\n");
> +	ata_port_printk(ap, ATA_MSG_INFO, "port EH scheduled\n");

DEBUG

>  }
>  
>  /**
> @@ -580,7 +582,7 @@ static void __ata_port_freeze(struct ata
>  
>  	ap->flags |= ATA_FLAG_FROZEN;
>  
> -	DPRINTK("ata%u port frozen\n", ap->id);
> +	ata_port_printk(ap, ATA_MSG_INFO, "ata%u port frozen\n", ap->id);

DEBUG

>  }
>  
>  /**
> @@ -653,7 +655,7 @@ void ata_eh_thaw_port(struct ata_port *a
>  
>  	spin_unlock_irqrestore(ap->lock, flags);
>  
> -	DPRINTK("ata%u port thawed\n", ap->id);
> +	ata_port_printk(ap, ATA_MSG_INFO, "ata%u port thawed\n", ap->id);

DEBUG

>  }
>  
>  static void ata_eh_scsidone(struct scsi_cmnd *scmd)
> @@ -839,7 +841,7 @@ static unsigned int ata_read_log_page(st
>  	struct ata_taskfile tf;
>  	unsigned int err_mask;
>  
> -	DPRINTK("read log page - page %d\n", page);
> +	ata_dev_printk(dev, ATA_MSG_INFO, "read log page - page %d\n", page);

DEBUG

>  
>  	ata_tf_init(dev, &tf);
>  	tf.command = ATA_CMD_READ_LOG_EXT;
> @@ -931,7 +934,7 @@ static unsigned int atapi_eh_request_sen
>  	struct ata_taskfile tf;
>  	u8 cdb[ATAPI_CDB_LEN];
>  
> -	DPRINTK("ATAPI request sense\n");
> +	ata_port_printk(ap, ATA_MSG_INFO, "ATAPI request sense\n");

DEBUG

>  
>  	ata_tf_init(dev, &tf);
>  

-- 
tejun
