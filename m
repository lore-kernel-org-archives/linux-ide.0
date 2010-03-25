From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [Patch 1/1] pata_via: HDD of VT6410/6415/6330 cannot be detected
 issue
Date: Thu, 25 Mar 2010 15:02:58 +0300
Message-ID: <4BAB50F2.5070902@ru.mvista.com>
References: <9E058EE846170743AF7338FE064CB5AB38B400@exchtp04.taipei.via.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.26]:28808 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751750Ab0CYMDb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Mar 2010 08:03:31 -0400
Received: by ey-out-2122.google.com with SMTP id 9so523124eyd.5
        for <linux-ide@vger.kernel.org>; Thu, 25 Mar 2010 05:03:30 -0700 (PDT)
In-Reply-To: <9E058EE846170743AF7338FE064CB5AB38B400@exchtp04.taipei.via.com.tw>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: JosephChan@via.com.tw
Cc: linux-ide@vger.kernel.org, stable@kernel.org, jeff@garzik.org, tj@kernel.org

Hello.

JosephChan@via.com.tw wrote:

> When using VT6410/6415/6330 chips on some VIA's platforms, the HDD connects to VT6410/6415/6330 cannot be detected.
> It is because the driver detects wrong via_isa_bridge ID, and then cause the this issue happen.
> This patch will fix this problem.
>
>
> Signed-off-by: Joseph Chan<josephchan@via.com.tw>
>
> --- a/drivers/ata/pata_via.c	2010-03-16 06:00:01.000000000 -0400
> +++ b/drivers/ata/pata_via.c	2010-03-19 10:21:59.000000000 -0400
> @@ -576,6 +576,10 @@
> 			u8 rev = isa->revision;
> 			pci_dev_put(isa);
>  
> +			if ( (id->device == 0x0415 || id->device == 0x3164) &&
> +			      (config->id != id->device ))
>   

   Don't put spaces before parens.

MBR, Sergei

