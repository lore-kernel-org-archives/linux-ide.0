From: Tejun Heo <htejun@gmail.com>
Subject: Re: [ANNOUNCE] new revision of PMP support patchsets are about to be posted
Date: Sat, 8 Jul 2006 20:21:10 +0900
Message-ID: <20060708112110.GD2592@htj.dyndns.org>
References: <20060708053517.GB2592@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.199]:36542 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964784AbWGHLUU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 8 Jul 2006 07:20:20 -0400
Received: by nz-out-0102.google.com with SMTP id z3so1163032nzf
        for <linux-ide@vger.kernel.org>; Sat, 08 Jul 2006 04:20:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20060708053517.GB2592@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, lkml@rtr.ca, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org

The patchsets have been rebased after autopsy-fix patch and two minor
bugs are fixed.

* ENABLE_LINK became EH action and doesn't repetitively enable devices
  which are disabled after hotplug event.

* sil24_read_tf() is fixed to handle ATA_TAG_INTERNAL properly.  This
  fixes NCQ and ATAPI CC handling.

Git trees are updated but patchsets won't be reposted as changes are
minor.

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
