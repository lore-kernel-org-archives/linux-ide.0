From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH] pata_bf54x: fix BMIDE status register emulation
Date: Fri, 06 Jan 2012 20:14:08 +0300
Message-ID: <4F072BE0.305@mvista.com>
References: <201112281836.45834.sshtylyov@ru.mvista.com> <DB904C5425BA6F4E8424B3B51A1414D16D76860B88@NWD2CMBX1.ad.analog.com> <4EFF24BF.20905@mvista.com> <DB904C5425BA6F4E8424B3B51A1414D16D76860EA1@NWD2CMBX1.ad.analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:36116 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750892Ab2AFQPQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 6 Jan 2012 11:15:16 -0500
Received: by eaad14 with SMTP id d14so1048885eaa.19
        for <linux-ide@vger.kernel.org>; Fri, 06 Jan 2012 08:15:15 -0800 (PST)
In-Reply-To: <DB904C5425BA6F4E8424B3B51A1414D16D76860EA1@NWD2CMBX1.ad.analog.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Zhang, Sonic" <Sonic.Zhang@analog.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "jgarzik@pobox.com" <jgarzik@pobox.com>

Hello.

On 01/04/2012 09:04 AM, Zhang, Sonic wrote:

> The MULTI_DONE_INT, UDMAIN_DONE_INT and UDMAOUT_DONE_INT are triggered independent of the ATAPI_DEV_INT, although they bind to the same IRQ on bf548. With your patch, these interrupts are ignored and results in kernel error "unhandled IRQ".

> If you insist the BMDMA emulation on bf548 should comply with INF-8038i. I would propose the following patch to disable all BF548 ATAPI specific interrupts.

> Sonic


> ---
>   drivers/ata/pata_bf54x.c |   19 ++-----------------
>   1 files changed, 2 insertions(+), 17 deletions(-)

> diff --git a/drivers/ata/pata_bf54x.c b/drivers/ata/pata_bf54x.c
> index bd987bb..9711c2a 100644
> --- a/drivers/ata/pata_bf54x.c
> +++ b/drivers/ata/pata_bf54x.c
> @@ -418,14 +418,6 @@ static void bfin_set_dmamode(struct ata_port *ap, struct ata_device *adev)
>                                          (tcyc_tdvs<<8 | tdvs));
>                                  ATAPI_SET_ULTRA_TIM_2(base, (tmli<<8 | tss));
>                                  ATAPI_SET_ULTRA_TIM_3(base, (trp<<8 | tzah));
> -
> -                               /* Enable host ATAPI Untra DMA interrupts */
> -                               ATAPI_SET_INT_MASK(base,
> -                                       ATAPI_GET_INT_MASK(base)
> -                                       | UDMAIN_DONE_MASK
> -                                       | UDMAOUT_DONE_MASK
> -                                       | UDMAIN_TERM_MASK
> -                                       | UDMAOUT_TERM_MASK);
>                          }
>                  }
>          }
> @@ -470,10 +462,6 @@ static void bfin_set_dmamode(struct ata_port *ap, struct ata_device *adev)
>                          ATAPI_SET_MULTI_TIM_0(base, (tm<<8 | td));
>                          ATAPI_SET_MULTI_TIM_1(base, (tkr<<8 | tkw));
>                          ATAPI_SET_MULTI_TIM_2(base, (teoc<<8 | th));
> -
> -                       /* Enable host ATAPI Multi DMA interrupts */
> -                       ATAPI_SET_INT_MASK(base, ATAPI_GET_INT_MASK(base)
> -                               | MULTI_DONE_MASK | MULTI_TERM_MASK);
>                          SSYNC();
>                  }
>          }
> @@ -1155,13 +1143,10 @@ static unsigned char bfin_bmdma_status(struct ata_port *ap)
>          void __iomem *base = (void __iomem *)ap->ioaddr.ctl_addr;
>          unsigned short int_status = ATAPI_GET_INT_STATUS(base);
>
> -       if (ATAPI_GET_STATUS(base)&  (MULTI_XFER_ON|ULTRA_XFER_ON))
> +       if (ATAPI_GET_STATUS(base)&  (MULTI_XFER_ON | ULTRA_XFER_ON))
>                  host_stat |= ATA_DMA_ACTIVE;
> -       if (int_status&  (MULTI_DONE_INT|UDMAIN_DONE_INT|UDMAOUT_DONE_INT|
> -               ATAPI_DEV_INT))
> +       if (ATAPI_GET_INT_STATUS(base)&  ATAPI_DEV_INT)
>                  host_stat |= ATA_DMA_INTR;
> -       if (int_status&  (MULTI_TERM_INT|UDMAIN_TERM_INT|UDMAOUT_TERM_INT))
> -               host_stat |= ATA_DMA_ERR|ATA_DMA_INTR;
>
>          dev_dbg(ap->dev, "ATAPI: host_stat=0x%x\n", host_stat);
>

    Unfortunately your patch is white space damaged, with tabs converted to 
spaces. I'll reconstruct it...

MBR, Sergei
