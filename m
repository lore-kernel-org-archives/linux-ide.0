From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2.6.11-rc3 10/11] ide: make ide_cmd_ioctl() use TASKFILE
Date: Thu, 24 Feb 2005 16:50:39 +0100
Message-ID: <58cb370e050224075040f5c031@mail.gmail.com>
References: <20050210083808.48E9DD1A@htj.dyndns.org>
	 <20050210083854.BD13DFBD@htj.dyndns.org>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received: from wproxy.gmail.com ([64.233.184.205]:7886 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262404AbVBXPum (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 Feb 2005 10:50:42 -0500
Received: by wproxy.gmail.com with SMTP id 68so208765wra
        for <linux-ide@vger.kernel.org>; Thu, 24 Feb 2005 07:50:41 -0800 (PST)
In-Reply-To: <20050210083854.BD13DFBD@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>

> +       in_valid->b.status_command      = 1;
> +       in_valid->b.error_feature       = 1;
> +       in_valid->b.nsector             = 1;

ide_end_drive_cmd() must be fixed first to respect ->tf_in_flags
and it must be done *without* affecting HDIO_DRIVE_TASKFILE.

>  extern int ide_driveid_update(ide_drive_t *);
> -extern int ide_ata66_check(ide_drive_t *, ide_task_t *);
> +int ide_ata66_check(ide_drive_t *, ide_task_t *);
>  extern int ide_config_drive_speed(ide_drive_t *, u8);
>  extern u8 eighty_ninty_three (ide_drive_t *);
> -extern int set_transfer(ide_drive_t *, ide_task_t *);
> +int set_transfer(ide_drive_t *, ide_task_t *);
>  extern int taskfile_lib_get_identify(ide_drive_t *drive, u8 *);

leftovers from previous version of the patch
