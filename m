From: Grant Grundler <grundler@google.com>
Subject: Re: [PATCH 03/10] ide: destroy DMA mappings after ending DMA
Date: Sat, 14 Mar 2009 08:12:57 +0100
Message-ID: <da824cf30903140012g1565696kd6c69b4cd513f15b@mail.gmail.com>
References: <20090220171139.25429.26702.sendpatchset@localhost.localdomain>
	 <20090220171201.25429.29473.sendpatchset@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.45.13]:5867 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752677AbZCNHND convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Mar 2009 03:13:03 -0400
In-Reply-To: <20090220171201.25429.29473.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Feb 20, 2009 at 6:12 PM, Bartlomiej Zolnierkiewicz
<bzolnier@gmail.com> wrote:
> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Subject: [PATCH] ide: destroy DMA mappings after ending DMA
>
> Move ide_destroy_dmatable() call out from ->dma_end method to
> {ide_pc,cdrom_newpc,ide_dma}_intr(), ide_dma_timeout_retry()
> and sgiioc4_resetproc().
=2E..
> --- a/drivers/ide/ide-dma-sff.c
> +++ b/drivers/ide/ide-dma-sff.c
> @@ -310,8 +310,6 @@ int ide_dma_end(ide_drive_t *drive)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* clear INTR & ERROR bits */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ide_dma_sff_write_status(hwif, dma_stat | =
ATA_DMA_ERR | ATA_DMA_INTR);
>
> - =C2=A0 =C2=A0 =C2=A0 /* purge DMA mappings */
> - =C2=A0 =C2=A0 =C2=A0 ide_destroy_dmatable(drive);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0wmb();

Bartlomiej,
I think the wmb() could removed as well. The outb/writeb functions are
required to be strongly ordered and I don't see anything else touching
DMA-able memory here.

BTW, care to remove "mask" usage from this function?
It's really not needed (can be replaced with #define).

I can create separate patches for both. Which git tree should I base
them against?

=2E..
> --- a/drivers/ide/scc_pata.c
> +++ b/drivers/ide/scc_pata.c
> @@ -365,8 +365,6 @@ static int __scc_dma_end(ide_drive_t *dr
> =C2=A0 =C2=A0 =C2=A0 =C2=A0dma_stat =3D scc_dma_sff_read_status(hwif)=
;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* clear the INTR & ERROR bits */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0scc_ide_outb(dma_stat | 6, hwif->dma_base =
+ 4);
> - =C2=A0 =C2=A0 =C2=A0 /* purge DMA mappings */
> - =C2=A0 =C2=A0 =C2=A0 ide_destroy_dmatable(drive);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* verify good DMA status */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0wmb();

I think this wmb() can be removed too.

=2E...
> --- a/drivers/ide/tx4939ide.c
> +++ b/drivers/ide/tx4939ide.c
> @@ -335,11 +335,9 @@ static int tx4939ide_dma_end(ide_drive_t
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* read and clear the INTR & ERROR bits */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0dma_stat =3D tx4939ide_clear_dma_status(ba=
se);
>
> - =C2=A0 =C2=A0 =C2=A0 /* purge DMA mappings */
> - =C2=A0 =C2=A0 =C2=A0 ide_destroy_dmatable(drive);
> - =C2=A0 =C2=A0 =C2=A0 /* verify good DMA status */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0wmb();

and this one as well.

hth,
grant
