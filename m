From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Marvell SATA AHCI 0x6141
Date: Fri, 09 Mar 2007 17:31:08 -0500
Message-ID: <45F1E02C.2020203@pobox.com>
References: <20070309220200.GA17323@emard>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:60254 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1767561AbXCIWbL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 9 Mar 2007 17:31:11 -0500
In-Reply-To: <20070309220200.GA17323@emard>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Davor <vordah@gmail.com>
Cc: linux-ide@vger.kernel.org

Davor wrote:
> HI
> 
> I have onboard 
> 02:00.0 SATA controller: Marvell Technology Group Ltd. Unknown device 6141 (rev 01)
> 02:00.0 0106: 11ab:6141 (rev 01)
> 
> and it's an AHCI compatible device so a simple patch makes it work 
> (patch agains linux-2.6.20.2)
> 
> --- drivers/ata/ahci.c.orig	2007-03-09 21:58:26.000000000 +0100
> +++ drivers/ata/ahci.c	2007-03-09 22:38:20.000000000 +0100
> @@ -437,6 +437,9 @@ static const struct pci_device_id ahci_p
>  	{ PCI_VDEVICE(SI, 0x1185), board_ahci }, /* SiS 966 */
>  	{ PCI_VDEVICE(SI, 0x0186), board_ahci }, /* SiS 968 */
>  
> +	/* Marvell */
> +	{ PCI_VDEVICE(MARVELL, 0x6141), board_ahci },	/* 6141 */

Yep, though you want the more-complete patch from libata-dev.git#mv-ahci 
or akpm's -mm.

	Jeff




