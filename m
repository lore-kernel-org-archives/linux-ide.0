From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET 08/11] add hotplug support, take 2
Date: Fri, 12 May 2006 00:32:06 +0900
Message-ID: <11473615261297-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.227]:60996 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030267AbWEKPcQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 11:32:16 -0400
Received: by wr-out-0506.google.com with SMTP id 55so355916wri
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 08:32:13 -0700 (PDT)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org, htejun@gmail.com

Hi.

This is part of patchset series described in [T].

This is the second take of add-hotplug-support patchset.  Changes from
the last take[L] are

* No ap->hotplug_flags and no atomic bitops helpers.  All are handled
  via dev->dflags and ap->eh_info.  Things are much simpler now.

* Tighter event handling.  Unless a new device is plugged in the
  middle of reset (there's no generic and reliable way to handle
  this), no hotplug event is lost.

* Stronger SCSI synchronization.  There still is a race condition
  during SCSI scan after hotplugging, but the window is really tiny
  and there doesn't seem to be a waterproof way to fix it.  I don't
  think the race will ever get triggered and even if it does the worst
  that can happen is not attaching a SCSI device for a newly detected
  ATA device.  Other than this race condition, everything should be
  watertight.

* Disabled devices are not automatically rescanned on user scan
  request unless the user explicitly requests scan of the device by
  specifying the device ID or using wild card.

* Probing during driver loading and detaching while unloading are all
  handled by hotplug.  There is only one probing/detaching path now.

* Unused ->probe_init, ->probe_reset and all related functions killed.

This patchset is against

  upstream (acc696d93dcf993dec123d69d599979e1456ffec)
  + [1] prep-for-new-EH patchset
  + [2] new-EH-framework patchset, take 3
  + [3] new-EH-implementation patchset, take 3
  + [4] merge-irq-pio patchset
  + [5] add-NCQ-support patchset, take 3
  + [6] prep-for-hotplug support, take 2
  + [7] prep-LLDDs-for-hotplug-support, take 1

--
tejun

[T] http://article.gmane.org/gmane.linux.ide/9957
[L] http://article.gmane.org/gmane.linux.ide/9587
[1] http://article.gmane.org/gmane.linux.ide/9959
[2] http://article.gmane.org/gmane.linux.ide/9984
[3] http://article.gmane.org/gmane.linux.ide/9995
[4] http://article.gmane.org/gmane.linux.ide/10005
[5] http://article.gmane.org/gmane.linux.ide/10011
[6] http://article.gmane.org/gmane.linux.ide/10028
[7] http://article.gmane.org/gmane.linux.ide/10063


