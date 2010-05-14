From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/2] libata: introduce sff_set_devctl() method
Date: Fri, 14 May 2010 17:31:12 -0400
Message-ID: <4BEDC120.4040609@pobox.com>
References: <201005072247.50318.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f191.google.com ([209.85.210.191]:51996 "EHLO
	mail-yx0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755910Ab0ENVhz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 14 May 2010 17:37:55 -0400
Received: by yxe29 with SMTP id 29so1246386yxe.4
        for <linux-ide@vger.kernel.org>; Fri, 14 May 2010 14:37:54 -0700 (PDT)
In-Reply-To: <201005072247.50318.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On 05/07/2010 02:47 PM, Sergei Shtylyov wrote:
> The set of libata's taskfile access methods is clearly incomplete as it lacks
> a method to write to the device control register -- which forces drivers like
> 'pata_bf54x' and 'pata_scc' to implement more "high level" (and more weighty)
> methods like freeze() and postreset().
>
> So, introduce the optional sff_set_devctl() method which the drivers only have
> to implement if the standard iowrite8() can't be used (just like the existing
> sff_check_altstatus() method) and make use of it in the freeze() and postreset()
> method implementations (I could also have used it in softreset() method but it
> also reads other taskfile registers without using tf_read() making that quite
> pointless); this makes freeze() method implementations in the 'pata_bf54x' and
> 'pata_scc' methods virtually identical to ata_sff_freeze(), so we can get rid
> of them completely.
>
> Signed-off-by: Sergei Shtylyov<sshtylyov@ru.mvista.com>
>
> ---
> The patch is against the recent Linus' tree.
>
>   Documentation/DocBook/libata.tmpl |   12 +++++++++++
>   drivers/ata/libata-sff.c          |   31 +++++++++++++++++++++++------
>   drivers/ata/pata_bf54x.c          |   40 ++++++++++++--------------------------
>   drivers/ata/pata_scc.c            |   38 +++++++++++-------------------------
>   include/linux/libata.h            |    1
>   5 files changed, 63 insertions(+), 59 deletions(-)
>
> Index: linux-2.6/Documentation/DocBook/libata.tmpl
> ===================================================================
> --- linux-2.6.orig/Documentation/DocBook/libata.tmpl
> +++ linux-2.6/Documentation/DocBook/libata.tmpl
> @@ -225,6 +225,18 @@ u8   (*sff_check_altstatus)(struct ata_p
>
>   	</sect2>
>
> +	<sect2><title>Write specific ATA shadow register</title>
> +	<programlisting>
> +void (*sff_set_devctl)(struct ata_port *ap, u8 ctl);
> +	</programlisting>
> +
> +	<para>
> +	Write the device control ATA shadow register to the hardware.
> +	Most drivers don't need to define this.
> +	</para>
> +
> +	</sect2>
> +
>   	<sect2><title>Select ATA device on bus</title>
>   	<programlisting>
>   void (*sff_dev_select)(struct ata_port *ap, unsigned int device);
> Index: linux-2.6/drivers/ata/libata-sff.c
> ===================================================================
> --- linux-2.6.orig/drivers/ata/libata-sff.c
> +++ linux-2.6/drivers/ata/libata-sff.c
> @@ -446,6 +446,27 @@ int ata_sff_wait_ready(struct ata_link *
>   EXPORT_SYMBOL_GPL(ata_sff_wait_ready);
>
>   /**
> + *	ata_sff_set_devctl - Write device control reg
> + *	@ap: port where the device is
> + *	@ctl: value to write
> + *
> + *	Writes ATA taskfile device control register.
> + *
> + *	Note: may NOT be used as the sff_set_devctl() entry in
> + *	ata_port_operations.
> + *
> + *	LOCKING:
> + *	Inherited from caller.
> + */
> +static void ata_sff_set_devctl(struct ata_port *ap, u8 ctl)
> +{
> +	if (ap->ops->sff_set_devctl)
> +		ap->ops->sff_set_devctl(ap, ctl);
> +	else
> +		iowrite8(ctl, ap->ioaddr.ctl_addr);
> +}
> +
> +/**
>    *	ata_sff_dev_select - Select device 0/1 on ATA bus
>    *	@ap: ATA channel to manipulate
>    *	@device: ATA device (numbered from zero) to select
> @@ -1895,13 +1916,11 @@ EXPORT_SYMBOL_GPL(ata_sff_lost_interrupt
>    */
>   void ata_sff_freeze(struct ata_port *ap)
>   {
> -	struct ata_ioports *ioaddr =&ap->ioaddr;
> -
>   	ap->ctl |= ATA_NIEN;
>   	ap->last_ctl = ap->ctl;
>
> -	if (ioaddr->ctl_addr)
> -		iowrite8(ap->ctl, ioaddr->ctl_addr);
> +	if (ap->ops->sff_set_devctl || ap->ioaddr.ctl_addr)
> +		ata_sff_set_devctl(ap, ap->ctl);
>
>   	/* Under certain circumstances, some controllers raise IRQ on
>   	 * ATA_NIEN manipulation.  Also, many controllers fail to mask
> @@ -2301,8 +2320,8 @@ void ata_sff_postreset(struct ata_link *
>   	}
>
>   	/* set up device control */
> -	if (ap->ioaddr.ctl_addr) {
> -		iowrite8(ap->ctl, ap->ioaddr.ctl_addr);
> +	if (ap->ops->sff_set_devctl || ap->ioaddr.ctl_addr) {
> +		ata_sff_set_devctl(ap, ap->ctl);
>   		ap->last_ctl = ap->ctl;

Applied, however, I think ata_sff_set_devctl() interface is a bit 
inefficient.  It requires the programmer to execute certain checks prior 
to calling ata_sff_set_devctl(), while other checks 
(ap->ops->sff_set_devctl) are duplicated.

It seems like better logic would put all those checks inside 
ata_sff_set_devctl(), like this:

	int ata_sff_set_devctl()
	{
		if (ap->ops->...)
			call hook
		else if (ap->ioaddr.ctl_addr)
			iowrite
		else
			return -EOPNOTSUPP;

		return 0;
	}

That sort of implementation with create a no-op set_devctl(), which 
would permit callers to call that function unconditionally -- and ignore 
the error result, if they previously would have called 
ata_sff_set_devctl() conditionally.

	Jeff




