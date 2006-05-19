From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET 03/03] add hotplug support, take 3
Date: Sat, 20 May 2006 00:48:26 +0900
Message-ID: <11480537063293-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.226]:42918 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932379AbWESPse (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 19 May 2006 11:48:34 -0400
Received: by wr-out-0506.google.com with SMTP id 50so180509wri
        for <linux-ide@vger.kernel.org>; Fri, 19 May 2006 08:48:34 -0700 (PDT)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org, htejun@gmail.com

Hello,

This is part of patchset series described in [T].

This is the third take of add-hotplug-support patchset.  Changes from
the last take[L] are

* Hotplug event is marked with ata_ehi_hotplugged() instead of
  directly setting flags.  The helper also takes care of timestamping
  the event such that spinup waiting time can be calculated.  So,
  LLDDs are required to call ata_ehi_hotplugged() as soon as possible
  once hotplug event is detected.

* ahci is changed to wait for spinup explicitly.  After spinup wait is
  complete, SRST is used to probe the new device.

* ahci hardreset() now clears TF rx area prior to issuing COMRESET to
  avoid finishing prematurely due to the existing TF value.

* sata_sil is changed to issue hardreset after hotplug event.
  COMRESET clears TF on these controllers and make the controllers
  wait for the first D2H reliably.

* sata_sil24 is changed to wait for spinup explicitly.  After spinup
  wait is complete, SRST is used to probe the new device.

This patchset is against

  upstream (8d4ee71ff6de5255ebfdf44fb83419d27bd06368)
  + enforce-default-EH-actions patch [1]
  + scsi_implement_eh-patch [2]
  + prep-for-hotplug-support patchset [3]
  + prep-LLDDs-for-hotplug-support patchset [4]

Thanks.

--
tejun

[T] http://article.gmane.org/gmane.linux.ide/10530
[L] http://article.gmane.org/gmane.linux.ide/10063
[1] http://article.gmane.org/gmane.linux.ide/10317
[2] http://article.gmane.org/gmane.linux.ide/10529
[3] http://article.gmane.org/gmane.linux.ide/10546
[4] http://article.gmane.org/gmane.linux.ide/10573


