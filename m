From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: fix broken Kconfig setup
Date: Mon, 17 Oct 2005 11:32:58 -0400
Message-ID: <4353C42A.3000005@pobox.com>
References: <20051017044606.GA1266@havoc.gtf.org> <Pine.LNX.4.64.0510170754500.23590@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751399AbVJQPdE@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0510170754500.23590@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, davej@redhat.com
List-Id: linux-ide@vger.kernel.org

Linus Torvalds wrote:
> 
> On Mon, 17 Oct 2005, Jeff Garzik wrote:
> 
>>CONFIG_SCSI_SATA is truly a boolean option, not a tristate.
>>Since the Kconfig dependencies are insufficient to describe this (2.4
>>had dep_mbool), we need to resort to 'if'.
> 
> 
> Two problems:
> 
>  - this is ugly as hell
> 
>    First, you change SCSI_SATA to be boolean, then you change the 
>    depends-on to be "if". Which makes no sense. Once SCSI_SATA is a 
>    boolean, then the "depends on" works fine, since SCSI_SATA can no 
>    longer be "m" anyway (ie your comment about "dep_mbool" doesn't make 
>    sense).
> 
>    Second, if you want "dep_mbool", then you can have dep_mbool in Kconfig 
>    too. Just do
> 
> 	depends on (XYZ != n)
> 
>    which gets you what you want (ie if XYZ is "m", then the inequality 
>    will be "y")
> 
>    So you might as well have just done something like
> 
> 	 config SCSI_SATA
> 	-       tristate "Serial ATA (SATA) support"
> 	-       depends on SCSI
> 	+       bool "Serial ATA (SATA) support"
> 	+       depends on SCSI != n
> 
>    and then just added SCSI to the "depends on" lines to get the "m" 
>    config. No "if" needed.
> 
>  - anything that depends on a module had better only be _inside_ that 
>    module. Ie the "dep_mbool" kind of behaviour should _not_ affect 
>    anything outside the module. The reason? Maybe you build the module 
>    _later_, and maybe you don't ever load it.
> 
>    So it appears that your dependence on quirk_intel_ide_combined() is 
>    fundamentally broken for the "m" case _anyway_.

CONFIG_SCSI_SATA does two things:
* Enables/disables the display of the SATA driver menu.
* Enables/disables the compiled-in PCI quirk.

Both of these are boolean, and have absolutely nothing to do with modules.

The original problem that caused me to merge the problematic patch (my 
fault for bad merge) was that Kconfig wouldn't allow SATA drivers to be 
built as modules if you did
	bool SCSI_SATA depends on SCSI
	tristate SCSI_SATA_driver depends on SCSI_SATA

That's why I used an 'if' in my patch.  I suppose we could split it into 
two Kconfig options, one for the menu (CONFIG_SCSI_SATA) using 'if', and 
one specifically for the PCI quirk.  Such a split would make it obvious 
that CONFIG_SCSI_SATA controls display of a menu, and nothing more.

Comments?

The entire situation is a hack, because we're fighting the 
always-built-in IDE driver for control of the hardware.  IDE driver 
picks up the PATA+SATA device even though it isn't listed in 
drivers/ide/pci/piix.c PCI table, because it blindly probes at the IDE 
ports after exhausting other options.


> Anyway, the second thing means that the whole configuration is somewhat 
> broken, but on the whole, why not this _much_ more trivial patch?

Because it's fundamental a boolean, and has -zero- to do with modules. 
Encouraging people to think otherwise will just lead to more confusion.

	Jeff
