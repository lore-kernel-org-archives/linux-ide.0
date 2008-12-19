From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide: Fix drive's DWORD-IO handling
Date: Fri, 19 Dec 2008 20:01:50 +0100
Message-ID: <200812192001.51335.bzolnier@gmail.com>
References: <494A5BC9.7000605@inf.tu-dresden.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f20.google.com ([209.85.220.20]:61618 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751506AbYLSTid (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 19 Dec 2008 14:38:33 -0500
Received: by fxm13 with SMTP id 13so250525fxm.13
        for <linux-ide@vger.kernel.org>; Fri, 19 Dec 2008 11:38:31 -0800 (PST)
In-Reply-To: <494A5BC9.7000605@inf.tu-dresden.de>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mario Schwalbe <schwalbe@inf.tu-dresden.de>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Sergei Shtylyov <sshtylyov@ru.mvista.com>

On Thursday 18 December 2008, Mario Schwalbe wrote:
> Resubmitted on request.
> 
> According the documentation, id[ATA_ID_DWORD_IO] is non-zero if
> the drive supports dword IO, while the code disables support by
> setting IDE_DFLAG_NO_IO_32BIT. In addition, this word has been
> reused by the ATA8 specification. This patch fixes both cases.
> 
> Signed-off-by: Mario Schwalbe <schwalbe@inf.tu-dresden.de>
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

Since it seems that libata developers need more time to fully analyze
issues with ata_id_has_dword_io() and I don't want to delay this fix
because if it could you please modify the patch according to Sergei's
suggestion of removing id[ATA_ID_DWORD_IO] check altogether?

[ It is a safe thing to do since the old code has been enabling 32-bit
  I/O _unless_ the ATA-1 dword I/O bit for VU compatibility was set... ]

Thanks,
Bart
