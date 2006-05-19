From: Tejun Heo <htejun@gmail.com>
Subject: Re: [git-patch] fixes & updated hotplug
Date: Fri, 19 May 2006 21:33:20 +0900
Message-ID: <20060519123320.GD10058@htj.dyndns.org>
References: <20060519122748.GC10058@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.178]:33661 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932296AbWESMd1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 19 May 2006 08:33:27 -0400
Received: by py-out-1112.google.com with SMTP id z59so907794pyg
        for <linux-ide@vger.kernel.org>; Fri, 19 May 2006 05:33:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20060519122748.GC10058@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, mlord@pobox.com, Albert Lee <albertcc@tw.ibm.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Jens Axboe <axboe@suse.de>, "Zhao, Forrest" <forrest.zhao@intel.com>
Cc: linux-ide@vger.kernel.org

[Sorry, forgot to cc linux-ide]

Hello,

Currently, the following two updates are pending.

* enforce default EH actions fix [1]
* scsi_implement_eh() patch [2]

And, the following three patchsets are about to be posted

1. prep-for-hotplug-support		: take 3 (14 patches)
2. prep-LLDDs-for-hotplug-support	: take 2 ( 6 patches)
3. add-hotplug-support			: take 3 (13 patches)

The overall structure of hotplug hasn't been changed.  The biggest
update is how controllers handle device detection after hotplug event.
Previously, libata hotplug often failed the first attempt to detect a
newly plugged device resulting in reset failure or timeout causing
unnecessary delay.  With this update, libata can detect most devices
on the first try.

Head message of each patchset will contain detailed changelog.

All of above changes can be accessed via the following git tree.

  http://htj.dyndns.org/git/?p=libata-tj.git;a=shortlog;h=for-jeff
  git://htj.dyndns.org/libata-tj for-jeff

The git tree is tagged as follows.

  fj-fixes		: contains two pending patches
  fj-hp-prep		: prep-for-hotplug-support patchset
  fj-hp-LLDD-prep	: prep-LLDDs-for-hotplug-support patchset
  fj-hp			: add-hotplug-support patchset

Thanks.

-- 
tejun

[1] http://article.gmane.org/gmane.linux.ide/10317
[2] http://article.gmane.org/gmane.linux.ide/10529
