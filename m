From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] ahci: Add MCP79 support to AHCI driver
Date: Tue, 02 Oct 2007 11:31:48 -0400
Message-ID: <47026464.5060209@garzik.org>
References: <200709211406065332552@gmail.com>, <20070921113908.180cd154@the-village.bc.nu> <200709241016214230742@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:38808 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752888AbXJBPbv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 2 Oct 2007 11:31:51 -0400
In-Reply-To: <200709241016214230742@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Peer Chen <peerchen@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>, akpm <akpm@linux-foundation.org>

Peer Chen wrote:
> Code change, remove some Device IDs.
> 
> Signed-off-by: Peer Chen <peerchen@gmail.com>
> ---
> --- linux-2.6.23-rc7/drivers/ata/ahci.c.orig	2007-09-20 11:01:55.000000000 -0400
> +++ linux-2.6.23-rc7/drivers/ata/ahci.c	2007-09-24 10:08:03.000000000 -0400
> @@ -472,6 +472,14 @@ static const struct pci_device_id ahci_p
>  	{ PCI_VDEVICE(NVIDIA, 0x0ad9), board_ahci },		/* MCP77 */
>  	{ PCI_VDEVICE(NVIDIA, 0x0ada), board_ahci },		/* MCP77 */
>  	{ PCI_VDEVICE(NVIDIA, 0x0adb), board_ahci },		/* MCP77 */
> +	{ PCI_VDEVICE(NVIDIA, 0x0ab8), board_ahci },		/* MCP79 */
> +	{ PCI_VDEVICE(NVIDIA, 0x0ab9), board_ahci },		/* MCP79 */
> +	{ PCI_VDEVICE(NVIDIA, 0x0aba), board_ahci },		/* MCP79 */
> +	{ PCI_VDEVICE(NVIDIA, 0x0abb), board_ahci },		/* MCP79 */
> +	{ PCI_VDEVICE(NVIDIA, 0x0abc), board_ahci },		/* MCP79 */
> +	{ PCI_VDEVICE(NVIDIA, 0x0abd), board_ahci },		/* MCP79 */
> +	{ PCI_VDEVICE(NVIDIA, 0x0abe), board_ahci },		/* MCP79 */
> +	{ PCI_VDEVICE(NVIDIA, 0x0abf), board_ahci },		/* MCP79 */

applied


