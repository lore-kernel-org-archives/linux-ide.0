From: Tejun Heo <htejun@gmail.com>
Subject: [RFT][PATCHSET] hotplug polling, take 2
Date: Wed, 5 Jul 2006 15:06:18 +0900
Message-ID: <11520795783649-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.233]:9602 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750743AbWGEGFh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 5 Jul 2006 02:05:37 -0400
Received: by wr-out-0506.google.com with SMTP id 69so871234wra
        for <linux-ide@vger.kernel.org>; Tue, 04 Jul 2006 23:05:36 -0700 (PDT)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, lkml@rtr.ca, axboe@suse.de, forrest.zhao@intel.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org, htejun@gmail.com

Hello, all.

This is the second take of hotplug polling patchset.  As the name
implies, this patchset implements hotplug by polling.  Changes from
the last take[1] are.

* vt8237 randomly locks up on SCR access and hp-poll support is
  dropped.

* port/host_set-excl std callbacks are removed.

libata core layer implements hp-poll infrastructure.  It interacts
with LLDs with three callbacks - hp_poll_activate(),
hp_poll_deactivate() and hp_poll().  libata core layer is responsible
for activating and deactivating at the right time, invoking the poll
callback periodically while activated, and generate hotplug event when
poll callback indicates something has happened.

hp-poll is used for the following cases.

* To detect hotplug events on frozen ports after reset fails such that
  replacing or replugging the failing device make libata automatically
  retry the port.

* To detect hotplug events on LLDs without hotplug interrupt.

The following drivers are converted to use hp-poll on failed ports.

* ahci
* sata_nv (nf2 and ck804 only) [untested]
* sata_sil
* sata_sil24

The following drivers are converted to use hp-poll for hotplug

* sata_nv (generic) [untested]
* sata_sis [untested]
* sata_svw [untested]
* sata_uli [untested]
* sata_via [SCR access broken, not supported]
* sata_vsc [untested]

vt8237 randomly locks up on SCR access and thus support is dropped.
And all other untested drivers need testing.

This patchset is against

  upstream (2154cfa6ba560401d25f6cc083fe3fb996cbb571)
  + add-ap-pflags [2]
  + fix-ehc_i_action-setting-in-ata_eh_autopsy [3]
  + cosmetic-replace-ap_lock [4]
  + new PM patchset [5]

This patchset is also available in the following git tree.

  http://htj.dyndns.org/git/?p=libata-tj.git;a=shortlog;h=hp-poll
  git://htj.dyndns.org/libata-tj hp-poll

Thanks.

--
tejun

[1] http://article.gmane.org/gmane.linux.ide/11827
[2] http://article.gmane.org/gmane.linux.ide/11717
[3] http://article.gmane.org/gmane.linux.ide/11801
[4] http://article.gmane.org/gmane.linux.ide/11802
[5] http://article.gmane.org/gmane.linux.ide/11816


