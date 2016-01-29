From: David Milburn <dmilburn@redhat.com>
Subject: Re: ata: BUG in ata_sff_hsm_move
Date: Fri, 29 Jan 2016 12:14:42 -0600
Message-ID: <20160129181442.GA30391@dhcp-10-15-1-8.hsv.redhat.com>
References: <CACT4Y+b_JsOxJu2EZyEf+mOXORc_zid5V1-pLZSroJVxyWdSpw@mail.gmail.com> <20160129115214.GM32380@htj.duckdns.org> <CACT4Y+Y_w3msrTw46T8wGpK-j09e6VAoPFa93JSfm+5_kvBAYQ@mail.gmail.com> <20160129122317.GO32380@htj.duckdns.org> <CACT4Y+Z5SPCKg0bMC2sD-VbCfJPOixzntb+-zfWcU5jufjygmw@mail.gmail.com> <CACT4Y+axb-FagKnftWDkOynT8xWoqOw758Q9t_Whs-bZPqU1Xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="5mCyUwZo2JvN/JJP"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57978 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750868AbcA2SB6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 29 Jan 2016 13:01:58 -0500
Content-Disposition: inline
In-Reply-To: <CACT4Y+axb-FagKnftWDkOynT8xWoqOw758Q9t_Whs-bZPqU1Xg@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dmitry Vyukov <dvyukov@google.com>
Cc: syzkaller <syzkaller@googlegroups.com>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@redhat.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, Kostya Serebryany <kcc@google.com>, Alexander Potapenko <glider@google.com>, Sasha Levin <sasha.levin@oracle.com>


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Hi Tejun,

Can ata_sff_hsm_move grab the lock and save off the task_state,
like this patch?

Thanks,
David

On Fri, Jan 29, 2016 at 02:40:33PM +0100, Dmitry Vyukov wrote:
> On Fri, Jan 29, 2016 at 2:18 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
> > On Fri, Jan 29, 2016 at 1:23 PM, Tejun Heo <tj@kernel.org> wrote:
> >> Hello, Dmitry.
> >>
> >> On Fri, Jan 29, 2016 at 12:59:49PM +0100, Dmitry Vyukov wrote:
> >>> > Hmmm... the port interrupt handler checks for IDLE before calling into
> >>> > hsm_move, so the only explanation would be that something is resetting
> >>> > it to IDLE inbetween.  ce7514526742 ("libata: prevent HSM state change
> >>> > race between ISR and PIO") describes and fixes the same problem.  The
> >>> > fix seems correct and I can't find anywhere else where this can
> >>> > happen.  :(
> >>> >
> >>> > Can you please post the kernel log leading to the BUG?  Also, I don't
> >>> > think that condition needs to be BUG.  I'll change it to WARN.
> >>>
> >>> Here are two logs, in both cases no kernel messages prior to the bug:
> >>> https://gist.githubusercontent.com/dvyukov/5087d633e3620280b6c7/raw/31c9ab1ced92ac5f85cfb15eaf48ec5793c2c3a1/gistfile1.txt
> >>> https://gist.githubusercontent.com/dvyukov/825b2e3d5fb80ae08a9a/raw/03c5a4f4c4bd9d0a304a71cda2da4c92f4b7f1ba/gistfile1.txt
> >>
> >> lol, this is kinda embarrassing.  It looks like the poll path wasn't
> >> doing any locking.  Can you please verify the following patch at least
> >> doesn't crash the machine immediately and if so keep it applied to the
> >> test kernel so that we can verify that the problem actually goes away?
> >
> >
> > Great that you managed to debug it without a repro!
> > I've applied this patch to my tree and will rerun fuzzer. I will
> > notify you if I see this warning again.
> > Thanks
> 
> It now deadlocks at this stack. It is probably not OK to call
> ata_sff_hsm_move holding the spinlock.
> 
> [    8.168809] NMI backtrace for cpu 2
> [    8.168809] CPU: 2 PID: 17 Comm: kworker/2:0 Not tainted 4.5.0-rc1+ #302
> [    8.168809] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS Bochs 01/01/2011
> [    8.168809] Workqueue: ata_sff ata_sff_pio_task
> [    8.168809] task: ffff88006d24c740 ti: ffff88006d090000 task.ti:
> ffff88006d090000
> [    8.168809] RIP: 0010:[<ffffffff82c0e388>]  [<ffffffff82c0e388>]
> delay_tsc+0x18/0x70
> [    8.168809] RSP: 0000:ffff88006d097a60  EFLAGS: 00000086
> [    8.168809] RAX: 000000008edaeede RBX: ffff880036e88028 RCX: 000000000000001e
> [    8.168809] RDX: 0000000000000033 RSI: 000000338edaee9c RDI: 0000000000000001
> [    8.168809] RBP: ffff88006d097a60 R08: 0000000000000002 R09: 0000000000000000
> [    8.168809] R10: fffffbfff11baf82 R11: 1ffffffff134edc5 R12: ffff880036e88038
> [    8.168809] R13: 000000009a9d2d40 R14: ffff880036e88030 R15: 0000000099383d98
> [    8.168809] FS:  0000000000000000(0000) GS:ffff88006d600000(0000)
> knlGS:0000000000000000
> [    8.168809] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
> [    8.168809] CR2: 00000000ffffffff CR3: 0000000007a4b000 CR4: 00000000000006e0
> [    8.168809] Stack:
> [    8.168809]  ffff88006d097a70 ffffffff82c0e2da ffff88006d097aa8
> ffffffff814661a9
> [    8.168809]  ffff880036e88028 0000000000000082 ffff880036e90008
> ffff880036e90010
> [    8.168809]  0000000000000001 ffff88006d097ad0 ffffffff86652c47
> ffffffff83a80c4c
> [    8.168809] Call Trace:
> [    8.168809]  [<ffffffff82c0e2da>] __delay+0xa/0x10
> [    8.168809]  [<ffffffff814661a9>] do_raw_spin_lock+0x149/0x2b0
> [    8.168809]  [<ffffffff86652c47>] _raw_spin_lock_irqsave+0xa7/0xd0
> [    8.168809]  [<ffffffff83a80c4c>] ? ata_hsm_qc_complete+0x12c/0x420
> [    8.168809]  [<ffffffff83a80c4c>] ata_hsm_qc_complete+0x12c/0x420
> [    8.168809]  [<ffffffff83a82f42>] ata_sff_hsm_move+0x1e2/0x1c60
> [    8.168809]  [<ffffffff83a85f17>] ? ata_sff_pio_task+0x87/0x530
> [    8.168809]  [<ffffffff83a86296>] ata_sff_pio_task+0x406/0x530
> [    8.168809]  [<ffffffff813a2386>] process_one_work+0x796/0x1440
> [    8.168809]  [<ffffffff813a22ba>] ? process_one_work+0x6ca/0x1440
> [    8.168809]  [<ffffffff813d6190>] ? finish_task_switch+0x120/0x5f0
> [    8.168809]  [<ffffffff813a1bf0>] ? pwq_dec_nr_in_flight+0x2e0/0x2e0
> [    8.168809]  [<ffffffff813a310b>] worker_thread+0xdb/0xfc0
> [    8.168809]  [<ffffffff813b637f>] kthread+0x23f/0x2d0
> [    8.168809]  [<ffffffff813a3030>] ? process_one_work+0x1440/0x1440
> [    8.168809]  [<ffffffff813b6140>] ? kthread_create_on_node+0x3b0/0x3b0
> [    8.168809]  [<ffffffff813b6140>] ? kthread_create_on_node+0x3b0/0x3b0
> [    8.168809]  [<ffffffff8665362f>] ret_from_fork+0x3f/0x70
> [    8.168809]  [<ffffffff813b6140>] ? kthread_create_on_node+0x3b0/0x3b0
> 
> 
> 
> 
> >> diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
> >> index 608677d..6991efc 100644
> >> --- a/drivers/ata/libata-sff.c
> >> +++ b/drivers/ata/libata-sff.c
> >> @@ -1362,12 +1362,14 @@ static void ata_sff_pio_task(struct work_struct *work)
> >>         u8 status;
> >>         int poll_next;
> >>
> >> +       spin_lock_irq(ap->lock);
> >> +
> >>         BUG_ON(ap->sff_pio_task_link == NULL);
> >>         /* qc can be NULL if timeout occurred */
> >>         qc = ata_qc_from_tag(ap, link->active_tag);
> >>         if (!qc) {
> >>                 ap->sff_pio_task_link = NULL;
> >> -               return;
> >> +               goto out_unlock;
> >>         }
> >>
> >>  fsm_start:
> >> @@ -1382,11 +1384,14 @@ static void ata_sff_pio_task(struct work_struct *work)
> >>          */
> >>         status = ata_sff_busy_wait(ap, ATA_BUSY, 5);
> >>         if (status & ATA_BUSY) {
> >> +               spin_unlock_irq(ap->lock);
> >>                 ata_msleep(ap, 2);
> >> +               spin_lock_irq(ap->lock);
> >> +
> >>                 status = ata_sff_busy_wait(ap, ATA_BUSY, 10);
> >>                 if (status & ATA_BUSY) {
> >>                         ata_sff_queue_pio_task(link, ATA_SHORT_PAUSE);
> >> -                       return;
> >> +                       goto out_unlock;
> >>                 }
> >>         }
> >>
> >> @@ -1403,6 +1408,8 @@ static void ata_sff_pio_task(struct work_struct *work)
> >>          */
> >>         if (poll_next)
> >>                 goto fsm_start;
> >> +out_unlock:
> >> +       spin_unlock_irq(ap->lock);
> >>  }
> >>
> >>  /**
> >>
> >> --
> >> You received this message because you are subscribed to the Google Groups "syzkaller" group.
> >> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller+unsubscribe@googlegroups.com.
> >> For more options, visit https://groups.google.com/d/optout.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=libata-sff-check-task_state-hsm-patch

 drivers/ata/libata-sff.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index cdf6215..f70bc13 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -1050,6 +1050,7 @@ int ata_sff_hsm_move(struct ata_port *ap, struct ata_queued_cmd *qc,
 	struct ata_eh_info *ehi = &link->eh_info;
 	unsigned long flags = 0;
 	int poll_next;
+	unsigned int task_state;
 
 	WARN_ON_ONCE((qc->flags & ATA_QCFLAG_ACTIVE) == 0);
 
@@ -1063,7 +1064,11 @@ fsm_start:
 	DPRINTK("ata%u: protocol %d task_state %d (dev_stat 0x%X)\n",
 		ap->print_id, qc->tf.protocol, ap->hsm_task_state, status);
 
-	switch (ap->hsm_task_state) {
+	spin_lock_irq(ap->lock);
+	task_state = ap->hsm_task_state;
+	spin_unlock_irq(ap->lock);
+
+	switch (task_state) {
 	case HSM_ST_FIRST:
 		/* Send first data block or PACKET CDB */
 

--5mCyUwZo2JvN/JJP--
