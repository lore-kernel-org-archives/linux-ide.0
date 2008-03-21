From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 14/17] ide-tape: remove pipeline-specific members from struct ide_tape_obj
Date: Fri, 21 Mar 2008 01:09:47 +0100
Message-ID: <200803210109.47178.bzolnier@gmail.com>
References: <1205736090-4435-1-git-send-email-petkovbb@gmail.com> <1205736090-4435-15-git-send-email-petkovbb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.186]:57487 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758380AbYCTX4h (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 20 Mar 2008 19:56:37 -0400
Received: by fk-out-0910.google.com with SMTP id 19so1495380fkr.5
        for <linux-ide@vger.kernel.org>; Thu, 20 Mar 2008 16:56:36 -0700 (PDT)
In-Reply-To: <1205736090-4435-15-git-send-email-petkovbb@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <petkovbb@googlemail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

On Monday 17 March 2008, Borislav Petkov wrote:
> Signed-off-by: Borislav Petkov <petkovbb@gmail.com>

applied after:
- merging with "ide-tape: remove pipeline-specific code from idetape_setup"
- cleaning up __idetape_discard_read_pipeline() (since patch #3 was dropped)
- cleaning up idetape_empty_write_pipeline() (since patch #4 was dropped)

> @@ -1905,7 +1855,6 @@ static int idetape_blkdev_ioctl(ide_drive_t *drive, unsigned int cmd,
>  	struct idetape_config {
>  		int dsc_rw_frequency;
>  		int dsc_media_access_frequency;
> -		int nr_stages;

we need to keep it:

>  	} config;
>  
>  	debug_log(DBG_PROCS, "Enter %s\n", __func__);
> @@ -1915,11 +1864,9 @@ static int idetape_blkdev_ioctl(ide_drive_t *drive, unsigned int cmd,
>  		if (copy_from_user(&config, argp, sizeof(config)))
>  			return -EFAULT;
>  		tape->best_dsc_rw_freq = config.dsc_rw_frequency;
> -		tape->max_stages = config.nr_stages;
>  		break;
>  	case 0x0350:
>  		config.dsc_rw_frequency = (int) tape->best_dsc_rw_freq;
> -		config.nr_stages = tape->max_stages;

changed this to export '1' to user-space
(which has always meant that pipeline-mode is disabled)

>  		if (copy_to_user(argp, &config, sizeof(config)))
>  			return -EFAULT;
>  		break;
