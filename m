From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] pata_legacy: Restructure and revamp
Date: Tue, 11 Dec 2007 21:23:26 -0800
Message-ID: <20071211212326.0223589c.akpm@linux-foundation.org>
References: <20071208155506.77642115@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:54883 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752178AbXLLFXl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Dec 2007 00:23:41 -0500
In-Reply-To: <20071208155506.77642115@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org

On Sat, 8 Dec 2007 15:55:06 +0000 Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> Rework the pata_legacy driver to have an internal way to plug multiple legacy interface types
> and designs into the driver. 
> 
> This driver supports
> 	- Generic legacy ISA on primary/secondary and tertiary ports
> 	- BIOS or jumper configured legacy ports
> 	- VLB controllers that snoop the mode set for PIO
> 		(Cirrus CLPD7220, Adaptec AIC25VL01)
> 	- Promise PDC20230
> 	- Holtek 6560A/B
> 	- Opti VLB controllers
> 	- QDI 6500/6580/6580DP controllers
> 
> The new driver also adds an "all" option so you can load all the PCI drivers you have, decide you have
> a controller that is totally unknown and then load pata_legacy all=1 to grab the primary/secondary ports
> as a last resort fallback.
> 
> TODO:
> 	Add ST412 support (needs some kind of geometry hook in libata core code)
> 	Winbond W83759A in programmable mode (aka DTC2278)
> 	Find more insane VLB controllers to support
> 
> This driver obsoletes pata_qdi, which can go once this is settled in.
> 

Is this patch going to screw my kernel up?

> +static __init void probe_opti_vlb(void)
> +{
> +	/* If an OPTI 82C46X is present find out where the channels are */
> +	static const char *optis[4] = {
> +		"3/463MV", "5MV",
> +		"5MVA", "5MVB"
> +	};
> +	u8 chans = 1;
> +	u8 ctrl = (opti_syscfg(0x30) & 0xC0) >> 6;
> +
> +	opti82c46x = 3;	/* Assume master and slave first */
> +	printk(KERN_INFO DRV_NAME ": Opti 82C46%s chipset support.\n",
> +								optis[ctrl]);
> +	if (ctrl == 3)
> +		chans = (opti_syscfg(0x3F) & 0x20) ? 2 : 1;

this could be

	if (ctrl == 3 && (opti_syscfg(0x3F) & 0x20))
		chans = 2;

if that's any clearer...

