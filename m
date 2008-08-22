From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2.6.26.2][RESEND] ata_piix: IDE Mode SATA patch for Intel
 Ibex Peak DeviceIDs
Date: Fri, 22 Aug 2008 02:11:41 -0400
Message-ID: <48AE589D.7080100@pobox.com>
References: <200808111703.18252.seth.heasley@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50860 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755103AbYHVGLo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 22 Aug 2008 02:11:44 -0400
In-Reply-To: <200808111703.18252.seth.heasley@intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Seth Heasley <seth.heasley@intel.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, htejun@gmail.com

Seth Heasley wrote:
> Resend with proper whitespace.
> 
> This patch adds the Intel Ibex Peak (PCH) IDE mode SATA Controller DeviceIDs.
> 
> Signed-off-by: Seth Heasley <seth.heasley@intel.com>
> 
> --- linux-2.6.26.2/drivers/ata/ata_piix.c.orig	2008-08-08 11:34:56.000000000 -0700
> +++ linux-2.6.26.2/drivers/ata/ata_piix.c	2008-08-08 14:30:02.000000000 -0700
> @@ -274,6 +274,14 @@
>  	{ 0x8086, 0x3a20, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata },
>  	/* SATA Controller IDE (ICH10) */
>  	{ 0x8086, 0x3a26, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata },
> +	/* SATA Controller IDE (PCH) */
> +	{ 0x8086, 0x3b20, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata },
> +	/* SATA Controller IDE (PCH) */
> +	{ 0x8086, 0x3b26, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata },
> +	/* SATA Controller IDE (PCH) */
> +	{ 0x8086, 0x3b2d, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata },
> +	/* SATA Controller IDE (PCH) */
> +	{ 0x8086, 0x3b2e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata },

applied


