From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET] new Power Management for libata, take 3
Date: Wed, 28 Jun 2006 15:23:04 +0900
Message-ID: <11514757842728-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.230]:16818 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030442AbWF1GWr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 28 Jun 2006 02:22:47 -0400
Received: by wr-out-0506.google.com with SMTP id i24so346494wra
        for <linux-ide@vger.kernel.org>; Tue, 27 Jun 2006 23:22:46 -0700 (PDT)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, lkml@rtr.ca, axboe@suse.de, forrest.zhao@intel.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org, htejun@gmail.com

Hello, all.

This is the third take of new-power-management patchset.  Changes from
the last take[1] are...

* Patches #1-7 are merged to #upstream and thus dropped from this
  patchset.

* libata-reimplement-controller-wide-PM patch has been reimplemented
  to include support for ap->port_suspend() and ap->port_resume().

This patchset contains 8 patches.

#01-04 : new core PM implementation
#05-08 : convert LLDs to use new PM

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

[1] http://article.gmane.org/gmane.linux.ide/11570


