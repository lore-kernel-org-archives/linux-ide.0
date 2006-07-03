From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET] new Power Management for libata, take 4
Date: Mon, 3 Jul 2006 16:07:25 +0900
Message-ID: <11519104451998-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.228]:16876 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750911AbWGCHGu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 3 Jul 2006 03:06:50 -0400
Received: by wr-out-0506.google.com with SMTP id 71so571500wri
        for <linux-ide@vger.kernel.org>; Mon, 03 Jul 2006 00:06:50 -0700 (PDT)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, lkml@rtr.ca, axboe@suse.de, forrest.zhao@intel.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org, htejun@gmail.com

Hello, all.

This is the fourth take of new-power-management patchset.  Changes
from the last take[1] are...

* Patches #1-4 added to implement

  - ATA_EHI_RESUME_LINK, ATA_EHI_NO_AUTOPSY, ATA_EHI_QUIET

  - better debounce timing selection

  These changes allow PM to behave more accurately.  e.g. Resume isn't
  reported or recorded as ATA bus error anymore.  No excessive EH
  messages on suspend and resume...

* move-ata_flush_cache patch dropped

* PM implementation patches slighly updated to use new features
  implemented in #1-4.

This patchset contains 11 patches.

#01-04 : EH/reset improvements
#05-07 : new core PM implementation
#08-11 : convert LLDs to use new PM

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

This patchset is against

  upstream[2]
  + add-ap-pflags [3]
  + fix-ehc_i_action-setting-in-ata_eh_autopsy [4]
  + cosmetic-replace-ap_lock [5]

This tree is also avilable in the following git tree.

  http://htj.dyndns.org/git/?p=libata-tj.git;a=shortlog;h=new-pm
  git://htj.dyndns.org/libata-tj new-pm

Thanks.

--
tejun

[1] http://article.gmane.org/gmane.linux.ide/11684
[2] 2154cfa6ba560401d25f6cc083fe3fb996cbb571
[3] http://article.gmane.org/gmane.linux.ide/11717
[4] http://article.gmane.org/gmane.linux.ide/11801
[5] http://article.gmane.org/gmane.linux.ide/11802


