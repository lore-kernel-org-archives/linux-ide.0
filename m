From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET] [PATCHSET] new Power Management for libata, take 2
Date: Sat, 24 Jun 2006 20:30:18 +0900
Message-ID: <11511486183271-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.200]:50821 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1752217AbWFXLaI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 24 Jun 2006 07:30:08 -0400
Received: by nz-out-0102.google.com with SMTP id z31so964564nzd
        for <linux-ide@vger.kernel.org>; Sat, 24 Jun 2006 04:30:07 -0700 (PDT)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, lkml@rtr.ca, axboe@suse.de, forrest.zhao@intel.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org, htejun@gmail.com

Hello, all.

This is the second take of new-power-management patchset.  Changes
from the last take[1] are...

* Per-dev PM is now supported.  Now generic device PM layer drives
  whole PM sequence and libata port-wide PM does much less.

* Suspend is now sequential - ie. harddrives hanging off a controller
  are spinned down one after another.  Spinning down is pretty fast
  and this doesn't make much difference.

* Resume is still done asynchronously but it also uses generic PM to
  drive it.

* sata_sil and sata_sil24 are fixed to perform PCI resume before
  reinitializing the controller.

This patchset contains 15 patches.

#01-07 : preparation patches, misc updates & fixes
#08-11 : new core PM implementation
#12-15 : convert LLDs to use new PM

As before, ata_piix, sata_sil and sata_sil24 are converted.  Both mem
and disk sleeps are tested and verifed to work on the following
configurations.

* On P5LD2 + latest BIOS
  - onboard ICH7R in ata_piix mode
  - sil3112 PCI card
  - sil3114 PCI card
  - sil3124 PCI-x card on a PCI slot
  - sil3132 PCI-e card

* On Fujitsu lifebook P7120 (+ PATA enabled + patch for PCI ID)
  - onboard ICH6M in ata_piix mode
  - sil3112 PCMCIA card

As in the last take, most of PM operations are performed by EH and
fully synchronized with all other operations.  Putting to sleep and
waking up should be safe under any circumstances as far as libata is
concerned.

Thanks.

--
tejun

[1] http://article.gmane.org/gmane.linux.ide/11336


