From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET 09/11] implement ata_link
Date: Fri, 12 May 2006 01:30:22 +0900
Message-ID: <11473650221713-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.230]:39563 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751624AbWEKQa3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 12:30:29 -0400
Received: by wr-out-0506.google.com with SMTP id i12so405462wra
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 09:30:28 -0700 (PDT)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org, htejun@gmail.com

Hellooo.

This is part of patchset series described in [T].

This is the first take of implement-ata_link patchset.  This patchset
contains 14 patches which can be categorized as follows.

#01   : prep
#02-03: implement ata_link
#04-06: make parts of libata deal with link instead of port
#07-09: misc link stuff (link init, reset_tries, ata_link_abort())
#10-14: add ap->pm_link[] and update parts of libata to deal with
        multiple links

ata_link abstracts PHY and sits between ata_port and ata_device.  The
following attributes are moved to ata_link from ata_port.

- active command state (active_tag, sactive)
- [hw_]sata_spd_limit
- eh_info and eh_context
- device array

With above and a few extra fields, a link can fully host attached
devices including qc management and EH/hotplug.  This patchset makes
libata ready to handle PM links.

This patchset is against

  upstream (acc696d93dcf993dec123d69d599979e1456ffec)
  + [1] prep-for-new-EH patchset
  + [2] new-EH-framework patchset, take 3
  + [3] new-EH-implementation patchset, take 3
  + [4] merge-irq-pio patchset
  + [5] add-NCQ-support patchset, take 3
  + [6] prep-for-hotplug support, take 2
  + [7] prep-LLDDs-for-hotplug-support, take 1
  + [8] add-hotplug-support, take 2

--
tejun

[T] http://article.gmane.org/gmane.linux.ide/9957
[1] http://article.gmane.org/gmane.linux.ide/9959
[2] http://article.gmane.org/gmane.linux.ide/9984
[3] http://article.gmane.org/gmane.linux.ide/9995
[4] http://article.gmane.org/gmane.linux.ide/10005
[5] http://article.gmane.org/gmane.linux.ide/10011
[6] http://article.gmane.org/gmane.linux.ide/10028
[7] http://article.gmane.org/gmane.linux.ide/10063
[8] http://article.gmane.org/gmane.linux.ide/10073


