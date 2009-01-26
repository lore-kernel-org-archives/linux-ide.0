From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 04/05] sata_mv: msi masking fix (v2)
Date: Mon, 26 Jan 2009 06:42:58 -0500
Message-ID: <497DA1C2.2070306@pobox.com>
References: <49750705.7010709@rtr.ca> <49750746.3010709@rtr.ca> <49750774.1070005@rtr.ca> <49773FD1.3040101@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:55206 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751133AbZAZLnB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 26 Jan 2009 06:43:01 -0500
In-Reply-To: <49773FD1.3040101@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>

Mark Lord wrote:
> @@ -3414,9 +3423,9 @@
>     if (rc)
>         return rc;
> 
> -    /* Enable interrupts */
> -    if (msi && pci_enable_msi(pdev))
> -        pci_intx(pdev, 1);
> +    /* Enable message-switched interrupts, if requested */
> +    if (msi && 0 == pci_enable_msi(pdev))
> +        hpriv->hp_flags |= MV_HP_FLAG_MSI;

applied, after moving the '0' equality test to follow the 
pci_enable_msi() call...  :)

