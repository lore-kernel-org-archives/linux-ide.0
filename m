From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 3/6] IDE: ide-cd: fix test unsigned var < 0
Date: Thu, 17 Apr 2008 00:40:07 +0200
Message-ID: <200804170040.07397.bzolnier@gmail.com>
References: <48055F1A.9020706@tiscali.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.190]:15618 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755527AbYDPW17 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Apr 2008 18:27:59 -0400
Received: by fk-out-0910.google.com with SMTP id 19so3013115fkr.5
        for <linux-ide@vger.kernel.org>; Wed, 16 Apr 2008 15:27:58 -0700 (PDT)
In-Reply-To: <48055F1A.9020706@tiscali.nl>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Roel Kluin <12o3l@tiscali.nl>
Cc: linux-ide@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, Borislav Petkov <petkovbb@gmail.com>


Hi,

On Wednesday 16 April 2008, Roel Kluin wrote:
> Is this the right fix in this case?

Yes, but it seems that 'valid' is only written to
so it may be as well removed completely.

Care to update the patch?

Thanks,
Bart

> ---
> valid is unsigned and cannot be below 0.,
>     
> Signed-off-by: Roel Kluin <12o3l@tiscali.nl>
> ---
> diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
> index c8d0e87..a60f5df 100644
> --- a/drivers/ide/ide-cd.c
> +++ b/drivers/ide/ide-cd.c
> @@ -182,8 +182,6 @@ void cdrom_analyze_sense_data(ide_drive_t *drive,
>  			sector &= ~(bio_sectors -1);
>  			valid = (sector - failed_command->sector) << 9;
>  
> -			if (valid < 0)
> -				valid = 0;
>  			if (sector < get_capacity(info->disk) &&
>  				drive->probed_capacity - sector < 4 * 75) {
>  				set_capacity(info->disk, sector);
