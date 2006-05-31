From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET 03/03] add hotplug support, take 5
Date: Wed, 31 May 2006 20:25:44 +0900
Message-ID: <11490747443727-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.229]:16624 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964994AbWEaLZx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 31 May 2006 07:25:53 -0400
Received: by wr-out-0506.google.com with SMTP id 37so220499wra
        for <linux-ide@vger.kernel.org>; Wed, 31 May 2006 04:25:52 -0700 (PDT)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org, htejun@gmail.com

Hello,

This is part of patchset series described in [T].

This is the fifth take of add-hotplug-support patchset.  Changes from
the last take[L] are.

* ata_scsi_hotplug() requeue condition check has been updated such
  that SCSI devices are guaranteed to be attached to ATA devices.  No
  race window anymore.

* boot probing reimplemented using ata_port_wait_eh().

* ata_port_detach() reimplemented using ata_port_wait_eh().  New
  implementation is much more robust and survives PCI unplugging under
  all circumstances.  EH part of unloading is also reimplemented in
  simpler and more robust way.

* UNLOADING check added to ata_scsi_hotplug().  hotplug task flushing
  is reliable now.

* s/FIS34/D2H FIS/g

One thing to note about unload handling is that, if EH is scheduled
after ata_port_detach() is complete but before SCSI host is actually
released, it can oops accessing ap->host_set.  The problem is that, as
SCSI doesn't supply host release callback, host_set is released before
all ports are released.

However, this condition is unlikely to occur - to trigger the bug,
either the driver has to schedule EH while frozen during that window,
or the user has to hold reference to scan/delete node and issue warm
plug request, again, during the window.

This patchset is against

  upstream (ef2824073fba9def3cf122e89cc485f66dd71f70)
  + [1] set-PIO-0-after-successful-EH-reset
  + [2] shift-host-flag-constants
  + [3] implement-ata_eh_wait
  + [4] prep-for-hotplug-support patchset
  + [5] prep-LLDDs-for-hotplug-support patchset

Thanks.

--
tejun

[T] http://article.gmane.org/gmane.linux.ide/11012
[L] http://article.gmane.org/gmane.linux.ide/10892
[1] http://article.gmane.org/gmane.linux.ide/10890
[2] http://article.gmane.org/gmane.linux.ide/11010
[3] http://article.gmane.org/gmane.linux.ide/11011
[4] http://article.gmane.org/gmane.linux.ide/11014
[5] http://article.gmane.org/gmane.linux.ide/11028


