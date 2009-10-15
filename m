From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [Patch 1/1] sata_via.c: Remove redundant device ID for VT8261
Date: Thu, 15 Oct 2009 03:16:15 -0400
Message-ID: <4AD6CC3F.6050305@garzik.org>
References: <C80EF34A3D2E494DBAF9AC29C7AE4EB80A1D1498@exchtp03.taipei.via.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:40874 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751124AbZJOHQy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 15 Oct 2009 03:16:54 -0400
In-Reply-To: <C80EF34A3D2E494DBAF9AC29C7AE4EB80A1D1498@exchtp03.taipei.via.com.tw>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: JosephChan@via.com.tw
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, tj@kernel.org

On 10/15/2009 03:10 AM, JosephChan@via.com.tw wrote:
> Just remove redundant device ID for VT8261.
>
> Signed-off-by: Joseph Chan<josephchan@via.com.tw>
>
> --- a/drivers/ata/sata_via.c	2009-10-15 21:38:14.000000000 +0800
> +++ b/drivers/ata/sata_via.c	2009-10-15 21:38:28.000000000 +0800
> @@ -93,7 +93,6 @@
>   	{ PCI_VDEVICE(VIA, 0x7372), vt6420 },
>   	{ PCI_VDEVICE(VIA, 0x5287), vt8251 }, /* 2 sata chnls (Master/Slave) */
>   	{ PCI_VDEVICE(VIA, 0x9000), vt8251 },
> -	{ PCI_VDEVICE(VIA, 0x9040), vt8251 },

PCI device ID 0x9040 does not exist elsewhere in the driver...  how is 
it redundant?

	Jeff




