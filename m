From: "Jan Beulich" <JBeulich@novell.com>
Subject: conflicting commits (block flush vs. ide)
Date: Tue, 15 Feb 2011 09:35:00 +0000
Message-ID: <4D5A56D40200007800031F3F@vpn.id2.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org

(resend because of corrupted email address in first attempt)

Tejun,

an older commit of yours to the legacy IDE driver
(5c4be57249e2e09136446597d2fe2a967c6ffef0) states

"* do_request functions might sleep now.  This should be okay as ide
  request_fn - do_ide_request() - is invoked only from make_request
  and plug work.  Make sure this is the case by adding might_sleep()
  to do_ide_request()."

With your newer commit "block: kick queue after sequencing
REQ_FLUSH/FUA" (47f70d5a6ca78c40a1c799d43506efbfed914f7b)
the assumption above doesn't appear to hold anymore, leading to

BUG: scheduling while atomic: swapper/0/0x10010000
Modules linked in: 8250 serial_core reiserfs
Modules linked in: 8250 serial_core reiserfs

Pid: 0, comm: swapper Not tainted 2.6.37-2011-01-22-xen0 #3 Precision WorkStation 220    /Precision WorkStation 220    
EIP: 0061:[<c01013a7>] EFLAGS: 00000246 CPU: 0
EIP is at 0xc01013a7
EAX: 00000000 EBX: 00000001 ECX: 00000000 EDX: 00000000
ESI: 00000000 EDI: c0509d20 EBP: 00000000 ESP: c04b1fb0
 DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0069
Process swapper (pid: 0, ti=ec004000 task=c04c14e0 task.ti=c04b0000)
Stack:
 c010a424 c04da2e0 c0103153 c050a380 c077e450 c04dcc02 0000005d c04dc74e
 c077e450 c050a380 00000005 c04dc135 00476680 00000000 c03cc763 f5800000
 c04b1ffc 00000000 00000000 00000000
Call Trace:
 [<c010a424>] xen_idle+0x24/0x50
 [<c0103153>] cpu_idle+0x43/0x80
 [<c04dcc02>] start_kernel+0x2f2/0x2f7
 [<c04dc135>] i386_start_kernel+0x135/0x13c
Code: cc cc cc cc b8 1c 00 00 00 cd 82 c3 cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc b8 1d 00 00 00 cd 82 <c3> cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc 
Call Trace:
 [<c010a424>] xen_idle+0x24/0x50
 [<c0103153>] cpu_idle+0x43/0x80
 [<c04dcc02>] start_kernel+0x2f2/0x2f7
 [<c04dc135>] i386_start_kernel+0x135/0x13c
Kernel panic - not syncing: scheduling while atomic
Pid: 0, comm: swapper Not tainted 2.6.37-2011-01-22-xen0 #3
Call Trace:
 [<c010827b>] try_stack_unwind+0x14b/0x170
 [<c010636f>] dump_trace+0x3f/0xf0
 [<c0107e8b>] show_trace_log_lvl+0x4b/0x60
 [<c0107eb8>] show_trace+0x18/0x20
 [<c0370f2b>] dump_stack+0x6d/0x72
 [<c0370f87>] panic+0x57/0x15b
 [<c0129008>] __schedule_bug+0x58/0x60
 [<c0371666>] schedule+0x466/0x5a0
 [<c037187f>] _cond_resched+0x2f/0x50
 [<c02cb7c5>] do_ide_request+0x55/0x450
 [<c022840c>] __blk_run_queue+0x4c/0x120
 [<c0227a81>] blk_finish_request+0x41/0xa0
 [<c0227dd9>] blk_end_bidi_request+0x49/0x70
 [<c0227e3f>] blk_end_request+0xf/0x20
 [<c02cb364>] ide_end_rq+0x24/0x50
 [<c02cb3ba>] ide_complete_rq+0x2a/0x60
 [<c02cf5ee>] task_no_data_intr+0xde/0x140
 [<c02caf38>] ide_intr+0x1d8/0x250
 [<c01648cd>] handle_IRQ_event+0x2d/0xc0
 [<c0166d5a>] handle_fasteoi_irq+0x8a/0x140
 [<c0105fc2>] handle_irq+0x82/0xd0

(I added the panic to get a full stack trace and stop the system
instead of endlessly printing the normal "scheduling while atomic"
output.)

As I understand it, it's the call to __blk_run_queue() from the
rq->end_io handler that is causing the conflict with
do_ide_request()'s use of might_sleep().

As a band-aid, the patch below worked for me (on 2.6.37), but
I'm not convinced this is actually an appropriate thing to do (not
the least because the other two examples of forcibly setting
QUEUE_FLAG_REENTER [in the scsi driver] look fishy to me).

Jan

--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -771,7 +771,8 @@ irqreturn_t ide_intr (int irq, void *dev
 	unsigned long flags;
 	ide_startstop_t startstop;
 	irqreturn_t irq_ret = IRQ_NONE;
-	int plug_device = 0;
+	bool plug_device = false, uninitialized_var(nested);
+	struct request_queue *q;
 	struct request *uninitialized_var(rq_in_flight);
 
 	if (host->host_flags & IDE_HFLAG_SERIALIZE) {
@@ -837,12 +838,31 @@ irqreturn_t ide_intr (int irq, void *dev
 	if (hwif->port_ops && hwif->port_ops->clear_irq)
 		hwif->port_ops->clear_irq(drive);
 
+	/*
+	 * At least task_no_data_intr() may cause do_ide_request() to get
+	 * called (via blk_end_request() and __blk_run_queue()), and the
+	 * latter doesn't tolerate being called in interrupt (atomic)
+	 * context (using might_sleep() right at its top).
+	 */
+	q = drive->queue;
+	if (q) {
+		spin_lock(q->queue_lock);
+		nested = queue_flag_test_and_set(QUEUE_FLAG_REENTER, q);
+		spin_unlock(q->queue_lock);
+	}
+
 	if (drive->dev_flags & IDE_DFLAG_UNMASK)
 		local_irq_enable_in_hardirq();
 
 	/* service this interrupt, may set handler for next interrupt */
 	startstop = handler(drive);
 
+	if (q && !nested) {
+		spin_lock(q->queue_lock);
+		queue_flag_clear(QUEUE_FLAG_REENTER, q);
+		spin_unlock(q->queue_lock);
+	}
+
 	spin_lock_irq(&hwif->lock);
 	/*
 	 * Note that handler() may have set things up for another

