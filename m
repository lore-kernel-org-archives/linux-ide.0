From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2.6.22-rc6] add PCI-ID for Adaptec 1430SA 4-Port SATA
 Controller
Date: Mon, 02 Jul 2007 10:07:50 -0400
Message-ID: <468906B6.1050700@garzik.org>
References: <20070630144436.GA13479@master.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:51749 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753037AbXGBOHx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 2 Jul 2007 10:07:53 -0400
In-Reply-To: <20070630144436.GA13479@master.home>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Florian Attenberger <valdyn@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Florian Attenberger wrote:
> Hi,
> 
> added this pci id to support my:
> lspci:
> 01:00.0 RAID bus controller: Adaptec Unknown device 0243 (rev 02)
> lspci -n:
> 01:00.0 0104: 9005:0243 (rev 02)
> 
> seems to work fine.
> 
> florian attenberger
> 
> 
> --- 2.6.22-rc6/drivers/ata/sata_mv.c	2007-06-30 16:21:47.462020256 +0200
> +++ 2.6.22-rc6.mine/drivers/ata/sata_mv.c	2007-06-30 16:25:25.999165444 +0200
> @@ -582,6 +582,9 @@ static const struct pci_device_id mv_pci
>  
>  	{ PCI_VDEVICE(ADAPTEC2, 0x0241), chip_604x },
>  
> +	/* Adaptec 1430SA */
> +	{ PCI_VDEVICE(ADAPTEC2, 0x0243), chip_7042 },
> +
>  	{ PCI_VDEVICE(TTI, 0x2310), chip_7042 },

Please do me a favor and resend with the Signed-off-by line as described 
by Documentation/SubmittingPatches and
http://linux.yyz.us/patch-format.html

Also, since your email is copied verbatim into the permanent kernel 
changelog, please remove all superfluous comments like "Hi," and 
"florian attenberger", or add a "---" separator and move the comments 
after the separator.

