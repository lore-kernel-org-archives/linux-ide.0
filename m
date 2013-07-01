From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [v2 4/4] sata: imx: add ahci sata support on imx platforms
Date: Mon, 1 Jul 2013 15:03:43 +0200
Message-ID: <20130701130343.GY516@pengutronix.de>
References: <1372672975-2997-1-git-send-email-r65037@freescale.com>
 <1372672975-2997-5-git-send-email-r65037@freescale.com>
 <51D17AF1.2060504@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54774 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752945Ab3GANEC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 1 Jul 2013 09:04:02 -0400
Content-Disposition: inline
In-Reply-To: <51D17AF1.2060504@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: Richard Zhu <richard.zhuhongxing@gmail.com>, shawn.guo@linaro.org, linux-arm-kernel@lists.infradead.org, jgarzik@pobox.com, avorontsov@ru.mvista.com, linux-ide@vger.kernel.org, Richard Zhu <r65037@freescale.com>

On Mon, Jul 01, 2013 at 07:49:53AM -0500, Rob Herring wrote:
> On 07/01/2013 05:02 AM, Richard Zhu wrote:
> > imx6q contains one Synopsys AHCI SATA controller,
> > But it can't shares ahci_platform driver with other
> > controllers.
> > Because there are some misalignments of the bits
> > definitions of the HBA registers and the Vendor
> > Specific registers
> >  - CAP_SSS(bit20) of the HOST_CAP is writable, default
> >  value is '0', should be configured to be '1'
> >  - bit0 (only one AHCI SATA port on imx6q) of the
> >  HOST_PORTS_IMPL should be set to be '1'.(default 0)
> >  - One Vendor Specific register HOST_TIMER1MS(offset:0xe0)
> >  should be configured regarding to the frequency of AHB
> >  bus clock.
> 
> All this really belongs in the bootloader.

I beg to differ. Normally we do not write the kernel that it depends on
setup being done by the bootloader.

> Wouldn't you most likely be
> booting the kernel from SATA as well?

Having a SATA disk attached doesn't mean you boot from it.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
