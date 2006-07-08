From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET 3/3] implement PMP support, take 2
Date: Sat, 8 Jul 2006 14:58:07 +0900
Message-ID: <11523382873130-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0102.google.com ([66.249.82.204]:43740 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964799AbWGHF5Q (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 8 Jul 2006 01:57:16 -0400
Received: by wx-out-0102.google.com with SMTP id t10so1206438wxc
        for <linux-ide@vger.kernel.org>; Fri, 07 Jul 2006 22:57:15 -0700 (PDT)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, lkml@rtr.ca, forrest.zhao@intel.com, linux-ide@vger.kernel.org, htejun@gmail.com

Hello,

This is part of patchset series described in [T].

This is the second take of libata-pmp patchset.  This patchset
contains 12 patches and implements PMP support.

#01-05: implement libata PMP support
#06-12: implement sata_sil24 PMP support

ATM, the only sata_sil24 supports PMP and only sil3726 and sil4726
PMPs are tested.

Changes from the last take[L] are.

* s/pm/pmp/g
* ATA_LFLAG_DISABLED handling (SError.N hotplug event detection for
  disabled ports)
* Power Management support - libata suspends and resumes properly with
  PMP attached.
* Batched EH - much shorter EH time on multiple device failure
* Updated to fit new #upstream

This patchset is against

  upstream (309bade002e9226781c2d7a015340d0089e399b5)
  + [1] hp-poll patchset, take 2
  + [2] libata-link patchset, take 2
  + [3] libata-pmp-prep patchset, take 2

Thanks.

--
tejun

[T] http://article.gmane.org/gmane.linux.ide/11927
[L] http://article.gmane.org/gmane.linux.ide/10122
[1] http://article.gmane.org/gmane.linux.ide/11862
[2] http://article.gmane.org/gmane.linux.ide/11928
[3] http://article.gmane.org/gmane.linux.ide/11946


