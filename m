From: Zubair Lutfullah Kakakhel <Zubair.Kakakhel-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v6] SATA: OCTEON: support SATA on OCTEON platform
Date: Wed, 3 Feb 2016 13:24:10 +0000
Message-ID: <56B1FF7A.3040906@imgtec.com>
References: <1454437485-48009-1-git-send-email-Zubair.Kakakhel@imgtec.com>
 <1930324.vU65IL0x0g@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1930324.vU65IL0x0g@wuerfel>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, aleksey.makarov-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-ide@vger.kernel.org

Hi,

Thanks for the review.

Response and further questions below.

On 02/02/16 20:48, Arnd Bergmann wrote:
> On Tuesday 02 February 2016 18:24:45 Zubair Lutfullah Kakakhel wrote:
>> diff --git a/Documentation/devicetree/bindings/mips/cavium/sata-uctl.txt b/Documentation/devicetree/bindings/mips/cavium/sata-uctl.txt
>> new file mode 100644
>> index 0000000..3bd3c2f
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mips/cavium/sata-uctl.txt
>> @@ -0,0 +1,42 @@
>> +* UCTL SATA controller glue
>> +
>> +UCTL is the bridge unit between the I/O interconnect (an internal bus)
>> +and the SATA AHCI host controller (UAHC). It performs the following functions:
>> +	- provides interfaces for the applications to access the UAHC AHCI
>> +	  registers on the CN71XX I/O space.
>> +	- provides a bridge for UAHC to fetch AHCI command table entries and data
>> +	  buffers from Level 2 Cache.
>> +	- posts interrupts to the CIU.
>> +	- contains registers that:
>> +		- control the behavior of the UAHC
>> +		- control the clock/reset generation to UAHC
>> +		- control endian swapping for all UAHC registers and DMA accesses
>>
>
> Typically we treat those special registers as part of the device itself
> and have a single device node for the AHCI controller and that one.
>
> What is your reason for doing it differently here?

Two reasons

1- The hardware is like a proper split rather than additional hidden registers in
the same memory space.

2- Tons of devices in the field have the following DT node built in the bootloader.

		uctl@118006c000000 {
			compatible = "cavium,octeon-7130-sata-uctl";
			reg = <0x11800 0x6c000000 0x0 0x100>;
			...
                         sata: sata@16c0000000000 {
                                 compatible = "cavium,octeon-7130-ahci";
                                 reg = <0x16c00 0x00000000 0x0 0x200>;
				...
                         };
		};

The patch suggests a way to handle this.

>
>> index 04975b8..6bc1de6 100644
>> --- a/drivers/ata/ahci_platform.c
>> +++ b/drivers/ata/ahci_platform.c
>> @@ -76,6 +76,8 @@ static const struct of_device_id ahci_of_match[] = {
>>   	{ .compatible = "ibm,476gtr-ahci", },
>>   	{ .compatible = "snps,dwc-ahci", },
>>   	{ .compatible = "hisilicon,hisi-ahci", },
>> +	{ .compatible = "fsl,qoriq-ahci", },
>> +	{ .compatible = "cavium,octeon-7130-ahci", },
>>   	{},
>
> The qoriq-ahci addition seems misplaced in this patch. Maybe split
> that out into a separate patch?
>

oops. Sorry. Will fix.

>> +/**
>> + * cvmx_sata_uctl_shim_cfg
>> + * from cvmx-sata-defs.h
>> + *
>> + * Accessible by: only when A_CLKDIV_EN
>> + * Reset by: IOI reset (srst_n) or SATA_UCTL_CTL[SATA_UCTL_RST]
>> + * This register allows configuration of various shim (UCTL) features.
>> + * Fields XS_NCB_OOB_* are captured when there are no outstanding OOB errors
>> + * indicated in INTSTAT and a new OOB error arrives.
>> + * Fields XS_BAD_DMA_* are captured when there are no outstanding DMA errors
>> + * indicated in INTSTAT and a new DMA error arrives.
>> + */
>> +union cvmx_sata_uctl_shim_cfg {
>> +	uint64_t u64;
>> +	struct cvmx_sata_uctl_shim_cfg_s {
>> +	/*
>> +	 * Read/write error log for out-of-bound UAHC register access.
>> +	 * 0 = read, 1 = write.
>> +	 */
>> +	__BITFIELD_FIELD(uint64_t xs_ncb_oob_wrn               : 1,
>> +	__BITFIELD_FIELD(uint64_t reserved_57_62               : 6,
>> +	/*
>
> Try to avoid bitfields when defining structures that interact with
> the hardware, bitfields often cause problems with mixed-endian
> environments and don't make this easier to understand.
>

Bitfields for both endians are used and handled by mips.
Mainly used by cavium.

As this is a cavium driver, would it be acceptable?

Or should I replace with the following.

	v = cvmx_read_csr((uint64_t)base + CVMX_SATA_UCTL_SHIM_CFG);
	v &= ~(SATA_UCTL_ENDIAN_MODE_E_MASK << DMA_ENDIAN_MODE);
	v &= ~(SATA_UCTL_ENDIAN_MODE_E_MASK << CSR_ENDIAN_MODE);
#ifdef __BIG_ENDIAN
	v |= SATA_UCTL_ENDIAN_MODE_E_BIG << DMA_ENDIAN_MODE;
	v |= SATA_UCTL_ENDIAN_MODE_E_BIG << CSR_ENDIAN_MODE;
#else
	v |= SATA_UCTL_ENDIAN_MODE_E_LITTLE << DMA_ENDIAN_MODE;
	v |= SATA_UCTL_ENDIAN_MODE_E_LITTLE << CSR_ENDIAN_MODE;
#endif
	v |= 1 << DMA_READ_CMD;
	cvmx_write_csr((uint64_t)base + CVMX_SATA_UCTL_SHIM_CFG, v);

>> +static int ahci_octeon_probe(struct platform_device *pdev)
>> +{
>> +	union cvmx_sata_uctl_shim_cfg shim_cfg;
>> +	struct device *dev = &pdev->dev;
>> +	struct device_node *node = dev->of_node;
>> +	struct resource *res;
>> +	void __iomem *base;
>> +	int ret;
>> +
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	if (!res) {
>> +		dev_err(&pdev->dev, "Platform resource[0] is missing\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	base = devm_ioremap_resource(&pdev->dev, res);
>> +	if (IS_ERR(base))
>> +		return PTR_ERR(base);
>> +
>> +	/* set-up endian mode */
>> +	shim_cfg.u64 = cvmx_read_csr(
>> +		(__force uint64_t)base + CVMX_SATA_UCTL_SHIM_CFG);
>> +#ifdef __BIG_ENDIAN
>> +	shim_cfg.s.dma_endian_mode = 1;
>> +	shim_cfg.s.csr_endian_mode = 1;
>> +#else
>> +	shim_cfg.s.dma_endian_mode = 0;
>> +	shim_cfg.s.csr_endian_mode = 0;
>> +#endif
>> +	shim_cfg.s.dma_read_cmd = 1; /* No allocate L2C */
>> +	cvmx_write_csr(
>> +		(__force uint64_t)base + CVMX_SATA_UCTL_SHIM_CFG, shim_cfg.u64);
>> +
>
> Maybe add a helper function around cvmx_write_csr() that
> allows you to write to an __iomem address? Drivers should
> generally not need to use __force.

Hmm. Will see.

Thanks
ZubairLK

>
> 	Arnd
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
