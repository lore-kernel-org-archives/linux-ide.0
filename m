From: Rafal Prylowski <prylowski@metasoft.pl>
Subject: Re: [PATCH 1/3] PATA host controller driver for ep93xx
Date: Fri, 30 Mar 2012 12:13:45 +0200
Message-ID: <4F758759.9090007@metasoft.pl>
References: <4F7418E7.4060500@metasoft.pl> <4F741AB1.4000107@metasoft.pl> <4F74E058.3010607@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from metasoft.pl ([195.149.224.191]:36469 "EHLO smtp.metasoft.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759310Ab2C3KOB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 30 Mar 2012 06:14:01 -0400
In-Reply-To: <4F74E058.3010607@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ryan Mallon <rmallon@gmail.com>
Cc: linux-ide@vger.kernel.org, bzolnier@gmail.com, hsweeten@visionengravers.com, Sergei Shtylyov <sshtylyov@mvista.com>, joao.ramos@inov.pt, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 2012-03-30 00:21, Ryan Mallon wrote:

>> +#include <mach/ep93xx-regs.h>
> 
> 
> ep93xx-regs.h is now deprecated for inclusion in drivers :-).

Will remove.

>> +enum {
>> +	/* IDE Control Register */
>> +	IDECtrl				= 0x00,
> 
> 
> Please don't use horrible camel case names.

I used these because it's original naming from EP93xx User's Guide.
It's easier to write code and compare with this document. But if it's not
allowed I could easily change it.

>> +	IDECtrl_CS0n			= (1 << 0),
>> +	IDECtrl_CS1n			= (1 << 1),
>> +	IDECtrl_DIORn			= (1 << 5),
>> +	IDECtrl_DIOWn			= (1 << 6),
>> +	IDECtrl_INTRQ			= (1 << 9),
>> +	IDECtrl_IORDY			= (1 << 10),
>> +
>> +	/* IDE Configuration Register */
>> +	IDECfg				= 0x04,
>> +	IDECfg_IDEEN			= (1 << 0),
> 
> 
> Why is this one enum, when you have multiple constants which define to
> the same value? This probably makes more sense as a set of defines.

In previous versions I had these as a set of defines. But I noticed, that
in the driver from Bartlomiej Zolnierkiewicz enum is used (in some other
libata drivers too). Isn't it better to avoid using of preprocessor
where possible?

>> +	const struct ata_timing *t, *cmd_t;
> 
> 
> Nitpick: Usually each field in a structure definition is on its own line.

Ok. Will do.

>> +static void ep93xx_pata_clear_regs(void __iomem *base)
>> +{
>> +	writel(IDECtrl_CS0n | IDECtrl_CS1n | IDECtrl_DIORn |
>> +		IDECtrl_DIOWn, base + IDECtrl);
>> +
>> +	writel(0, base + IDECfg);
> 
> 
> Might be worth having ep93xx_pata_write/read functions so you don't have
> to do the base + thing everywhere. Passing struct ep93xx_pata_data to
> each function would be more typical also.

I'll try to do it and see if it helps to simplify driver.

>> +static inline int ep93xx_pata_check_iordy(void __iomem *base)
>> +{
>> +	return (readl(base + IDECtrl) & IDECtrl_IORDY) ? 1 : 0;
> 
> 
> You can use !! here rather than ? 1 : 0.

Ok.

>> +static inline int ep93xx_pata_get_wst(int pio_mode)
>> +{
>> +	return (pio_mode == 0 ? 3 : pio_mode < 3 ? 2 : 1)
>> +		<< IDECfg_WST_SHIFT;
> 
> 
> Ick, thats really hard to read. What's wrong with:
> 
>   unsigned val = 1;
> 
>   if (pio_mode == 0)
>   	val = 3;
>   else if (pio_mode < 3)
>   	val = 2;
>   else
> 	val = 1;
> 
>   return val << IDECFG_WST_SHIFT;

Yes, it's much simplier (at first I wrote exactly your version, but "optimized"
it later ;) ). Will chage.

>> +static inline void ep93xx_pata_enable_pio(void __iomem *base, int pio_mode)
> 
> 
> Don't bother marking functions inline. The compiler will do it for you.

Ok.

>> +	if (drv_data->iordy) {
>> +		/* min. 1s timeout (at cpu cycle = 5ns) */
>> +		unsigned int timeout = 200000;
> 
> 
> Probably be better to use jiffies, msecs_to_jiffies and
> time_before/after rather than relying on a particular clock speed.

Yes! This is much better solution IMHO. Will try to do that.

>> +		while (!ep93xx_pata_check_iordy(base) && --timeout)
>> +			cpu_relax();

>> +	if (drv_data->iordy) {
>> +		/* min. 1s timeout */
>> +		unsigned int timeout = 200000;
>> +		while (!ep93xx_pata_check_iordy(base) && --timeout)
>> +			cpu_relax();
> 
> 
> This loop is used more than once. Wrap it up in a function maybe.

Ok.

>> +		VPRINTK("hob: feat 0x%X nsect 0x%X, lba 0x%X 0x%X 0x%X\n",
>> +			tf->hob_feature, tf->hob_nsect, tf->hob_lbal,
>> +			tf->hob_lbam, tf->hob_lbah);
> 
> 
>   dev_vdbg(ap->host->dev, ...)
> 
> ? Same elsewhere.

It's original code from libata (printing is enabled by ATA_DEBUG,
ATA_VERBOSE_DEBUG). Don't know if we could just change that.

>> +	DPRINTK("ata%u: cmd 0x%X\n", ap->print_id, tf->command);
> 
> 
>   dev_dbg(ap->host->dev, ...);

Ditto.

>> +	if (device == 0)
>> +		tmp = ATA_DEVICE_OBS;
>> +	else
>> +		tmp = ATA_DEVICE_OBS | ATA_DEV1;
> 
> 
> This could be:
> 
>   u8 tmp = ATA_DEVICE_OBS;
> 
>   ...
> 
>   if (device != 0)
>   	tmp |= ATA_DEV1;

This is also from original libata code. I'll change this, as I like your
version more.

>> +	u16 *data = (u16 *) buf;
> 
> 
> No space after the cast.

Ok.

>> +	/* Transfer multiple of 2 bytes */
>> +	if (rw == READ)
>> +		while (words--)
>> +			*data++ = cpu_to_le16(
>> +				ep93xx_pata_read(drv_data, data_addr, t));
>> +	else
>> +		while (words--)
>> +			ep93xx_pata_write(drv_data, le16_to_cpu(*data++),
>> +				data_addr, t);
> 
> 
> This would would be a bit simpler as:
> 
>   while (words--) {
>   	if (rw == READ)
> 		*data++ = ...;
> 	else
> 		ep93xx_pata_write(...);
>   }

Ok. Will change.

>> +
>> +	if ((nsect == 0x55) && (lbal == 0xaa))
>> +		return 1;	/* we found a device */
>> +
>> +	return 0;		/* nothing found */
> 
> 
> This function should return a bool. Maybe also change the function name
> to ep93xx_pata_device_is_present, which more accurately reflects what
> this does. Then you can drop the comments above too.

This is based on original code from libata, but I think we could change
it according to your suggestion (this function is not used as a hook
anywhere, it's only called from ep93xx_pata_softreset). Will do that.

>> +	/* if device 1 was found in ata_devchk, wait for register
>> +	 * access briefly, then wait for BSY to clear.
>> +	 */
> 
> 
>   /*
>    * Mutli-line comment style
>    * looks like this.
>    */

Original libata code. I preferred to change as little as possible in this
driver, that's why I left it as is. Will correct.

>> +	if (!txd) {
>> +		dev_err(qc->ap->dev, "failed to prepare slave for sg dma\n");
>> +		BUG();
> 
> 
> Don't BUG in drivers if you can possibly avoid it. Set an error state
> and try to bail out gracefully.

I think that changing BUG() to "return" is reasonable, as I don't know
any possibility to inform libata core about failed .bmdma_setup or .bmdma_start
(also explained in reply to Hartley).

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
> 
> 
> Only a couple of other pata driver appears to do this horrible casting
> mess. Other drivers appear to be using (devm_ioremap). Can we clean this up?

I wrote about solution with static table of these values in reply to Hartley
(I think we could avoid using this ioaddr->... everywhere in case of ep93xx).
Maybe enums can be used?

>> +	/*if (readl(EP93XX_SYSCON_DEVCFG) & (EP93XX_SYSCON_DEVCFG_EONIDE
>> +		| EP93XX_SYSCON_DEVCFG_GONIDE | EP93XX_SYSCON_DEVCFG_HONIDE)) {
>> +		dev_err(&pdev->dev, "IDE/GPIO pin conflict\n");
>> +		return -EINVAL;
>> +	}*/
> 
> 
> Fix or remove.

Will be removed.


Thanks for thorough review.

Regards,
RP
