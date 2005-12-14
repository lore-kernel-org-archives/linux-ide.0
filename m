From: Jeremy Higdon <jeremy@sgi.com>
Subject: Re: [RFC][PATCH] Necessary evil to get sata_vsc to initialize with Intel iq3124h
Date: Tue, 13 Dec 2005 16:39:24 -0800
Message-ID: <20051214003924.GD184894@sgi.com>
References: <e9c3a7c20512131100v3def8760o2017d3da1a7e5b3e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from omx2-ext.sgi.com ([192.48.171.19]:29106 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030402AbVLNAja (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 Dec 2005 19:39:30 -0500
Content-Disposition: inline
In-Reply-To: <e9c3a7c20512131100v3def8760o2017d3da1a7e5b3e@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dan Williams <dan.j.williams@gmail.com>
Cc: linux-ide@vger.kernel.org

On Tue, Dec 13, 2005 at 12:00:57PM -0700, Dan Williams wrote:
> The following patch works around "irq nobody cared" problems
> encountered while using sata_vsc with the Intel iq3124h.  It seems the
> unexpected interrupts are only generated at initialization time, but
> more testing is required.  Patch is against 2.6.14.3
> 
> Dan

I think you'll have to resend this but not wrap the lines this
time.  This patch won't apply.

jeremy

> diff --git a/drivers/scsi/sata_vsc.c b/drivers/scsi/sata_vsc.c
> index cf94e01..7dcc486 100644
> --- a/drivers/scsi/sata_vsc.c
> +++ b/drivers/scsi/sata_vsc.c
> @@ -81,6 +81,19 @@
>  /* Port stride */
>  #define VSC_SATA_PORT_OFFSET           0x200
> 
> +/* Error interrupt status bit offsets */
> +#define VSC_SATA_INT_ERROR_E_OFFSET    2
> +#define VSC_SATA_INT_ERROR_P_OFFSET    4
> +#define VSC_SATA_INT_ERROR_T_OFFSET    5
> +#define VSC_SATA_INT_ERROR_M_OFFSET    1
> +#define is_vsc_sata_int_err(port_idx, int_status) \
> +        (int_status & ((1 << (VSC_SATA_INT_ERROR_E_OFFSET + (8 *
> port_idx))) | \
> +                       (1 << (VSC_SATA_INT_ERROR_P_OFFSET + (8 *
> port_idx))) | \
> +                       (1 << (VSC_SATA_INT_ERROR_T_OFFSET + (8 *
> port_idx))) | \
> +                       (1 << (VSC_SATA_INT_ERROR_M_OFFSET + (8 *
> port_idx)))   \
> +                      )\
> +        )
> +
> 
>   static u32 vsc_sata_scr_read (struct ata_port *ap, unsigned int sc_reg)
>  {
> @@ -193,13 +206,28 @@ static irqreturn_t vsc_sata_interrupt (i
>                         struct ata_port *ap;
> 
>                         ap = host_set->ports[i];
> +
> +                       if (is_vsc_sata_int_err(i, int_status)) {
> +                               u32 err_status;
> +                               printk(KERN_DEBUG "%s: ignoring
> interrupt(s)\n", __FUNCTION__);
> +                               err_status = ap ?
> vsc_sata_scr_read(ap, SCR_ERROR) : 0;
> +                               vsc_sata_scr_write(ap, SCR_ERROR, err_status);
> +                               handled++;
> +                       }
> +
>                         if (ap && !(ap->flags &
>                                     (ATA_FLAG_PORT_DISABLED|ATA_FLAG_NOINTR))) {
>                                 struct ata_queued_cmd *qc;
> 
>                                 qc = ata_qc_from_tag(ap, ap->active_tag);
> -                               if (qc && (!(qc->tf.ctl & ATA_NIEN)))
> +                               if (qc && (!(qc->tf.ctl & ATA_NIEN))) {
>                                         handled += ata_host_intr(ap, qc);
> +                               } else {
> +                                       printk(KERN_DEBUG "%s:
> ignoring interrupt(s)\n", __FUNCTION__);
> +                                       ata_chk_status(ap);
> +                                       handled++;
> +                               }
> +
>                         }
>                 }
>         }
