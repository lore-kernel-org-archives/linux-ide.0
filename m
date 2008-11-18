From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] Add SATA GEN3 related messages
Date: Tue, 18 Nov 2008 20:13:02 +0900
Message-ID: <4922A33E.2090700@gmail.com>
References: <1227000818.5631.12.camel@chunhao-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.188]:43979 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751061AbYKRLNR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 18 Nov 2008 06:13:17 -0500
Received: by ti-out-0910.google.com with SMTP id b6so1829469tic.23
        for <linux-ide@vger.kernel.org>; Tue, 18 Nov 2008 03:13:15 -0800 (PST)
In-Reply-To: <1227000818.5631.12.camel@chunhao-desktop>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shane Huang <shane.huang@amd.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Shane Huang wrote:
> The present AHCI driver seems to support SATA GEN 3 speed, but the related
> messages should be modified.
> 
> Signed-off-by: Shane Huang <shane.huang@amd.com>
> 
> diff -ruN c/drivers/ata/ahci.c d/drivers/ata/ahci.c
> --- c/drivers/ata/ahci.c	2008-11-07 11:23:24.000000000 +0800
> +++ d/drivers/ata/ahci.c	2008-11-07 13:47:46.000000000 +0800
> @@ -2446,6 +2446,8 @@
>  		speed_s = "1.5";
>  	else if (speed == 2)
>  		speed_s = "3";
> +	else if (speed == 3)
> +		speed_s = "6";
>  	else
>  		speed_s = "?";
>  
> diff -ruN c/drivers/ata/libata-core.c d/drivers/ata/libata-core.c
> --- c/drivers/ata/libata-core.c	2008-11-07 13:46:39.000000000 +0800
> +++ d/drivers/ata/libata-core.c	2008-11-07 13:46:23.000000000 +0800
> @@ -930,6 +930,7 @@
>  	static const char * const spd_str[] = {
>  		"1.5 Gbps",
>  		"3.0 Gbps",
> +		"6.0 Gbps",
>  	};
>  
>  	if (spd == 0 || (spd - 1) >= ARRAY_SIZE(spd_str))

Sweeeeettt.  Can you also update the force_tbl and force param handling?

-- 
tejun
