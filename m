From: Tejun Heo <tj@kernel.org>
Subject: [GIT PATCH linux-2.6-block#for-linus] block: fix hd and mg_disk
Date: Tue, 28 Apr 2009 12:52:16 +0900
Message-ID: <1240890740-3462-1-git-send-email-tj@kernel.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:46125 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755388AbZD1Dwg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 27 Apr 2009 23:52:36 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: axboe@kernel.dk, linux-kernel@vger.kernel.org, donari75@gmail.com, bzolnier@gmail.com, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk

Hello,

Upon ack, please pull from the following git tree.

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/misc.git tj-block-for-linus

to receive the following patches.

 0001-mg_disk-fix-locking.patch
 0002-mg_disk-fix-CONFIG_LBD-y-warning.patch
 0003-hd-fix-locking.patch

0001 and 0003 fix locking problem in mg_disk and hd.  mg_disk is only
compile tested but hd received almost identical changes and is
verified to work so I'm relatively confident regarding the mg_disk.

0002 removes a build warning.

This patchset is on top of the current linux-2.6-block#for-linus[1]
and contains the following changes.

 drivers/block/hd.c      |   17 +++++++----------
 drivers/block/mg_disk.c |   19 ++++++++++++++-----
 2 files changed, 21 insertions(+), 15 deletions(-)

Thanks.

--
tejun

[1] f2d1f0ae7851be5ebd9613a80dac139270938809
