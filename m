From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET] new Power Management for libata
Date: Tue, 13 Jun 2006 00:50:28 +0900
Message-ID: <11501274284082-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.203]:2386 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1752079AbWFLPuf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 12 Jun 2006 11:50:35 -0400
Received: by nz-out-0102.google.com with SMTP id s18so1663632nze
        for <linux-ide@vger.kernel.org>; Mon, 12 Jun 2006 08:50:35 -0700 (PDT)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, lkml@rtr.ca, axboe@suse.de, forrest.zhao@intel.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org, htejun@gmail.com

Hello, all.

This patchset implements new Power Management for libata.  Currently,
only controller-wide suspend and resume are supported.  No per-device
power management yet.  Both memsleep and disksleep work on supported
controllers.

All PM operations are performed by EH and thus fully synchronized w/
EH.  Suspend/resume operations should be safe under all circumstances
as long as libata is concerned.  Attaching/detaching/exchanging
devices while sleeping is allowed and handled correctly.

ata_piix, sata_sil and sata_sil24 are updated to use new PM.  PM is
tested on the following machines.

* ASUS P5LD2: sky2 disabled as it oopses on PM

	O ICH7R in piix mode (advanced/compatible)
	O sil3112 PCI card
	O sil3114 PCI card
	O sil3124 PCI-x card on PCI slot
	X sil3132 failed probably due to PCI-e PM problem

* Fujitsu lifebook P7120: enabled ATA_ENABLE_PATA and added entry for
  0x266f in ata_piix pci table.  Net console makes resume from
  memsleep fail.

	O ICH6M in piix mode
	O sil3112 PCMCIA card

This patchset contains 10 patches.

#01-04	prep for new PM
#05-06	implement new PM
#07-10	update LLDs

This patchset is against

     upstream (aeb2ecd6096182cc080d37679080c0f088dcd4a4)
     + [1] kill-ATA_FLAG_SRST patch
     + [2] shift-ATA_FLAG_-bits patch

Jens, Mark, can you guys please test if this patch works on your
notebooks?  Note that AHCI isn't updated yet.

Zhao, can you port your AHCI PM stuff over this?  This should solve
the problem you talked about in the other mail.  Recent changes update
ahci such that it listens to more PHY events for hotplug and that
causes EH to kick in after resuming.  The original PM implementation
didn't synchronize w/ EH and thus caused problems.

This patchset is for review only.

Thanks.

--
tejun

[1] http://marc.theaimsgroup.com/?l=linux-ide&m=115012501502940&w=2
[2] http://marc.theaimsgroup.com/?l=linux-ide&m=115012349728574&w=2


