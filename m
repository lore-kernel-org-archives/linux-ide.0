From: Tejun Heo <htejun@gmail.com>
Subject: EH/NCQ/hotplug/PM patchsets are about to be posted...
Date: Thu, 11 May 2006 20:27:21 +0900
Message-ID: <20060511112721.GA4219@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.202]:9125 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751545AbWEKL12 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 07:27:28 -0400
Received: by nz-out-0102.google.com with SMTP id 13so164708nzn
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 04:27:27 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Jens Axboe <axboe@suse.de>, Albert Lee <albertcc@tw.ibm.com>, "Zhao, Forrest" <forrest.zhao@intel.com>, efalk@google.com, linux-ide@vger.kernel.org

Hello, all.

I'm about to post the following 11 patchsets composed of 122 patches.
These contain the same changes as the git tree[1] posted yesterday and
the git tree is probably much easier to import for testing and
merging.  These patchsets are mainly to help review process.

 1. prep-for-new-EH			: take 1 (22 patches)
 2. new-EH-framework			: take 3 (11 patches)
 3. new-EH-implementation		: take 3 (11 patches)
 4. merge-irq-pio			: take 1 ( 2 patches)
 5. add-NCQ-support			: take 3 (12 patches)
 6. prep-for-hotplug-support		: take 2 (14 patches)
 7. prep-LLDDs-for-hotplug-support	: take 1 ( 6 patches)
 8. add-hotplug-support			: take 2 (13 patches)
 9. implement-ata_link			: take 1 (14 patches)
10. prep-for-PM-support			: take 1 ( 7 patches)
11. add-PM-support			: take 1 (10 patches)

All patchsets are against the current upstream[2] and stacks on the
prvious ones.

Patchsets have been slightly reorganized from the last post[3].

* new patchsets added inbetween existing ones (pset #1 and #7)
* SCSI changes are merged into prep-for-new-EH
* some of patches from new-EH-framework are moved to prep-for-new-EH
* some of patches from add-hotplug-support are moved to
  prep-LLDDs-for-hotplug-support

All the patchsets have gone through a lot of changes.  Detailed
description of the changes will be posted in the head messages of each
patchset.

Thanks.

--
tejun

[1] http://article.gmane.org/gmane.linux.ide/9919
[2] acc696d93dcf993dec123d69d599979e1456ffec
[3] http://article.gmane.org/gmane.linux.ide/9493 
