From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [RESEND PATCH] arm: assabet_defconfig: disable IDE subsystem
Date: Thu, 09 Mar 2017 15:42:49 +0100
Message-ID: <3285453.g1rFzTv5DW@amdc3058>
References: <1467991490-24895-1-git-send-email-b.zolnierkie@samsung.com>
 <a8eab3b1-8867-00dd-08e4-bcece23010a6@cogentembedded.com>
 <20170309135714.GJ21222@n2100.armlinux.org.uk>
 <CGME20170309144256epcas1p25b4c18f7ced857f71e2f8c53ce7b2345@epcas1p2.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <20170309135714.GJ21222@n2100.armlinux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Arnd Bergmann <arnd@arndb.de>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Kevin Hilman <khilman@baylibre.com>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org
List-Id: linux-ide@vger.kernel.org


Hi,

On Thursday, March 09, 2017 01:57:15 PM Russell King - ARM Linux wrote:
> On Thu, Mar 09, 2017 at 03:24:56PM +0300, Sergei Shtylyov wrote:
> > On 03/09/2017 03:20 PM, Sekhar Nori wrote:
> > 
> > >[...]
> > 
> > >>>diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c
> > >>>b/arch/arm/mach-davinci/board-dm644x-evm.c
> > >>>index 023480b75244..60a1f23890cd 100644
> > >>>--- a/arch/arm/mach-davinci/board-dm644x-evm.c
> > >>>+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
> > >>>@@ -744,7 +744,7 @@ static int davinci_phy_fixup(struct phy_device
> > >>>*phydev)
> > >>>     return 0;
> > >>> }
> > >>>
> > >>>-#define HAS_ATA        IS_ENABLED(CONFIG_BLK_DEV_PALMCHIP_BK3710)
> > >>>+#define HAS_ATA        IS_ENABLED(CONFIG_PATA_BK3710)
> > >>
> > >>   I think it would be more correct to check for both libata and IDE
> > >>drivers here...
> > >
> > >As I understand, the plan is to remove the IDE driver soon.
> > 
> >    I'm not sure DaveM would support any removals in drivers/ide/. He has
> > explicitly expressed his will to maintain the IDE driuver forever.
> 
> As I keep saying, there are ARM machines where the IDE driver works but
> the PATA driver doesn't.  EBSA110's PCMCIA slots for instance.

Please be more specific, I'll be happy to help with migrating this
machines to libata PATA.

BTW the example you're giving has never worked with the old IDE
driver in the upstream kernel.

> Yes, it's very obscure - but what it comes down to is the silly way the
> "ISA" IO is handled on the platform (which depends whether it's an 8-bit
> or 16-bit ISA-style peripheral.)  The old IDE CS driver _could_ be bent
> to work via a patch like this:
> 
> ARM: EBSA110: Enable 16-bit IO type for ide-iops
> 
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index 047a20780fc1..2eb501d6b5fe 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -217,7 +217,8 @@ ifeq ($(CONFIG_ARCH_EBSA110),y)
>  # This is what happens if you forget the IOCS16 line.
>  # PCMCIA cards stop working.
>  CFLAGS_3c589_cs.o :=-DISA_SIXTEEN_BIT_PERIPHERAL
> -export CFLAGS_3c589_cs.o
> +CFLAGS_ide-io-std.o :=-DISA_SIXTEEN_BIT_PERIPHERAL
> +export CFLAGS_3c589_cs.o CFLAGS_ide-io-std.o
>  endif

As I've already explained in the past, the proper fix for the problem
(for both old IDE and libata) is to define custom transport ops in
ide-cs.c/ata_pcmcia.c and use them on affected platforms.

>  # The byte offset of the kernel image in RAM from the start of RAM.
> 
> but the PATA driver is much harder.

There are a lot examples of using your own transport operations in
existing code (i.e. pata_octeon_cf.c or drivers/ata/sata_rcar.c).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
