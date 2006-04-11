From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET 6/9] new EH implementation, take 2
Date: Tue, 11 Apr 2006 22:48:21 +0900
Message-ID: <11447633013561-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.229]:11678 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750930AbWDKNsX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 09:48:23 -0400
Received: by wproxy.gmail.com with SMTP id i11so926519wra
        for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 06:48:23 -0700 (PDT)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org, htejun@gmail.com

Hello, all.

This is the second take of new-EH-implementation patchset.  Changes
from the last take[L] are...

* !tries[] and ata_set_mode() failure handlings in ata_eh_revive() are
  updated in the same way ata_bus_probe() is updated.

* ata_eh_analyze_serror() is updated such that it doesn't depend on
  existence of qc.  Result from analyze_serror() will be used for hot
  plug event detection.

* better wait logic before the first reset in ata_eh_revive().  The
  wait logic now lives in a separate function
  ata_eh_wait_before_reset().

* ata_eh_revive() skips EH reset if possible

* ata_eh_revive() skips revalidation if SATA PHY reports no device is
  attached to the port.

* ahci error_handler grabs host_set lock when accessing pp->eh_* fields

* ahci_host_intr is converted to return void

* ahci autopsy is performed before determine_qc such that the result
  can be used for NCQ determine_qc later.

* sata_sil24 is converted to new EH

* sata_sil postreset now calls ata_std_postreset() before reenabling
  interrupts

This patchset is against

  upstream (c2a6585296009379e0f4eff39cdcb108b457ebf2)
  + [1] misc-reset-updates patchset (repost)
  + [2] implement-and-use-ata_wait_register patchset (repost)
  + [3] misc-ata_bus_probe-updates patchset
  + [4] fixes-errata-workaround-and-reset-updates patchset, take 2
  + [5] implement-scsi_eh_schedule patchset
  + [6] fix-scsi_kill_request-busy-count handling patch
  + [7] new-EH-framework patchset, take 2

Thanks.

--
tejun

[L] http://article.gmane.org/gmane.linux.ide/9322
[1] http://article.gmane.org/gmane.linux.ide/9495
[2] http://article.gmane.org/gmane.linux.ide/9499
[3] http://article.gmane.org/gmane.linux.ide/9506
[4] http://article.gmane.org/gmane.linux.ide/9516
[5] http://article.gmane.org/gmane.linux.ide/9290
[6] http://article.gmane.org/gmane.linux.ide/9487
[7] http://article.gmane.org/gmane.linux.ide/9524


