From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 02/18] ide-cd: remove ide_cd_drain_data and ide_cd_pad_transfer
Date: Sat, 14 Jun 2008 19:29:05 +0200
Message-ID: <200806141929.05834.bzolnier@gmail.com>
References: <1213252870-20474-1-git-send-email-petkovbb@gmail.com> <1213252870-20474-3-git-send-email-petkovbb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:10563 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752799AbYFNRrE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Jun 2008 13:47:04 -0400
Received: by fg-out-1718.google.com with SMTP id 19so3007231fgg.17
        for <linux-ide@vger.kernel.org>; Sat, 14 Jun 2008 10:47:01 -0700 (PDT)
In-Reply-To: <1213252870-20474-3-git-send-email-petkovbb@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <petkovbb@googlemail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

On Thursday 12 June 2008, Borislav Petkov wrote:
> Use the generic ide_pad_transfer() helper instead
> 
> Signed-off-by: Borislav Petkov <petkovbb@gmail.com>

applied w/ ide_cd_drain_data() -> ide_pad_transfer() conversion fixup

[...]

> @@ -1006,7 +981,7 @@ static ide_startstop_t cdrom_newpc_intr(ide_drive_t *drive)
>  					   - bio_cur_sectors(rq->bio),
>  					   thislen >> 9);
>  			if (nskip > 0) {
> -				ide_cd_drain_data(drive, nskip);
> +				ide_pad_transfer(drive, write, nskip);
>  				rq->current_nr_sectors -= nskip;
>  				thislen -= (nskip << 9);
>  			}

ide_cd_drain_data() took number for _sectors_ as an argument
while ide_pad_transfer() wants to be given number of _bytes_

> @@ -1043,7 +1018,7 @@ static ide_startstop_t cdrom_newpc_intr(ide_drive_t *drive)
>  				 * If the buffers are full, pipe the rest into
>  				 * oblivion.
>  				 */
> -				ide_cd_drain_data(drive, thislen >> 9);
> +				ide_pad_transfer(drive, 0, thislen >> 9);

ditto
