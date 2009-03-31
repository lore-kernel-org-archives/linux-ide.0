From: Grant Grundler <grundler@google.com>
Subject: Re: [PATCH] tx4939ide: remove wmb()
Date: Tue, 31 Mar 2009 09:36:15 -0700
Message-ID: <da824cf30903310936p75469518j9bb28421b1ee81b8@mail.gmail.com>
References: <1238516136-15852-1-git-send-email-anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.33.17]:60185 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751768AbZCaQgV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 31 Mar 2009 12:36:21 -0400
In-Reply-To: <1238516136-15852-1-git-send-email-anemo@mba.ocn.ne.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org

On Tue, Mar 31, 2009 at 9:15 AM, Atsushi Nemoto <anemo@mba.ocn.ne.jp> w=
rote:
> * define CHECK_DMA_MASK
> * remove use of wmb()
>
> Suggested-by: Grant Grundler <grundler@google.com>

Thank you for the attribution!

But I think proper header would be:
    Reported-by: Grant Grundler <grundler@google.com>

But in this case, since i've looked at the code and am under the
illusion I understand it, I'm comfortable with:
    Reviewed-by: Grant Grundler <grundler@google.com>

thanks!
grant

> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> ---
> This patch is against linux-next 20090331.
>
> =C2=A0drivers/ide/tx4939ide.c | =C2=A0 =C2=A06 +++---
> =C2=A01 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/ide/tx4939ide.c b/drivers/ide/tx4939ide.c
> index cc269c0..48186ae 100644
> --- a/drivers/ide/tx4939ide.c
> +++ b/drivers/ide/tx4939ide.c
> @@ -327,15 +327,15 @@ static int tx4939ide_dma_end(ide_drive_t *drive=
)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* read and clear the INTR & ERROR bits */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0dma_stat =3D tx4939ide_clear_dma_status(ba=
se);
>
> - =C2=A0 =C2=A0 =C2=A0 wmb();
> +#define CHECK_DMA_MASK (ATA_DMA_ACTIVE | ATA_DMA_ERR | ATA_DMA_INTR)
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* verify good DMA status */
> - =C2=A0 =C2=A0 =C2=A0 if ((dma_stat & (ATA_DMA_INTR | ATA_DMA_ERR | =
ATA_DMA_ACTIVE)) =3D=3D 0 &&
> + =C2=A0 =C2=A0 =C2=A0 if ((dma_stat & CHECK_DMA_MASK) =3D=3D 0 &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(ctl & (TX4939IDE_INT_XFEREN=
D | TX4939IDE_INT_HOST)) =3D=3D
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(TX4939IDE_INT_XFEREND | TX4=
939IDE_INT_HOST))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* INT_IDE los=
t... bug? */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> - =C2=A0 =C2=A0 =C2=A0 return ((dma_stat & (ATA_DMA_INTR | ATA_DMA_ER=
R | ATA_DMA_ACTIVE)) !=3D
> + =C2=A0 =C2=A0 =C2=A0 return ((dma_stat & CHECK_DMA_MASK) !=3D
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ATA_DMA_INTR) =
? 0x10 | dma_stat : 0;
> =C2=A0}
>
> --
> 1.5.6.3
>
>
