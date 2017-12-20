From: Jason Yan <yanaijie@huawei.com>
Subject: about warning in ata_eh_finish()
Date: Wed, 20 Dec 2017 14:13:25 +0800
Message-ID: <5A39FF85.1040904@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from szxga07-in.huawei.com ([45.249.212.35]:35981 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751978AbdLTGPK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Wed, 20 Dec 2017 01:15:10 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org, linux-ide@vger.kernel.org

Hi, Tejun,

We often see this warning when using sata disks with libsas:

[26705.760518] WARNING: CPU: 1 PID: 6796 at drivers/ata/libata-eh.c:4037 
ata_eh_finish+0xb4/0xcc

[26706.350156] [<ffff0000088baf70>] ata_eh_finish+0xb4/0xcc
[26706.364260] [<ffff0000088bb764>] ata_do_eh+0x68/0xd8
[26706.377497] [<ffff0000088bb818>] ata_std_error_handler+0x44/0x8c
[26706.393406] [<ffff0000088bb408>] ata_scsi_port_error_handler+0x480/0x694
[26706.411352] [<ffff000008879364>] async_sas_ata_eh+0x4c/0x80
[26706.426133] [<ffff0000080f6be8>] async_run_entry_fn+0x4c/0x170
[26706.441841] [<ffff0000080ebd70>] process_one_work+0x144/0x390
[26706.457057] [<ffff0000080ec100>] worker_thread+0x144/0x418
[26706.471610] [<ffff0000080f2c98>] kthread+0x10c/0x138
[26706.484991] [<ffff0000080855dc>] ret_from_fork+0x10/0x18

This seems implies that ap->nr_active_links is wrong and should be zero.
But I didn't see any other errors. The disks work well.

Question:
ap->nr_active_links seems can be modified by different cpus 
simultaneously, should it be atomic_t? Is this the reason of the warning
above?

