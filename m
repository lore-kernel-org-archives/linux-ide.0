From: Tejun Heo <htejun@gmail.com>
Subject: [git-patch] another round of hotplug patches
Date: Wed, 31 May 2006 19:31:57 +0900
Message-ID: <20060531103157.GC8106@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.179]:46877 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S964950AbWEaKcF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 31 May 2006 06:32:05 -0400
Received: by py-out-1112.google.com with SMTP id e30so1024444pya
        for <linux-ide@vger.kernel.org>; Wed, 31 May 2006 03:32:04 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Mark Lord <mlord@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Albert Lee <albertcc@tw.ibm.com>, Jens Axboe <axboe@suse.de>, "Zhao, Forrest" <forrest.zhao@intel.com>, linux-ide@vger.kernel.org, ric@emc.com

Hello,

Currently, the following misc patches are pending on top of
upstream[1].

[2] set-PIO-0-after-successful-EH-reset
[3] shift-host-flag-constants 
[4] implement-ata_eh_wait

New round of hotplug patchesets are about to be posted.  All patches
are against the current upstream + the above three misc patches.

1. prep-for-hotplug-support		: take 5 (12 patches)
2. prep-LLDDs-for-hotplug-support	: take 4 ( 5 patches)
3. add-hotplug-support			: take 5 (13 patches)

Detailed changelog is attached at the head messages of patchsets.

Also, the following patch is pending on top of hotplug patchsets.

[5] ata_piix-fix-ghost-device-probing-by-honoring-PCS-present-bits

All patches are available as git tree.

http://htj.dyndns.org/git/?p=libata-tj.git;a=shortlog;h=for-jeff
git://htj.dyndns.org/libata-tj for-jeff

The git tree is tagged as follows.  (don't forget to prefix git
address with 'tag')

  fj-misc		: contains three misc updates [2][3][4]
  fj-hp-prep		: prep-for-hotplug-support patchset
  fj-hp-LLDD-prep	: prep-LLDDs-for-hotplug-support patchset
  fj-hp			: add-hotplug-support patchset
  fj-ata_piix-fix-ghost	: contains ata_piix-fix-ghost patch [5]

Thanks.

-- 
tejun

[1] ef2824073fba9def3cf122e89cc485f66dd71f70
[2] http://article.gmane.org/gmane.linux.ide/10890
[3] http://article.gmane.org/gmane.linux.ide/11010
[4] http://article.gmane.org/gmane.linux.ide/11011
[5] http://article.gmane.org/gmane.linux.ide/10937
