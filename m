From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] sata_mv: Test patch for Hightpoint RocketRaid 1740/1742
Date: Thu, 12 Jul 2007 17:00:14 -0400
Message-ID: <4696965E.70403@garzik.org>
References: <20070709143841.133abb71@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:56088 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760514AbXGLVAR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 12 Jul 2007 17:00:17 -0400
In-Reply-To: <20070709143841.133abb71@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, akpm@osdl.org

Alan Cox wrote:
> Underneath all the HPT packaging, PCI identifiers, binary driver modules
> and stuff you find that ...
> 
> Signed-off-by: Alan Cox <alan@redhat.com>
> 
> --- drivers/ata/sata_mv.c~	2007-07-09 13:19:57.003052904 +0100
> +++ drivers/ata/sata_mv.c	2007-07-09 13:19:57.004052752 +0100
> @@ -573,6 +573,9 @@
>  	{ PCI_VDEVICE(MARVELL, 0x5041), chip_504x },
>  	{ PCI_VDEVICE(MARVELL, 0x5080), chip_5080 },
>  	{ PCI_VDEVICE(MARVELL, 0x5081), chip_508x },
> +	/* RocketRAID 1740/174x have different identifiers */
> +	{ PCI_VDEVICE(TTI, 0x1740), chip_508x },
> +	{ PCI_VDEVICE(TTI, 0x1742), chip_508x },

If your testers could re-test on top of what I just submitted to Linus, 
that would be most helpful.  My non-RocketRAID 5081 works just fine, but 
sata_mv received some major changes and bug fixes, which could 
potentially change behavior here.

Since we're guessing (I assume?), I definitely want to make sure we have 
the correct MV variant for use with RocketRAID.

Any idea if RocketRAID is marketed as SATA-II or with NCQ support? 
("queueing" in marketing lit doesn't help, alas).

	Jeff



