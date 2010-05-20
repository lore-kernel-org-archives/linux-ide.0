From: tytso@mit.edu
Subject: Re: ext3 filesystem corruption on md RAID1 device
Date: Thu, 20 May 2010 10:30:39 -0400
Message-ID: <20100520143039.GC16634@thunk.org>
References: <BA8A2107B0FD8A48AEB0405BDC36CE4F3F48B1DCFD@GVW1115EXC.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from THUNK.ORG ([69.25.196.29]:48812 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755001Ab0ETOap (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 20 May 2010 10:30:45 -0400
Content-Disposition: inline
In-Reply-To: <BA8A2107B0FD8A48AEB0405BDC36CE4F3F48B1DCFD@GVW1115EXC.americas.hpqcorp.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Buehl, Reiner" <reiner.buehl@hp.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>

On Thu, May 20, 2010 at 10:08:21AM +0000, Buehl, Reiner wrote:
> Hi,
> 
> I keep getting ext3 filesystem corruptions on one of my md RAID1 arrays. Shortly after booting, I get messages like the following one:
> 
> EXT3-fs error (device md1): htree_dirblock_to_tree: bad entry in
> directory #17269110: rec_len is smaller than minimal - offset=0,
> inode=0, rec_len=0, name_len=0

This looks like a block got completely zero'ed out.  One interesting
question is whether the corruption is happening on the read side (when
transfering data from the disk to memory) or on the write side (when
tranferring data from memory to disk).  So something that's worth
doing is grab the output of e2fsck, and see if it see if is trying to
fix the directory inode reported by the EXT3-fs error syslog.

Another thing that's worth doing is to try running e2fsck -fy /dev/md1
a second time.  If you see errors in that second fsck run, then it's
time to suspect that either (a) the storage stack isn't reliably
reading from disk, or (b) the storage stack isn't reliably writing to
the disk.  Thers is the possibility of an e2fsck bug, but that seems
unlikely in this context.  If you save the outputs from each e2fsck
run, I can look at them and tell you whether it's likely an e2fsck bug
or, what seems more likely a storage stack failure.

Regards,

						- Ted
