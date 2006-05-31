From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET 02/03] prep LLDDs for hotplug support, take 4
Date: Wed, 31 May 2006 20:11:27 +0900
Message-ID: <11490738873808-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0102.google.com ([66.249.82.193]:27942 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964979AbWEaLLd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 31 May 2006 07:11:33 -0400
Received: by wx-out-0102.google.com with SMTP id h27so3993wxd
        for <linux-ide@vger.kernel.org>; Wed, 31 May 2006 04:11:33 -0700 (PDT)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org, htejun@gmail.com

Hello,

This is This is part of patchset series described in [T].

This is the fourth take of prep-LLDDs-for-hotplug-support patchset.
Changes from the last take[L] are.

* spin_[un]lock_irq() fixed to spin_[un]lock() in sil_interrupt()

* TODO comment dropped from sil_interrupt()

This patchset is against

  upstream (ef2824073fba9def3cf122e89cc485f66dd71f70)
  + [1] set-PIO-0-after-successful-EH-reset
  + [2] shift-host-flag-constants
  + [3] implement-ata_eh_wait
  + [4] prep-for-hotplug-support patchset

Thanks.

--
tejun

[T] http://article.gmane.org/gmane.linux.ide/11012
[L] http://article.gmane.org/gmane.linux.ide/10892
[1] http://article.gmane.org/gmane.linux.ide/10890
[2] http://article.gmane.org/gmane.linux.ide/11010
[3] http://article.gmane.org/gmane.linux.ide/11011
[4] http://article.gmane.org/gmane.linux.ide/11014


