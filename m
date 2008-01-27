From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 22/32] ide-tape: struct idetape_packet_command_s: shorten member names
Date: Sun, 27 Jan 2008 20:40:49 +0100
Message-ID: <200801272040.49377.bzolnier@gmail.com>
References: <1201427300-3954-1-git-send-email-petkovbb@gmail.com> <1201427300-3954-17-git-send-email-petkovbb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:9418 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756096AbYA0TcZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 27 Jan 2008 14:32:25 -0500
Received: by fg-out-1718.google.com with SMTP id e21so1431428fga.17
        for <linux-ide@vger.kernel.org>; Sun, 27 Jan 2008 11:32:23 -0800 (PST)
In-Reply-To: <1201427300-3954-17-git-send-email-petkovbb@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <petkovbb@googlemail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <bbpetkov@yahoo.de>

On Sunday 27 January 2008, Borislav Petkov wrote:
> From: Borislav Petkov <bbpetkov@yahoo.de>
> 
> Signed-off-by: Borislav Petkov <bbpetkov@yahoo.de>
> ---
>  drivers/ide/ide-tape.c |   88 ++++++++++++++++++++++++-----------------------
>  1 files changed, 45 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
> index b487d56..4690f71 100644
> --- a/drivers/ide/ide-tape.c
> +++ b/drivers/ide/ide-tape.c
> @@ -193,24 +193,25 @@ struct idetape_bh {
>  	char *b_data;
>  };
>  
> -/*
> - *	Our view of a packet command.
> - */
>  typedef struct idetape_packet_command_s {
> -	u8 c[12];				/* Actual packet bytes */
> -	int retries;				/* On each retry, we increment retries */
> -	int error;				/* Error code */
> -	int request_transfer;			/* Bytes to transfer */
> -	int actually_transferred;		/* Bytes actually transferred */
> -	int buffer_size;			/* Size of our data buffer */
> +	u8 c[12];		/* Actual packet bytes */
> +	int retries;		/* On each retry, we increment retries */
> +	int error;		/* Error code */
> +	int rq_xfer;		/* Request bytes to transfer */
> +	int xferred;		/* Bytes actually transferred */
> +	int buf_size;		/* Size of our data buffer */
>  	struct idetape_bh *bh;
>  	char *b_data;
>  	int b_count;
> -	u8 *buffer;				/* Data buffer */
> -	u8 *current_position;			/* Pointer into the above buffer */
> -	ide_startstop_t (*callback) (ide_drive_t *);	/* Called when this packet command is completed */
> +	u8 *buffer;		/* Data buffer */
> +	u8 *cur_pos;		/* Pointer into the above buffer */
> +
> +	/* Called when this packet command is completed */
> +	ide_startstop_t (*callback) (ide_drive_t *);
>  	u8 pc_buffer[IDETAPE_PC_BUFFER_SIZE];	/* Temporary buffer */
> -	unsigned long flags;			/* Status/Action bit flags: long for set_bit */
> +
> +	/* Status/Action bit flags: long for set_bit */
> +	unsigned long flags;
>  } idetape_pc_t;

ide-{floppy,scsi} are using 'request_transfer', 'actually_transferred',
'buffer_size' and 'current_position' in their packet command structures.

We are going to unify ATAPI packet command handling for all ATAPI
device drivers and this patch is a change in the opposite direction.
(IOW I suggest to drop it until ATAPI handling gets unified). 

Thanks,
Bart
