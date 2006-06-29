From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 3/9] ata_piix.c conversion
Date: Fri, 30 Jun 2006 01:32:24 +0900
Message-ID: <44A40098.5050303@gmail.com>
References: <20060629160952.GD23122@zmei.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:52254 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750891AbWF2QcH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 29 Jun 2006 12:32:07 -0400
Received: by ug-out-1314.google.com with SMTP id a2so428561ugf
        for <linux-ide@vger.kernel.org>; Thu, 29 Jun 2006 09:32:06 -0700 (PDT)
In-Reply-To: <20060629160952.GD23122@zmei.tnic>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <bbpetkov@yahoo.de>
Cc: linux-ide <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>

Borislav Petkov wrote:

> @@ -515,7 +515,8 @@ static int piix_sata_prereset(struct ata
>  	u8 pcs;
>  
>  	pci_read_config_byte(pdev, ICH5_PCS, &pcs);
> -	DPRINTK("ata%u: ENTER, pcs=0x%x base=%d\n", ap->id, pcs, base);
> +	ata_port_printk(ap, ATA_MSG_CMD, 
> +			"ata%u: ENTER, pcs=0x%x base=%d\n", ap->id, pcs, base);

Again, not CMD.

>  
>  	/* enable all ports on this ap and wait for them to settle */
>  	for (i = 0; i < 2; i++) {
> @@ -544,11 +545,11 @@ static int piix_sata_prereset(struct ata
>  	if (!(ap->flags & PIIX_FLAG_AHCI))
>  		pci_write_config_byte(pdev, ICH5_PCS, pcs);
>  
> -	DPRINTK("ata%u: LEAVE, pcs=0x%x present_mask=0x%x\n",
> +	ata_port_printk(ap, ATA_MSG_CMD, "ata%u: LEAVE, pcs=0x%x present_mask=0x%x\n",
>  		ap->id, pcs, present_mask);

Ditto.

> @@ -642,7 +643,7 @@ static void piix_set_dmamode (struct ata
>  	u8			reg48, reg54, reg55;
>  
>  	pci_read_config_word(dev, maslave, &reg4042);
> -	DPRINTK("reg4042 = 0x%04x\n", reg4042);
> +	ata_port_printk(ap, ATA_MSG_CMD, "reg4042 = 0x%04x\n", reg4042);

Ditto.

-- 
tejun
