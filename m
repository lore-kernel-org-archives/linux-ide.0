From: Rafal Prylowski <prylowski@metasoft.pl>
Subject: Re: [PATCH 1/3] PATA host controller driver for ep93xx
Date: Mon, 02 Apr 2012 09:52:49 +0200
Message-ID: <4F795AD1.4070101@metasoft.pl>
References: <4F7418E7.4060500@metasoft.pl> <4F741AB1.4000107@metasoft.pl> <201203302018.43681.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from metasoft.pl ([195.149.224.191]:49412 "EHLO smtp.metasoft.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751040Ab2DBHw7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 2 Apr 2012 03:52:59 -0400
In-Reply-To: <201203302018.43681.arnd@arndb.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, bzolnier@gmail.com, hsweeten@visionengravers.com, "rmallon@gmail.com" <rmallon@gmail.com>, Sergei Shtylyov <sshtylyov@mvista.com>, joao.ramos@inov.pt

On 2012-03-30 22:18, Arnd Bergmann wrote:
>> +static u16 ep93xx_pata_read(struct ep93xx_pata_data *drv_data,
>> +			    void *addr_io,
>> +			    const struct ata_timing *t)
>> +{
>> +	unsigned long addr = (unsigned long) addr_io & 0x1f;
>> +	void __iomem *base = drv_data->ide_base;
>> +	u16 ret;
>> +
>> +	writel(IDECtrl_DIOWn | IDECtrl_DIORn | addr, base + IDECtrl);
>> +	ndelay(t->setup);
>> +	writel(IDECtrl_DIOWn | addr, base + IDECtrl);
> 
> The pointer arithmetic that you do here on addr_io looks really evil.
> Basically your registers are indirect and cannot be accessed through
> pointer dereference. Maybe you should not be trying to do that then
> and not use the ata_port->ioaddr structure.

Yes, I already prepared a version of the driver in which IDE register
addresses are coded as enums instead of using ata_port->ioaddr structure. 
I will post updated version, when I get feedback from Ryan if enums
or defines are preferred.

>> +	ndelay(t->act8b);
> 
> I'm not too familar with ata drivers, but I don't think you're supposed
> to have delays in the code for the timings, rather than programming
> the timings into the controller registers. Are you sure this is the
> right thing here?

EP93xx IDE controller is quite unusual - in PIO mode it's a GPIO like pin
interface.

>> +	if (drv_data->iordy) {
>> +		/* min. 1s timeout (at cpu cycle = 5ns) */
>> +		unsigned int timeout = 200000;
>> +		while (!ep93xx_pata_check_iordy(base) && --timeout)
>> +			cpu_relax();
>> +	}
> 
> This is not a reliable way to implement a timeout. Instead, you should
> use time_before() to check if hte timeout has expired.

Fixed.

>> +static void ep93xx_pata_setup_port(struct ata_ioports *ioaddr)
>> +{
>> +	/*
>> +	 * the device IDE register to be accessed is selected through
>> +	 * IDECTRL register's specific bitfields 'DA', 'CS1n' and 'CS0n':
>> +	 *   b4   b3   b2    b1     b0
>> +	 *   A2   A1   A0   CS1n   CS0n
>> +	 * the values filled in this structure allows the value to be directly
>> +	 * ORed to the IDECTRL register, hence giving directly the A[2:0] and
>> +	 * CS1n/CS0n values for each IDE register.
>> +	 * The values correspond to the transformation:
>> +	 *   ((real IDE address) << 2) | CS1n value << 1 | CS0n value
>> +	 */
>> +	ioaddr->cmd_addr	= (void __iomem *) 0 + 2; /* CS1 */
>> +
>> +	ioaddr->data_addr	= (void __iomem *) (ATA_REG_DATA << 2) + 2;
>> +	ioaddr->error_addr	= (void __iomem *) (ATA_REG_ERR << 2) + 2;
>> +	ioaddr->feature_addr	= (void __iomem *) (ATA_REG_FEATURE << 2) + 2;
>> +	ioaddr->nsect_addr	= (void __iomem *) (ATA_REG_NSECT << 2) + 2;
>> +	ioaddr->lbal_addr	= (void __iomem *) (ATA_REG_LBAL << 2) + 2;
>> +	ioaddr->lbam_addr	= (void __iomem *) (ATA_REG_LBAM << 2) + 2;
>> +	ioaddr->lbah_addr	= (void __iomem *) (ATA_REG_LBAH << 2) + 2;
>> +	ioaddr->device_addr	= (void __iomem *) (ATA_REG_DEVICE << 2) + 2;
>> +	ioaddr->status_addr	= (void __iomem *) (ATA_REG_STATUS << 2) + 2;
>> +	ioaddr->command_addr	= (void __iomem *) (ATA_REG_CMD << 2) + 2;
>> +
>> +	ioaddr->altstatus_addr	= (void __iomem *) (0x06 << 2) + 1; /* CS0 */
>> +	ioaddr->ctl_addr	= (void __iomem *) (0x06 << 2) + 1; /* CS0 */
>> +}
> 
> As mentioned above, this seems to make no sense.

Removed.

>> ===================================================================
>> --- linux-2.6.orig/drivers/ata/Kconfig
>> +++ linux-2.6/drivers/ata/Kconfig
>> @@ -416,6 +416,15 @@ config PATA_EFAR
>>  
>>  	  If unsure, say N.
>>  
>> +config PATA_EP93XX
>> +	tristate "Cirrus Logic EP93xx PATA support"
>> +	depends on ARCH_EP93XX
>> +	help
>> +	  This option enables support for the PATA controller in
>> +	  the Cirrus Logic EP9312 and EP9315 ARM CPU.
>> +
>> +	  If unsure, say N.
>> +
>>  config PATA_HPT366
>>  	tristate "HPT 366/368 PATA support"
>>  	depends on PCI
> 
> And I think this should be consequently be sorted below nonstandard ports, instead of the SFF list.
> 
> 	Arnd

I selected "PATA SFF controllers with BMDMA" list because the driver
inherits .ata_bmdma_port_ops (this is in libata-sff.c, which is compiled
only if ATA_SFF is set).

Thanks for comments.
RP
