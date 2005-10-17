From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] libata: fix broken Kconfig setup
Date: Mon, 17 Oct 2005 08:58:40 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510170848180.23590@g5.osdl.org>
References: <20051017044606.GA1266@havoc.gtf.org> <Pine.LNX.4.64.0510170754500.23590@g5.osdl.org>
 <4353C42A.3000005@pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751410AbVJQP7G@vger.kernel.org>
In-Reply-To: <4353C42A.3000005@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, davej@redhat.com
List-Id: linux-ide@vger.kernel.org



On Mon, 17 Oct 2005, Jeff Garzik wrote:
> 
> CONFIG_SCSI_SATA does two things:
> * Enables/disables the display of the SATA driver menu.
> * Enables/disables the compiled-in PCI quirk.
> 
> Both of these are boolean, and have absolutely nothing to do with modules.

You ignore the biggest thing it does:
 - it is the depends-on for the actual low-level drivers

IOW, the _biggest_ reason for it existing at all is in fact _not_ a 
boolean. It very much is a tristate. When it's "m" the SATA driver menu 
_should_ show.

Also, as already mentioned, that compiled-in PCI quirk is _wrong_. The 
fact that somebody asked for SCSI_SATA should not change Intel settings. 
Maybe somebody hass a separate SATA card, and has enabled support for 
_that_, but wants the on-board thing to work with legacy drivers? The way 
he'd have done that is to enable SCSI_SATA, but _not_ enable 
SCSI_ATA_PIIX.

So regardless, that PCI quirk is wrong wrong _wrong_.

Btw, if you want to really hide things (and not just gray them out) I 
think you should do a

	menu "SATA low-level drivers"
		depends on SCSI_SATA != n

	..

	endmenu

around the SATA drivers.

> Because it's fundamental a boolean, and has -zero- to do with modules.
> Encouraging people to think otherwise will just lead to more confusion.

I disagree. It is no more fundamentally boolean than anything else that 
controls modules. It's a tristate, because it chooses between the 
low-level drivers being tristate.

I also think that the _only_ thing your ugly patch fixes was totally wrong 
for wholly other reasons anyway. If that quirk is needed, it really looks 
like it should be

	#if defined(CONFIG_SCSI_SATA_PIIX) || defined(CONFIG_SCSI_SATA_PIIX_MODULE)
	..
	#endif

or something like that. It has _nothing_ to do with whether the user has 
enabled SATA or not.

		Linus
