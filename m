From: Brad Campbell <brad@wasp.net.au>
Subject: Re: sata media errors not propagated? (was Re: sata_via issue)
Date: Tue, 17 Aug 2004 22:57:00 +0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <412254FC.2010207@wasp.net.au>
References: <1092741447.1581.33.camel@localhost> <4122350F.3040700@wasp.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wasp.net.au ([203.190.192.17]:12236 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S266596AbUHQS4c (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Aug 2004 14:56:32 -0400
In-Reply-To: <4122350F.3040700@wasp.net.au>
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Brad Campbell wrote:
> About here, scsi passes a command down to libata, ata_queued_cmd which 
> causes the next 3 messages.
> libata never errors out here and completes the request so it all falls 
> in a heap.
> I'm going out to dinner, I'll see if I can trace it further later tonight.
> 
>> ATA: abnormal status 0x59 on port 0xB807
>> ATA: abnormal status 0x59 on port 0xB807
>> ATA: abnormal status 0x59 on port 0xB807

OOOooooo it's timing sensitive.
I sprinkled some printk's around and now scsi_request_fn is stuck in an infinite loop as this 
evaluates as true. In case you are wondering where all the 12345 and the like come from, I'm 
including my scsi_request_fn with it's added printk's

                 if (!scsi_host_queue_ready(q, shost, sdev))
                         goto not_ready;

Aug 17 22:32:54 srv kernel: 123456789ABata_queued_cmd
Aug 17 22:32:54 srv kernel: ata_qc_new_init
Aug 17 22:32:54 srv kernel: ata_qc_new
Aug 17 22:32:54 srv kernel: ata_qc_new out
Aug 17 22:32:54 srv kernel: ata_qc_new_init out
Aug 17 22:32:54 srv kernel:  ata_qc_issue
Aug 17 22:32:54 srv kernel: ata_qc_issue_out
Aug 17 22:32:54 srv kernel: ata_qc_issue_prot
Aug 17 22:32:54 srv kernel: ata_qc_issue_prot out
Aug 17 22:32:54 srv kernel: CD3EHI
Aug 17 22:33:24 srv kernel: ata13: command 0x25 timeout, stat 0xd0 host_stat 0x1
Aug 17 22:33:24 srv kernel: ata_qc_complete
Aug 17 22:33:24 srv kernel: ata_scsi_qc_complete
Aug 17 22:33:24 srv kernel: scsi12: ERROR on channel 0, id 0, lun 0, CDB: Read (10) 00 00 00 00 00 
00 00 80 00
Aug 17 22:33:24 srv kernel: Current sda: sense key Medium Error
Aug 17 22:33:24 srv kernel: Additional sense: Unrecovered read error - auto reallocate failed
Aug 17 22:33:24 srv kernel: end_request: I/O error, dev sda, sector 0
Aug 17 22:33:24 srv kernel: Buffer I/O error on device sda, logical block 0
Aug 17 22:33:24 srv kernel: 123456FGHI
Aug 17 22:33:24 srv kernel: 123456FGHI
Aug 17 22:33:24 srv kernel: ata_qc_complete_out
Aug 17 22:33:24 srv kernel: 123456FGHI
Aug 17 22:33:24 srv kernel: 123456FGHI
This last line loops forever and prevent me from doing anything at all on the console.
Notice no abnormal status messages anymore.

Progress! Without the extra printk's in libata-core and libata-scsi this was how it went

Aug 17 22:01:10 srv kernel: 123456789ABata_queued_cmd
Aug 17 22:01:10 srv kernel: CD3EHI
Aug 17 22:01:40 srv kernel: ata13: command 0x25 timeout, stat 0xd0 host_stat 0x1
Aug 17 22:01:40 srv kernel: ata_scsi_qc_complete
Aug 17 22:01:40 srv kernel: scsi12: ERROR on channel 0, id 0, lun 0, CDB: Read (10) 00 00 00 00 80 
00 00 80 00
Aug 17 22:01:40 srv kernel: Current sda: sense key Medium Error
Aug 17 22:01:41 srv kernel: Additional sense: Unrecovered read error - auto reallocate failed
Aug 17 22:01:41 srv kernel: end_request: I/O error, dev sda, sector 128
Aug 17 22:01:41 srv kernel: Buffer I/O error on device sda, logical block 128
Aug 17 22:01:41 srv kernel: 123456FGHI
Aug 17 22:01:41 srv kernel: 123456FGHI
Aug 17 22:01:41 srv kernel: 123456789ABata_queued_cmd
Aug 17 22:01:41 srv kernel: ATA: abnormal status 0xD0 on port 0x8807
Aug 17 22:01:41 srv last message repeated 2 times
Aug 17 22:01:41 srv kernel: CD3EHI
This just sits here idle with dd in the D state.

dd's call trace for the above log.

Aug 17 20:00:52 srv kernel: dd            D DFCA4C88     0  1681   1585                     (NOTLB)
Aug 17 20:00:52 srv kernel: dce31dfc 00000086 dce31e34 dfca4c88 c01048b4 78601dca 00000034 dfaa1790
Aug 17 20:00:52 srv kernel:        000d6653 78603c1f 00000034 0000031d 7860af72 00000034 dcccea68 
c130cd60
Aug 17 20:00:52 srv kernel:        c1400588 dce31e34 dce31e04 c02fd98e dfca4c88 c01310f5 c130cd60 
00000000
Aug 17 20:00:52 srv kernel: Call Trace:
Aug 17 20:00:52 srv kernel:  [<c01048b4>] common_interrupt+0x18/0x20
Aug 17 20:00:52 srv kernel:  [<c02fd98e>] io_schedule+0xe/0x20
Aug 17 20:00:52 srv kernel:  [<c01310f5>] __lock_page+0xc5/0xf0
Aug 17 20:00:52 srv kernel:  [<c0130e40>] page_wake_function+0x0/0x50
Aug 17 20:00:52 srv kernel:  [<c0130e40>] page_wake_function+0x0/0x50
Aug 17 20:00:52 srv kernel:  [<c01318da>] do_generic_mapping_read+0x3ca/0x480
Aug 17 20:00:52 srv kernel:  [<c0131c47>] __generic_file_aio_read+0x1d7/0x210
Aug 17 20:00:52 srv kernel:  [<c0131990>] file_read_actor+0x0/0xe0
Aug 17 20:00:52 srv kernel:  [<c0131d5f>] generic_file_read+0x6f/0x90
Aug 17 20:00:52 srv kernel:  [<c01154eb>] scheduler_tick+0x1b/0x400
Aug 17 20:00:52 srv kernel:  [<c012060f>] do_timer+0xcf/0xe0
Aug 17 20:00:52 srv kernel:  [<c014c5b0>] vfs_read+0xb0/0x100
Aug 17 20:00:52 srv kernel:  [<c014c7e7>] sys_read+0x47/0x80
Aug 17 20:00:52 srv kernel:  [<c0103f47>] syscall_call+0x7/0xb



static void scsi_request_fn(struct request_queue *q)
{
         struct scsi_device *sdev = q->queuedata;
         struct Scsi_Host *shost = sdev->host;
         struct scsi_cmnd *cmd;
         struct request *req;

         printk("1");
         if(!get_device(&sdev->sdev_gendev))
                 /* We must be tearing the block queue down already */
                 return;

         /*
          * To start with, we keep looping until the queue is empty, or until
          * the host is no longer able to accept any more requests.
          */
         printk("2");
         while (!blk_queue_plugged(q)) {
                 int rtn;
                 /*
                  * get next queueable request.  We do this early to make sure
                  * that the request is fully prepared even if we cannot
                  * accept it.
                  */
                 printk("3");
                 req = elv_next_request(q);
                 if (!req || !scsi_dev_queue_ready(q, sdev))
                         break;
                 printk("4");
                 if (unlikely(!scsi_device_online(sdev))) {
                         printk(KERN_ERR "scsi%d (%d:%d): rejecting I/O to offline device\n",
                                sdev->host->host_no, sdev->id, sdev->lun);
                         blkdev_dequeue_request(req);
                         req->flags |= REQ_QUIET;
                         while (end_that_request_first(req, 0, req->nr_sectors))
                                 ;
                         end_that_request_last(req);
                         continue;
                 }


                 /*
                  * Remove the request from the request list.
                  */
                 if (!(blk_queue_tagged(q) && !blk_queue_start_tag(q, req)))
                         blkdev_dequeue_request(req);
                 sdev->device_busy++;
                 printk("5");
                 spin_unlock(q->queue_lock);
                 spin_lock(shost->host_lock);
                 printk("6");
                 if (!scsi_host_queue_ready(q, shost, sdev))
                         goto not_ready;
                 printk("7");
                 if (sdev->single_lun) {
                         if (sdev->sdev_target->starget_sdev_user &&
                             sdev->sdev_target->starget_sdev_user != sdev)
                                 goto not_ready;
                         sdev->sdev_target->starget_sdev_user = sdev;
                 }
                 shost->host_busy++;
                 printk("8");

                 /*
                  * XXX(hch): This is rather suboptimal, scsi_dispatch_cmd will
                  *              take the lock again.
                  */
                 spin_unlock_irq(shost->host_lock);
                 printk("9");

                 cmd = req->special;
                 if (unlikely(cmd == NULL)) {
                         printk(KERN_CRIT "impossible request in %s.\n"
                                          "please mail a stack trace to "
                                          "linux-scsi@vger.kernel.org",
                                          __FUNCTION__);
                         BUG();
                 }
                 printk("A");

                 /*
                  * Finally, initialize any error handling parameters, and set up
                  * the timers for timeouts.
                  */
                 scsi_init_cmd_errh(cmd);
                 printk("B");

                 /*
                  * Dispatch the command to the low-level driver.
                  */
                 rtn = scsi_dispatch_cmd(cmd);
                 spin_lock_irq(q->queue_lock);
                 printk("C");
                 if(rtn) {
                         /* we're refusing the command; because of
                          * the way locks get dropped, we need to
                          * check here if plugging is required */
                         if(sdev->device_busy == 0)
                                 blk_plug_device(q);

                         break;
                 }
                 printk("D");
         }

                 printk("E");
         goto out;

  not_ready:
         spin_unlock_irq(shost->host_lock);
                 printk("F");

         /*
          * lock q, handle tag, requeue req, and decrement device_busy. We
          * must return with queue_lock held.
          *
          * Decrementing device_busy without checking it is OK, as all such
          * cases (host limits or settings) should run the queue at some
          * later time.
          */
         spin_lock_irq(q->queue_lock);
         blk_requeue_request(q, req);
         sdev->device_busy--;
         if(sdev->device_busy == 0)
                 blk_plug_device(q);
                 printk("G");
  out:
         /* must be careful here...if we trigger the ->remove() function
          * we cannot be holding the q lock */
                 printk("H");
         spin_unlock_irq(q->queue_lock);
         put_device(&sdev->sdev_gendev);
         spin_lock_irq(q->queue_lock);
                 printk("I\n");
}


Does anyone get the idea I'm stumbling around in the dark ? ;p)

Regards,
Brad
