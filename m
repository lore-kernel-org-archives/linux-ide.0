From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] ahci: change the Device IDs of nvidia MCP7B AHCI controller
 in ahci.c
Date: Fri, 30 May 2008 18:11:54 -0400
Message-ID: <48407BAA.6030106@garzik.org>
References: <200805191444539981741@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Big5
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:44963 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751565AbYE3WLz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 30 May 2008 18:11:55 -0400
In-Reply-To: <200805191444539981741@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: peerchen <peerchen@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>, akpm <akpm@linux-foundation.org>

peerchen wrote:
> Change the partial Device IDs of nvidia MCP7B AHCI controller in ahci.c
> 
> Signed-off-by: Peer Chen <peerchen@gmail.com>
> ---
> --- linux-2.6.26-rc3/drivers/ata/ahci.c.orig	2008-05-07 13:24:19.000000000 -0400
> +++ linux-2.6.26-rc3/drivers/ata/ahci.c	2008-05-07 13:25:17.000000000 -0400
> @@ -502,10 +502,10 @@ static const struct pci_device_id ahci_p
>  	{ PCI_VDEVICE(NVIDIA, 0x0bcd), board_ahci },		/* MCP7B */
>  	{ PCI_VDEVICE(NVIDIA, 0x0bce), board_ahci },		/* MCP7B */
>  	{ PCI_VDEVICE(NVIDIA, 0x0bcf), board_ahci },		/* MCP7B */
> -	{ PCI_VDEVICE(NVIDIA, 0x0bd0), board_ahci },		/* MCP7B */
> -	{ PCI_VDEVICE(NVIDIA, 0x0bd1), board_ahci },		/* MCP7B */
> -	{ PCI_VDEVICE(NVIDIA, 0x0bd2), board_ahci },		/* MCP7B */
> -	{ PCI_VDEVICE(NVIDIA, 0x0bd3), board_ahci },		/* MCP7B */
> +	{ PCI_VDEVICE(NVIDIA, 0x0bc4), board_ahci },		/* MCP7B */
> +	{ PCI_VDEVICE(NVIDIA, 0x0bc5), board_ahci },		/* MCP7B */
> +	{ PCI_VDEVICE(NVIDIA, 0x0bc6), board_ahci },		/* MCP7B */
> +	{ PCI_VDEVICE(NVIDIA, 0x0bc7), board_ahci },		/* MCP7B */

applied


