From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2.6.22-rc6+mboxjeff 2/3] pata_sis: new PCI ID
Date: Mon, 02 Jul 2007 10:21:03 -0400
Message-ID: <468909CF.1030805@garzik.org>
References: <200706300358.12199.uwe.koziolek@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:51977 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751558AbXGBOVG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 2 Jul 2007 10:21:06 -0400
In-Reply-To: <200706300358.12199.uwe.koziolek@gmx.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Uwe Koziolek <uwe.koziolek@gmx.net>
Cc: Alan <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Uwe Koziolek wrote:
> The SiS966 has an alternate PCI-ID 1180 for an IDE compatible controller
> The primaty channel acts as PATA-controller, the secondary channel
> acts as SATA-controller in PATA-emulation.
> 
> Signed-off-by: Uwe Koziolek <uwe.koziolek@gmx.net>
> 
> --- a/drivers/ata/pata_sis.c	2007-06-30 02:52:06.000000000 +0200
> +++ b/drivers/ata/pata_sis.c	2007-06-30 02:58:30.000000000 +0200
> @@ -1016,6 +1016,7 @@
>  static const struct pci_device_id sis_pci_tbl[] = {
>  	{ PCI_VDEVICE(SI, 0x5513), },	/* SiS 5513 */
>  	{ PCI_VDEVICE(SI, 0x5518), },	/* SiS 5518 */
> +	{ PCI_VDEVICE(SI, 0x1180), },	/* SiS 1180 */

patches 2 and 3 seem to already be included in the patch I just applied, 
so, ignored these...

Please wait a few hours (from the time of this email) and check 
libata-dev.git#upstream-fixes to make sure everything is in order.  It 
looks ok to me.

Thanks for your patience!

	Jeff



