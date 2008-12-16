From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide: Fix drive's DWORD-IO handling
Date: Tue, 16 Dec 2008 20:13:15 +0100
Message-ID: <200812162013.15461.bzolnier@gmail.com>
References: <4945968D.7050300@inf.tu-dresden.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:47890 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751671AbYLPTPB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 16 Dec 2008 14:15:01 -0500
Received: by bwz14 with SMTP id 14so4385977bwz.13
        for <linux-ide@vger.kernel.org>; Tue, 16 Dec 2008 11:14:59 -0800 (PST)
In-Reply-To: <4945968D.7050300@inf.tu-dresden.de>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mario Schwalbe <schwalbe@inf.tu-dresden.de>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Monday 15 December 2008, Mario Schwalbe wrote:
> According the documentation, id[ATA_ID_DWORD_IO] is non-zero if
> the drive supports dword IO, while the code disables support by
> setting IDE_DFLAG_NO_IO_32BIT. In addition, this word has been
> reused by the ATA8 specification. This patch fixes both cases.
> ---
>  drivers/ide/ide-probe.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
> index c55bdbd..859b0e5 100644
> --- a/drivers/ide/ide-probe.c
> +++ b/drivers/ide/ide-probe.c
> @@ -856,7 +856,7 @@ static void ide_port_tune_devices(ide_hwif_t *hwif)
>  		ide_drive_t *drive = &hwif->drives[unit];
> 
>  		if ((hwif->host_flags & IDE_HFLAG_NO_IO_32BIT) ||
> -		    drive->id[ATA_ID_DWORD_IO])
> +		    !ata_id_has_dword_io(drive->id))
>  			drive->dev_flags |= IDE_DFLAG_NO_IO_32BIT;
>  		else
>  			drive->dev_flags &= ~IDE_DFLAG_NO_IO_32BIT;

This change is OK and I would happily apply the patch but...

ata_id_has_dword_io() itself has bugs that need fixing (which would
have a nice side-effect of fixing some libata drivers that happen to
use it directly).  ATA_ID_DWORD_IO word is defined only in ATA-1 spec
and devices confirming to the later versions of spec support dword IO
just fine despite using zero value for the said word.

Thus could you please fix ata_id_has_dword_io() first (preferrably in
a separate patch) and than re-submit this patch (btw please remember to
include "Signed-off-by" line in your patches).

Thanks,
Bart
