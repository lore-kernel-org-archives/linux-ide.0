From: Tejun Heo <htejun@gmail.com>
Subject: [RFT][PATCHSET] hotplug polling
Date: Tue, 4 Jul 2006 23:16:17 +0900
Message-ID: <11520225771424-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0102.google.com ([66.249.82.200]:50392 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932254AbWGDOPm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Jul 2006 10:15:42 -0400
Received: by wx-out-0102.google.com with SMTP id i28so654870wxd
        for <linux-ide@vger.kernel.org>; Tue, 04 Jul 2006 07:15:41 -0700 (PDT)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, lkml@rtr.ca, axboe@suse.de, forrest.zhao@intel.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org, htejun@gmail.com

Hello, all.

This is the first take of hotplug polling patchset.  As the name
implies, this patchset implements hotplug by polling.

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
* sata_via
* sata_vsc [untested]

There are three variants of sata_std_poll() - regular, port-exclusive
and host_set-exclusive.  port-exclusive skips polling if command is in
progress to the port.  host_set-exclusive skips polling if one or more
commands are in progress to any port in the host_set.  This is because
some controllers lock up if SCR regs are accessed while command is in
progress.

Well, the port-exclusive case is dumb but understandable; however,
sata_via (vt8237) takes it to the next level and may lock up if any
available port in the host_set is active when a SCR reg is accessed,
so it needs host_set-exclusive version.  It took me two days of
boredom to figure out that things can be made THAT dumb.  Their new
AHCI controller also seems to require host_set-wide EH ops to recover
from errors.  Well, I guess they consider requiring host_set-wide ops
a feature or something.  :-( Note that this means that the current
libata EH may lock up the whole machine on vt8237 if EH occurs at a
bad time.

Currently, all 'untested' LLDs are using the regular version and some
of them might need to use a dumber version.  So, we need some testing
here.

This patchset is against

  upstream (2154cfa6ba560401d25f6cc083fe3fb996cbb571)
  + add-ap-pflags [1]
  + fix-ehc_i_action-setting-in-ata_eh_autopsy [2]
  + cosmetic-replace-ap_lock [3]
  + new PM patchset [4]

This patchset is also available in the following git tree.

  http://htj.dyndns.org/git/?p=libata-tj.git;a=shortlog;h=hp-poll
  git://htj.dyndns.org/libata-tj hp-poll

Thanks.

--
tejun

[1] http://article.gmane.org/gmane.linux.ide/11717
[2] http://article.gmane.org/gmane.linux.ide/11801
[3] http://article.gmane.org/gmane.linux.ide/11802
[4] http://article.gmane.org/gmane.linux.ide/11816


