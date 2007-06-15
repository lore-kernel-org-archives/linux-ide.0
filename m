From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/5] ide: add short cables support
Date: Sat, 16 Jun 2007 00:54:12 +0400
Message-ID: <4672FC74.6020601@ru.mvista.com>
References: <200706101558.08990.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:8526 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754658AbXFOUw2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 15 Jun 2007 16:52:28 -0400
In-Reply-To: <200706101558.08990.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

> This patch allows users to override both host and device side cable detection
> with "ideX=ata66" kernel parameter.  Thanks to this it should be now possible
> to use UDMA > 2 modes on systems (laptops mainly) which use short 40-pin cable
> instead of 80-pin one.

> Next patches add automatic detection of some systems using short cables.

> Changes:

> * Rename hwif->udma_four to hwif->cbl and make it u8.

    Not sure if already short word "cable" was worth further shortening. :-)

> Index: b/drivers/ide/pci/alim15x3.c
> ===================================================================
> --- a/drivers/ide/pci/alim15x3.c
> +++ b/drivers/ide/pci/alim15x3.c
> @@ -594,7 +594,7 @@ out:
>   *	FIXME: frobs bits that are not defined on newer ALi devicea
>   */
>  
> -static unsigned int __devinit ata66_ali15x3 (ide_hwif_t *hwif)
> +static u8 __devinit ata66_ali15x3(ide_hwif_t *hwif)
>  {
>  	struct pci_dev *dev	= hwif->pci_dev;
>  	unsigned int ata66	= 0;
> @@ -657,7 +657,7 @@ static unsigned int __devinit ata66_ali1
>  
>  	local_irq_restore(flags);
>  
> -	return(ata66);
> +	return ata66 ? ATA_CBL_PATA80 : ATA_CBL_PATA40;

    Ahem... I'd think it was about the right time to fix the abomination which
those ata66 and cable_80_pin[2] are, something like this:

static unsigned int __devinit ata66_ali15x3 (ide_hwif_t *hwif)
{
         struct pci_dev *dev     = hwif->pci_dev;
         unsigned int cbl        = ATA_CBL_PATA40;
         unsigned long flags;
         u8 tmpbyte, mask	= hwif->channel ? 0x02 : 0x01;

         local_irq_save(flags); /* Not sure if it's necessary... */

         if (m5229_revision >= 0xC2) {
                 /*
                  * Ultra66 cable detection (from Host View)
                  * m5229, 0x4a, bit0: primary, bit1: secondary
		 * 0: 80 pin, 1: 40 pin
                  */
                 pci_read_config_byte(dev, 0x4a, &tmpbyte);
                 /*
                  * Allow ata66 if cable of current channel has 80 pins
                  */
                 cbl = (tmpbyte & mask) ? ATA_CBL_PATA40 : ATA_CBL_PATA80;
         } else {

[Following code frankly speaking has no business being in this function]

         local_irq_restore(flags); /* Not sure if it's necessary... */

	return cbl;
>  }
>  
>  /**
> Index: b/drivers/ide/pci/serverworks.c
> ===================================================================
> --- a/drivers/ide/pci/serverworks.c
> +++ b/drivers/ide/pci/serverworks.c
> @@ -329,9 +329,9 @@ static unsigned int __devinit init_chips
>  	return dev->irq;
>  }
>  
> -static unsigned int __devinit ata66_svwks_svwks (ide_hwif_t *hwif)
> +static u8 __devinit ata66_svwks_svwks(ide_hwif_t *hwif)
>  {
> -	return 1;
> +	return ATA_CBL_PATA80;
>  }

    Hm, worth folding into ata66_svwks()...

>  /* On Dell PowerEdge servers with a CSB5/CSB6, the top two bits
> @@ -341,7 +341,7 @@ static unsigned int __devinit ata66_svwk
>   * Bit 14 clear = primary IDE channel does not have 80-pin cable.
>   * Bit 14 set   = primary IDE channel has 80-pin cable.
>   */
> -static unsigned int __devinit ata66_svwks_dell (ide_hwif_t *hwif)
> +static u8 __devinit ata66_svwks_dell(ide_hwif_t *hwif)
>  {
>  	struct pci_dev *dev = hwif->pci_dev;
>  	if (dev->subsystem_vendor == PCI_VENDOR_ID_DELL &&

    Isn't this check duplicating the check in ata66_svwks()?

> @@ -359,18 +359,18 @@ static unsigned int __devinit ata66_svwk
>   *
>   * WARNING: this only works on Alpine hardware!
>   */
> -static unsigned int __devinit ata66_svwks_cobalt (ide_hwif_t *hwif)
> +static u8 __devinit ata66_svwks_cobalt(ide_hwif_t *hwif)
>  {
>  	struct pci_dev *dev = hwif->pci_dev;
>  	if (dev->subsystem_vendor == PCI_VENDOR_ID_SUN &&

    Same question here...

> Index: b/drivers/ide/pci/sis5513.c
> ===================================================================
> --- a/drivers/ide/pci/sis5513.c
> +++ b/drivers/ide/pci/sis5513.c
> @@ -796,7 +796,7 @@ static unsigned int __devinit init_chips
>  	return 0;
>  }
>  
> -static unsigned int __devinit ata66_sis5513 (ide_hwif_t *hwif)
> +static u8 __devinit ata66_sis5513(ide_hwif_t *hwif)
>  {
>  	u8 ata66 = 0;
>  
> @@ -811,7 +811,8 @@ static unsigned int __devinit ata66_sis5
>  		pci_read_config_byte(hwif->pci_dev, 0x48, &reg48h);
>  		ata66 = (reg48h & mask) ? 0 : 1;
>  	}
> -        return ata66;
> +
> +	return ata66 ? ATA_CBL_PATA80 : ATA_CBL_PATA40;
>  }

    That doesn't look good as well. I think we should part with 'ata66' 
variable here completely...

MBR, Sergei
