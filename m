From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] PATA driver for CF interface on AT91SAM9260 SoC
Date: Wed, 17 Jun 2009 23:53:51 +0100
Message-ID: <20090617235351.1cb05c97@lxorguk.ukuu.org.uk>
References: <1245181151-7040-1-git-send-email-geomatsi@gmail.com>
	<20090618002004.54701b40@realm>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:36657 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755697AbZFQWwo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 17 Jun 2009 18:52:44 -0400
In-Reply-To: <20090618002004.54701b40@realm>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: geomatsi@gmail.com, linux-ide@vger.kernel.org, Andrew Victor <linux@maxim.org.za>, Sergey Lapin <slapin@ossfans.org>

> This patch provides PATA driver for CompactFlash interface in True IDE
> mode on AT91SAM9260 SoC.

Couple of points

> +static int pio_mask = ATA_PIO4;
> +module_param(pio_mask, int, 0);

This doesn't appear to be used ? is it a left over that can go

> +	set_smc_timing(dev, info, &initial_timing);
> +	set_smc_mode(info);

The core libata code will call your speed setting methods for PIO_0
before probing the port. I don't think this is needed ?

Alan
