From: Jens Axboe <axboe@suse.de>
Subject: [patch] ide tcq for 2.4.19-pre8
Date: Fri, 17 May 2002 08:36:07 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20020517063607.GA1109@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Linux IDE <linux-ide@vger.kernel.org>, "Andre M. Hedrick" <andre@linux-ide.org>

Hi,

Fixed a few bugs and missing functionality (recovery) since the initial
2.4 version. Changelog:

- (generic tcq) use list_for_each_safe() in blk_queue_invalidate_tags(),
  we are removing entries while browsning.
- (ide tcq) remember to honor max depth set.
- (ide tcq) fix auto_poll detection oops
- (ide tcq) enable use of NOP command to clear hardware tag queue on
  error.
- (ide tcq) hwgroup->rq clearing race
- (ide tcq) refuse to toggle tcq enable flag on busy drive. This will
  need to be fixed properly by serializing such requests with the normal
  request queue.

I have tested error recovery, and it works. I've provoked errors at full
queue depths, and the code correctly recovered and kept spinning without
data loss.

Generic tcq support:

*.kernel.org/pub/linux/kernel/people/axboe/patches/v2.4/2.4.19-pre8/block-tag-2419p8-2.bz2

IDE tcq support:

*.kernel.org/pub/linux/kernel/people/axboe/patches/v2.4/2.4.19-pre8/ide-tag-2419p8-2.bz2

All-in-one:

*.kernel.org/pub/linux/kernel/people/axboe/patches/v2.4/2.4.19-pre8/ide-block-tag-2419p8.bz2

Enjoy,
-- 
Jens Axboe

