From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET 02/03] prep LLDDs for hotplug support, take 3
Date: Mon, 29 May 2006 15:34:41 +0900
Message-ID: <11488844811684-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.239]:53437 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751270AbWE2Ges (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 May 2006 02:34:48 -0400
Received: by wr-out-0506.google.com with SMTP id i7so818693wra
        for <linux-ide@vger.kernel.org>; Sun, 28 May 2006 23:34:47 -0700 (PDT)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org, htejun@gmail.com

Hello,

This is This is part of patchset series described in [T].

This is the third take of prep-LLDDs-for-hotplug-support patchset.
Changes from the last take[L] are.

* TF access is mandatory, sata_sil24()-tf-optional patch has been
  dropped.  sil24_hardreset() update is separated into
  update-sil24_hardreset() patch.

* sata_sil now calls ata_bmdma_irq_clear() directly instead of calling
  ops->irq_clear()

* sil_interrupt() now uses spin_lock/unlock_irq()

This patchset is against

  upstream (ef2824073fba9def3cf122e89cc485f66dd71f70)
  + [1] set-PIO-0-after-successful-EH-reset
  + [2] prep-for-hotplug-support patchset

Thanks.

--
tejun

[T] http://article.gmane.org/gmane.linux.ide/10891
[L] http://article.gmane.org/gmane.linux.ide/10573
[1] http://article.gmane.org/gmane.linux.ide/10890
[2] http://article.gmane.org/gmane.linux.ide/10892


