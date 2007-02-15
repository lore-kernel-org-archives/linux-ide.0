From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [git patches] libata updates (mostly fixes)
Date: Thu, 15 Feb 2007 15:48:04 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702151546130.20368@woody.linux-foundation.org>
References: <20070215233411.GA10782@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:39104 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422687AbXBOXsZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 15 Feb 2007 18:48:25 -0500
In-Reply-To: <20070215233411.GA10782@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>



On Thu, 15 Feb 2007, Jeff Garzik wrote:
> 
> diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
> index db185f3..d51f0f1 100644
> --- a/arch/ia64/Kconfig
> +++ b/arch/ia64/Kconfig
> @@ -22,6 +22,7 @@ config IA64
>  
>  config 64BIT
>  	bool
> +	select ATA_NONSTANDARD if ATA
>  	default y

Ok, this is just _strange_.

Tying ATA_NONSTANDARD into ia64 by tying it to the 64BIT config variable 
may work (well, I _assume_ it does), but it's just psychedelic.

How about adding a separate config entry like

	config IA64_ATA
		bool
		depends on ATA
		select ATA_NONSTANDARD
		default y

which kind of makes sense when you squint just the right way..

		Linus
