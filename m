From: Steven Scholz <steven.scholz@imc-berlin.de>
Subject: Re: hotplug event on fdisk?
Date: Mon, 18 Jul 2005 08:49:00 +0200
Message-ID: <42DB50DC.3040404@imc-berlin.de>
References: <42D3E880.6060902@imc-berlin.de> <20050716212452.531e0a84.vsu@altlinux.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.imc-berlin.de ([217.110.46.186]:24844 "EHLO
	mail.imc-berlin.de") by vger.kernel.org with ESMTP id S261555AbVGRGtF
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 18 Jul 2005 02:49:05 -0400
In-Reply-To: <20050716212452.531e0a84.vsu@altlinux.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergey Vlasov <vsu@altlinux.ru>
Cc: linux-ide@vger.kernel.org

Sergey,

>> ...
>>Why is it so? And what is the system suposed to do? Actually remove
>>the device?
> 
> 
> Looking at the size of your device (512 MB), I guess that it is some
> king of flash drive.  Such devices pretend to be removable hard disks -
> and here the "removable" bit causes trouble.

Indeed I was talking about a CF Flash Card in a CF socket.

> ...
> Anyway, here is the patch with such workaround for CompactFlash (against
> the current git tree, but it should also apply to earlier kernels with
> some fuzz).
> 
> ---
> Subject: [PATCH] Avoid superfluous rechecking of partitions for IDE flash drives
> 
> For some reason, IDE flash drives report that they have removable media,
> which is not really correct - the drive as a whole is removed, therefore
> rescanning of the partition table on the first open of such devices is
> just a waste of time.
> 
> Signed-off-by: Sergey Vlasov <vsu@altlinux.ru>
> 
> diff --git a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
> --- a/drivers/ide/ide-disk.c
> +++ b/drivers/ide/ide-disk.c
> @@ -1174,6 +1174,14 @@ static int idedisk_media_changed(struct 
>  	struct ide_disk_obj *idkp = ide_disk_g(disk);
>  	ide_drive_t *drive = idkp->drive;
>  
> +	/*
> +	 * PCMCIA flash drives report themselves as removable, but can be
> +	 * treated as fixed - when such device is removed, its IDE controller
> +	 * also disappears.
> +	 */
> +	if (drive->is_flash)
> +		return 0;
> +
>  	/* do not scan partitions twice if this is a removable device */
>  	if (drive->attach) {
>  		drive->attach = 0;

Is "drive->is_flash" set for mechanical PCMCIA hard disk drives (like 
Microdrives) as well?

-- 
Steven
