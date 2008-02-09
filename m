From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: ide-tape redux (was: Re:)
Date: Sat, 9 Feb 2008 17:25:23 +0100
Message-ID: <200802091725.23372.bzolnier@gmail.com>
References: <1202132440-26648-1-git-send-email-petkovbb@gmail.com> <200802050220.22637.bzolnier@gmail.com> <20080206052343.GA14349@gollum.tnic>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.179]:42918 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755361AbYBIQS0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 9 Feb 2008 11:18:26 -0500
Received: by py-out-1112.google.com with SMTP id u52so5966992pyb.10
        for <linux-ide@vger.kernel.org>; Sat, 09 Feb 2008 08:18:26 -0800 (PST)
In-Reply-To: <20080206052343.GA14349@gollum.tnic>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org


Hi,

On Wednesday 06 February 2008, Borislav Petkov wrote:
> On Tue, Feb 05, 2008 at 02:20:22AM +0100, Bartlomiej Zolnierkiewicz wrote:
> 
> [...]
> 
> > w.r.t. #11 ide-tape uses char devices and supports DSC so it is not as obvious
> > as in ide-floppy case that all atomic bitops can be just removed (extra audit
> > and some time -mm are required) so please resync/resubmit
> 
> Ok, here's what i think we should do here: There are two flags that handle DSC:
> PC_FL_WAIT_FOR_DSC and IDETAPE_FL_IGNORE_DSC. The first one is per pc and is set in
> all the packet command init functions ..create_bla_cmd() after their callers have
> created a pc on the stack and reached its ptr down for initialization. This case
> is carefree since the bit will be tested first in the interrupt handler and this
> happens only after the pc is queued (ide_do_drive_cmd()) into the request buffer.
> 
> The other flag, IDETAPE_FL_IGNORE_DSC, is polled for in the request handler and
> can be set when a pc is being retried and we should leave only those atomic
> tests intact, imho, but i'm definitely gonna need a second opinion here.

Actually for this flag it looks safe because the new request shouldn't be
queued while the old one is still active (IOW there should be no simultaneous
idetape_do_request() and idetape_end_request() calls).  OTOH some other
flags (especially IDETAPE_PIPELINE_ACTIVE) looks un-safe (pileline can be
active while ->open on character device happens).

Given that this driver is currently scheduled for removal and that complete
audit/analysis would be quite costly I don't think that removing atomic bitops
from tape->flags is worth it (for pc->flags it is fine).

Could you please recast the patch accordingly?

[ + some minor issues below ]

> ---
> 
> commit 1ed8ae92249d5dff7af4ee88710ea08ff3f3356f
> Author: Borislav Petkov <petkovbb@gmail.com>
> Date:   Tue Feb 5 08:05:35 2008 +0100
> 
>     ide-tape: remove atomic test/set macros
>     
>     Also, since the driver supports DSC, leave the atomic tests
>     for the IDETAPE_FL_IGNORE_DSC bit untouched because this is polled
>     for in the request handler and can be set in the interrupt
>     handler through idetape_retry_pc() after enabling interrupts.
>     
>     Finally, remove flag IDETAPE_READ_ERROR since it is unused.
>     
>     Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
> 
> diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
> index e59e49e..9455ce4 100644
> --- a/drivers/ide/ide-tape.c
> +++ b/drivers/ide/ide-tape.c
> @@ -206,24 +206,24 @@ typedef struct idetape_packet_command_s {
>  	/* Temporary buffer */
>  	u8 pc_buffer[IDETAPE_PC_BUFFER_SIZE];
>  	/* Status/Action bit flags: long for set_bit */
> -	unsigned long flags;
> +	unsigned int flags;

please leave it as 'unsigned long' to match other drivers

>  } idetape_pc_t;
>  
> -/*
> - *	Packet command flag bits.
> - */
> -/* Set when an error is considered normal - We won't retry */
> -#define	PC_ABORT			0
> -/* 1 When polling for DSC on a media access command */
> -#define PC_WAIT_FOR_DSC			1
> -/* 1 when we prefer to use DMA if possible */
> -#define PC_DMA_RECOMMENDED		2
> -/* 1 while DMA in progress */
> -#define	PC_DMA_IN_PROGRESS		3
> -/* 1 when encountered problem during DMA */
> -#define	PC_DMA_ERROR			4
> -/* Data direction */
> -#define	PC_WRITING			5
> +/* Packet command flag bits. */
> +enum {
> +	/* Set when an error is considered normal - We won't retry */
> +	PC_FL_ABORT		= (1 << 0),
> +	/* 1 When polling for DSC on a media access command */
> +	PC_FL_WAIT_FOR_DSC	= (1 << 1),
> +	/* 1 when we prefer to use DMA if possible */
> +	PC_FL_DMA_RECOMMENDED	= (1 << 2),
> +	/* 1 while DMA in progress */
> +	PC_FL_DMA_IN_PROGRESS	= (1 << 3),
> +	/* 1 when encountered problem during DMA */
> +	PC_FL_DMA_ERROR		= (1 << 4),
> +	/* Data direction */
> +	PC_FL_WRITING		= (1 <<	5),

Why not PC_FLAG_*?  [ It would match flags in ide-floppy ]

> +};
>  
>  /* A pipeline stage. */
>  typedef struct idetape_stage_s {
> @@ -357,8 +357,7 @@ typedef struct ide_tape_obj {
>  	/* Wasted space in each stage */
>  	int excess_bh_size;
>  
> -	/* Status/Action flags: long for set_bit */
> -	unsigned long flags;
> +	unsigned int flags;

please leave it as 'unsigned long'

[ besides I don't think that mixing atomic and non-atomic access on
  the _same_ variable is OK ]

>  	/* protects the ide-tape queue */
>  	spinlock_t lock;
>  
> @@ -451,20 +450,26 @@ static void ide_tape_put(struct ide_tape_obj *tape)
>  #define DOOR_LOCKED			1
>  #define DOOR_EXPLICITLY_LOCKED		2
>  
> -/*
> - *	Tape flag bits values.
> - */
> -#define IDETAPE_IGNORE_DSC		0
> -#define IDETAPE_ADDRESS_VALID		1	/* 0 When the tape position is unknown */
> -#define IDETAPE_BUSY			2	/* Device already opened */
> -#define IDETAPE_PIPELINE_ERROR		3	/* Error detected in a pipeline stage */
> -#define IDETAPE_DETECT_BS		4	/* Attempt to auto-detect the current user block size */
> -#define IDETAPE_FILEMARK		5	/* Currently on a filemark */
> -#define IDETAPE_DRQ_INTERRUPT		6	/* DRQ interrupt device */
> -#define IDETAPE_READ_ERROR		7
> -#define IDETAPE_PIPELINE_ACTIVE		8	/* pipeline active */
> -/* 0 = no tape is loaded, so we don't rewind after ejecting */
> -#define IDETAPE_MEDIUM_PRESENT		9
> +/* Tape flag bits values. */
> +enum {
> +	IDETAPE_FL_IGNORE_DSC		= (1 << 0),
> +	/* 0 When the tape position is unknown */
> +	IDETAPE_FL_ADDRESS_VALID	= (1 <<	1),
> +	/* Device already opened */
> +	IDETAPE_FL_BUSY			= (1 << 2),
> +	/* Error detected in a pipeline stage */
> +	IDETAPE_FL_PIPELINE_ERR	= (1 <<	3),
> +	/* Attempt to auto-detect the current user block size */
> +	IDETAPE_FL_DETECT_BS		= (1 << 4),
> +	/* Currently on a filemark */
> +	IDETAPE_FL_FILEMARK		= (1 << 5),
> +	/* DRQ interrupt device */
> +	IDETAPE_FL_DRQ_INTERRUPT	= (1 << 6),
> +	/* pipeline active */
> +	IDETAPE_FL_PIPELINE_ACTIVE	= (1 << 7),
> +	/* 0 = no tape is loaded, so we don't rewind after ejecting */
> +	IDETAPE_FL_MEDIUM_PRESENT	= (1 << 8),

Why not IDETAPE_FLAG_*?

The rest of the patch looks good.
