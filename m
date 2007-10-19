From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 6/12] ide: add struct ide_taskfile
Date: Fri, 19 Oct 2007 20:47:22 +0400
Message-ID: <4718DF9A.8010605@ru.mvista.com>
References: <200710082311.10925.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:54879 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760526AbXJSQrN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 19 Oct 2007 12:47:13 -0400
In-Reply-To: <200710082311.10925.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>

Hello.

Bartlomiej Zolnierkiewicz wrote:

> * Don't set write-only ide_task_t.hobRegister[6] and ide_task_t.hobRegister[7]
>   in idedisk_set_max_address_ext().

> * Add struct ide_taskfile and use it in ide_task_t instead of tfRegister[]
>   and hobRegister[].

> * Remove no longer needed IDE_CONTROL_OFFSET_HOB define.

> * Add #ifndef/#endif __KERNEL__ around definitions of {task,hob}_struct_t.

> While at it:

> * Use ATA_LBA define for LBA bit (0x40) as suggested by Tejun Heo.

> There should be no functionality changes caused by this patch.

    There's some idea too...

> Index: b/include/linux/ide.h
> ===================================================================
> --- a/include/linux/ide.h
> +++ b/include/linux/ide.h
[...]
> @@ -1072,15 +1070,33 @@ extern void ide_end_drive_cmd(ide_drive_
>   */
>  extern int ide_wait_cmd(ide_drive_t *, u8, u8, u8, u8, u8 *);
>  
> +struct ide_taskfile {
> +	u8	hob_data;	/*  0: high data byte (for TASKFILE IOCTL) */
> +
> +	u8	hob_feature;	/*  1-5: additional data to support LBA48 */
> +	u8	hob_nsect;
> +	u8	hob_lbal;
> +	u8	hob_lbam;
> +	u8	hob_lbah;
> +
> +	u8	data;		/*  6: low data byte (for TASKFILE IOCTL) */
> +
> +	u8	feature;

    Why not use unnamed union like this:

	union {				/*  7: feature */
		u8	error;		/*  read: error   */
		u8	feature;	/* write: feature */
	};

> +	u8	command;	/* 13: command */

	union {				/* 13 */
		u8	status;		/*  read: status  */
		u8	command;	/* write: command */
	};

    This should qualify some places where you have to check for command 
register for the ERR bit, etc...

> +};

MBR, Sergei
