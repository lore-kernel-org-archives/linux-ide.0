From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [Patch 1/1 RESEND] pata_via.c: Add VIA VX900 support
Date: Mon, 22 Mar 2010 22:45:22 -0400
Message-ID: <4BA82B42.7080101@garzik.org>
References: <9E058EE846170743AF7338FE064CB5AB38AA65@exchtp04.taipei.via.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:49941 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753074Ab0CWCp3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Mar 2010 22:45:29 -0400
Received: by gyg8 with SMTP id 8so2994790gyg.19
        for <linux-ide@vger.kernel.org>; Mon, 22 Mar 2010 19:45:28 -0700 (PDT)
In-Reply-To: <9E058EE846170743AF7338FE064CB5AB38AA65@exchtp04.taipei.via.com.tw>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: JosephChan@via.com.tw
Cc: linux-ide@vger.kernel.org, stable@kernel.org, tj@kernel.org, alan@lxorguk.ukuu.org.uk

On 03/19/2010 02:08 AM, JosephChan@via.com.tw wrote:
> Add the VIA VX900 (0x9001) support
>
> Signed-off-by: Joseph Chan<josephchan@via.com.tw>
>
> --- a/drivers/ata/pata_via.c	2010-03-15 04:16:15.000000000 -0400
> +++ b/drivers/ata/pata_via.c	2010-03-15 05:14:34.000000000 -0400
> @@ -677,6 +677,7 @@
>   	{ PCI_VDEVICE(VIA, 0x3164), },
>   	{ PCI_VDEVICE(VIA, 0x5324), },
>   	{ PCI_VDEVICE(VIA, 0xC409), VIA_IDFLAG_SINGLE },
> +	{ PCI_VDEVICE(VIA, 0x9001), VIA_IDFLAG_SINGLE },

applied


