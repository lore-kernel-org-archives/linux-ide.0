From: Rafal Prylowski <prylowski@metasoft.pl>
Subject: Re: [PATCH 1/3] PATA host controller driver for ep93xx
Date: Fri, 30 Mar 2012 10:13:46 +0200
Message-ID: <4F756B3A.8050901@metasoft.pl>
References: <4F7418E7.4060500@metasoft.pl> <4F741AB1.4000107@metasoft.pl> <ADE657CA350FB648AAC2C43247A983F0020697025609@AUSP01VMBX24.collaborationhost.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from metasoft.pl ([195.149.224.191]:33434 "EHLO smtp.metasoft.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759033Ab2C3IOH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 30 Mar 2012 04:14:07 -0400
In-Reply-To: <ADE657CA350FB648AAC2C43247A983F0020697025609@AUSP01VMBX24.collaborationhost.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: H Hartley Sweeten <hartleys@visionengravers.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "bzolnier@gmail.com" <bzolnier@gmail.com>, "rmallon@gmail.com" <rmallon@gmail.com>, "sshtylyov@ru.montavista.com" <sshtylyov@ru.montavista.com>, "joao.ramos@inov.pt" <joao.ramos@inov.pt>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 2012-03-29 19:25, H Hartley Sweeten wrote:
>> +#include <asm/mach-types.h>
>> +#include <mach/ep93xx-regs.h>
> 
> mach-types.h and ep93xx-regs.h should not be needed.

Ok. Will remove.

>> +static u8 ep93xx_pata_check_status(struct ata_port *ap)
>> +{
>> +     struct ep93xx_pata_data *drv_data = ap->host->private_data;
> 
> Please add a whitespace here.

Ok. Will add.

>> +static u8 ep93xx_pata_check_altstatus(struct ata_port *ap)
>> +{
>> +     struct ep93xx_pata_data *drv_data = ap->host->private_data;
> 
> Please add a whitespace here.

Ditto.

>> +static void ep93xx_pata_exec_command(struct ata_port *ap,
>> +                                  const struct ata_taskfile *tf)
>> +{
>> +     struct ep93xx_pata_data *drv_data = ap->host->private_data;
> 
> Please add a whitespace here.

Ditto.

>> +static void ep93xx_pata_set_devctl(struct ata_port *ap, u8 ctl)
>> +{
>> +     struct ep93xx_pata_data *drv_data = ap->host->private_data;
> 
> Please add a whitespace here.

Ditto.

>> +     /* is all this really necessary? */
>> +     ap->ops->sff_dev_select(ap, 0);
>> +     if (dev1)
>> +             ap->ops->sff_dev_select(ap, 1);
>> +     if (dev0)
>> +             ap->ops->sff_dev_select(ap, 0);
> 
> Is it necessary? If so please remove the comment.

Many libata drivers are written by copying code from libata-core.c,
libata-sff.c etc., with some needed modifications. In case of ep93xx,
all functions which will do read/write to ATA registers need to be
slightly modified. I suppose functions modified from original libata code
should comment that fact (like in pata_scc.c for example). Will add that.
So, this is original libata code, and as I'm not libata/IDE expert,
I don't have any clue if the above code is necessary ;)

>> +     ep93xx_pata_write(drv_data, ap->ctl, ioaddr->ctl_addr, t);
>> +     udelay(20);             /* FIXME: flush */
>> +     ep93xx_pata_write(drv_data, ap->ctl | ATA_SRST, ioaddr->ctl_addr, t);
>> +     udelay(20);             /* FIXME: flush */
> 
> What's up with the FIXME?
> 

Ditto.

>> +     txd = channel->device->device_prep_slave_sg(channel, qc->sg,
>> +              qc->n_elem, qc->dma_dir, DMA_CTRL_ACK);
>> +     if (!txd) {
>> +             dev_err(qc->ap->dev, "failed to prepare slave for sg dma\n");
>> +             BUG();
> 
> Is there a better way to handle this than BUG()? Can the driver fall back to PIO mode?

Another possibility would be to replace this BUG() with return, and hope libata
error handling will recover from this problem. Will do that.

>> +     ioaddr->cmd_addr        = (void __iomem *) 0 + 2; /* CS1 */
>> +
>> +     ioaddr->data_addr       = (void __iomem *) (ATA_REG_DATA << 2) + 2;
>> +     ioaddr->error_addr      = (void __iomem *) (ATA_REG_ERR << 2) + 2;
>> +     ioaddr->feature_addr    = (void __iomem *) (ATA_REG_FEATURE << 2) + 2;
>> +     ioaddr->nsect_addr      = (void __iomem *) (ATA_REG_NSECT << 2) + 2;
>> +     ioaddr->lbal_addr       = (void __iomem *) (ATA_REG_LBAL << 2) + 2;
>> +     ioaddr->lbam_addr       = (void __iomem *) (ATA_REG_LBAM << 2) + 2;
>> +     ioaddr->lbah_addr       = (void __iomem *) (ATA_REG_LBAH << 2) + 2;
>> +     ioaddr->device_addr     = (void __iomem *) (ATA_REG_DEVICE << 2) + 2;
>> +     ioaddr->status_addr     = (void __iomem *) (ATA_REG_STATUS << 2) + 2;
>> +     ioaddr->command_addr    = (void __iomem *) (ATA_REG_CMD << 2) + 2;
>> +
>> +     ioaddr->altstatus_addr  = (void __iomem *) (0x06 << 2) + 1; /* CS0 */
>> +     ioaddr->ctl_addr        = (void __iomem *) (0x06 << 2) + 1; /* CS0 */
> 
> Is there any way to get rid of the casts? These aren't really (void __iomem *) anyway...

We could store all these values as a static table of unsigned ints IMHO. Then, in each
ep93xx_pata_read/write, replace ioaddr->... with proper value from table.
This should simplify the driver a bit. Will try to do that.

>> +     /*if (readl(EP93XX_SYSCON_DEVCFG) & (EP93XX_SYSCON_DEVCFG_EONIDE
>> +             | EP93XX_SYSCON_DEVCFG_GONIDE | EP93XX_SYSCON_DEVCFG_HONIDE)) {
>> +             dev_err(&pdev->dev, "IDE/GPIO pin conflict\n");
>> +             return -EINVAL;
>> +     }*/
> 
> Remove this, see my comment in PATCH 2/3.

Ok.

>> +     mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +     if (!mem_res) {
>> +             dev_err(&pdev->dev, "resources allocation failed\n");
> 
> Are these dev_err messages necessary?

Some libata drivers do it, others not... I think we could remove them.

>> +     ap->pio_mask = ATA_PIO4;
> 
> Please add a whitespace line here.

Ok.

>> +     if (drv_data->dma_rx_channel && drv_data->dma_tx_channel) {
>> +             int chip_rev = ep93xx_chip_revision();
> 
> Please add a whitespace here.

Ok.

>> +     return ata_host_activate(host, irq, ata_bmdma_interrupt, 0,
>> +             &ep93xx_pata_sht);
> 
> If the host does not activate do you need to handle any cleanup?

Hmm.. Probably dma channels should be released. Will add.

> Make sure to call the core ep93xx_ide_release_gpio function in the remove.

Yes. I'll remember that.

>> +module_init(ep93xx_pata_init);
>> +module_exit(ep93xx_pata_exit);
> 
> Please use module_platform_driver instead of module_init/module_exit.

Ok.

Thanks for thorough review.
