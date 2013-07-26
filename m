From: Zhu Richard-R65037 <r65037@freescale.com>
Subject: RE: linux-next: Tree for Jul 25 (ahci_imx.c)
Date: Fri, 26 Jul 2013 04:58:14 +0000
Message-ID: <0E83723C55F66F43A6041464FE31119D34886A@039-SN2MPN1-011.039d.mgd.msft.net>
References: <20130725151253.8b9b53b3a3cf6cacd501dc54@canb.auug.org.au>
 <51F16F17.4030002@infradead.org>
 <0E83723C55F66F43A6041464FE31119D3487F2@039-SN2MPN1-011.039d.mgd.msft.net>
 <20130726040349.GA29268@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-db9lp0251.outbound.messaging.microsoft.com ([213.199.154.251]:30734
	"EHLO db9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750961Ab3GZE6T convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 26 Jul 2013 00:58:19 -0400
In-Reply-To: <20130726040349.GA29268@S2101-09.ap.freescale.net>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>, "tj@kernel.org" <tj@kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>, Stephen Rothwell <sfr@canb.auug.org.au>, "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hi Shawn:
yes, it is.

BTW, Should I re-send the AHCI_IMX patch-set or send out one stand-alone patch to fix this issue?

Hi Tejun:
What's your opinion?

Best Regards
Richard Zhu


-----Original Message-----
From: Shawn Guo [mailto:shawn.guo@linaro.org] 
Sent: Friday, July 26, 2013 12:04 PM
To: Zhu Richard-R65037
Cc: Randy Dunlap; Stephen Rothwell; linux-next@vger.kernel.org; linux-kernel@vger.kernel.org; linux-ide@vger.kernel.org
Subject: Re: linux-next: Tree for Jul 25 (ahci_imx.c)

On Fri, Jul 26, 2013 at 03:46:42AM +0000, Zhu Richard-R65037 wrote:
> -----Original Message-----
> From: Randy Dunlap [mailto:rdunlap@infradead.org] 
> Sent: Friday, July 26, 2013 2:32 AM
> To: Stephen Rothwell
> Cc: linux-next@vger.kernel.org; linux-kernel@vger.kernel.org; linux-ide@vger.kernel.org; Zhu Richard-R65037
> Subject: Re: linux-next: Tree for Jul 25 (ahci_imx.c)
> 
> On 07/24/13 22:12, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Changes since 20130724:
> > 
> 
> on i386:
> 
> # CONFIG_MFD_SYSCON is not set
> 
> 
> when ahci_imx.c is built as a loadable module:
> 
> ERROR: "syscon_regmap_lookup_by_compatible" [drivers/ata/ahci_imx.ko] undefined!
> 
> or when it is builtin:
> 
> ahci_imx.c:(.text+0x182e54): undefined reference to `syscon_regmap_lookup_by_compatible'
> 

We should have it depend on MFD_SYSCON.

Shawn

