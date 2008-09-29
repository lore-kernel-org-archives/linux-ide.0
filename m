From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2.6.26.7-rc4] ata_piix: IDE Mode SATA patch for Intel
 Ibex Peak DeviceIDs
Date: Mon, 29 Sep 2008 00:34:49 -0400
Message-ID: <48E05AE9.1040901@pobox.com>
References: <200808271640.06762.seth.heasley@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50460 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751355AbYI2Eey (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 Sep 2008 00:34:54 -0400
In-Reply-To: <200808271640.06762.seth.heasley@intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Seth Heasley <seth.heasley@intel.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, htejun@gmail.com

Seth Heasley wrote:
> This patch updates the Intel Ibex Peak (PCH) IDE mode SATA Controller DeviceIDs.
> 
> Signed-off-by: Seth Heasley <seth.heasley@intel.com>
> 
> --- linux-2.6/drivers/ata/ata_piix.c.orig	2008-08-27 11:32:28.000000000 -0700
> +++ linux-2.6/drivers/ata/ata_piix.c	2008-08-27 11:47:59.000000000 -0700
> @@ -278,12 +278,15 @@
>  	/* SATA Controller IDE (PCH) */
>  	{ 0x8086, 0x3b20, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata },
>  	/* SATA Controller IDE (PCH) */
> +	{ 0x8086, 0x3b21, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata },
> +	/* SATA Controller IDE (PCH) */
>  	{ 0x8086, 0x3b26, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata },
>  	/* SATA Controller IDE (PCH) */
> +	{ 0x8086, 0x3b28, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata },
> +	/* SATA Controller IDE (PCH) */
>  	{ 0x8086, 0x3b2d, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata },
>  	/* SATA Controller IDE (PCH) */
>  	{ 0x8086, 0x3b2e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata },
> -
>  	{ }	/* terminate list */
>  };

applied


