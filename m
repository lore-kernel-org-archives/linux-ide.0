From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: H8/300 target support patch
Date: Sun, 22 Feb 2004 18:08:06 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200402221808.06615.bzolnier@elka.pw.edu.pl>
References: <m2y8r4naht.wl%ysato@users.sourceforge.jp> <200402201942.00232.bzolnier@elka.pw.edu.pl> <m2llmv9iwi.wl%ysato@users.sourceforge.jp>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:8955 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261700AbUBVRB3
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 22 Feb 2004 12:01:29 -0500
In-Reply-To: <m2llmv9iwi.wl%ysato@users.sourceforge.jp>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-ide@vger.kernel.org

On Sunday 22 of February 2004 17:30, Yoshinori Sato wrote:
> At Fri, 20 Feb 2004 19:42:00 +0100,
>
> Bartlomiej Zolnierkiewicz wrote:
> > On Friday 20 of February 2004 18:58, Yoshinori Sato wrote:
> > > > - added #if !defined(__H8300H__) to ide-proc.c
> > > >   (only place where ->OUTL is used, ->INL is unused in generic IDE
> > > > code)
> > >
> > > "__H8300S__" becomes the same condition, too.
> >
> > Oh yes, it should be CONFIG_H8300.
> >
> > > > - __ide_outl() and __ide_inl() removed
> > > > - redundant includes removed
> > > > - init driver through initcall (so no need to make changes in ide.c)
> > >
> > > It seems to have been overwritten with default_hwif_iops
> > > setting of h8300_hwif_iops in module_init.
> >
> > Yep, h8300_ide_init() still should be called from ide.c.
> > (because ide_register_hw() checks "initialization" flag etc.)
>
> I corrected it to initialize it with ide_init_default_hwifs.
> A correction of ide.c becomes needless.

NO!!!  ide_init_default_hwifs() should DIE!
The same goes for ide_default_{irq,io_base}().

They are not needed - you have driver(s) for H8/300 IDE controllers!

> Because h8300-iops.c might change every a target,
> I arranged with the other directory.

Please explain.

> +static u16 __ide_inw(unsigned long a)
> +{
> +	return inw(a);
> +}
> +
> +static void __ide_outl(u32 d, unsigned long a)
> +{
> +}
> +
> +static u32 __ide_inl(unsigned long a)
> +{
> +	return 0xffffffffUL;
> +}

__ide_outl() and __inl() are really not needed

> +void __init ide_init_hwif_ports(hw_regs_t *hw, unsigned long data_port,
> +				unsigned long ctrl_port, int *irq)

This should be static as it was before.

> -void h8300_ide_print_resource(char *name, hw_regs_t *hw);
> -static inline int ide_default_irq(unsigned long base) { return 0; };
> -static inline unsigned long ide_default_io_base(int index) { return 0; };
> +#define H8300_IDE_DEFINE
> +#include <asm/machine-depend.h>
> +#undef  H8300_IDE_DEFINE

What's that?
If you want to choose between H8MAX and IDE expand for AE-3068/9 just do this
using arch specific Kconfig or (better in my opinion) in drivers/ide/Kconfig.

> -static __inline__ void ide_init_hwif_ports(hw_regs_t *hw, unsigned long
> data_port, -	 unsigned long ctrl_port, int *irq)
> +static __inline__ int ide_default_irq(unsigned long base)
>  {
> -}
> +	return IDE_IRQ;
> +};
>
> -
> -static inline void ide_init_default_hwifs(void)
> +static __inline__ unsigned long ide_default_io_base(int index)
>  {
> -}
> +	if (index == 0)
> +		return IDE_BASE;
> +	else
> +		return 0;
> +};
> +
> +void ide_init_hwif_ports(hw_regs_t *hw, unsigned long data_port,
> +			 unsigned long ctrl_port, int *irq);
> +void ide_init_default_hwifs(void);

This is just wrong and redundant.
Please, no more <asm/ide.h> crap for new IDE drivers.

Cheers,
--bart

