From: "saeed bishara" <saeed.bishara@gmail.com>
Subject: Re: [PATCH,RFC] sata_mv: don't avoid clearing interrupt status on SoC host adapters
Date: Thu, 28 Aug 2008 13:28:27 +0300
Message-ID: <c70ff3ad0808280328i41179803v80329bade95b9107@mail.gmail.com>
References: <20080824030429.GA10230@xi.wantstofly.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f29.google.com ([209.85.217.29]:57997 "EHLO
	mail-gx0-f29.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751615AbYH1K23 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 28 Aug 2008 06:28:29 -0400
Received: by gxk10 with SMTP id 10so681000gxk.13
        for <linux-ide@vger.kernel.org>; Thu, 28 Aug 2008 03:28:28 -0700 (PDT)
In-Reply-To: <20080824030429.GA10230@xi.wantstofly.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Lennert Buytenhek <buytenh@wantstofly.org>, Mark Lord <liml@rtr.ca>
Cc: Saeed Bishara <saeed@marvell.com>, linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>

On Sun, Aug 24, 2008 at 6:04 AM, Lennert Buytenhek
<buytenh@wantstofly.org> wrote:
> For some reason, sata_mv doesn't clear interrupt status during init
> when it's running on an SoC host adapter.  If the bootloader has
> touched the SATA controller before starting Linux, Linux can end up
> enabling the SATA interrupt with events pending, which will cause the
> interrupt to be marked as spurious and then be disabled, which then
> breaks all further accesses to the controller.
>
> This patch makes the SoC path clear interrupt status on init like in
> the non-SoC case.
>
> Signed-off-by: Lennert Buytenhek <buytenh@marvell.com>
> ---
>  drivers/ata/sata_mv.c |   21 ++++++++++-----------
>  1 files changed, 10 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
> index ad169ff..e829a3a 100644
> --- a/drivers/ata/sata_mv.c
> +++ b/drivers/ata/sata_mv.c
> @@ -3131,19 +3131,18 @@ static int mv_init_host(struct ata_host *host, unsigned int board_idx)
>                writelfl(0, hc_mmio + HC_IRQ_CAUSE_OFS);
>        }
>
> -       if (!IS_SOC(hpriv)) {
> -               /* Clear any currently outstanding host interrupt conditions */
> -               writelfl(0, mmio + hpriv->irq_cause_ofs);
> +       /* Clear any currently outstanding host interrupt conditions */
> +       writelfl(0, mmio + hpriv->irq_cause_ofs);
>
> -               /* and unmask interrupt generation for host regs */
> -               writelfl(hpriv->unmask_all_irqs, mmio + hpriv->irq_mask_ofs);
> +       /* and unmask interrupt generation for host regs */
> +       writelfl(hpriv->unmask_all_irqs, mmio + hpriv->irq_mask_ofs);
> +
> +       /*
> +        * enable only global host interrupts for now.
> +        * The per-port interrupts get done later as ports are set up.
> +        */
> +       mv_set_main_irq_mask(host, 0, PCI_ERR);
>
> -               /*
> -                * enable only global host interrupts for now.
> -                * The per-port interrupts get done later as ports are set up.
> -                */
> -               mv_set_main_irq_mask(host, 0, PCI_ERR);
> -       }
>  done:
>        return rc;
>  }
The patch looks fine.
Mark, I think that all the code that clears the cause registers should
be moved from mv_init_host to the reset_hc functions, which already
clears some of those register. for example, register 0x14 (host
controller cause register) get cleared twice, the first time at
mv5_reset_one_hc. also, the reset_hc functions better use the register
define instead of a hardcoded number when possible.


saeed
