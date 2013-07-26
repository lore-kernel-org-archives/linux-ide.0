From: Zhu Richard-R65037 <r65037@freescale.com>
Subject: RE: linux-next: Tree for Jul 25 (ahci_imx.c)
Date: Fri, 26 Jul 2013 03:46:42 +0000
Message-ID: <0E83723C55F66F43A6041464FE31119D3487F2@039-SN2MPN1-011.039d.mgd.msft.net>
References: <20130725151253.8b9b53b3a3cf6cacd501dc54@canb.auug.org.au>
 <51F16F17.4030002@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <51F16F17.4030002@infradead.org>
Content-Language: en-US
Sender: linux-next-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>, Stephen Rothwell <sfr@canb.auug.org.au>
Cc: "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>
List-Id: linux-ide@vger.kernel.org

Hi Randy:
Thanks for your kindly reminder.
I re-produced this issue at my side.
Now, I'm trying to find a proper method to fix it.

Best Regards
Richard Zhu


-----Original Message-----
From: Randy Dunlap [mailto:rdunlap@infradead.org] 
Sent: Friday, July 26, 2013 2:32 AM
To: Stephen Rothwell
Cc: linux-next@vger.kernel.org; linux-kernel@vger.kernel.org; linux-ide@vger.kernel.org; Zhu Richard-R65037
Subject: Re: linux-next: Tree for Jul 25 (ahci_imx.c)

On 07/24/13 22:12, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20130724:
> 

on i386:

# CONFIG_MFD_SYSCON is not set


when ahci_imx.c is built as a loadable module:

ERROR: "syscon_regmap_lookup_by_compatible" [drivers/ata/ahci_imx.ko] undefined!

or when it is builtin:

ahci_imx.c:(.text+0x182e54): undefined reference to `syscon_regmap_lookup_by_compatible'



Full randconfig file is attached.


-- 
~Randy
