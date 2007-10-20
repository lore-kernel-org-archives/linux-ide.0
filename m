From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 10/12] ide: add ide_tf_load() helper
Date: Sat, 20 Oct 2007 23:20:20 +0400
Message-ID: <471A54F4.3010606@ru.mvista.com>
References: <200710082317.46641.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:62119 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750768AbXJTTUK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 20 Oct 2007 15:20:10 -0400
In-Reply-To: <200710082317.46641.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>

Hello.

Bartlomiej Zolnierkiewicz wrote:

> Based on the earlier work by Tejun Heo.

> * Add 'tf_flags' field (for taskfile flags) to ide_task_t.

> * Add IDE_TFLAG_LBA48 taskfile flag for LBA48 taskfiles.

> * Add IDE_TFLAG_NO_SELECT_MASK taskfile flag for __ide_do_rw_disk()
>   which doesn't use SELECT_MASK() (looks like a bug but it requires
>   some more investigation).

> * Split off ide_tf_load() helper from do_rw_taskfile().

> * Convert __ide_do_rw_disk() to use ide_tf_load().

> There should be no functionality changes caused by this patch.

> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> Index: b/drivers/ide/ide-taskfile.c
> ===================================================================
> --- a/drivers/ide/ide-taskfile.c
> +++ b/drivers/ide/ide-taskfile.c
> @@ -62,6 +62,37 @@ static void taskfile_output_data(ide_dri
>  	}
>  }
>  
> +void ide_tf_load(ide_drive_t *drive, ide_task_t *task)
> +{
> +	ide_hwif_t *hwif = drive->hwif;
> +	struct ide_taskfile *tf = &task->tf;
> +	u8 HIHI = (task->tf_flags & IDE_TFLAG_LBA48) ? 0xE0 : 0xEF;

    Funny name indeed. I wonder what could it mean? B-)


MBR, Sergei
