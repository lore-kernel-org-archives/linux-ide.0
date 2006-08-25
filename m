From: "Fajun Chen" <fajunchen@gmail.com>
Subject: Re: Libata EH False Alarm (2.6.18-rc2)?
Date: Fri, 25 Aug 2006 08:41:24 -0600
Message-ID: <8202f4270608250741l15047a96q544d38eebca8d57e@mail.gmail.com>
References: <8202f4270608241242i7a4d2d0anc3f607dad7df0129@mail.gmail.com>
	 <44EE0561.1030007@gmail.com>
	 <8202f4270608241305n2e0d3e80q2bd377ae85d841bb@mail.gmail.com>
	 <44EE0A42.4070104@gmail.com> <44EE0AE6.8070608@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.176]:45737 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751290AbWHYOlZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 25 Aug 2006 10:41:25 -0400
Received: by py-out-1112.google.com with SMTP id n25so1265248pyg
        for <linux-ide@vger.kernel.org>; Fri, 25 Aug 2006 07:41:25 -0700 (PDT)
In-Reply-To: <44EE0AE6.8070608@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com

Hi Tejun,

I tested your patch. No more EH alarms in dmesg during an overnight
test.  One question I have is whether this fix will mask genuine
failure.

Thanks,
Fajun

On 8/24/06, Tejun Heo <htejun@gmail.com> wrote:
> Tejun Heo wrote:
> > Fajun Chen wrote:
> >> Sil3124. That's the only chipset we use.
> >
> >>> > [30540.003174] ata1: exception Emask 0x10 SAct 0x0 SErr 0x80000 action
> >>> > 0x2 frozen
> >>> > [30540.003259] ata1: (irq_stat 0x01100010, PHY RDY changed)
> >
> > Yeap, this message from sata_sil24.  You're not getting any phy status
> > changes bits in SError although the device is reporting phy rdy changed
> > event.  However, your 3124 is reporting 8b/10b decoding error threshold
> > exceeded error interrupt.  That could be related to the phyrdy status
> > changed event.  This happens only under heavy IO, right?  How often does
> > it occur in units of times per megabytes transferred?
> >
> > 8b/10b error is a recoverable FIS reception error.  The interrupt bit
> > (bit 24 of irq_stat) is only turned on if threshold count is exceeded,
> > which is initialized to 0x8000 at the moment.  This indicates that there
> > are quite some number of transmission failures.
> >
>
> Sorry, I forgot to attach patch.  Can you please try the attached patch?
>
> --
> tejun
>
>
> --- a/drivers/scsi/sata_sil24.c
> +++ b/drivers/scsi/sata_sil24.c
> @@ -1034,9 +1034,9 @@ static void sil24_init_controller(struct
>                         writel(PORT_CS_IRQ_WOC, port + PORT_CTRL_CLR);
>
>                 /* Zero error counters. */
> -               writel(0x8000, port + PORT_DECODE_ERR_THRESH);
> -               writel(0x8000, port + PORT_CRC_ERR_THRESH);
> -               writel(0x8000, port + PORT_HSHK_ERR_THRESH);
> +               writel(0x0000, port + PORT_DECODE_ERR_THRESH);
> +               writel(0x0000, port + PORT_CRC_ERR_THRESH);
> +               writel(0x0000, port + PORT_HSHK_ERR_THRESH);
>                 writel(0x0000, port + PORT_DECODE_ERR_CNT);
>                 writel(0x0000, port + PORT_CRC_ERR_CNT);
>                 writel(0x0000, port + PORT_HSHK_ERR_CNT);
>
>
>
