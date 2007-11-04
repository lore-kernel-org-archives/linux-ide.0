From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 7/15] ide: remove atapi_ireason_t
Date: Sun, 04 Nov 2007 17:57:26 +0300
Message-ID: <472DDDD6.8030806@ru.mvista.com>
References: <200710310028.27935.bzolnier@gmail.com> <200711022121.24688.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:11014 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756329AbXKDO5U (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 4 Nov 2007 09:57:20 -0500
In-Reply-To: <200711022121.24688.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> [PATCH] ide: remove atapi_ireason_t (take 2)

> Remove atapi_ireason_t.

> While at it:
> * replace 'HWIF(drive)' by 'drive->hwif' (or just 'hwif' where possible)

> v2:
> * v1 had CD and IO bits reversed in many places.

> * Use CD and IO defines from <linux/hdreg.h>.

    You're reading my mind. :-)

> Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

> Index: b/drivers/ide/ide-floppy.c
> ===================================================================
> --- a/drivers/ide/ide-floppy.c
> +++ b/drivers/ide/ide-floppy.c
> @@ -788,12 +788,11 @@ static ide_startstop_t idefloppy_pc_intr
>  {
>  	idefloppy_floppy_t *floppy = drive->driver_data;
>  	ide_hwif_t *hwif = drive->hwif;
> -	atapi_ireason_t ireason;
>  	idefloppy_pc_t *pc = floppy->pc;
>  	struct request *rq = pc->rq;
>  	unsigned int temp;
>  	u16 bcount;
> -	u8 stat;
> +	u8 stat, ireason;
>  
>  	debug_log(KERN_INFO "ide-floppy: Reached %s interrupt handler\n",
>  		__FUNCTION__);
> @@ -852,18 +851,18 @@ static ide_startstop_t idefloppy_pc_intr
>  	bcount = (hwif->INB(IDE_BCOUNTH_REG) << 8) |
>  		  hwif->INB(IDE_BCOUNTL_REG);
>  	/* on this interrupt */
> -	ireason.all = HWIF(drive)->INB(IDE_IREASON_REG);
> +	ireason = hwif->INB(IDE_IREASON_REG);
>  
> -	if (ireason.b.cod) {
> +	if (ireason & CD) {
>  		printk(KERN_ERR "ide-floppy: CoD != 0 in idefloppy_pc_intr\n");
>  		return ide_do_reset(drive);
>  	}
> -	if (ireason.b.io == test_bit(PC_WRITING, &pc->flags)) {
> +	if ((ireason & IO) == test_bit(PC_WRITING, &pc->flags)) {

    This won't work as IO is 0x02 and test_bit() returns 0 or 1.

[...]
> Index: b/drivers/ide/ide-tape.c
> ===================================================================
> --- a/drivers/ide/ide-tape.c
> +++ b/drivers/ide/ide-tape.c
[...]
> @@ -1965,18 +1964,18 @@ static ide_startstop_t idetape_pc_intr (
>  	bcount = (hwif->INB(IDE_BCOUNTH_REG) << 8) |
>  		  hwif->INB(IDE_BCOUNTL_REG);
>  
> -	ireason.all = hwif->INB(IDE_IREASON_REG);
> +	ireason = hwif->INB(IDE_IREASON_REG);
>  
> -	if (ireason.b.cod) {
> +	if (ireason & CD) {
>  		printk(KERN_ERR "ide-tape: CoD != 0 in idetape_pc_intr\n");
>  		return ide_do_reset(drive);
>  	}
> -	if (ireason.b.io == test_bit(PC_WRITING, &pc->flags)) {
> +	if ((ireason & IO) == test_bit(PC_WRITING, &pc->flags)) {

    This won't work either...

[...]

MBR, Sergei
