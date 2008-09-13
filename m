From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] ata: duplicate variable sparse warning
Date: Sat, 13 Sep 2008 16:43:34 -0400
Message-ID: <48CC25F6.8050701@pobox.com>
References: <20080908093139.3909a3ac@extreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:46388 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752583AbYIMUnh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 13 Sep 2008 16:43:37 -0400
In-Reply-To: <20080908093139.3909a3ac@extreme>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stephen Hemminger <shemminger@vyatta.com>
Cc: linux-ide@vger.kernel.org

Stephen Hemminger wrote:
> drivers/ata/ata_piix.c:1502:7: warning: symbol 'rc' shadows an earlier one
> 
> Signed-off-by: Stephen Hemminger <shemminger@vyatta.com>
> 
> --- a/drivers/ata/ata_piix.c	2008-09-08 09:29:22.000000000 -0700
> +++ b/drivers/ata/ata_piix.c	2008-09-08 09:29:33.000000000 -0700
> @@ -1499,7 +1499,7 @@ static int __devinit piix_init_one(struc
>  	 * off.
>  	 */
>  	if (pdev->vendor == PCI_VENDOR_ID_INTEL && pdev->device == 0x2652) {
> -		int rc = piix_disable_ahci(pdev);
> +		rc = piix_disable_ahci(pdev);
>  		if (rc)
>  			return rc;

applied


