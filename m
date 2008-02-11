From: Elias Oltmanns <eo@nebensachen.de>
Subject: Re: Current qc_defer implementation may lead to infinite recursion
Date: Mon, 11 Feb 2008 23:03:10 +0100
Message-ID: <87r6fj2lsx.fsf@denkblock.local>
References: <87ir0w4rzo.fsf@denkblock.local> <47AFD7C1.7070204@gmail.com>
	<871w7k9b8y.fsf@denkblock.local> <47B00AA1.3010104@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nebensachen.de ([195.34.83.29]:38848 "EHLO mail.nebensachen.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755951AbYBKWDU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 11 Feb 2008 17:03:20 -0500
In-Reply-To: <47B00AA1.3010104@gmail.com> (Tejun Heo's message of "Mon, 11 Feb
	2008 17:43:13 +0900")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo <htejun@gmail.com> wrote:
> Hello,
>
> Elias Oltmanns wrote:
>>> Hmmm... The reason why max_host_blocked and max_device_blocked are set
>>> to 1 is to let libata re-consider status after each command completion
>>> as blocked status can be rather complex w/ PMP.  I haven't really
>>> followed the code yet but you're saying that blocked count of 2 should
>>> be used for that behavior, right?
>> 
>> Not quite. On an SMP system the current implementation will probably do
>> exactly what you had in mind. In particular, setting max_device_blocked
>> and max_host_blocked to 1 seems to be the right thing to do in this
>> case.
>
[...]
> I don't think such infinite recursions can happen because
> blk_run_queue() doesn't allow recursing more than once.

Quite right. Sorry for missing that. However, the problem remains
although I'm not too sure anymore whether libata is to blame. See below.

>
>>> Another strange thing is that there hasn't been any such lock up /
>>> infinite recursion report till now although ->qc_defer mechanism bas
>>> been used widely for some time now.  Can you reproduce the problem w/o
>>> the disk shock protection?
>> 
>> No, unfortunately, I'm unable to reproduce this without the patch on my
>> machine. This is for purely technical reasons though because I'm using
>> ata_piix. Running a vanilla kernel, I'd expect everything to work just
>> fine except for one case: A non-SMP system using a driver that provides
>> the ->qc_defer() callback. Currently, the ->qc_defer() callback is the
>> only thing that can possibly send a non zero return value to the scsi
>> midlayer. Once it does, however, the driver will only get a chance to
>> complete some qcs before ->qc_defer() is called again provided that
>> multithreading is supported.
>> 
>> So, what I'm saying is this: If the low level driver doesn't provide a
>> ->qc_defer() callback, there is no (obvious) reason why
>> max_device_blocked and max_host_blocked should be set to 1 since libata
>> won't gain anything by it. However, it is not a bug either, even though
>> James considers it suboptimal and I will have to think about a solution
>> for my patch. On the other hand, once a driver defines the ->qc_defer()
>> callback, we really have a bug because things will go wrong once
>> ->qc_defer() returns non zero on a uniprocessor. So, in this case
>> max_device_blocked and max_host_blocked should be set to 1 on an SMP
>> system and *have to* be bigger than 1 otherwise.
>
> Well, we need to support ->qc_defer on UP systems too.  I'm still very
> skeptical that the scenario you described can happen.  The mechanism is
> just used too widely for such problem to go unnoticed.  For example,
> deferring is exercised when FLUSH is issued to a driver which have
> in-flight NCQ commands.  If you have barrier enabled FS mounted on an
> NCQ enabled hard drive, such events will happen regularly but we haven't
> heard of any similar lock up or stack overflow till now.
>
> Feel free to add ->qc_defer to ata_piix and let it defer commands (say
> every 20th or any other criteria you seem fit for testing)

An excellent idea, although it took me some time to figure out what kind
of a qc_defer replacement would best fit my needs. Indeed, I can
reproduce the system freeze with a suitably crafted qc_defer callback.
See below the patch I've used to get it working. The intention is to
simulate the following scenario:

1. libata has accepted some commands from the midlayer already and has
   stored them on the private queue of some ata_port.
2. Eventually, qc_defer declines a command for whatever reason.
3. Even though an infinite recursion does not occur in the way I had
   suggested, qc_defer will decline this command again the next time
   because the general situation hasn't changed. In particular, all the
   commands that had already been enqueued for that port at the last
   time will still be there and will not have been processed or even
   changed in any way.

Hopefully, I didn't miss the crucial point this time. Please note that
you have to strip down the piix_qc_defer() function in this patch in
order to get the scenario described above. Just get rid of those two
if-blocks whose condition contains the expression

PIIX_QC_DEFER_THRESHOLD + 100

in some way. Not doing that will prevent the system from freezing
entirely but still lead to BUG: messages in dmesg. At least that's what
happens in my case. These messages suggest to me that libata may be not
the culprit after all. However, I have no experience with interpreting
them properly so I'd appreciate it if you had a look at them after you
have verified that my qc_defer function does indeed constitute a valid
test case. I'll append some of the messages I get after the patch.

Thanks for your help,

Elias


---
diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index b406b39..f4dede7 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -167,6 +167,7 @@ static void piix_set_dmamode(struct ata_
 static void ich_set_dmamode(struct ata_port *ap, struct ata_device *adev);
 static int ich_pata_cable_detect(struct ata_port *ap);
 static u8 piix_vmw_bmdma_status(struct ata_port *ap);
+static int piix_qc_defer(struct ata_queued_cmd *qc);
 #ifdef CONFIG_PM
 static int piix_pci_device_suspend(struct pci_dev *pdev, pm_message_t mesg);
 static int piix_pci_device_resume(struct pci_dev *pdev);
@@ -311,6 +312,7 @@ static const struct ata_port_operations 
 	.bmdma_start		= ata_bmdma_start,
 	.bmdma_stop		= ata_bmdma_stop,
 	.bmdma_status		= ata_bmdma_status,
+	.qc_defer		= piix_qc_defer,
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
 	.data_xfer		= ata_data_xfer,
@@ -343,6 +345,7 @@ static const struct ata_port_operations 
 	.bmdma_start		= ata_bmdma_start,
 	.bmdma_stop		= ata_bmdma_stop,
 	.bmdma_status		= ata_bmdma_status,
+	.qc_defer		= piix_qc_defer,
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
 	.data_xfer		= ata_data_xfer,
@@ -371,6 +374,7 @@ static const struct ata_port_operations 
 	.bmdma_start		= ata_bmdma_start,
 	.bmdma_stop		= ata_bmdma_stop,
 	.bmdma_status		= ata_bmdma_status,
+	.qc_defer		= piix_qc_defer,
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
 	.data_xfer		= ata_data_xfer,
@@ -402,6 +406,7 @@ static const struct ata_port_operations 
 	.bmdma_start		= ata_bmdma_start,
 	.bmdma_stop		= ata_bmdma_stop,
 	.bmdma_status		= piix_vmw_bmdma_status,
+	.qc_defer		= piix_qc_defer,
 	.qc_prep		= ata_qc_prep,
 	.qc_issue		= ata_qc_issue_prot,
 	.data_xfer		= ata_data_xfer,
@@ -419,6 +424,43 @@ static const struct ata_port_operations 
 	.port_start		= ata_port_start,
 };
 
+static int piix_qc_defer(struct ata_queued_cmd *qc)
+{
+	static struct ata_port *ap = NULL;
+	struct ata_queued_cmd qcmd[ATA_MAX_QUEUE];
+	static int count = 0;
+#define PIIX_QC_DEFER_THRESHOLD 5000
+
+	if (!ap)
+		ap = qc->ap;
+	else if (ap != qc->ap)
+		return 0;
+
+	if (count > PIIX_QC_DEFER_THRESHOLD + 100)
+		return 0;
+
+	count++;
+	if (count < PIIX_QC_DEFER_THRESHOLD)
+		return 0;
+	else if (count == PIIX_QC_DEFER_THRESHOLD) {
+		int i;
+		if (ap->qc_allocated) {
+			for (i = 0; i < ATA_MAX_QUEUE; i++)
+				qcmd[i] = ap->qcmd[i];
+			printk(KERN_DEBUG "piix_qc_defer(): saved current state\n");
+			msleep(5000);
+		} else
+			count--;
+	} else if (count == PIIX_QC_DEFER_THRESHOLD + 100) {
+		dump_stack();
+		count++;
+	} else if (memcmp(qcmd, ap->qcmd, sizeof(qcmd[0]) * ATA_MAX_QUEUE))
+		return ATA_DEFER_LINK;
+	else
+		count = 0;
+	return 0;
+}
+
 static const struct piix_map_db ich5_map_db = {
 	.mask = 0x7,
 	.port_enable = 0x3,
---


====================================================================
Feb 11 20:33:05 denkblock kernel: piix_qc_defer(): saved current state
Feb 11 20:33:11 denkblock kernel: BUG: scheduling while atomic: swapper/0/0x00000100
Feb 11 20:33:11 denkblock kernel: 
Feb 11 20:33:11 denkblock kernel: Pid: 0, comm: swapper Not tainted (2.6.24.1-dbg-1 #2)
Feb 11 20:33:11 denkblock kernel: EIP: 0060:[<e0021814>] EFLAGS: 00000216 CPU: 0
Feb 11 20:33:11 denkblock kernel: EIP is at acpi_processor_idle+0x245/0x3c5 [processor]
Feb 11 20:33:11 denkblock kernel: EAX: 4e9bda7e EBX: 00008f3f ECX: 00000358 EDX: 00000037
Feb 11 20:33:11 denkblock kernel: ESI: de52dac8 EDI: 007188d5 EBP: de52d800 ESP: c0309fc8
Feb 11 20:33:11 denkblock kernel:  DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068
Feb 11 20:33:11 denkblock kernel: CR0: 8005003b CR2: b7f11e20 CR3: 1c4ea000 CR4: 000006d0
Feb 11 20:33:11 denkblock kernel: DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
Feb 11 20:33:11 denkblock kernel: DR6: ffff0ff0 DR7: 00000400
Feb 11 20:33:11 denkblock kernel:  [cpu_idle+67/93] cpu_idle+0x43/0x5d
Feb 11 20:33:11 denkblock kernel:  [start_kernel+572/577] start_kernel+0x23c/0x241
Feb 11 20:33:11 denkblock kernel:  [unknown_bootoption+0/405] unknown_bootoption+0x0/0x195
Feb 11 20:33:11 denkblock kernel:  =======================
Feb 11 20:33:11 denkblock kernel: bad: scheduling from the idle thread!
Feb 11 20:33:11 denkblock kernel: Pid: 0, comm: swapper Not tainted 2.6.24.1-dbg-1 #2
Feb 11 20:33:11 denkblock kernel:  [dequeue_task_idle+21/24] dequeue_task_idle+0x15/0x18
Feb 11 20:33:11 denkblock kernel:  [dequeue_task+10/20] dequeue_task+0xa/0x14
Feb 11 20:33:11 denkblock kernel:  [deactivate_task+28/39] deactivate_task+0x1c/0x27
Feb 11 20:33:11 denkblock kernel:  [schedule+195/759] schedule+0xc3/0x2f7
Feb 11 20:33:11 denkblock kernel:  [<e003434e>] scsi_done+0x0/0x16 [scsi_mod]
Feb 11 20:33:11 denkblock kernel:  [schedule_timeout+110/139] schedule_timeout+0x6e/0x8b
Feb 11 20:33:11 denkblock kernel:  [process_timeout+0/5] process_timeout+0x0/0x5
Feb 11 20:33:11 denkblock kernel:  [schedule_timeout+105/139] schedule_timeout+0x69/0x8b
Feb 11 20:33:11 denkblock kernel:  [msleep+13/18] msleep+0xd/0x12
Feb 11 20:33:11 denkblock kernel:  [<e002c10b>] piix_qc_defer+0xa1/0xff [ata_piix]
Feb 11 20:33:11 denkblock kernel:  [<e003434e>] scsi_done+0x0/0x16 [scsi_mod]
Feb 11 20:33:11 denkblock kernel:  [<e0059518>] ata_scsi_qc_complete+0x0/0x36d [libata]
Feb 11 20:33:11 denkblock kernel:  [<e005556b>] ata_qc_complete_internal+0x0/0xb [libata]
Feb 11 20:33:11 denkblock kernel:  [<e00594e4>] ata_scsi_translate+0xd6/0x10a [libata]
Feb 11 20:33:11 denkblock kernel:  [<e003434e>] scsi_done+0x0/0x16 [scsi_mod]
Feb 11 20:33:11 denkblock kernel:  [<e005bb8f>] ata_scsi_queuecmd+0x17f/0x184 [libata]
Feb 11 20:33:11 denkblock kernel:  [<e005920a>] ata_scsi_rw_xlat+0x0/0x1de [libata]
Feb 11 20:33:11 denkblock kernel:  [<e0034aa8>] scsi_dispatch_cmd+0x197/0x20b [scsi_mod]
Feb 11 20:33:11 denkblock kernel:  [<e0039b33>] scsi_request_fn+0x256/0x2d7 [scsi_mod]
Feb 11 20:33:11 denkblock kernel:  [as_completed_request+438/451] as_completed_request+0x1b6/0x1c3
Feb 11 20:33:11 denkblock kernel:  [blk_run_queue+42/75] blk_run_queue+0x2a/0x4b
Feb 11 20:33:11 denkblock kernel:  [<e0038702>] scsi_next_command+0x25/0x2f [scsi_mod]
Feb 11 20:33:11 denkblock kernel:  [<e0038810>] scsi_end_request+0x8f/0x99 [scsi_mod]
Feb 11 20:33:11 denkblock kernel:  [<e0039407>] scsi_io_completion+0x150/0x302 [scsi_mod]
Feb 11 20:33:11 denkblock kernel:  [blk_done_softirq+74/85] blk_done_softirq+0x4a/0x55
Feb 11 20:33:11 denkblock kernel:  [__do_softirq+53/117] __do_softirq+0x35/0x75
Feb 11 20:33:11 denkblock kernel:  [do_softirq+34/38] do_softirq+0x22/0x26
Feb 11 20:33:11 denkblock kernel:  [irq_exit+41/88] irq_exit+0x29/0x58
Feb 11 20:33:11 denkblock kernel:  [do_IRQ+88/107] do_IRQ+0x58/0x6b
Feb 11 20:33:11 denkblock kernel:  [tick_notify+356/547] tick_notify+0x164/0x223
Feb 11 20:33:11 denkblock kernel:  [acpi_hw_register_read+129/297] acpi_hw_register_read+0x81/0x129
Feb 11 20:33:11 denkblock kernel:  [common_interrupt+35/40] common_interrupt+0x23/0x28
Feb 11 20:33:11 denkblock kernel:  [<e0021814>] acpi_processor_idle+0x245/0x3c5 [processor]
Feb 11 20:33:11 denkblock kernel:  [cpu_idle+67/93] cpu_idle+0x43/0x5d
Feb 11 20:33:11 denkblock kernel:  [start_kernel+572/577] start_kernel+0x23c/0x241
Feb 11 20:33:11 denkblock kernel:  [unknown_bootoption+0/405] unknown_bootoption+0x0/0x195
Feb 11 20:33:11 denkblock kernel:  =======================


This block (except for the first line) is repeated 27 times with
virtually no variance. Then it proceeds like this:


Feb 11 20:33:11 denkblock kernel: BUG: scheduling while atomic: swapper/0/0x00000100
Feb 11 20:33:11 denkblock kernel: 
Feb 11 20:33:11 denkblock kernel: Pid: 0, comm: swapper Not tainted (2.6.24.1-dbg-1 #2)
Feb 11 20:33:11 denkblock kernel: EIP: 0060:[<e0021814>] EFLAGS: 00000216 CPU: 0
Feb 11 20:33:11 denkblock kernel: EIP is at acpi_processor_idle+0x245/0x3c5 [processor]
Feb 11 20:33:11 denkblock kernel: EAX: 4e9bda7e EBX: 00008f3f ECX: 00000358 EDX: 00000037
Feb 11 20:33:11 denkblock kernel: ESI: de52dac8 EDI: 007188d5 EBP: de52d800 ESP: c0309fc8
Feb 11 20:33:11 denkblock kernel:  DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068
Feb 11 20:33:11 denkblock kernel: CR0: 8005003b CR2: b7f11e20 CR3: 1c5fb000 CR4: 000006d0
Feb 11 20:33:11 denkblock kernel: DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
Feb 11 20:33:11 denkblock kernel: DR6: ffff0ff0 DR7: 00000400
Feb 11 20:33:11 denkblock kernel:  [cpu_idle+67/93] cpu_idle+0x43/0x5d
Feb 11 20:33:11 denkblock kernel:  [start_kernel+572/577] start_kernel+0x23c/0x241
Feb 11 20:33:11 denkblock kernel:  [unknown_bootoption+0/405] unknown_bootoption+0x0/0x195
Feb 11 20:33:11 denkblock kernel:  =======================
Feb 11 20:33:11 denkblock kernel: bad: scheduling from the idle thread!
Feb 11 20:33:11 denkblock kernel: Pid: 0, comm: swapper Not tainted 2.6.24.1-dbg-1 #2
Feb 11 20:33:11 denkblock kernel:  [dequeue_task_idle+21/24] dequeue_task_idle+0x15/0x18
Feb 11 20:33:11 denkblock kernel:  [dequeue_task+10/20] dequeue_task+0xa/0x14
Feb 11 20:33:11 denkblock kernel:  [deactivate_task+28/39] deactivate_task+0x1c/0x27
Feb 11 20:33:11 denkblock kernel:  [schedule+195/759] schedule+0xc3/0x2f7
Feb 11 20:33:11 denkblock kernel:  [<e003434e>] scsi_done+0x0/0x16 [scsi_mod]
Feb 11 20:33:11 denkblock kernel:  [schedule_timeout+110/139] schedule_timeout+0x6e/0x8b
Feb 11 20:33:11 denkblock kernel:  [process_timeout+0/5] process_timeout+0x0/0x5
Feb 11 20:33:11 denkblock kernel: ===
Feb 11 20:33:11 denkblock kernel: Pid: 31, comm: kblockd/0 Not tainted 2.6.24.1-dbg-1 #2
Feb 11 20:33:11 denkblock kernel:  [<e002c125>] piix_qc_defer+0xbb/0xff [ata_piix]
Feb 11 20:33:11 denkblock kernel:  [__alloc_pages+96/718] __alloc_pages+0x60/0x2ce
Feb 11 20:33:11 denkblock kernel:  [clockevents_program_event+224/238] clockevents_program_event+0xe0/0xee
Feb 11 20:33:11 denkblock kernel:  [<e0057f20>] ata_build_rw_tf+0x175/0x242 [libata]
Feb 11 20:33:11 denkblock kernel:  [<e0059347>] ata_scsi_rw_xlat+0x13d/0x1de [libata]
Feb 11 20:33:11 denkblock kernel:  [insert_work+89/92] insert_work+0x59/0x5c
Feb 11 20:33:11 denkblock kernel:  [<e0057f20>] ata_build_rw_tf+0x175/0x242 [libata]
Feb 11 20:33:11 denkblock kernel:  [<e0059347>] ata_scsi_rw_xlat+0x13d/0x1de [libata]
Feb 11 20:33:11 denkblock kernel:  [<e00594e4>] ata_scsi_translate+0xd6/0x10a [libata]
Feb 11 20:33:11 denkblock kernel:  [<e003434e>] scsi_done+0x0/0x16 [scsi_mod]
Feb 11 20:33:11 denkblock kernel:  [<e005bb8f>] ata_scsi_queuecmd+0x17f/0x184 [libata]
Feb 11 20:33:11 denkblock kernel:  [<e005920a>] ata_scsi_rw_xlat+0x0/0x1de [libata]
Feb 11 20:33:11 denkblock kernel:  [<e0034aa8>] scsi_dispatch_cmd+0x197/0x20b [scsi_mod]
Feb 11 20:33:11 denkblock kernel:  [<e0039b33>] scsi_request_fn+0x256/0x2d7 [scsi_mod]
Feb 11 20:33:11 denkblock kernel:  [blk_remove_plug+78/90] blk_remove_plug+0x4e/0x5a
Feb 11 20:33:11 denkblock kernel:  [blk_unplug_work+0/12] blk_unplug_work+0x0/0xc
Feb 11 20:33:11 denkblock kernel:  [__generic_unplug_device+29/31] __generic_unplug_device+0x1d/0x1f
Feb 11 20:33:11 denkblock kernel:  [generic_unplug_device+6/8] generic_unplug_device+0x6/0x8
Feb 11 20:33:11 denkblock kernel:  [blk_unplug_work+11/12] blk_unplug_work+0xb/0xc
Feb 11 20:33:11 denkblock kernel:  [run_workqueue+107/223] run_workqueue+0x6b/0xdf
Feb 11 20:33:11 denkblock kernel:  [worker_thread+0/189] worker_thread+0x0/0xbd
Feb 11 20:33:11 denkblock kernel:  [worker_thread+178/189] worker_thread+0xb2/0xbd
Feb 11 20:33:11 denkblock kernel:  [autoremove_wake_function+0/53] autoremove_wake_function+0x0/0x35
Feb 11 20:33:11 denkblock kernel:  [kthread+54/93] kthread+0x36/0x5d
Feb 11 20:33:11 denkblock kernel:  [kthread+0/93] kthread+0x0/0x5d
Feb 11 20:33:11 denkblock kernel:  [kernel_thread_helper+7/16] kernel_thread_helper+0x7/0x10
Feb 11 20:33:11 denkblock kernel:  =======================
Feb 11 20:33:11 denkblock kernel: bad: scheduling from the idle thread!
Feb 11 20:33:11 denkblock kernel: Pid: 0, comm: swapper Not tainted 2.6.24.1-dbg-1 #2
Feb 11 20:33:11 denkblock kernel:  [dequeue_task_idle+21/24] dequeue_task_idle+0x15/0x18
Feb 11 20:33:11 denkblock kernel:  [dequeue_task+10/20] dequeue_task+0xa/0x14
Feb 11 20:33:11 denkblock kernel:  [deactivate_task+28/39] deactivate_task+0x1c/0x27
Feb 11 20:33:11 denkblock kernel:  [schedule+195/759] schedule+0xc3/0x2f7
Feb 11 20:33:11 denkblock kernel:  [tick_nohz_restart_sched_tick+275/305] tick_nohz_restart_sched_tick+0x113/0x131
Feb 11 20:33:11 denkblock kernel:  [cpu_idle+91/93] cpu_idle+0x5b/0x5d
Feb 11 20:33:11 denkblock kernel:  [start_kernel+572/577] start_kernel+0x23c/0x241
Feb 11 20:33:11 denkblock kernel:  [unknown_bootoption+0/405] unknown_bootoption+0x0/0x195
Feb 11 20:33:11 denkblock kernel:  =======================


Now, the last block beginning with the lines

Feb 11 20:33:11 denkblock kernel: bad: scheduling from the idle thread!
Feb 11 20:33:11 denkblock kernel: Pid: 0, comm: swapper Not tainted 2.6.24.1-dbg-1 #2

is repeated for (p)ages with minor variations. For instance, it would
occasionally read like this:

Feb 11 20:33:11 denkblock kernel: bad: scheduling from the idle thread!
Feb 11 20:33:11 denkblock kernel: Pid: 0, comm: swapper Not tainted 2.6.24.1-dbg-1 #2
Feb 11 20:33:11 denkblock kernel:  [dequeue_task_idle+21/24] dequeue_task_idle+0x15/0x18
Feb 11 20:33:11 denkblock kernel:  [dequeue_task+10/20] dequeue_task+0xa/0x14
Feb 11 20:33:11 denkblock kernel:  [deactivate_task+28/39] deactivate_task+0x1c/0x27
Feb 11 20:33:11 denkblock kernel:  [schedule+195/759] schedule+0xc3/0x2f7
Feb 11 20:33:11 denkblock kernel:  [tick_nohz_restart_sched_tick+275/305] tick_nohz_restart_sched_tick+0x113/0x131
Feb 11 20:33:11 denkblock kernel:  [cpu_idle+91/93] cpu_idle+0x5b/0x5d
Feb 11 20:33:11 denkblock kernel:  [start_kernel+572/577] start_kernel+0x23c/0x241
Feb 11 20:33:11 denkblock kernel:  [unknown_bootoption+0/405] unknown_bootoption+0x0/0x195
Feb 11 20:33:11 denkblock kernel:  =======================
