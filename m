From: Tejun Heo <tj@kernel.org>
Subject: [RFC PATCH 0/2] sata_via: fix TF access and add 8251 support
Date: Thu, 02 Oct 2008 10:53:09 +0900
Message-ID: <48E42985.60400@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:56303 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751384AbYJBByy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 1 Oct 2008 21:54:54 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Joseph Chan <JosephChan@via.com.tw>, IDE/ATA development list <linux-ide@vger.kernel.org>, HaraldWelte@viatech.com

Hello, Joseph and Harald.

I'm gonna send two patches as reply to this message.  Can you please
review them?  Both are separated out from Joseph's original patch.

  http://thread.gmane.org/gmane.linux.kernel.commits.mm/40640

The former one (fix TF load) is rather straight-forward and it seems
to work on my vt6421's but I couldn't test 8251 support as I don't
have any.  I thought the controller you sent me was 8251 but it was
6421, right?  I think I asked for 6421 not knowing what I wanted was
8251.  So, it would be great if you can test whether the 8251 support
works.  Please post the kernel log whether it succeeds or not.

For the time being, I skipped support for 0581 and 5324 as they were
not on the PCI device ID list of the original patch.  Do they have the
same configuration?  Or are they SATA/PATA mixed?

The patches are on top of the upstream branch of Jeff's libata-dev
tree.

 git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git
 http://www.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

Thanks.

-- 
tejun
