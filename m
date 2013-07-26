From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: linux-next: Tree for Jul 25 (ahci_imx.c)
Date: Fri, 26 Jul 2013 12:03:51 +0800
Message-ID: <20130726040349.GA29268@S2101-09.ap.freescale.net>
References: <20130725151253.8b9b53b3a3cf6cacd501dc54@canb.auug.org.au>
 <51F16F17.4030002@infradead.org>
 <0E83723C55F66F43A6041464FE31119D3487F2@039-SN2MPN1-011.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from co9ehsobe004.messaging.microsoft.com ([207.46.163.27]:21380
	"EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750931Ab3GZEET (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 26 Jul 2013 00:04:19 -0400
Content-Disposition: inline
In-Reply-To: <0E83723C55F66F43A6041464FE31119D3487F2@039-SN2MPN1-011.039d.mgd.msft.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Zhu Richard-R65037 <r65037@freescale.com>
Cc: Randy Dunlap <rdunlap@infradead.org>, Stephen Rothwell <sfr@canb.auug.org.au>, "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

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

