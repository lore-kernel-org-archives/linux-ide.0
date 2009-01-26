From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 05/05] sata_mv: no longer experimental (v2)
Date: Mon, 26 Jan 2009 06:43:09 -0500
Message-ID: <497DA1CD.40305@pobox.com>
References: <49750705.7010709@rtr.ca> <49750746.3010709@rtr.ca> <49750774.1070005@rtr.ca> <49773FD1.3040101@rtr.ca> <49774079.1040902@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:55215 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751445AbZAZLnM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 26 Jan 2009 06:43:12 -0500
In-Reply-To: <49774079.1040902@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>

Mark Lord wrote:
> Update Kconfig for sata_mv with full list of chips supported,
> and (finally!) remove the "EXPERIMENTAL" designations.
> 
> Signed-off-by: Mark Lord <mlord@pobox.com>
> ---
> 
> This replaces the patch "[PATCH 06/06] sata_mv: remove experimental".
> 
> --- old/drivers/ata/Kconfig    2009-01-21 10:16:16.000000000 -0500
> +++ linux/drivers/ata/Kconfig    2009-01-21 10:25:35.000000000 -0500
> @@ -112,11 +112,11 @@
>       If unsure, say N.
> 
> config SATA_MV
> -    tristate "Marvell SATA support (HIGHLY EXPERIMENTAL)"
> -    depends on EXPERIMENTAL
> +    tristate "Marvell SATA support"
>     help
>       This option enables support for the Marvell Serial ATA family.
> -      Currently supports 88SX[56]0[48][01] chips.
> +      Currently supports 88SX[56]0[48][01] PCI(-X) chips,
> +      as well as the newer [67]042 PCI-X/PCIe and SOC devices.

applied.

three cheers!


