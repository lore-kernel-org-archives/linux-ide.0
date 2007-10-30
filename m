From: Denys Vlasenko <vda.linux@googlemail.com>
Subject: Re: [IDE] Fix build bug
Date: Tue, 30 Oct 2007 11:34:29 +0000
Message-ID: <200710301134.30087.vda.linux@googlemail.com>
References: <20071025135334.GA23272@linux-mips.org> <200710252341.38902.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <200710252341.38902.bzolnier@gmail.com>
Content-Disposition: inline
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-mips@linux-mips.org, Martijn Uffing <mp3project@sarijopen.student.utwente.nl>
List-Id: linux-ide@vger.kernel.org

On Thursday 25 October 2007 22:41, Bartlomiej Zolnierkiewicz wrote:
> > -static const struct ide_port_info generic_chipsets[] __devinitdata = {
> > +static struct ide_port_info generic_chipsets[] __devinitdata = {
> >  	/*  0 */ DECLARE_GENERIC_PCI_DEV("Unknown",	0),
> >  
> >  	{	/* 1 */
> 
> I would prefer to not remove const from generic_chipsets[] so:
> 
> [PATCH] drivers/ide/pci/generic: fix build for CONFIG_HOTPLUG=n
> 
> It turns out that const and __{dev}initdata cannot be mixed currently
> and that generic IDE PCI host driver is also affected by the same issue:
> 
> On Thursday 25 October 2007, Ralf Baechle wrote:
> >   CC      drivers/ide/pci/generic.o
> > drivers/ide/pci/generic.c:52: error: __setup_str_ide_generic_all_on causes a
> > +section type conflict
> 
> [ Also reported by Martijn Uffing <mp3project@sarijopen.student.utwente.nl>. ]
> 
> This patch workarounds the problem in a bit hackish way but without
> removing const from generic_chipsets[] (it adds const to __setup() so
> __setup_str_ide_generic_all becomes const).

You wouldn't believe how much const data is not marked as const because
we don't have __constinitdata etc. Literally megabytes.
--
vda
