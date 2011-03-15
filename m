From: Maxime Bizon <mbizon@freebox.fr>
Subject: Re: "irq 4: nobody cared" when loading ahci driver on ce4100
Date: Tue, 15 Mar 2011 16:03:42 +0100
Message-ID: <1300201422.10827.39.camel@sakura.staff.proxad.net>
References: <1300129707.28545.34.camel@sakura.staff.proxad.net>
	 <4D7EB9EB.8030807@gmail.com> <1300162840.2118.4.camel@kero>
	 <20110315071937.GB8635@htj.dyndns.org>
	 <1300200509.10827.27.camel@sakura.staff.proxad.net>
Reply-To: mbizon@freebox.fr
Mime-Version: 1.0
Content-Type: text/plain; charset="ANSI_X3.4-1968"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp4-g21.free.fr ([212.27.42.4]:38878 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751278Ab1COPDu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 15 Mar 2011 11:03:50 -0400
In-Reply-To: <1300200509.10827.27.camel@sakura.staff.proxad.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Robert Hancock <hancockrwd@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, linux-ide <linux-ide@vger.kernel.org>


On Tue, 2011-03-15 at 15:48 +0100, Maxime Bizon wrote:

> no it doesn't, but this one does:

sorry it does not compile, missing ')', but actually works

I will send a proper patch if you agree with this solution

> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> index 26d4523..6a01e3d 100644
> --- a/drivers/ata/libahci.c
> +++ b/drivers/ata/libahci.c
> @@ -1897,7 +1897,9 @@ static void ahci_pmp_attach(struct ata_port *ap)
>  	ahci_enable_fbs(ap);
>  
>  	pp->intr_mask |= PORT_IRQ_BAD_PMP;
> -	writel(pp->intr_mask, port_mmio + PORT_IRQ_MASK);
> +
> +	if (!(ap->pflags & (ATA_PFLAG_FROZEN | ATA_PFLAG_INITIALIZING))
> +		writel(pp->intr_mask, port_mmio + PORT_IRQ_MASK);
>  }
>  
>  static void ahci_pmp_detach(struct ata_port *ap)
> @@ -1913,7 +1915,9 @@ static void ahci_pmp_detach(struct ata_port *ap)
>  	writel(cmd, port_mmio + PORT_CMD);
>  
>  	pp->intr_mask &= ~PORT_IRQ_BAD_PMP;
> -	writel(pp->intr_mask, port_mmio + PORT_IRQ_MASK);
> +
> +	if (!(ap->pflags & (ATA_PFLAG_FROZEN | ATA_PFLAG_INITIALIZING))
> +		writel(pp->intr_mask, port_mmio + PORT_IRQ_MASK);
>  }
>  
>  int ahci_port_resume(struct ata_port *ap)
> 
> 
> 
> 


-- 
Maxime


