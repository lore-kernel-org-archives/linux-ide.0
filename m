From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: fix broken Kconfig setup
Date: Mon, 17 Oct 2005 12:21:18 -0400
Message-ID: <4353CF7E.1090404@pobox.com>
References: <20051017044606.GA1266@havoc.gtf.org> <Pine.LNX.4.64.0510170754500.23590@g5.osdl.org> <4353C42A.3000005@pobox.com> <Pine.LNX.4.64.0510170848180.23590@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751430AbVJQQVY@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0510170848180.23590@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, davej@redhat.com
List-Id: linux-ide@vger.kernel.org

Linus Torvalds wrote:
> 
> On Mon, 17 Oct 2005, Jeff Garzik wrote:
> 
>>CONFIG_SCSI_SATA does two things:
>>* Enables/disables the display of the SATA driver menu.
>>* Enables/disables the compiled-in PCI quirk.
>>
>>Both of these are boolean, and have absolutely nothing to do with modules.
> 
> 
> You ignore the biggest thing it does:
>  - it is the depends-on for the actual low-level drivers

That dependency for each driver exists solely for menu display purposes. 
  There is no code dependency.


> IOW, the _biggest_ reason for it existing at all is in fact _not_ a 
> boolean. It very much is a tristate. When it's "m" the SATA driver menu 
> _should_ show.

The only operational difference between CONFIG_SCSI_SATA=y and 
CONFIG_SCSI_SATA=m is that CONFIG_SCSI_SATA=m restricts the drivers from 
being compiled in -- a silly and needless restriction.

The elimination of 'y' as an option should propagate from CONFIG_SCSI.


> Also, as already mentioned, that compiled-in PCI quirk is _wrong_. The 
> fact that somebody asked for SCSI_SATA should not change Intel settings. 
> Maybe somebody hass a separate SATA card, and has enabled support for 
> _that_, but wants the on-board thing to work with legacy drivers? The way 
> he'd have done that is to enable SCSI_SATA, but _not_ enable 
> SCSI_ATA_PIIX.

Agreed this is a _theoretical_ problem.

Never heard of this being an issue in the real world, because the IDE 
driver locks up on a lot of the Intel hardware in question.  That was 
one of the original reason for the split PATA/SATA driver configuration, 
for this wonky combined mode.


> Btw, if you want to really hide things (and not just gray them out) I 
> think you should do a
> 
> 	menu "SATA low-level drivers"
> 		depends on SCSI_SATA != n
> 
> 	..
> 
> 	endmenu
> 
> around the SATA drivers.

No preference whether its hidden or greyed out.

CONFIG_SCSI_SATA is just a switch to enable listing a set of drivers, 
just like CONFIG_NET_PCI (which I note is a bool), CONFIG_NET_ISA (a 
bool), ...


>>Because it's fundamental a boolean, and has -zero- to do with modules.
>>Encouraging people to think otherwise will just lead to more confusion.
> 
> 
> I disagree. It is no more fundamentally boolean than anything else that 
> controls modules. It's a tristate, because it chooses between the 
> low-level drivers being tristate.
> 
> I also think that the _only_ thing your ugly patch fixes was totally wrong 
> for wholly other reasons anyway. If that quirk is needed, it really looks 
> like it should be
> 
> 	#if defined(CONFIG_SCSI_SATA_PIIX) || defined(CONFIG_SCSI_SATA_PIIX_MODULE)
> 	..
> 	#endif

If IDE is compiled in, IDE SATA option is not enabled, and ata_piix or 
ahci are used.

Do we really want to do

	#if defined (CONFIG_IDE_GENERIC) &&
	       !defined(CONFIG_IDE_BLK_DEV_SATA) &&
	    (
	       defined(CONFIG_SCSI_SATA_PIIX) ||
	       defined(CONFIG_SCSI_SATA_PIIX_MODULE) ||
	       defined(CONFIG_SCSI_SATA_AHCI ||
	       defined(CONFIG_SCSI_SATA_AHCI_MODULE)
	    )

?

At that point it seems easier to solve at the Kconfig level, perhaps 
defining CONFIG_SATA_INTEL_COMBINED at the end.  And then with the quirk 
issue out of the way, CONFIG_SCSI_SATA becomes purely a boolean 
enable/disable-this-menu switch.

	Jeff
