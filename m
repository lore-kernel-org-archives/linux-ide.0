From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 3/3] ide-cd: fix DMA for non bio-backed requests
Date: Tue, 27 Jan 2009 16:06:03 +0100
Message-ID: <200901271606.04097.bzolnier@gmail.com>
References: <1233002440-4325-1-git-send-email-petkovbb@gmail.com> <1233002440-4325-3-git-send-email-petkovbb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755849AbZA0PZh@vger.kernel.org>
In-Reply-To: <1233002440-4325-3-git-send-email-petkovbb@gmail.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <petkovbb@googlemail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>
List-Id: linux-ide@vger.kernel.org

On Monday 26 January 2009, Borislav Petkov wrote:
> This one fixes http://bugzilla.kernel.org/show_bug.cgi?id=12320.
> 
> Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
> ---
>  drivers/ide/ide-cd.c |    3 +++
>  drivers/ide/ide-io.c |    9 ++++++---
>  2 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
> index 94981f9..84bc370 100644
> --- a/drivers/ide/ide-cd.c
> +++ b/drivers/ide/ide-cd.c
> @@ -784,6 +784,9 @@ static ide_startstop_t cdrom_newpc_intr(ide_drive_t *drive)
>  		if (blk_fs_request(rq)) {
>  			ide_end_request(drive, 1, rq->nr_sectors);
>  			return ide_stopped;
> +		} else if (rq->cmd_type == REQ_TYPE_ATA_PC && !rq->bio) {
> +			ide_end_request(drive, 1, 1);
> +			return ide_stopped;
>  		}
>  		goto end_request;
>  	}
> diff --git a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
> index 9927b03..615b6e7 100644
> --- a/drivers/ide/ide-io.c
> +++ b/drivers/ide/ide-io.c
> @@ -291,11 +291,14 @@ void ide_map_sg(ide_drive_t *drive, struct request *rq)
>  	ide_hwif_t *hwif = drive->hwif;
>  	struct scatterlist *sg = hwif->sg_table;
>  
> -	if (rq->cmd_type != REQ_TYPE_ATA_TASKFILE) {
> -		hwif->sg_nents = blk_rq_map_sg(drive->queue, rq, sg);
> -	} else {
> +	if (rq->cmd_type == REQ_TYPE_ATA_TASKFILE) {
>  		sg_init_one(sg, rq->buffer, rq->nr_sectors * SECTOR_SIZE);
>  		hwif->sg_nents = 1;
> +	} else if (!rq->bio) {
> +		sg_init_one(sg, rq->data, rq->data_len);
> +		hwif->sg_nents = 1;
> +	} else {
> +		hwif->sg_nents = blk_rq_map_sg(drive->queue, rq, sg);
>  	}
>  }

applied

Thanks for fixing this.
