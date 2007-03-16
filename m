From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] libata: add support for READ/WRITE LONG
Date: Fri, 16 Mar 2007 17:02:04 +0300
Message-ID: <45FAA35C.2090902@ru.mvista.com>
References: <3aac340703102322p362998b9labedc13503702d2b@mail.gmail.com>	 <45F56800.3040104@rtr.ca> <3aac340703121003l43685599t8dbffe6247879a91@mail.gmail.com> <45F5A523.1080500@rtr.ca> <45FA8D7A.3040504@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:33186 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S964773AbXCPOCR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 16 Mar 2007 10:02:17 -0400
In-Reply-To: <45FA8D7A.3040504@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, Vitaliyi <imgrey@gmail.com>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Hello.

Mark Lord wrote:

> The READ/WRITE LONG commands are theoretically obsolete,
> but the majority of drives in existance still implement them.

> The WRITE_LONG and WRITE_LONG_ONCE commands are of particular
> interest for fault injection testing -- eg. creating "media errors"
> at specific locations on a disk.

> The fussy bit is that these commands require a non-standard
> sector size, usually 520 bytes instead of 512.

    Which requires from the drivers to be able to turn off IDE prefetch (and 
maybe posting too).  I don't see that in this patch (or are you expecting them 
to just "snoop' the commands and do it automagically?).

> This patch adds support to libata for READ/WRITE LONG commands
> issued via SG_IO/ATA_16.

> Signed-off-by:  Mark Lord <mlord@pobox.com>
> ---
> --- linux/include/linux/libata.h.orig    2007-03-07 09:20:04.000000000 
> -0500
> +++ linux/include/linux/libata.h    2007-03-12 13:16:29.000000000 -0400
> @@ -425,6 +425,7 @@
>     int            dma_dir;
> 
>     unsigned int        pad_len;
> +    unsigned int        sect_size;
> 
>     unsigned int        nbytes;
>     unsigned int        curbytes;

    Tabs are spoilt. :-/

> @@ -1171,6 +1172,7 @@
>     qc->n_elem = 0;
>     qc->err_mask = 0;
>     qc->pad_len = 0;
> +    qc->sect_size = ATA_SECT_SIZE;
> 
>     ata_tf_init(qc->dev, &qc->tf);
> 
> --- linux/include/linux/ata.h.orig    2007-03-07 09:21:25.000000000 -0500
> +++ linux/include/linux/ata.h    2007-03-12 13:15:45.000000000 -0400
> @@ -163,6 +163,12 @@
>     /* READ_LOG_EXT pages */
>     ATA_LOG_SATA_NCQ    = 0x10,
> 
> +    /* READ/WRITE LONG (obsolete) */
> +    ATA_CMD_READ_LONG    = 0x22,
> +    ATA_CMD_READ_LONG_ONCE    = 0x23,
> +    ATA_CMD_WRITE_LONG    = 0x32,
> +    ATA_CMD_WRITE_LONG_ONCE    = 0x33,
> +
>     /* SETFEATURES stuff */
>     SETFEATURES_XFER    = 0x03,
>     XFER_UDMA_7        = 0x47,
> --- linux/drivers/ata/libata-scsi.c.orig    2007-03-07 
> 09:21:13.000000000 -0500
> +++ linux/drivers/ata/libata-scsi.c    2007-03-12 13:14:46.000000000 -0400
> @@ -2678,6 +2678,18 @@
>         tf->device = qc->dev->devno ?
>             tf->device | ATA_DEV1 : tf->device & ~ATA_DEV1;
> 
> +    /* READ/WRITE LONG use a non-standard sect_size */
> +    qc->sect_size = ATA_SECT_SIZE;
> +    switch (tf->command) {
> +    case ATA_CMD_READ_LONG:
> +    case ATA_CMD_READ_LONG_ONCE:
> +    case ATA_CMD_WRITE_LONG:
> +    case ATA_CMD_WRITE_LONG_ONCE:
> +        if (tf->protocol != ATA_PROT_PIO || tf->nsect != 1)
> +            goto invalid_fld;
> +        qc->sect_size = scmd->request_bufflen;
> +    }
> +
>     /*
>      * Filter SET_FEATURES - XFER MODE command -- otherwise,
>      * SET_FEATURES - XFER MODE must be preceded/succeeded
> --- linux/drivers/ata/libata-core.c.orig    2007-03-12 
> 11:22:43.000000000 -0400
> +++ linux/drivers/ata/libata-core.c    2007-03-12 13:08:28.000000000 -0400
> @@ -4032,10 +4032,10 @@
> 
> 
> /**
> - *    ata_pio_sector - Transfer ATA_SECT_SIZE (512 bytes) of data.
> + *    ata_pio_sector - Transfer a sector of data.
>  *    @qc: Command on going
>  *
> - *    Transfer ATA_SECT_SIZE of data from/to the ATA device.
> + *    Transfer qc->sect_size bytes of data from/to the ATA device.
>  *
>  *    LOCKING:
>  *    Inherited from caller.
> @@ -4050,7 +4050,7 @@
>     unsigned int offset;
>     unsigned char *buf;
> 
> -    if (qc->curbytes == qc->nbytes - ATA_SECT_SIZE)
> +    if (qc->curbytes == qc->nbytes - qc->sect_size)
>         ap->hsm_task_state = HSM_ST_LAST;
> 
>     page = sg[qc->cursg].page;
> @@ -4070,17 +4070,17 @@
>         buf = kmap_atomic(page, KM_IRQ0);
> 
>         /* do the actual data transfer */
> -        ap->ops->data_xfer(qc->dev, buf + offset, ATA_SECT_SIZE, 
> do_write);
> +        ap->ops->data_xfer(qc->dev, buf + offset, qc->sect_size, 
> do_write);


>         kunmap_atomic(buf, KM_IRQ0);
>         local_irq_restore(flags);
>     } else {
>         buf = page_address(page);
> -        ap->ops->data_xfer(qc->dev, buf + offset, ATA_SECT_SIZE, 
> do_write);
> +        ap->ops->data_xfer(qc->dev, buf + offset, qc->sect_size, 
> do_write);
>     }
> 
> -    qc->curbytes += ATA_SECT_SIZE;
> -    qc->cursg_ofs += ATA_SECT_SIZE;
> +    qc->curbytes += qc->sect_size;
> +    qc->cursg_ofs += qc->sect_size;
> 
>     if (qc->cursg_ofs == (&sg[qc->cursg])->length) {
>         qc->cursg++;

    Again, ata_data_xfer() doesn't seem capable of performing ECC read/writes 
-- the ECC bytes must be transferred in 8-bit mode, AFAIR. ata_data_xfer() can 
oinly do that for optionally trailing odd byte. NAK.

MBR, Sergei
