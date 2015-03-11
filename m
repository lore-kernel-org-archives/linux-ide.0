From: Tony Battersby <tonyb@cybernetics.com>
Subject: Re: [PATCH] libata: revert "libata: use blk taging" et al.
Date: Wed, 11 Mar 2015 18:19:27 -0400
Message-ID: <5500BF6F.6080000@cybernetics.com>
References: <5500863D.4070807@cybernetics.com> <5500B783.20106@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5500B783.20106@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jens Axboe <axboe@fb.com>, Tejun Heo <tj@kernel.org>, Shaohua Li <shli@fb.com>, linux-ide@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>, Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On 03/11/2015 05:45 PM, Jens Axboe wrote:
> On 03/11/2015 02:15 PM, Tony Battersby wrote:
>> This reverts commits 12cb5ce101abfaf74421f8cc9f196e708209eb79 and
>> 98bd4be1ba95f2fe7f543910792b7163a5de06eb.
>>
>> Commit 12cb5ce101ab ("libata: use blk taging") causes the following oops
>> with scsi-mq enabled:
>>
>> BUG: unable to handle kernel NULL pointer dereference at 0000000000000058
>> IP: [<ffffffff804fd46e>] ata_qc_new_init+0x3e/0x120
>> PGD 32adf0067 PUD 32adf1067 PMD 0
>> Oops: 0002 [#1] SMP DEBUG_PAGEALLOC
>> Modules linked in: iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi igb
>> i2c_algo_bit ptp pps_core pm80xx libsas scsi_transport_sas sg coretemp
>> eeprom w83795 i2c_i801
>> CPU: 4 PID: 1450 Comm: cydiskbench Not tainted 4.0.0-rc3 #1
>> Hardware name: Supermicro X8DTH-i/6/iF/6F/X8DTH, BIOS 2.1b       05/04/12
>> task: ffff8800ba86d500 ti: ffff88032a064000 task.ti: ffff88032a064000
>> RIP: 0010:[<ffffffff804fd46e>]  [<ffffffff804fd46e>] ata_qc_new_init+0x3e/0x120
>> RSP: 0018:ffff88032a067858  EFLAGS: 00010046
>> RAX: 0000000000000000 RBX: ffff8800ba0d2230 RCX: 000000000000002a
>> RDX: ffffffff80505ae0 RSI: 0000000000000020 RDI: ffff8800ba0d2230
>> RBP: ffff88032a067868 R08: 0000000000000201 R09: 0000000000000001
>> R10: 0000000000000000 R11: 0000000000000000 R12: ffff8800ba0d0000
>> R13: ffff8800ba0d2230 R14: ffffffff80505ae0 R15: ffff8800ba0d0000
>> FS:  0000000041223950(0063) GS:ffff88033e480000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
>> CR2: 0000000000000058 CR3: 000000032a0a3000 CR4: 00000000000006e0
>> Stack:
>>   ffff880329eee758 ffff880329eee758 ffff88032a0678a8 ffffffff80502dad
>>   ffff8800ba167978 ffff880329eee758 ffff88032bf9c520 ffff8800ba167978
>>   ffff88032bf9c520 ffff88032bf9a290 ffff88032a0678b8 ffffffff80506909
>> Call Trace:
>>   [<ffffffff80502dad>] ata_scsi_translate+0x3d/0x1b0
>>   [<ffffffff80506909>] ata_sas_queuecmd+0x149/0x2a0
>>   [<ffffffffa0046650>] sas_queuecommand+0xa0/0x1f0 [libsas]
>>   [<ffffffff804ea544>] scsi_dispatch_cmd+0xd4/0x1a0
>>   [<ffffffff804eb50f>] scsi_queue_rq+0x66f/0x7f0
>>   [<ffffffff803e5098>] __blk_mq_run_hw_queue+0x208/0x3f0
>>   [<ffffffff803e54b8>] blk_mq_run_hw_queue+0x88/0xc0
>>   [<ffffffff803e5c74>] blk_mq_insert_request+0xc4/0x130
>>   [<ffffffff803e0b63>] blk_execute_rq_nowait+0x73/0x160
>>   [<ffffffffa0023fca>] sg_common_write+0x3da/0x720 [sg]
>>   [<ffffffff80308b8e>] ? might_fault+0x5e/0xb0
>>   [<ffffffffa0025100>] sg_new_write+0x250/0x360 [sg]
>>   [<ffffffff802a236c>] ? __lock_acquire+0x50c/0xc10
>>   [<ffffffff802a2b87>] ? lock_release_non_nested+0xa7/0x360
>>   [<ffffffff8068954b>] ? _raw_spin_unlock_irqrestore+0x3b/0x60
>>   [<ffffffff80308b8e>] ? might_fault+0x5e/0xb0
>>   [<ffffffff80308b8e>] ? might_fault+0x5e/0xb0
>>   [<ffffffffa0025feb>] sg_write+0x13b/0x450 [sg]
>>   [<ffffffff802a236c>] ? __lock_acquire+0x50c/0xc10
>>   [<ffffffff802cb1e9>] ? do_futex+0x109/0xbf0
>>   [<ffffffff80308b8e>] ? might_fault+0x5e/0xb0
>>   [<ffffffff8032ec91>] vfs_write+0xd1/0x1b0
>>   [<ffffffff8032ee54>] SyS_write+0x54/0xc0
>>   [<ffffffff80689932>] system_call_fastpath+0x12/0x17
>> Code: 24 20 04 0f 85 ec 00 00 00 49 83 3c 24 00 0f 84 cf 00 00 00 83 fe 1f
>> 0f 87 dc 00 00 00 89 f0 48 69 c0 f0 00 00 00 49 8d 44 04 40 <89> 70 58 48
>> c7 40 10 00 00 00 00 4c 89 20 48 89 58 08 c7 40 64
>> RIP  [<ffffffff804fd46e>] ata_qc_new_init+0x3e/0x120
>>   RSP <ffff88032a067858>
>> CR2: 0000000000000058
>> ---[ end trace 43f5eefb64627eff ]---
>>
>>
>> scsi-mq uses a host-wide tag map shared among all devices with some
>> integer tag values >= ATA_MAX_QUEUE.  These unexpectedly high tag values
>> cause __ata_qc_from_tag() to return NULL, which is then dereferenced in
>> ata_qc_new_init(), causing the oops above.
> Wait, something is missing here. We should not be getting tag values 
> that are >= ATA_MAX_QUEUE. Instead of reverting this, we need to figure 
> out why this is happening, and fix it. That is correct way forward here. 
> What setup is this being reproduced on?
>

Hardware:
PMC 8001 SAS HBA (PCI ID 117c:0042, PCI sub-ID 117c:0043) using pm80xx
driver
4 SATA disks directly connected (no expander)

Test procedure:
Send disk read/write commands to SATA disks using the SCSI generic (sg)
driver.

Analysis:

shost->can_queue is 508

With my patch applied to revert the problematic commits, I added the
following code to ata_scsi_qc_new():

    int tag = cmd->request->tag;
    static int max_tag;
    if (tag > max_tag) {
        max_tag = tag;
        printk(KERN_DEBUG "max tag %d\n", tag);
    }

Testing one SATA disk at a time with scsi-mq enabled, I get a max tag of
64.  Testing 4 disks at a time with scsi-mq enabled gives a max tag of
194.  With scsi-mq disabled, I get a max tag of 30 no matter how many
disks I test.

Tony
