From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2.6.23-rc4][reRESEND] ahci: RAID mode SATA patch for Intel
 Tolapai
Date: Fri, 31 Aug 2007 03:47:15 -0400
Message-ID: <46D7C783.8050803@pobox.com>
References: <200708302127.19535.jason.d.gaston@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:41901 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753486AbXHaHrR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 31 Aug 2007 03:47:17 -0400
In-Reply-To: <200708302127.19535.jason.d.gaston@intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jason Gaston <jason.d.gaston@intel.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Jason Gaston wrote:
> Resend trying to remove 8-bit characters in the email.
> 
> This patch adds the Intel Tolapai RAID controller DID's for SATA support.
> 
> Signed-off-by:  Jason Gaston <jason.d.gaston@intel.com>
> 
> --- linux-2.6.23-rc4/drivers/ata/ahci.c.orig	2007-08-27 18:32:35.000000000 -0700
> +++ linux-2.6.23-rc4/drivers/ata/ahci.c	2007-08-28 16:58:11.000000000 -0700
> @@ -411,6 +411,8 @@
>  	{ PCI_VDEVICE(INTEL, 0x292f), board_ahci_pi }, /* ICH9M */
>  	{ PCI_VDEVICE(INTEL, 0x294d), board_ahci_pi }, /* ICH9 */
>  	{ PCI_VDEVICE(INTEL, 0x294e), board_ahci_pi }, /* ICH9M */
> +	{ PCI_VDEVICE(INTEL, 0x502a), board_ahci }, /* Tolapai */
> +	{ PCI_VDEVICE(INTEL, 0x502b), board_ahci }, /* Tolapai */

Why did you not use board_ahci_pi?  Is the AHCI ports-implemented 
register unreliable on this platform?


