From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] ahci: add the Device IDs of nvidia MCP7B AHCI controller
 to ahci.c
Date: Mon, 10 Mar 2008 20:51:47 -0400
Message-ID: <47D5D7A3.1030705@garzik.org>
References: <200803062122359218883@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755907AbYCKAw0@vger.kernel.org>
In-Reply-To: <200803062122359218883@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: peerchen <peerchen@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>, akpm <akpm@linux-foundation.org>
List-Id: linux-ide@vger.kernel.org

peerchen wrote:
> Add the device IDs of nvidia MCP79 AHCI controller to ahci.c
> 
> Signed-off-by: Peer Chen <peerchen@gmail.com>
> ---
> --- linux-2.6.25-rc4/drivers/ata/ahci.c.orig	2008-03-04 21:46:30.000000000 -0500
> +++ linux-2.6.25-rc4/drivers/ata/ahci.c	2008-03-04 21:50:42.000000000 -0500
> @@ -563,6 +563,18 @@ static const struct pci_device_id ahci_p
>  	{ PCI_VDEVICE(NVIDIA, 0x0abd), board_ahci },		/* MCP79 */
>  	{ PCI_VDEVICE(NVIDIA, 0x0abe), board_ahci },		/* MCP79 */
>  	{ PCI_VDEVICE(NVIDIA, 0x0abf), board_ahci },		/* MCP79 */
> +	{ PCI_VDEVICE(NVIDIA, 0x0bc8), board_ahci },		/* MCP7B */
> +	{ PCI_VDEVICE(NVIDIA, 0x0bc9), board_ahci },		/* MCP7B */
> +	{ PCI_VDEVICE(NVIDIA, 0x0bca), board_ahci },		/* MCP7B */
> +	{ PCI_VDEVICE(NVIDIA, 0x0bcb), board_ahci },		/* MCP7B */
> +	{ PCI_VDEVICE(NVIDIA, 0x0bcc), board_ahci },		/* MCP7B */
> +	{ PCI_VDEVICE(NVIDIA, 0x0bcd), board_ahci },		/* MCP7B */
> +	{ PCI_VDEVICE(NVIDIA, 0x0bce), board_ahci },		/* MCP7B */
> +	{ PCI_VDEVICE(NVIDIA, 0x0bcf), board_ahci },		/* MCP7B */
> +	{ PCI_VDEVICE(NVIDIA, 0x0bd0), board_ahci },		/* MCP7B */
> +	{ PCI_VDEVICE(NVIDIA, 0x0bd1), board_ahci },		/* MCP7B */
> +	{ PCI_VDEVICE(NVIDIA, 0x0bd2), board_ahci },		/* MCP7B */
> +	{ PCI_VDEVICE(NVIDIA, 0x0bd3), board_ahci },		/* MCP7B */

applied
