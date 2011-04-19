From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 0/2] fix libata-sff and pata_cmd64x to not crash on boot
 on parisc
Date: Wed, 20 Apr 2011 00:53:17 +0400
Message-ID: <4DADF63D.1020607@ru.mvista.com>
References: <1303152147.7167.12.camel@mulgrave.site>	 <20110418205203.56bbdb14@lxorguk.ukuu.org.uk> <1303159802.7167.30.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:58842 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751804Ab1DSUyz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Apr 2011 16:54:55 -0400
In-Reply-To: <1303159802.7167.30.camel@mulgrave.site>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide <linux-ide@vger.kernel.org>, Parisc List <linux-parisc@vger.kernel.org>

Hello.

On 19-04-2011 0:50, James Bottomley wrote:

>> You shouldn't need to touch a single line of the core libata code,
>> although it might be the best way of doing it.

> So how about this, using the dummy port info mechanism.  I get a
> spurious ata2: DUMMY message, but I suppose libata people are used to
> that.  I still have to fix libata to prevent spurious irq information,
> but that's cosmetic.

> James

> ---

> diff --git a/drivers/ata/pata_cmd64x.c b/drivers/ata/pata_cmd64x.c
> index 905ff76..10dabe9 100644
> --- a/drivers/ata/pata_cmd64x.c
> +++ b/drivers/ata/pata_cmd64x.c
> @@ -354,6 +361,19 @@ static int cmd64x_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
>   	mrdmode |= 0x02;	/* Memory read line enable */
>   	pci_write_config_byte(pdev, MRDMODE, mrdmode);
>
> +	/* check for enabled ports */
> +	pci_read_config_byte(pdev, ENPORT,&reg);
> +	/* the cm643 primary port is always enabled */
> +	if (id->driver_data != 0&&  !(reg&  ENPORT_PRIMARY)) {
> +		dev_printk(KERN_ERR,&pdev->dev, "Primary port is disabled; detaching\n");

    This is no longer true.

> +		ppi[0] =&ata_dummy_port_info;
> +		
> +	}

WBR, Sergei
