From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET 1/3] implement ata_link, take 2
Date: Sat, 8 Jul 2006 14:45:35 +0900
Message-ID: <11523375353473-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.228]:41839 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932516AbWGHFoo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 8 Jul 2006 01:44:44 -0400
Received: by wr-out-0506.google.com with SMTP id 36so1484119wra
        for <linux-ide@vger.kernel.org>; Fri, 07 Jul 2006 22:44:43 -0700 (PDT)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, lkml@rtr.ca, forrest.zhao@intel.com, linux-ide@vger.kernel.org, htejun@gmail.com

Hello, all.

This is part of patchset series described in [T].

This is the second take of implement-ata_link patchset.  This patchset
contains 17 patches which can be categorized as follows.

#01-02: prep
#03-04: implement ata_link
#05-08: make libata deal with link instead of port
#09-11: misc link stuff (link init, reset_tries, ata_link_abort())
#12-17: add ap->pmp_link[] and update libata to deal with multiple
	links

ata_link abstracts PHY and sits between ata_port and ata_device.  The
following attributes are moved to ata_link from ata_port.

- active command state (active_tag, sactive)
- [hw_]sata_spd_limit
- eh_info and eh_context
- device array

With above and a few extra fields, a link can fully host attached
devices including qc management and EH/hotplug.  This patchset makes
libata ready to handle PM links.

Changes from the last take[L] are.

* updated to fit new #upstream
* ata_eh_handle_dev_fail() is separated out from ata_eh_recover() to
  ease making EH batch later.
* Link resume handling udpated.
* Power Management is linkified.

This patchset is against

  upstream (309bade002e9226781c2d7a015340d0089e399b5)
  + [1] hp-poll patchset, take #2

Thanks.

--
tejun

[T] http://article.gmane.org/gmane.linux.ide/11927
[L] http://article.gmane.org/gmane.linux.ide/10106
[1] http://article.gmane.org/gmane.linux.ide/11862


