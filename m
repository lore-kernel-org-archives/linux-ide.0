From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 0/2] fix libata-sff and pata_cmd64x to not crash on boot
 on parisc
Date: Wed, 20 Apr 2011 14:04:10 +0400
Message-ID: <4DAEAF9A.1020704@ru.mvista.com>
References: <1303152147.7167.12.camel@mulgrave.site>	 <20110418205203.56bbdb14@lxorguk.ukuu.org.uk>	 <1303159802.7167.30.camel@mulgrave.site>	 <20110418222017.4e77fe05@lxorguk.ukuu.org.uk>	 <4DADF798.6010705@ru.mvista.com>	 <20110419221900.67528a07@lxorguk.ukuu.org.uk>	 <4DADFD2E.9070809@ru.mvista.com>	 <20110419222838.6a6f36aa@lxorguk.ukuu.org.uk> <1303254709.11237.34.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <1303254709.11237.34.camel@mulgrave.site>
Sender: linux-parisc-owner@vger.kernel.org
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Sergei Shtylyov <sshtylyov@mvista.com>, linux-ide <linux-ide@vger.kernel.org>, Parisc List <linux-parisc@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Hello.

On 20-04-2011 3:11, James Bottomley wrote:

>> Beats me then. Whatever - its easy enough to work around and avoid
>> exploding parisc and sparc so it definitely wants sorting

> OK, so are we all agreed on this (I'll split it up into the cosmetic
> libata piece and the cmd64x fix later)?

> James

> ---

> diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
> index f8380ce..b1b926c 100644
> --- a/drivers/ata/libata-sff.c
> +++ b/drivers/ata/libata-sff.c
> @@ -2447,13 +2447,18 @@ int ata_pci_sff_activate_host(struct ata_host *host,
>   		return -ENOMEM;
>
>   	if (!legacy_mode&&  pdev->irq) {
> +		int i;
> +
>   		rc = devm_request_irq(dev, pdev->irq, irq_handler,
>   				      IRQF_SHARED, drv_name, host);
>   		if (rc)
>   			goto out;
>
> -		ata_port_desc(host->ports[0], "irq %d", pdev->irq);
> -		ata_port_desc(host->ports[1], "irq %d", pdev->irq);
> +		for (i = 0; i < 2; i++) {
> +			if (ata_port_is_dummy(host->ports[i]))
> +				continue;
> +			ata_port_desc(host->ports[i], "irq %d", pdev->irq);

    Does this really makes any difference?

> diff --git a/drivers/ata/pata_cmd64x.c b/drivers/ata/pata_cmd64x.c
> index 905ff76..c39fd5a 100644
> --- a/drivers/ata/pata_cmd64x.c
> +++ b/drivers/ata/pata_cmd64x.c
> @@ -41,6 +41,9 @@
>   enum {
>   	CFR 		= 0x50,
>   		CFR_INTR_CH0  = 0x04,
> +	CNTRL		= 0x51,
> +		CNTRL_PRIMARY   = 0x04,
> +		CNTRL_SECONDARY = 0x08,

    Probably better to call them CNTRL_CH0 and CNTRL_CH1 to keep the naming in 
line with already existing one...

> @@ -328,9 +331,17 @@ static int cmd64x_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
>   			.port_ops =&cmd648_port_ops
>   		}
>   	};
> -	const struct ata_port_info *ppi[] = {&cmd_info[id->driver_data], NULL };
> -	u8 mrdmode;
> +	const struct ata_port_info *ppi[] = {
> +		&cmd_info[id->driver_data],
> +		&cmd_info[id->driver_data],
> +		NULL
> +	};
> +	u8 mrdmode, reg;
>   	int rc;
> +	struct pci_dev *bridge = pdev->bus->self;
> +	/* mobility split bridges don't report enabled ports correctly */
> +	int port_ok = !(bridge && bridge->vendor ==
> +			PCI_VENDOR_ID_MOBILITY_ELECTRONICS);
>
>   	rc = pcim_enable_device(pdev);
>   	if (rc)
> @@ -354,6 +369,21 @@ static int cmd64x_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
>   	mrdmode |= 0x02;	/* Memory read line enable */
>   	pci_write_config_byte(pdev, MRDMODE, mrdmode);
>
> +	/* check for enabled ports */
> +	pci_read_config_byte(pdev, CNTRL,&reg);
> +	if (port_ok)

    You mean !port_ok.

> +		dev_printk(KERN_NOTICE, &pdev->dev, "Mobility Bridge detected, ignoring CNTRL port enable/disable\n");
> +	/* 643 and 646 no UDMA, primary port always enabled */
> +	if (port_ok && id->driver_data > 1 &&  !(reg & CNTRL_PRIMARY)) {

    PCI0646U and later revisions on PCI0646 do have the primary port enable 
bit. The same about UltraDMA -- PCI0646U2 has it. Look at what cmd64x does in 
cmd64x_init_one()...

> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 4e2c915..7a0ac45 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -608,6 +608,8 @@
>   #define PCI_DEVICE_ID_MATROX_G550	0x2527
>   #define PCI_DEVICE_ID_MATROX_VIA	0x4536
>
> +#define PCI_VENDOR_ID_MOBILITY_ELECTRONICS	0x14f2
> +

    The current trend seems to be to only define vendor/device IDs where they 
are used and not in pci_ids.h...

MBR, Sergei
