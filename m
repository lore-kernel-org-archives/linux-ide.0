From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET 01/03] prep for hotplug support, take 5
Date: Wed, 31 May 2006 20:05:40 +0900
Message-ID: <1149073540186-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.230]:21727 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964964AbWEaLFs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 31 May 2006 07:05:48 -0400
Received: by wr-out-0506.google.com with SMTP id 37so216589wra
        for <linux-ide@vger.kernel.org>; Wed, 31 May 2006 04:05:48 -0700 (PDT)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org, htejun@gmail.com

Hello,

This is part of patchset series described in [T].

This is the fourth take of add-hotplug-support patchset.  Changes from
the last take[L] are.

* ata_scsi_wq renamed to ata_aux_wq

* msleep(200) added between phy wakeup and the first SStatus polling.

* SLAVE_POSS check dropped from ata_find_dev()

* s/FIS34/D2H FIS/g

This patchset is against

  upstream (ef2824073fba9def3cf122e89cc485f66dd71f70)
  + [1] set-PIO-0-after-successful-EH-reset
  + [2] shift-host-flag-constants
  + [3] implement-ata_eh_wait

Thanks.

--
tejun

[T] http://article.gmane.org/gmane.linux.ide/11012
[L] http://article.gmane.org/gmane.linux.ide/10892
[1] http://article.gmane.org/gmane.linux.ide/10890
[2] http://article.gmane.org/gmane.linux.ide/11010
[3] http://article.gmane.org/gmane.linux.ide/11011


