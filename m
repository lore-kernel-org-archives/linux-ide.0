From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2.6.22-rc2] libata: sata_sis fixes
Date: Fri, 25 May 2007 15:32:30 +0100
Message-ID: <20070525153230.325258e9@the-village.bc.nu>
References: <200705250948.52588.uwe.koziolek@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:37145 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751199AbXEYO1i (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 25 May 2007 10:27:38 -0400
In-Reply-To: <200705250948.52588.uwe.koziolek@gmx.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Uwe Koziolek <uwe.koziolek@gmx.net>
Cc: Jeff Garzik <jeff@garzik.org>, htejun@gmail.com, linux-ide@vger.kernel.org

On Fri, 25 May 2007 09:48:52 +0200
Uwe Koziolek <uwe.koziolek@gmx.net> wrote:

> The sata_sis driver supports SATA and PATA ports. The broken support
> of both types in one controller is fixed.
> 
> the PATA-port of SiS180 controller does not support a drive present status
> in the pci configspace like the other SiS PATA controllers, check skipped.
> 
> Signed-off-by: Uwe Koziolek <uwe.koziolek@gmx.net>

Needs checking with SiS because they submitted code that uses those
enable bits and its been in drivers/ide for years with respect of the
MuTOL ATA133. No argument about the SATA one if you've checked the docs
and seen the bug.

> -	if (!pci_test_config_bits(pdev, &sis_enable_bits[ap->port_no]))
> +	if ((pdev->device != 0x0180) && (pdev->device != 0x0181) &&
> +	    !pci_test_config_bits(pdev, &sis_enable_bits[ap->port_no]))
>  		return -ENOENT;

Might look a lot nicer with less brackets, or even better pull the device
check out into a new static function (gcc will inline it all nicely
anyway) so you can just say

	if (sis_enables_supported(pdev) && !pci_test...

