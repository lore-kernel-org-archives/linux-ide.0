From: "Peer Chen" <peerchen@gmail.com>
Subject: Re: Re: [PATCH] ahci: Add MCP79 support to AHCI driver
Date: Tue, 25 Sep 2007 10:58:13 +0800
Message-ID: <200709251058091899290@gmail.com>
References: <200709211406065332552@gmail.com>,
 <20070921113908.180cd154@the-village.bc.nu>,
 <200709241016214230742@gmail.com>,
 <46F7B344.7050903@ru.mvista.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.190]:16238 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751557AbXIYC6X (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 24 Sep 2007 22:58:23 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1588044rvb
        for <linux-ide@vger.kernel.org>; Mon, 24 Sep 2007 19:58:23 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>, akpm <akpm@linux-foundation.org>, jeff <jeff@garzik.org>

Yes,they all belong to AHCI controllers, 4 of them use ahci class code =
and others use RAID class code.

------------------				=20
Peer Chen
2007-09-25

-------------------------------------------------------------
=B7=A2=BC=FE=C8=CB=A3=BASergei Shtylyov
=B7=A2=CB=CD=C8=D5=C6=DA=A3=BA2007-09-24 20:53:44
=CA=D5=BC=FE=C8=CB=A3=BAPeer Chen
=B3=AD=CB=CD=A3=BAAlan Cox; linux-kernel; linux-ide; akpm; jeff
=D6=F7=CC=E2=A3=BARe: [PATCH] ahci: Add MCP79 support to AHCI driver

Hello.

Peer Chen wrote:

> Code change, remove some Device IDs.

> Signed-off-by: Peer Chen <peerchen@gmail.com>
> ---
> --- linux-2.6.23-rc7/drivers/ata/ahci.c.orig	2007-09-20 11:01:55.0000=
00000 -0400
> +++ linux-2.6.23-rc7/drivers/ata/ahci.c	2007-09-24 10:08:03.000000000=
 -0400
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

    I wonder whether all of those 8 IDs belong to AHCI controllers...

MBR, Sergei

