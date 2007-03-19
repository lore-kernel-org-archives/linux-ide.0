From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] sata_sil24: Add Adaptec 1220SA PCI ID
Date: Mon, 19 Mar 2007 12:04:03 -0400
Message-ID: <45FEB473.7050501@pobox.com>
References: <45F62D00.9060902@metaparadigm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53766 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030295AbXCSQEJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 19 Mar 2007 12:04:09 -0400
In-Reply-To: <45F62D00.9060902@metaparadigm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jamie Clark <jamie@metaparadigm.com>
Cc: linux-ide@vger.kernel.org, htejun@gmail.com

Jamie Clark wrote:
> Add Adaptec 1220SA (SIL3132) to devices claimed by sata_sil24
> Patch generated against 2.6.20.2
> 
> Signed-off-by: Jamie Clark <jclark@metaparadigm.com>
> 
> --- drivers/ata/sata_sil24.c.orig    2007-03-10 02:58:04.000000000 +0800
> +++ drivers/ata/sata_sil24.c    2007-03-12 20:41:02.000000000 +0800
> @@ -352,6 +352,7 @@
>     { PCI_VDEVICE(CMD, 0x3124), BID_SIL3124 },
>     { PCI_VDEVICE(INTEL, 0x3124), BID_SIL3124 },
>     { PCI_VDEVICE(CMD, 0x3132), BID_SIL3132 },
> +    { PCI_VDEVICE(CMD, 0x0242), BID_SIL3132 },
>     { PCI_VDEVICE(CMD, 0x3131), BID_SIL3131 },
>     { PCI_VDEVICE(CMD, 0x3531), BID_SIL3131 },

applied


