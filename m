From: Larry McVoy <lm@bitmover.com>
Subject: Re: Libata VIA woes continue. Worked around - *wrong*
Date: Mon, 30 Aug 2004 07:45:52 -0700
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040830144552.GC16320@work.bitmover.com>
References: <412F3DEA.2070307@wasp.net.au> <41318680.8080102@wasp.net.au> <41318C87.9010806@pobox.com> <4131910B.6020000@wasp.net.au> <41319C1F.6030207@pobox.com> <4131A0C1.3090305@wasp.net.au> <4131A431.8080409@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ipcop.bitmover.com ([192.132.92.15]:18665 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S268472AbUH3Op5
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 30 Aug 2004 10:45:57 -0400
Content-Disposition: inline
In-Reply-To: <4131A431.8080409@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Brad Campbell <brad@wasp.net.au>, linux-ide@vger.kernel.org, linxu-kernel@vger.kernel.org, Larry McVoy <lm@bitmover.com>, Linus Torvalds <torvalds@osdl.org>

> Since BK changesets are ordered as a progression, you can also do a 
> bsearch by clone trees to specific changesets, such as
> 
> bk changes -rv2.6.6..2.6.7 > /tmp/changes.txt
> # view changes.txt, pick out cset 1.1587.39.1 as your "top of tree"
> bk clone -r1.1587.39.1 vanilla-2.6 brad-test-2.6.6-bk
> # compile and test the kernel in brad-test-2.6.6-bk

A couple of comments:
    - BK changesets are not a linear progression, they are in the form of
      a graph called a lattice.  Getting a path through there that you can
      do binary search on is not straightforward.

    - The CVS tree represents one such straight path, get just the ChangeSet
      file from the CVS tree and do an rlog on it - you are looking for the
      lines like:

      BKrev: 41316382Cxbyp1_yHDX8LmymGot3Ww

      That rev is the "md5key" of the BK rev and can be used anywhere a BK
      rev may be used (bk clone -r41316382Cxbyp1_yHDX8LmymGot3Ww ...)

    - The biggest time saver is knowing where to look for your bug.  If you
      knew that the bug was in drivers/scsi/libata-core.c then you could
      find each changeset which touched that file like so

      $ bk rset -lv2.6.6 | grep drivers/scsi/libata-core.c
      drivers/scsi/libata-core.c|1.39
      $ bk prs -hnd:I: -r1.39.. drivers/scsi/libata-core.c | while read rev
      do  bk r2c -r$rev drivers/scsi/libata-core.c
      done

      That will crunch away and spit out (in this case) 63 revs like

      1.1803.1.40
      1.1803.1.39
      1.1803.1.38
      ...

      and a binary search over those revs is likely to be fair more fruitful
      because the history of that one file is pretty linear.
-- 
---
Larry McVoy                lm at bitmover.com           http://www.bitkeeper.com
