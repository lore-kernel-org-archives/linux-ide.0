From: "Jan Beulich" <JBeulich@novell.com>
Subject: old ide driver incompatible with new flush implementation
	 (was: conflicting commits (block flush vs. ide))
Date: Tue, 15 Feb 2011 11:45:25 +0000
Message-ID: <4D5A75650200007800031F9C@vpn.id2.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org

>>> On 15.02.11 at 10:35, Jan Beulich wrote:
> BUG: scheduling while atomic: swapper/0/0x10010000

Actually, the situation is worse. While the patch sent previously
allowed that system to boot, it died the moment it tried to
access its secondary disk (which supports flushes, while the
primary doesn't):

BUG: scheduling while atomic: swapper/0/0x10010000
Process swapper (pid: 0, ti=ec004000 task=c04c14e0 task.ti=c04b0000)
Stack:
Call Trace:
Code: cc cc cc cc b8 1c 00 00 00 cd 82 c3 cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc b8 1d 00 00 00 cd 82 <c3> cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc 
Kernel panic - not syncing: scheduling while atomic
Pid: 0, comm: swapper Not tainted 2.6.37-2011-01-22-xen0 #4
Call Trace:
 [<c010827b>] try_stack_unwind+0x14b/0x170
 [<c010636f>] dump_trace+0x3f/0xf0
 [<c0107e8b>] show_trace_log_lvl+0x4b/0x60
 [<c0107eb8>] show_trace+0x18/0x20
 [<c037104b>] dump_stack+0x6d/0x72
 [<c03710a7>] panic+0x57/0x15b
 [<c0129008>] __schedule_bug+0x58/0x60
 [<c0371786>] schedule+0x466/0x5a0
 [<c037199f>] _cond_resched+0x2f/0x50
 [<c02cb8e5>] do_ide_request+0x55/0x450
 [<c0228698>] __generic_unplug_device+0x28/0x30
 [<c022ab2c>] blk_flush_complete_seq+0xbc/0x1a0		-> queue_next_fseq() -> elv_insert()
 [<c022ad9a>] blk_flush_complete_seq_end_io+0x2a/0x70
 [<c0227a81>] blk_finish_request+0x41/0xa0
 [<c0227dd9>] blk_end_bidi_request+0x49/0x70
 [<c0227e3f>] blk_end_request+0xf/0x20
 [<c02cb484>] ide_end_rq+0x24/0x50
 [<c02cb4da>] ide_complete_rq+0x2a/0x60
 [<c02cf70e>] task_no_data_intr+0xde/0x140
 [<c02cafab>] ide_intr+0x24b/0x370
 [<c01648cd>] handle_IRQ_event+0x2d/0xc0
 [<c0166d5a>] handle_fasteoi_irq+0x8a/0x140
 [<c0105fc2>] handle_irq+0x82/0xd0

(again, I converted the dump_stack() in there to a panic()).
Adding ide_core.noflush=0.1 allows the system to access
that secondary disk again, but surely it can't be the
intention to require this option to be specified universally
for all drives that support flushes.

Hence the question really is whether instead the might_sleep()
can't be removed from do_ide_request(), or at least be made
conditional upon some property of the device.

Jan

