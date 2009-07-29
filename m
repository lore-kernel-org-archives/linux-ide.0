From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] Add AMD SB900 SATA/IDE controller device IDs
Date: Tue, 28 Jul 2009 20:56:30 -0400
Message-ID: <4A6F9E3E.30500@pobox.com>
References: <1248762566.3437.7.camel@zm-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:42711 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751107AbZG2A4d (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 28 Jul 2009 20:56:33 -0400
In-Reply-To: <1248762566.3437.7.camel@zm-desktop>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: shane.huang@amd.com
Cc: tj@kernel.org, linux-ide@vger.kernel.org

Shane Huang wrote:
> Add AMD SB900 SATA/IDE controller device IDs.
> 
> Signed-off-by: Shane Huang <shane.huang@amd.com>
> 
> diff -ruN a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> --- a/drivers/ata/ahci.c	2009-07-27 18:55:43.000000000 +0800
> +++ b/drivers/ata/ahci.c	2009-07-27 18:55:47.000000000 +0800
> @@ -533,6 +533,11 @@
>  	{ PCI_VDEVICE(ATI, 0x4394), board_ahci_sb700 }, /* ATI SB700/800 */
>  	{ PCI_VDEVICE(ATI, 0x4395), board_ahci_sb700 }, /* ATI SB700/800 */
>  
> +	/* AMD */
> +	{ PCI_VDEVICE(AMD, 0x7800), board_ahci }, /* AMD SB900 */
> +	{ PCI_VENDOR_ID_AMD, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
> +	  PCI_CLASS_STORAGE_RAID << 8, 0xffffff, board_ahci }, /* AMD RAID */

Are you _absolutely_ certain that future AMD PCI_CLASS_STORAGE_RAID 
hardware will be compatible with AHCI?

	Jeff


