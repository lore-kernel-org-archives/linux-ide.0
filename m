From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2/4] pata_cmd64x: use interrupt status from MRDMODE register
Date: Tue, 13 Mar 2012 16:44:50 -0400
Message-ID: <4F5FB1C2.1010001@pobox.com>
References: <201203112225.30144.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:57390 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750841Ab2CMUow (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 Mar 2012 16:44:52 -0400
Received: by ghrr11 with SMTP id r11so1025607ghr.19
        for <linux-ide@vger.kernel.org>; Tue, 13 Mar 2012 13:44:52 -0700 (PDT)
In-Reply-To: <201203112225.30144.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On 03/11/2012 03:25 PM, Sergei Shtylyov wrote:
> @@ -306,7 +336,7 @@ static void cmd64x_fixup(struct pci_dev
>
>   static int cmd64x_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
>   {
> -	static const struct ata_port_info cmd_info[6] = {
> +	static const struct ata_port_info cmd_info[7] = {
>   		{	/* CMD 643 - no UDMA */
>   			.flags = ATA_FLAG_SLAVE_POSS,
>   			.pio_mask = ATA_PIO4,
[...]
> @@ -372,16 +408,19 @@ static int cmd64x_init_one(struct pci_de
>   		switch (pdev->revision) {
>   		/* UDMA works since rev 5 */
>   		default:
> -			ppi[0] =&cmd_info[2];
> -			ppi[1] =&cmd_info[2];
> +			ppi[0] =&cmd_info[3];
> +			ppi[1] =&cmd_info[3];
>   			break;
> +		/* Interrupts in MRDMODE since rev 3 */
>   		case 3:
>   		case 4:
> +			ppi[0] =&cmd_info[2];
> +			ppi[1] =&cmd_info[2];
>   			break;
>   		/* Rev 1 with other problems? */
>   		case 1:
> -			ppi[0] =&cmd_info[3];
> -			ppi[1] =&cmd_info[3];
> +			ppi[0] =&cmd_info[4];
> +			ppi[1] =&cmd_info[4];
>   			/* FALL THRU */
>   		/* Early revs have no CNTRL_CH0 */
>   		case 2:
> @@ -429,8 +468,8 @@ static int cmd64x_reinit_one(struct pci_
>   static const struct pci_device_id cmd64x[] = {
>   	{ PCI_VDEVICE(CMD, PCI_DEVICE_ID_CMD_643), 0 },
>   	{ PCI_VDEVICE(CMD, PCI_DEVICE_ID_CMD_646), 1 },
> -	{ PCI_VDEVICE(CMD, PCI_DEVICE_ID_CMD_648), 4 },
> -	{ PCI_VDEVICE(CMD, PCI_DEVICE_ID_CMD_649), 5 },
> +	{ PCI_VDEVICE(CMD, PCI_DEVICE_ID_CMD_648), 5 },
> +	{ PCI_VDEVICE(CMD, PCI_DEVICE_ID_CMD_649), 6 },


Would be nice to move to replace those hardcoded numbers with something 
more resilient to change (named constants).

	Jeff


