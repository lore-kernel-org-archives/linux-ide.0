From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [IDE] Fix build bug
Date: Tue, 30 Oct 2007 21:30:55 +0100
Message-ID: <200710302130.55225.bzolnier@gmail.com>
References: <20071025135334.GA23272@linux-mips.org> <200710301134.30087.vda.linux@googlemail.com> <20071030124155.GA7582@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:12135 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758963AbXJ3UYl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Oct 2007 16:24:41 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1739912nfb
        for <linux-ide@vger.kernel.org>; Tue, 30 Oct 2007 13:24:39 -0700 (PDT)
In-Reply-To: <20071030124155.GA7582@linux-mips.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Denys Vlasenko <vda.linux@googlemail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-mips@linux-mips.org, Martijn Uffing <mp3project@sarijopen.student.utwente.nl>


On Tuesday 30 October 2007, Ralf Baechle wrote:
> On Tue, Oct 30, 2007 at 11:34:29AM +0000, Denys Vlasenko wrote:
> 
> > On Thursday 25 October 2007 22:41, Bartlomiej Zolnierkiewicz wrote:
> > > > -static const struct ide_port_info generic_chipsets[] __devinitdata = {
> > > > +static struct ide_port_info generic_chipsets[] __devinitdata = {
> > > >  	/*  0 */ DECLARE_GENERIC_PCI_DEV("Unknown",	0),
> > > >  
> > > >  	{	/* 1 */
> > > 
> > > I would prefer to not remove const from generic_chipsets[] so:
> > > 
> > > [PATCH] drivers/ide/pci/generic: fix build for CONFIG_HOTPLUG=n
> > > 
> > > It turns out that const and __{dev}initdata cannot be mixed currently
> > > and that generic IDE PCI host driver is also affected by the same issue:
> > > 
> > > On Thursday 25 October 2007, Ralf Baechle wrote:
> > > >   CC      drivers/ide/pci/generic.o
> > > > drivers/ide/pci/generic.c:52: error: __setup_str_ide_generic_all_on causes a
> > > > +section type conflict
> > > 
> > > [ Also reported by Martijn Uffing <mp3project@sarijopen.student.utwente.nl>. ]
> > > 
> > > This patch workarounds the problem in a bit hackish way but without
> > > removing const from generic_chipsets[] (it adds const to __setup() so
> > > __setup_str_ide_generic_all becomes const).
> > 
> > You wouldn't believe how much const data is not marked as const because
> > we don't have __constinitdata etc. Literally megabytes.
> 
> The gain from marking it const is very little and once any non-const
> __initdata object is added to a compilation unit all other const declarations
> will have to be removed.  Bad tradeoff.

In this case (struct ide_port_info) and probably few others having const
is important (maybe even more important than having __{dev}initdata since
majority of people use CONFIG_HOTPLUG=y) because it allows developers to
catch subtle yet hard to find bugs very early in the development process.

We had a few such cases in IDE - struct ide_port_info _template_ was being
modified because some quirk was needed for one version of the hardware which
was of course incorrect if another version of the hardware was also present
in the system.

Some other potential gains of using const like the better optimized code
or the protection of read-only kernel data are only an extra bonuses. :)

I agree that we need __const{dev}initdata but until then the workaround
that all __{dev}initdata must be const is an acceptable temporary solution
for IDE host drivers.

Thanks,
Bart
