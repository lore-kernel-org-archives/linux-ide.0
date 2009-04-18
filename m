From: Tejun Heo <tj@kernel.org>
Subject: [GIT PATCH pata-2.6] ide: clean up ide-tape, take#2
Date: Sun, 19 Apr 2009 08:58:32 +0900
Message-ID: <1240099122-18381-1-git-send-email-tj@kernel.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:57756 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752519AbZDRX6w (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 18 Apr 2009 19:58:52 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@googlemail.com, bzolnier@gmail.com, axboe@kernel.dk, linux-ide@vger.kernel.org

Hello, Bartlomiej, Jens, Borislav.

Upon ack, please pull from the following git tree.

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/misc.git ide-phase2

This is the second take of clean-up-ide-tape patchset.  Please read
the head message on the last take[L] for general description.

Changes from the last take are

* Tested with Seagate STT8000A rev 5.44 and various fixes bugs
  including a few already existing ones.

* 0003 and 0004 of the last take are merged into one.  The first one
  converted data carrier to bio and the second changed data transfer
  mechanism accordingly.  As blk_rq_map_kern() can produce scatter IO
  the first one without the second didn't work.

* Rebased.

This patchset contains the following ten patches.

 0001-ide-tape-floppy-fix-failed-command-completion-after.patch
 0002-ide-atapi-tape-floppy-allow-pc_callback-to-chan.patch
 0003-ide-tape-use-single-continuous-buffer.patch
 0004-ide-tape-use-standard-data-transfer-mechanism.patch
 0005-ide-tape-kill-idetape_bh.patch
 0006-ide-tape-unify-r-w-init-paths.patch
 0007-ide-tape-use-byte-size-instead-of-sectors-on-rw-iss.patch
 0008-ide-tape-simplify-read-write-functions.patch
 0009-ide-atapi-kill-unused-fields-and-callbacks.patch
 0010-ide-drop-rq-data-handling-from-ide_map_sg.patch

and is on top of

  linux-pata-2.6#for-next (15da90b516e9da92cc1d90001e640fd6707d0e27)
+ [1] ide-rq-buffer-data-special-cleanups patchset, take#2

and contains the following changes.

 drivers/ide/ide-atapi.c  |   29 -
 drivers/ide/ide-floppy.c |    4 
 drivers/ide/ide-io.c     |    6 
 drivers/ide/ide-tape.c   |  722 ++++++++++-------------------------------------
 include/linux/ide.h      |   12 
 5 files changed, 170 insertions(+), 603 deletions(-)

Thanks.

--
tejun

[L] http://thread.gmane.org/gmane.linux.ide/39316
[1] http://thread.gmane.org/gmane.linux.ide/39930
