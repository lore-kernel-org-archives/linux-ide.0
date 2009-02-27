From: Chuck Ebbert <cebbert@redhat.com>
Subject: ahci 0000:00:1f.2: DMA-API: device driver maps memory from stack
Date: Fri, 27 Feb 2009 18:42:50 -0500
Message-ID: <20090227184250.3dd6e7ce@dhcp-100-2-144.bos.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:34596 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761125AbZB0XnA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 27 Feb 2009 18:43:00 -0500
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n1RNgxvD018945
	for <linux-ide@vger.kernel.org>; Fri, 27 Feb 2009 18:42:59 -0500
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n1RNgxsp001257
	for <linux-ide@vger.kernel.org>; Fri, 27 Feb 2009 18:42:59 -0500
Received: from dhcp-100-2-144.bos.redhat.com (dhcp-100-2-144.bos.redhat.com [10.16.2.144])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n1RNgwR5020139
	for <linux-ide@vger.kernel.org>; Fri, 27 Feb 2009 18:42:59 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

With v3 of the DMA API debug patchset:

------------[ cut here ]------------
WARNING: at lib/dma-debug.c:515 check_for_stack+0x78/0x9a() (Not tainted)
Hardware name: 74585FU
ahci 0000:00:1f.2: DMA-API: device driver maps memory from stack
[addr=ffff880137929c00]
Modules linked in:
Pid: 645, comm: scsi_eh_1 Not tainted 2.6.29-0.172.rc6.git4.fc11.x86_64 #1
Call Trace:
 [<ffffffff8104ba7b>] warn_slowpath+0xbc/0xf0
 [<ffffffff81060061>] ? sys_timer_gettime+0x80/0x9b
 [<ffffffff8101781b>] ? native_sched_clock+0x2d/0x5a
 [<ffffffff810170b5>] ? sched_clock+0x9/0xc
 [<ffffffff811a72a0>] ? dma_entry_alloc+0x7e/0x86
 [<ffffffff81395baf>] ? _spin_unlock_irqrestore+0x41/0x58
 [<ffffffff811a6677>] check_for_stack+0x78/0x9a
 [<ffffffff811a73f3>] debug_dma_map_sg+0xd8/0x104
 [<ffffffff81263b0a>] ata_qc_issue+0x1f3/0x289
 [<ffffffff812641ce>] ? ata_exec_internal_sg+0x8c/0x4dc
 [<ffffffff812643c0>] ata_exec_internal_sg+0x27e/0x4dc
 [<ffffffff81395bb6>] ? _spin_unlock_irqrestore+0x48/0x58
 [<ffffffff812646ab>] ata_exec_internal+0x8d/0x9c
 [<ffffffff81393b89>] ? wait_for_common+0xcc/0x110
 [<ffffffff8126adb6>] atapi_eh_request_sense+0x9f/0xa8
 [<ffffffff8126dad8>] ata_eh_recover+0x92d/0xbbe
 [<ffffffff8106f4e5>] ? mark_lock+0x28/0x37f
 [<ffffffff812750aa>] ? ahci_postreset+0x0/0x5f
 [<ffffffff8127467f>] ? ahci_hardreset+0x0/0xeb
 [<ffffffff812765fe>] ? ahci_softreset+0x0/0x42
 [<ffffffff81263052>] ? ata_std_prereset+0x0/0xb7
 [<ffffffff81271e7b>] sata_pmp_error_handler+0xd3/0xa0a
 [<ffffffff8101781b>] ? native_sched_clock+0x2d/0x5a
 [<ffffffff8101781b>] ? native_sched_clock+0x2d/0x5a
 [<ffffffff810170b5>] ? sched_clock+0x9/0xc
 [<ffffffff8106e001>] ? lock_release_holdtime+0x2c/0x11d
 [<ffffffff81395bb6>] ? _spin_unlock_irqrestore+0x48/0x58
 [<ffffffff812750a6>] ahci_error_handler+0x4a/0x4e
 [<ffffffff8126e7a8>] ata_scsi_error+0x2c0/0x619
 [<ffffffff8124d189>] scsi_error_handler+0xdd/0x4fe
 [<ffffffff81395bb6>] ? _spin_unlock_irqrestore+0x48/0x58
 [<ffffffff8106fa96>] ? trace_hardirqs_on_caller+0x12f/0x153
 [<ffffffff8106fac7>] ? trace_hardirqs_on+0xd/0xf
 [<ffffffff8124d0ac>] ? scsi_error_handler+0x0/0x4fe
 [<ffffffff81060881>] kthread+0x4d/0x78
 [<ffffffff810126aa>] child_rip+0xa/0x20
 [<ffffffff8100f88b>] ? __switch_to+0x190/0x398
 [<ffffffff81011fbe>] ? restore_args+0x0/0x30
 [<ffffffff81060834>] ? kthread+0x0/0x78
 [<ffffffff810126a0>] ? child_rip+0x0/0x20
---[ end trace 88a6b0f8de8d369d ]---

AFAICT it's complaining about ata_exec_internal(),
which puts 'sg' on the stack, assigns 'psg' the
address of 'sg' and passes that pointer to lower
level code:

unsigned ata_exec_internal(struct ata_device *dev,
                           struct ata_taskfile *tf, const u8 *cdb,
                           int dma_dir, void *buf, unsigned int buflen,
                           unsigned long timeout)
{
        struct scatterlist *psg = NULL, sg;
        unsigned int n_elem = 0;

        if (dma_dir != DMA_NONE) {
                WARN_ON(!buf);
                sg_init_one(&sg, buf, buflen);
                psg = &sg;
                n_elem++;
        }

        return ata_exec_internal_sg(dev, tf, cdb, dma_dir, psg, n_elem,
                                    timeout);
}
