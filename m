From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: libata vs ATAPI
Date: Thu, 14 Oct 2004 23:15:21 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <58cb370e04101414157605d9a@mail.gmail.com>
References: <58cb370e04101213215ce9a23c@mail.gmail.com>
	 <416C438C.4010902@pobox.com>
	 <58cb370e0410121417591ecff0@mail.gmail.com>
	 <20041014071313.GF1454@suse.de>
	 <58cb370e04101412196d5a5c87@mail.gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rproxy.gmail.com ([64.233.170.206]:5176 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267164AbUJNVPW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Oct 2004 17:15:22 -0400
Received: by mproxy.gmail.com with SMTP id 76so574082rnl
        for <linux-ide@vger.kernel.org>; Thu, 14 Oct 2004 14:15:21 -0700 (PDT)
In-Reply-To: <58cb370e04101412196d5a5c87@mail.gmail.com>
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, Linux IDE <linux-ide@vger.kernel.org>

On Thu, 14 Oct 2004 21:19:25 +0200, Bartlomiej Zolnierkiewicz
<bzolnier@gmail.com> wrote:
> 
> 
> On Thu, 14 Oct 2004 09:13:13 +0200, Jens Axboe <axboe@suse.de> wrote:
> > On Tue, Oct 12 2004, Bartlomiej Zolnierkiewicz wrote:
> > > > libata enables DMA at the maximum level supported by both the device and
> > > > host controller.  I definitely want to do this by default.
> > >
> > > Me too but I suppose that there are many devices which don't like it
> > > (otherwise restrictions in ide-cd and ide-scsi make no sense).
> > >
> > > Jens?
> >
> > There's no precedens for doing > 128KiB on ATAPI in Linux. Recently Pat
> > at Iomega tested 512/1024KiB requests and it worked fine. So if the
> > device works, we should be golden...
> 
> Cool...
> 
> Jeff, I added arbitrary size ATAPI PIO support and it didn't help :(
> (still empty info from SCSI layer)
> 
> Patch below:

It has a small bug...
 
> diff -Nru a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
> --- a/drivers/scsi/libata-core.c        2004-10-14 21:18:29 +02:00
> +++ b/drivers/scsi/libata-core.c        2004-10-14 21:18:29 +02:00
> @@ -2223,11 +2223,48 @@
>         kunmap(page);
>  }
> 
> -static void atapi_pio_sector(struct ata_queued_cmd *qc)
> +static void __atapi_pio_bytes(struct ata_queued_cmd *qc, unsigned int bytes)
> +{
> +       int do_write = (qc->tf.flags & ATA_TFLAG_WRITE);
> +       struct scatterlist *sg = qc->sg;
> +       struct ata_port *ap = qc->ap;
> +       struct page *page;
> +       unsigned char *buf;
> +       unsigned int count;
> +
> +       if (qc->curbytes == qc->nbytes - bytes)
> +               ap->pio_task_state = PIO_ST_LAST;
> +
> +next_sg:
> +       sg = &sg[qc->cursg];
> +       count = min(sg_dma_len(sg) - qc->cursg_ofs, bytes);

page = sg->page;

should be here

I also found the real bug (feature?): ata_scsi_rbuf_get() clears
INQUIRY buffer for ATAPI when called from atapi_qc_complete().

With the patch below INQUIRY w/ DMA works just fine for me
("Vendor" and "Model" are correctly reported).

Now time for REPORT_LUNS...


[libata] fix INQUIRY command handling for ATAPI

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

diff -Nru a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
--- a/drivers/scsi/libata-scsi.c	2004-10-14 23:04:45 +02:00
+++ b/drivers/scsi/libata-scsi.c	2004-10-14 23:04:45 +02:00
@@ -895,7 +895,6 @@
 		buflen = cmd->request_bufflen;
 	}
 
-	memset(buf, 0, buflen);
 	*buf_out = buf;
 	return buflen;
 }
@@ -944,6 +943,7 @@
 	struct scsi_cmnd *cmd = args->cmd;
 
 	buflen = ata_scsi_rbuf_get(cmd, &rbuf);
+	memset(rbuf, 0, buflen);
 	rc = actor(args, rbuf, buflen);
 	ata_scsi_rbuf_put(cmd);
