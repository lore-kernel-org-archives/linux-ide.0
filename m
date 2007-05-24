From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2.6.22-rc2] libata: sata_sis fixes
Date: Thu, 24 May 2007 01:22:54 +0100
Message-ID: <20070524012254.729352c8@the-village.bc.nu>
References: <200705240131.32021.uwe.koziolek@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:32989 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756792AbXEXASM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 May 2007 20:18:12 -0400
In-Reply-To: <200705240131.32021.uwe.koziolek@gmx.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Uwe Koziolek <uwe.koziolek@gmx.net>
Cc: htejun@gmail.com, jeff@garzik.org, linux-ide@vger.kernel.org

> the pata133 sis controllers does not support a drive present status
> in the pci configspace like the older sis controllers, check removed.

Are you sure about this - I've no idea about the SATA/PATA combo but the
pure PATA 133Mhz (MuTOL 96x) chipsets seem to do so correctly.
 
> Signed-off-by: Uwe Koziolek <uwe.koziolek@gmx.net>

> +static void sis_133_error_handler(struct ata_port *ap)
> +{
> +	ata_bmdma_drive_eh(ap, ata_std_prereset, ata_std_softreset, NULL, ata_std_postreset);
> +}

NAK - if this is needed then you can simply set .error_handler to use the
default bmdma handler rather than adding the function

Alan
