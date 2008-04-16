From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] [IT821X IDE] Do not describe noraid parameter with its value
Date: Thu, 17 Apr 2008 00:32:57 +0200
Message-ID: <200804170032.58116.bzolnier@gmail.com>
References: <1208334500.5614.29.camel@compaq.thuisdomein>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:52666 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755304AbYDPW1z (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Apr 2008 18:27:55 -0400
Received: by fg-out-1718.google.com with SMTP id l27so2584416fgb.17
        for <linux-ide@vger.kernel.org>; Wed, 16 Apr 2008 15:27:55 -0700 (PDT)
In-Reply-To: <1208334500.5614.29.camel@compaq.thuisdomein>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Paul Bolle <pebolle@tiscali.nl>
Cc: linux-ide@vger.kernel.org

On Wednesday 16 April 2008, Paul Bolle wrote:
> From: Paul Bolle <pebolle@tiscali.nl>
> 
> Describe noraid parameter with its name (and not its value)
>     
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>

thanks, applied

> ---
> diff --git a/drivers/ide/pci/it821x.c b/drivers/ide/pci/it821x.c
> index 1597f0c..d8a1674 100644
> --- a/drivers/ide/pci/it821x.c
> +++ b/drivers/ide/pci/it821x.c
> @@ -667,7 +667,7 @@ static int __init it821x_ide_init(void)
>  module_init(it821x_ide_init);
>  
>  module_param_named(noraid, it8212_noraid, int, S_IRUGO);
> -MODULE_PARM_DESC(it8212_noraid, "Force card into bypass mode");
> +MODULE_PARM_DESC(noraid, "Force card into bypass mode");
>  
>  MODULE_AUTHOR("Alan Cox");
>  MODULE_DESCRIPTION("PCI driver module for the ITE 821x");
