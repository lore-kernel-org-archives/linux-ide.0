From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET 06/11] prep for hotplug support, take 2
Date: Fri, 12 May 2006 00:02:34 +0900
Message-ID: <11473597542442-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.232]:65058 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751824AbWEKPCl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 11:02:41 -0400
Received: by wr-out-0506.google.com with SMTP id i12so385619wra
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 08:02:40 -0700 (PDT)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org, htejun@gmail.com

Bang-Ga.

This is part of patchset series described in [T].

This is the second take of prep-for-hotplug-support patchset.  Changes
from the last take[L] are

* dev->flags is used for warm plug and synchronized with host_set
  lock.  ata_dev_init() is updated to clear non-persistent part of
  dev->flags while holding host_set lock.

* ap->orig_sata_spd_limit renamed to ap->hw_sata_spd_limit.

* sata_phy_debounce() implemented.  This function will be called
  before performing EH resets to settle devices instead of blind
  delay.  sata_phy_debounce() is superset of the wait used in
  sata_phy_resume() and sata_phy_resume() is converted to use it.

* TF access is made optional.  All probing (including boot probing)
  will be done via hotplug and hotplug probing is implemented such
  that ->tf_read/write() isn't necessary, so now drivers like
  sata_sil24 don't have to fake TF access.  As ->check_[alt]status()
  was embedded too deep, ata_noop_check_status() is added instead of
  making those methods optional.  In the long term, those low level
  methods should be separated from highlevel ops somehow.

* ops->prereset() added.  This function is the counterpart of
  postreset() and called before a series of resets.  This is quite
  similar to ->probe_init() except that it's called for all resets.
  prereset() can determine things like whether it's prepping for boot
  probing or not, and which reset will be performed by testing
  ap->flags and ehi.

* Followup-softreset handling implemented.

* hotplug will completely replace ->probe_init/reset().

This patchset is against

  upstream (acc696d93dcf993dec123d69d599979e1456ffec)
  + [1] prep-for-new-EH patchset
  + [2] new-EH-framework patchset, take 3
  + [3] new-EH-implementation patchset, take 3
  + [4] merge-irq-pio patchset
  + [5] add-NCQ-support patchset, take 3

--
tejun

[T] http://article.gmane.org/gmane.linux.ide/9957
[L] http://article.gmane.org/gmane.linux.ide/9579
[1] http://article.gmane.org/gmane.linux.ide/9959
[2] http://article.gmane.org/gmane.linux.ide/9984
[3] http://article.gmane.org/gmane.linux.ide/9995
[4] http://article.gmane.org/gmane.linux.ide/10005
[5] http://article.gmane.org/gmane.linux.ide/10011


