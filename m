From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] updated sata_promise.c with new device id
Date: Fri, 03 Mar 2006 21:27:06 -0500
Message-ID: <4408FAFA.9090704@pobox.com>
References: <43E7A0B4.4050908@novator.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:17053 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750717AbWCDC1I (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 3 Mar 2006 21:27:08 -0500
In-Reply-To: <43E7A0B4.4050908@novator.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Borkowski <rborkows@novator.com>
Cc: linux-ide@vger.kernel.org

Robert Borkowski wrote:
> patch is against kernel 2.4.32
> card is a Promise SATAII 300 TX4, PDC40718-GP printed on the main chip
> 
> Tested by making md raid5 on four drives and stressing with bonnie++.
> Any other tests I should run?
> 
> Signed-off-by: Robert Borkowski <rborkows@novator.com>
> --- drivers/scsi/sata_promise.c.orig    Mon Feb  6 11:45:06 2006
> +++ drivers/scsi/sata_promise.c Mon Feb  6 11:45:39 2006
> @@ -181,6 +181,8 @@
>           board_20319 },
>         { PCI_VENDOR_ID_PROMISE, 0x3319, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
>           board_20319 },
> +       { PCI_VENDOR_ID_PROMISE, 0x3d17, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> +         board_20319 },
>         { PCI_VENDOR_ID_PROMISE, 0x3d18, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
>           board_20319 },
> 

Can you resend against 2.6.x?

	Jeff


