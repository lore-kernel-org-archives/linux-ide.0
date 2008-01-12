From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 12/21] ide-floppy: factor out ioctl handlers from idefloppy_ioctl()
Date: Sat, 12 Jan 2008 21:16:27 +0100
Message-ID: <200801122116.27967.bzolnier@gmail.com>
References: <1200052699-28420-1-git-send-email-bbpetkov@yahoo.de> <1200052699-28420-12-git-send-email-bbpetkov@yahoo.de> <1200052699-28420-13-git-send-email-bbpetkov@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:20839 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758501AbYALUUE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 12 Jan 2008 15:20:04 -0500
Received: by ug-out-1314.google.com with SMTP id z38so640523ugc.16
        for <linux-ide@vger.kernel.org>; Sat, 12 Jan 2008 12:20:02 -0800 (PST)
In-Reply-To: <1200052699-28420-13-git-send-email-bbpetkov@yahoo.de>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <bbpetkov@yahoo.de>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Friday 11 January 2008, Borislav Petkov wrote:
> By passing idefloppy_floppy_t *floppy to the factored out functions, we get
> rid of (almost) all local vars so stack usage should be at minimum here. Also,
> we merge idefloppy_begin_format() into idefloppy_format_start() since it is its
> only user.
> 
> Also,
> - remove unneeded scsi ioctl chunk

They are _needed_, despite the name these ioctls are _not_ limited
to SCSI subsystem.

[...]

> +		int prevent = (arg) ? 1 : 0;

parentheses are unnecessary

[...]

> +static int idefloppy_format_unit(idefloppy_floppy_t *floppy, unsigned long arg)

__user tag was dropped from 'arg'
(I bet that this would make sparse checking unhappy)

> +{
> +	int blocks, length, flags, err = 0;
> +	int __user *argp = (int __user *)arg;

wouldn't be needed if the 'arg' was of 'int __user' type and the casting was
done in the caller function

[...]

> +	if (idefloppy_queue_pc_tail(floppy->drive, &pc)) {
> +		err = -EIO;
> +		goto out;

'goto out' is unnecessary

> +	}
> +
> +out:
> +	if (err)
> +		clear_bit(IDEFLOPPY_FORMAT_IN_PROGRESS, &floppy->flags);
> +	return err;
> +}

[...]

> -	/*
> -	 * skip SCSI_IOCTL_SEND_COMMAND (deprecated)
> -	 * and CDROM_SEND_PACKET (legacy) ioctls
> -	 */
> -	if (cmd != CDROM_SEND_PACKET && cmd != SCSI_IOCTL_SEND_COMMAND)
> -		err = scsi_cmd_ioctl(file, bdev->bd_disk->queue,
> -					bdev->bd_disk, cmd, argp);
> -	else
> -		err = -ENOTTY;
> -
> -	if (err == -ENOTTY)
> -		err = generic_ide_ioctl(drive, file, bdev, cmd, arg);
> -
> -	return err;
> +	return generic_ide_ioctl(drive, file, bdev, cmd, arg);

this whole chunk needs to be reverted

Please recast/resubmit.
