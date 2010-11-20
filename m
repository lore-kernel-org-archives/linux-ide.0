From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: ide boot failure 2.6.36/2.6.28 - 2.6.27 works
Date: Sat, 20 Nov 2010 13:04:01 +0000
Message-ID: <20101120130401.59d8b8a1@lxorguk.ukuu.org.uk>
References: <20101120032828.GA14693@iq>
	<20101120074508.GA16854@liondog.tnic>
	<20101120121121.GA30338@iq>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:47269 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752797Ab0KTNFO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 20 Nov 2010 08:05:14 -0500
In-Reply-To: <20101120121121.GA30338@iq>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>
Cc: Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

> The author of the regression knew that he was breaking some setups
> and cleared his conscience by adding a printk
> +   printk(KERN_INFO DRV_NAME ": please use \"probe_mask=0x3f\" module "
> +   	     	       "parameter for probing all legacy ISA IDE ports\n");
> at boot time. Of course this scrolls off the screen too quickly to read.

I pointed out at the time that this was totally bogus hackery, but
without result. On a PCI box however you should always have a matching
PCI driver, and if not you want to force ide-generic to bind to it in
almost all cases, so if its hitting a lot of people then something else
is wrong in the config choices of the distro

The libata driver tries to be a bit smarter, firstly by not leaking
random resources but also knows not to bind against ports mapped to PCI
devices, or to certain special cases (non PCI standard but PCI space
using) devices.

If you have a PCI ATA driver which is not handled by any of the libata
drivers and is not known by ata_generic then please let me know. I
think we have pretty much everything old, weird and wonderful covered in
libata.

Alan
