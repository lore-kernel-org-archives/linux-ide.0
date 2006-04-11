From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET 9/9] add hotplug support
Date: Tue, 11 Apr 2006 23:14:06 +0900
Message-ID: <1144764846705-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.196]:19875 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751288AbWDKOOJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 10:14:09 -0400
Received: by zproxy.gmail.com with SMTP id o37so1102564nzf
        for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 07:14:09 -0700 (PDT)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org, htejun@gmail.com

Hellooooo, all.

Finally, the last one.  This is the first take of add-hotplug-support
patchset.  This patchset includes 13 patches.

#01-04	implement hotplug framework
#05-07	implement warm plug (SCSI scan/delete callbacks)
#08-10	hook and activate hotplug
#11-13	add LLDD hotplug supports (PHY status change notifications)

Hotplugging is implemented as an integral part of EH.  A new EH helper
ata_eh_hotplug() is defined which should be called after all regular
EH is done.  LLDDs have to do very little to support hotplug.

Warm unplug/plug comes at almost no cost for LLDDs implementing new EH
- adding a call to ata_eh_hotplug() at the end of ->error_handler is
enough (even this is unnecessary if it's using bmdma error_handler).
e.g. ata_piix isn't changed by hotplug patchsets at all but still
supports warm plugging (even PATA warm plugging works although it's
electronically unsafe).

To support full hot unplug/plug, all a LLDD has to do are enabling PHY
status changed interrupt and, when PHY RDY status changes, call
ata_schedule_probe() and schedule EH.  ahci, sata_sil and sata_sil24
are converted this way and hotplugging works perfectly for those
drivers.

One of the design goals was making hotplug support and the driver
resillient.  Hardware might get stuck but the driver should NEVER oops
or malfunction no matter what the user does.  As far as libata is
conerned, all are allowed - yanking and plugging at any time,
requesting warm plug or unplug under heavy IO or during EH.  So, if
you have some time, torture libata, be pervert and break it.  If you
succeed, please let me know.  I'll try to reproduce your perverseness
and fix the breakage.

Some hardware gotchas I've found...

* ICH7 in piix mode has troubles seeing new SATA devices if the port
  was not occupied on boot.

* sil3124 locks up really hard if it's requested to scan the bus
  (which triggers immediate ATA_EH_FREEZE) while commands to the port
  are in progress.  Port reset cannot resume the port.  Power cycling
  works.  Maybe host reset needed?

This patchset is against

  upstream (c2a6585296009379e0f4eff39cdcb108b457ebf2)
  + [1] misc-reset-updates patchset (repost)
  + [2] implement-and-use-ata_wait_register patchset (repost)
  + [3] misc-ata_bus_probe-updates patchset
  + [4] fixes-errata-workaround-and-reset-updates patchset, take 2
  + [5] implement-scsi_eh_schedule patchset
  + [6] fix-scsi_kill_request-busy-count-handling patch
  + [7] new-EH-framework patchset, take 2
  + [8] new-EH-implementation patchset, take 2
  + [9] add-NCQ-support patchset, take 2
  + [10] prep-for-hotplug-support patchset

Thanks.

--
tejun

[1] http://article.gmane.org/gmane.linux.ide/9495
[2] http://article.gmane.org/gmane.linux.ide/9499
[3] http://article.gmane.org/gmane.linux.ide/9506
[4] http://article.gmane.org/gmane.linux.ide/9516
[5] http://article.gmane.org/gmane.linux.ide/9290
[6] http://article.gmane.org/gmane.linux.ide/9487
[7] http://article.gmane.org/gmane.linux.ide/9524
[8] http://article.gmane.org/gmane.linux.ide/9540
[9] http://article.gmane.org/gmane.linux.ide/9555
[10] http://article.gmane.org/gmane.linux.ide/9579


