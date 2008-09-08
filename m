From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2.6.27-rc4] ahci: RAID mode SATA patch for Intel Ibex
 Peak DeviceIDs
Date: Mon, 08 Sep 2008 12:16:06 -0400
Message-ID: <48C54FC6.6030109@pobox.com>
References: <200808271647.22782.seth.heasley@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:37742 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752728AbYIHQQJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 8 Sep 2008 12:16:09 -0400
In-Reply-To: <200808271647.22782.seth.heasley@intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Seth Heasley <seth.heasley@intel.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Seth Heasley wrote:
> This patch adds the Intel Ibex Peak (PCH) SATA RAID Controller DeviceIDs.
> 
> Signed-off-by: Seth Heasley <seth.heasley@intel.com>
> 
> --- linux-2.6/drivers/ata/ahci.c.orig	2008-08-27 11:48:10.000000000 -0700
> +++ linux-2.6/drivers/ata/ahci.c	2008-08-27 11:49:23.000000000 -0700
> @@ -487,7 +487,9 @@
>  	{ PCI_VDEVICE(INTEL, 0x3a05), board_ahci }, /* ICH10 */
>  	{ PCI_VDEVICE(INTEL, 0x3a25), board_ahci }, /* ICH10 */
>  	{ PCI_VDEVICE(INTEL, 0x3b24), board_ahci }, /* PCH RAID */
> +	{ PCI_VDEVICE(INTEL, 0x3b25), board_ahci }, /* PCH RAID */
>  	{ PCI_VDEVICE(INTEL, 0x3b2b), board_ahci }, /* PCH RAID */
> +	{ PCI_VDEVICE(INTEL, 0x3b2c), board_ahci }, /* PCH RAID */

applied


