From: Tejun Heo <tj@kernel.org>
Subject: [PATCHSET pata-2.6] ide: rq->buffer, data, special and misc cleanups, take#2
Date: Fri, 17 Apr 2009 18:33:07 +0900
Message-ID: <1239960802-31978-1-git-send-email-tj@kernel.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:39976 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757083AbZDQJdj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 17 Apr 2009 05:33:39 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@googlemail.com, bzolnier@gmail.com, axboe@kernel.dk, linux-ide@vger.kernel.org


Hello, Bartlomiej, Jens, Borislav.

This is the second take of ide-rq-buffer-data-special-cleanups
patchset.  Changes from the last take[L] are

* blk_rq_map_kern_prealloc() dropped in favor of Borislav's
  blk_rq_map_kern() from do_request() approach.

* ide-tape tested and fixed.  (data transfer triggers oom but the bug
  exists before the patchset and things other than data transfer work
  well before and after the patchset.  The data transfer bug will be
  dealt with in the next patchset.)

For general overview of the patchset, please read the head message of
the last take.

This patchset contains the following patches.

 0001-block-clear-req-errors-on-bio-completion-only-for.patch
 0002-ide-tape-remove-back-to-back-REQUEST_SENSE-detectio.patch
 0003-ide-use-blk_run_queue-instead-of-blk_start_queuei.patch
 0004-ide-don-t-set-REQ_SOFTBARRIER.patch
 0005-ide-kill-unused-ide_cmd-special.patch
 0006-ide-cd-clear-sense-buffer-before-issuing-request-se.patch
 0007-ide-floppy-block-pc-always-uses-bio.patch
 0008-ide-taskfile-don-t-abuse-rq-buffer.patch
 0009-ide-atapi-don-t-abuse-rq-buffer.patch
 0010-ide-cd-don-t-abuse-rq-buffer.patch
 0011-ide-add-helpers-for-preparing-sense-requests.patch
 0012-ide-cd-convert-to-using-generic-sense-request.patch
 0013-ide-atapi-convert-ide-floppy-tape-to-using-preall.patch
 0014-ide-cd-atapi-use-bio-for-internal-commands.patch
 0015-ide-pm-don-t-abuse-rq-data.patch

0001 is block layer patch.  Jens acked it and agreed to push it
through ide tree.  0002 is new and fixes an ide-tape oops.  0003-0010
are identical to 0004-0011 of the last take.

0011-0013 are from Borislav[1] and unifies sense rq handling between
cd and atapi.  Note that these patches have been modified quite a bit
to make them fit in the series (use of blk_rq_map_kern() is moved to
later patch) and incorporate Bartlomiej's comments and fixes for bugs
I found during testing.  I retained Borislav's S-O-B in the patches,
if this is a problem, please feel free to replace with other proper
tag.

0014 unifies data buffer handling in cd and atapi so that they always
use bio.  0015 is identical to 0012 of the last take.

Tested against cdrom, floppy and tape, so, hopefully, all the bases
are covered.

This patchset is on top of linux-next pata-2.6 tree as of 2009-04-16.
Git tree is available at the following vector but please DO NOT pull
from the following git tree as pata-2.6 tree is quilt-based and the
base tree I used isn't the one which is gonna go upstream.  The
following tree is for review only.

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/misc.git ide-phase1

Bartlomiej, please feel free to include this in the pata-2.6 patchset.
Also, is the git tree coming?

This patchset contains the following changes.

 block/blk-core.c           |   10 ++-
 drivers/ide/ide-atapi.c    |  147 ++++++++++++++++++++++++++++++---------------
 drivers/ide/ide-cd.c       |   88 ++++++++------------------
 drivers/ide/ide-cd.h       |    4 -
 drivers/ide/ide-disk.c     |    1 
 drivers/ide/ide-floppy.c   |   20 +++---
 drivers/ide/ide-io.c       |   10 +--
 drivers/ide/ide-ioctls.c   |    1 
 drivers/ide/ide-park.c     |    7 --
 drivers/ide/ide-pm.c       |   38 ++++-------
 drivers/ide/ide-tape.c     |   18 ++---
 drivers/ide/ide-taskfile.c |   18 +++--
 include/linux/ide.h        |   15 +++-
 13 files changed, 197 insertions(+), 180 deletions(-)

Thanks.

--
tejun

[L] http://thread.gmane.org/gmane.linux.ide/39275
