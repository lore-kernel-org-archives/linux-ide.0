From: Tejun Heo <htejun@gmail.com>
Subject: [git-patch] new round of hotplug patchsets
Date: Mon, 29 May 2006 14:54:47 +0900
Message-ID: <20060529055447.GA30639@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.202]:18133 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751211AbWE2Fyx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 May 2006 01:54:53 -0400
Received: by nz-out-0102.google.com with SMTP id s18so471627nze
        for <linux-ide@vger.kernel.org>; Sun, 28 May 2006 22:54:53 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Mark Lord <mlord@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Albert Lee <albertcc@tw.ibm.com>, Jens Axboe <axboe@suse.de>, "Zhao, Forrest" <forrest.zhao@intel.com>, linux-ide@vger.kernel.org

Hello, all.

Currently, the following fix patch is pending

set-PIO-0-after-successful-EH-reset[1]

And, new round of hotplug patchsets are about to be posted.  All
patches are against the current upstream[2] + the above set-PIO0[1]
patch.

1. prep-for-hotplug-support		: take 4 (12 patches)
2. prep-LLDDs-for-hotplug-support	: take 3 ( 5 patches)
3. add-hotplug-support			: take 4 (13 patches)

All patches are available as git tree.  Detailed changelog is attached
at the head messages of patchsets.

http://htj.dyndns.org/git/?p=libata-tj.git;a=shortlog;h=for-jeff
git://htj.dyndns.org/libata-tj for-jeff

The git tree is tagged as follows.  (don't forget to prefix git
address with 'tag')

  fj-fixes		: contains set-PIO0 fix patch
  fj-hp-prep		: prep-for-hotplug-support patchset
  fj-hp-LLDD-prep	: prep-LLDDs-for-hotplug-support patchset
  fj-hp			: add-hotplug-support patchset

Thanks.

-- 
tejun

[1] http://article.gmane.org/gmane.linux.ide/10890
[2] ef2824073fba9def3cf122e89cc485f66dd71f70
