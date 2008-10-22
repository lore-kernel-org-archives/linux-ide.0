From: Elias Oltmanns <eo@nebensachen.de>
Subject: Re: [PATCH 3/4] libata: Improve timeout handling
Date: Wed, 22 Oct 2008 17:47:24 +0200
Message-ID: <87ej28skc3.fsf@denkblock.local>
References: <20081017180655.7781.15021.stgit@localhost.localdomain>
	<20081017180848.7781.59492.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nebensachen.de ([195.34.83.29]:36600 "EHLO mail.nebensachen.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751127AbYJVPrz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 22 Oct 2008 11:47:55 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> From: Alan Cox <alan@redhat.com>
>
> On a timeout call a device specific handler early in the recovery so that
> we can complete and process successful commands which timed out due to IRQ
> loss or the like rather more elegantly.
>
> Signed-off-by: Alan Cox <alan@redhat.com>
> ---
[...]
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index a93247c..757b956 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
[...]
> @@ -2871,6 +2914,7 @@ EXPORT_SYMBOL_GPL(ata_sff_qc_issue);
>  EXPORT_SYMBOL_GPL(ata_sff_qc_fill_rtf);
>  EXPORT_SYMBOL_GPL(ata_sff_host_intr);
>  EXPORT_SYMBOL_GPL(ata_sff_interrupt);
> +EXPORT_SYMBOL_GPL(ata_sff_lost_interrupt);
[...]
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index 7bb1013..75dbb35 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
[...]
> @@ -1514,6 +1515,7 @@ extern bool ata_sff_qc_fill_rtf(struct ata_queued_cmd *qc);
>  extern unsigned int ata_sff_host_intr(struct ata_port *ap,
>  				      struct ata_queued_cmd *qc);
>  extern irqreturn_t ata_sff_interrupt(int irq, void *dev_instance);
> +extern void ata_sff_lost_interrupt(struct ata_port *ap);

Actually, this one isn't used anywhere outside libata-sff.c (yet?).

Also, perhaps we cannot agree on the style of multiple line comments,
but please check this patch for whitespace issues, there is even one
that can easily be spotted without running checkpatch.pl.

Regards,

Elias
