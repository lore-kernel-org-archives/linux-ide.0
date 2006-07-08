From: Tejun Heo <htejun@gmail.com>
Subject: [ANNOUNCE] new revision of PMP support patchsets are about to be posted
Date: Sat, 8 Jul 2006 14:35:17 +0900
Message-ID: <20060708053517.GB2592@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.238]:12395 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932408AbWGHFe0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 8 Jul 2006 01:34:26 -0400
Received: by wr-out-0506.google.com with SMTP id 36so1483587wra
        for <linux-ide@vger.kernel.org>; Fri, 07 Jul 2006 22:34:26 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, lkml@rtr.ca, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org

Hello, all.

The second round of PMP support patchsets are about to be posted.
It's consisted of the following three patchsets.

1. libata-link, take 2	   : 17 patches, implement ata_link abstraction
2. libata-pmp-prep, take 2 :  6 patches, prep for PMP support
3. libata-pmp, take 2	   : 12 patches, implement core PMP support and
			     add PMP support to sata_sil24

Patchsets are against

  upstream (309bade002e9226781c2d7a015340d0089e399b5)
  + hp-poll patchset, take #2 [1]

Changes from tha last post[2] are

* Modified to fit the current #upstream (updated hotplug, PM...)

* link resume handling updated

* Disabled link handling added.  When EH fails on a link, SError.X bit
  isn't cleared as before but .N is cleared and watched for PHY status
  change event.  ie. Hotplug events are watched for disabled ports, so
  when user replaces a failing device, libata retries the port.

* EH actions are performed in batch and thus results in much shorter
  recovery time when multiple devices fail simultaneously.

Patchsets are available in the following git trees.

  http://htj.dyndns.org/git/?p=libata-tj.git;a=shortlog;h=link
  git://htj.dyndns.org/libata-tj link

  http://htj.dyndns.org/git/?p=libata-tj.git;a=shortlog;h=pmp-prep
  git://htj.dyndns.org/libata-tj pmp-prep

  http://htj.dyndns.org/git/?p=libata-tj.git;a=shortlog;h=pmp
  git://htj.dyndns.org/libata-tj pmp

Thanks.

-- 
tejun

[1] http://article.gmane.org/gmane.linux.ide/11862
[2] http://article.gmane.org/gmane.linux.ide/10106
    http://article.gmane.org/gmane.linux.ide/10112
    http://article.gmane.org/gmane.linux.ide/10122
