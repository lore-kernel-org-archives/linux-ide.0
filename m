From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2.6.26.2][RESEND] ahci: RAID mode SATA patch for Intel
 Ibex Peak DeviceIDs
Date: Fri, 22 Aug 2008 02:11:32 -0400
Message-ID: <48AE5894.9010408@pobox.com>
References: <200808111703.09743.seth.heasley@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50856 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752961AbYHVGLg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 22 Aug 2008 02:11:36 -0400
In-Reply-To: <200808111703.09743.seth.heasley@intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Seth Heasley <seth.heasley@intel.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Seth Heasley wrote:
> Resend with proper whitespace.
> 
> This patch adds the Intel Ibex Peak (PCH) SATA RAID Controller DeviceIDs.
> 
> Signed-off-by: Seth Heasley <seth.heasley@intel.com>
> 
> --- linux-2.6.26.2/drivers/ata/ahci.c.orig	2008-08-08 11:34:48.000000000 -0700
> +++ linux-2.6.26.2/drivers/ata/ahci.c	2008-08-08 11:36:06.000000000 -0700
> @@ -445,6 +445,8 @@
>  	{ PCI_VDEVICE(INTEL, 0x502b), board_ahci }, /* Tolapai */
>  	{ PCI_VDEVICE(INTEL, 0x3a05), board_ahci }, /* ICH10 */
>  	{ PCI_VDEVICE(INTEL, 0x3a25), board_ahci }, /* ICH10 */
> +	{ PCI_VDEVICE(INTEL, 0x3b24), board_ahci }, /* PCH RAID */
> +	{ PCI_VDEVICE(INTEL, 0x3b2b), board_ahci }, /* PCH RAID */
>  
>  	/* JMicron 360/1/3/5/6, match class to avoid IDE function */
>  	{ PCI_VENDOR_ID_JMICRON, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,

applied


