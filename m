From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH #upstream-fixes 2/2] libata: implement spurious irq handling
 for SFF and apply it to piix
Date: Thu, 14 Jan 2010 15:42:35 +0300
Message-ID: <4B4F113B.30400@ru.mvista.com>
References: <4B4ECCCD.1040902@kernel.org> <4B4ECD81.8020205@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([206.112.117.35]:15106 "HELO
	imap.sh.mvista.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1752302Ab0ANMoN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Jan 2010 07:44:13 -0500
In-Reply-To: <4B4ECD81.8020205@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Hans Werner <hwerner4@gmx.de>

Hello.

Tejun Heo wrote:

> Traditional IDE interface sucks in that it doesn't have a reliable IRQ
> pending bit, so if the controller raises IRQ while the driver is
> expecting it not to, the IRQ won't be cleared and eventually the IRQ
> line will be killed by interrupt subsystem.  Some controllers have
> non-standard mechanism to indicate IRQ pending so that this condition
> can be detected and worked around.
>
> This patch adds an optional operation ->sff_irq_check() which will be
> called for each port from the ata_sff_interrupt() if an unexpected
> interrupt is received.  If the operation returns %true,
> ->sff_check_status() and ->sff_irq_clear() will be cleared for the
> port.  Note that this doesn't mark the interrupt as handled so it
> won't prevent IRQ subsystem from killing the IRQ if this mechanism
> fails to clear the spurious IRQ.
>
> This patch also implements ->sff_irq_check() for ata_piix.  Note that
> this adds slight overhead to shared IRQ operation as IRQs which are
> destined for other controllers will trigger extra register accesses to
> check whether IDE interrupt is pending but this solves rare screaming
> IRQ cases and for some curious reason also helps weird BIOS related
> glitch on Samsung n130 as reported in bko#14314.
>
>   http://bugzilla.kernel.org/show_bug.cgi?id=14314
>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reported-by: Johannes Stezenbach <js@sig21.net>
> Reported-by: Hans Werner <hwerner4@gmx.de>
> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> ---
> This is generalized safe version of the previous patch which only
> worked for ata_piix and marked the interrupt as handled.
>
> Thanks.
>
>  drivers/ata/ata_piix.c   |   18 ++++++++++++++++--
>  drivers/ata/libata-sff.c |   22 ++++++++++++++++++++++
>  include/linux/libata.h   |    1 +
>  3 files changed, 39 insertions(+), 2 deletions(-)
>
> Index: ata/include/linux/libata.h
> ===================================================================
> --- ata.orig/include/linux/libata.h
> +++ ata/include/linux/libata.h
> @@ -857,6 +857,7 @@ struct ata_port_operations {
>  	unsigned int (*sff_data_xfer)(struct ata_device *dev,
>  			unsigned char *buf, unsigned int buflen, int rw);
>  	u8   (*sff_irq_on)(struct ata_port *);
> +	bool (*sff_irq_check)(struct ata_port *);
>  	void (*sff_irq_clear)(struct ata_port *);
>  
>  	void (*bmdma_setup)(struct ata_queued_cmd *qc);
> Index: ata/drivers/ata/ata_piix.c
> ===================================================================
> --- ata.orig/drivers/ata/ata_piix.c
> +++ ata/drivers/ata/ata_piix.c
> @@ -173,6 +173,7 @@ static int piix_sidpr_scr_read(struct at
>  			       unsigned int reg, u32 *val);
>  static int piix_sidpr_scr_write(struct ata_link *link,
>  				unsigned int reg, u32 val);
> +static bool piix_irq_check(struct ata_port *ap);
>  #ifdef CONFIG_PM
>  static int piix_pci_device_suspend(struct pci_dev *pdev, pm_message_t mesg);
>  static int piix_pci_device_resume(struct pci_dev *pdev);
> @@ -309,8 +310,13 @@ static struct scsi_host_template piix_sh
>  	ATA_BMDMA_SHT(DRV_NAME),
>  };
>  
> -static struct ata_port_operations piix_pata_ops = {
> +static struct ata_port_operations piix_base_ops = {
>  	.inherits		= &ata_bmdma32_port_ops,
> +	.sff_irq_check		= piix_irq_check,
> +};
> +
> +static struct ata_port_operations piix_pata_ops = {
> +	.inherits		= &piix_base_ops,
>  	.cable_detect		= ata_cable_40wire,
>  	.set_piomode		= piix_set_piomode,
>  	.set_dmamode		= piix_set_dmamode,
> @@ -329,7 +335,7 @@ static struct ata_port_operations ich_pa
>  };
>  
>  static struct ata_port_operations piix_sata_ops = {
> -	.inherits		= &ata_bmdma32_port_ops,
> +	.inherits		= &piix_base_ops,
>  };
>   

   Not sure it was worth wasting memory on having 2 identical copies of 
the struct ata_port_operations...

>  
>  static struct ata_port_operations piix_sidpr_sata_ops = {
> @@ -962,6 +968,14 @@ static int piix_sidpr_scr_write(struct a
>  	return 0;
>  }
>  
> +static bool piix_irq_check(struct ata_port *ap)
> +{
> +	if (unlikely(!ap->ioaddr.bmdma_addr))
> +		return false;
> +
> +	return ap->ops->bmdma_status(ap) & ATA_DMA_INTR;
> +}
> +
>   

   I'm not at all sure that old, pre-ICH controllers set this bit also 
for the PIO mode commands, not only for DMA. And if you didn't make such 
assumption, I don't see why this can't be generic and placed into 
libata-sff.c instead...

WBR, Sergei

