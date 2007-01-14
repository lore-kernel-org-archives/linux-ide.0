From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: 2.6.20-rc4-mm1
Date: Mon, 15 Jan 2007 09:20:42 +1100
Message-ID: <20070114222042.GO5860@kernel.dk>
References: <20070111222627.66bb75ab.akpm@osdl.org> <1168768104.2941.53.camel@localhost.localdomain> <1168771617.2941.59.camel@localhost.localdomain> <1168785616.2941.67.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751742AbXAOAHb@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1168785616.2941.67.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, jgarzik@pobox.com, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Sun, Jan 14 2007, Thomas Gleixner wrote:
> On Sun, 2007-01-14 at 11:46 +0100, Thomas Gleixner wrote:
> > > Boot proceeds, but gets stuck hard at:
> > > "Remounting root filesystem in read-write mode:"
> > > 
> > > No SysRq-T, nothing.
> > > 
> > > The above BUG seems unrelated to that. Investigating further.
> > 
> > Bisect identified: git-block.patch
> 
> Does only happen on 2 systems. Both have sata + raid1 setup. I managed 
> to get a stacktrace from the SMP box. Sits there and sleeps forever.
> 
> 	tglx
> 
> [<c032ac64>] io_schedule+0x7a/0x9a
> [<c0157f89>] sleep_on_page+0x8/0xc
> [<c032ae45>] __wait_on_bit+0x36/0x5d
> [<c01580d8>] wait_on_page_bit+0x5b/0x61
> [<c0158a2b>] wait_on_page_writeback_range+0x4f/0xef
> [<c0158b0f>] filemap_fdatawait+0x44/0x49
> [<c0158da0>] filemap_write_and_wait+0x22/0x2d
> [<c0190e39>] sync_blockdev+0x17/0x1d
> [<c01a27af>] quota_sync_sb+0x33/0xd6
> [<c01a2874>] sync_dquots+0x22/0xfa
> [<c01757cf>] __fsync_super+0x17/0x66
> [<c0175829>] fsync_super+0xb/0x19
> [<c0175880>] do_remount_sb+0x49/0x101
> [<c0187f98>] do_mount+0x1ad/0x678
> [<c01884d2>] sys_mount+0x6f/0xa4
> [<c0103f6a>] sysenter_past_esp+0x5f/0x99

raid seems to have severe problems with the plugging change. I'll try
and find Neil and have a chat with him, hopefully we can work it out.

-- 
Jens Axboe
