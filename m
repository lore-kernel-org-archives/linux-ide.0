From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] pata_hpt3x2n: Cable detect handling
Date: Wed, 07 Mar 2007 18:19:26 +0300
Message-ID: <45EED7FE.9020305@ru.mvista.com>
References: <20070307161723.49b4b4aa@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:20080 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751908AbXCGPTg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Mar 2007 10:19:36 -0500
In-Reply-To: <20070307161723.49b4b4aa@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, jgarzik@pobox.com, linux-ide@vger.kernel.org

Hello.

Alan Cox wrote:

> +/**
> + *	hpt3x2n_pre_reset	-	reset the hpt3x2n bus
> + *	@ap: ATA port to reset
> + *
> + *	Perform the initial reset handling for the 3x2n series controllers.
> + *	Reset the hardware and state machine,
> + */
>  
> +static int hpt3xn_pre_reset(struct ata_port *ap)
> +{
> +	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
>  	/* Reset the state machine */
>  	pci_write_config_byte(pdev, 0x50, 0x37);
>  	pci_write_config_byte(pdev, 0x54, 0x37);
>  	udelay(100);
> -
>  	return ata_std_prereset(ap);
>  }
>  

    Hmmm... is it really safe to reset both channels here, when only one port 
gets reset?

MBR, Sergei
