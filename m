From: Robert Richter <rric@kernel.org>
Subject: Re: [PATCH] ahci: use pci_alloc_irq_vectors
Date: Fri, 21 Oct 2016 16:01:06 +0200
Message-ID: <20161021140106.GU25086@rric.localdomain>
References: <1473088905-27670-1-git-send-email-hch@lst.de>
 <1473088905-27670-2-git-send-email-hch@lst.de>
 <20160906163946.GB24268@htj.duckdns.org>
 <20161020154722.GH22012@rric.localdomain>
 <20161021125918.GA18082@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:36004 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755380AbcJUOBM (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 21 Oct 2016 10:01:12 -0400
Received: by mail-lf0-f66.google.com with SMTP id b75so6069200lfg.3
        for <linux-ide@vger.kernel.org>; Fri, 21 Oct 2016 07:01:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20161021125918.GA18082@lst.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Robert Richter <robert.richter@cavium.com>, Auger Eric <eric.auger@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, linux-ide@vger.kernel.org, dan.j.williamps@intel.com, Tejun Heo <tj@kernel.org>, linux-arm-kernel@lists.infradead.org

Christoph,

On 21.10.16 14:59:18, Christoph Hellwig wrote:
> can you try the latest fixed in the libata tree:
> 
> https://git.kernel.org/cgit/linux/kernel/git/tj/libata.git/log/?h=for-4.9-fixes

I see now this warning:

 WARNING: CPU: 0 PID: 1601 at drivers/ata/libata-core.c:6426 ata_host_activate+0x138/0x150

... and it still fails:

[   21.765921] ata1.00: qc timeout (cmd 0xec)
[   21.770031] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[   22.249869] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[   22.533896] ata4.00: qc timeout (cmd 0xec)
[   22.537996] ata4.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[   23.017874] ata4: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[   32.261874] ata1.00: qc timeout (cmd 0xec)
[   32.265972] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[   32.272059] ata1: limiting SATA link speed to 3.0 Gbps
[   32.753873] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[   33.029878] ata4.00: qc timeout (cmd 0xec)
[   33.033978] ata4.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[   33.040066] ata4: limiting SATA link speed to 3.0 Gbps
[   33.521884] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[   63.493874] ata1.00: qc timeout (cmd 0xec)
[   63.497973] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[   63.977867] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[   65.541890] ata4.00: qc timeout (cmd 0xec)
[   65.545987] ata4.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[   66.025873] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[   66.032337] VFS: Cannot open root device "sda2" or unknown-block(0,0): error -6
[   66.039682] Please append a correct "root=" boot option; here are the available partitions:
[   66.048047] Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0)

Full log below.

(Note that I tested a backported version based on 4.8 with all your 3
patches applied.)

-Robert


[   15.740362] ahci 0001:00:08.0: version 3.0
[   15.744577] ahci 0001:00:08.0: AHCI 0001.0300 32 slots 1 ports 6 Gbps 0x1 impl SATA mode
[   15.752670] ahci 0001:00:08.0: flags: 64bit ncq sntf ilck pm led clo only pmp fbs pio slum part ccc apst 
[   15.762239] ahci 0001:00:08.0: port 0 is not capable of FBS
[   15.767996] ------------[ cut here ]------------
[   15.772610] WARNING: CPU: 0 PID: 1601 at drivers/ata/libata-core.c:6426 ata_host_activate+0x138/0x150
[   15.781815] 
[   15.783298] CPU: 0 PID: 1601 Comm: kworker/0:1 Tainted: G        W       4.8.1-00004-gf0dadca853a2 #171
[   15.792677] Hardware name: www.cavium.com ThunderX CRB-2S/ThunderX CRB-2S, BIOS 0.3 Sep 13 2016
[   15.801365] Workqueue: events work_for_cpu_fn
[   15.805714] task: ffff800fcb5e4e00 task.stack: ffff800fcb618000
[   15.811622] PC is at ata_host_activate+0x138/0x150
[   15.816401] LR is at ata_host_activate+0x5c/0x150
[   15.821094] pc : [<ffff0000087b7868>] lr : [<ffff0000087b778c>] pstate: 60000045
[   15.828476] sp : ffff800fcb61bbb0
[   15.831780] x29: ffff800fcb61bbb0 x28: 0000000000000001 
[   15.837085] x27: ffff000009245408 x26: ffff000009245bf0 
[   15.842391] x25: ffff800fca8e40a0 x24: ffff800fcb451118 
[   15.847695] x23: 0000000000000080 x22: ffff000009245bf0 
[   15.853000] x21: 0000000000000000 x20: ffff0000087cddc8 
[   15.858305] x19: ffff800fcb451218 x18: ffff0000892f7d77 
[   15.863610] x17: ffff7fe003f2e820 x16: ffffffffffffff98 
[   15.868915] x15: 0000000000000006 x14: ffff0000092f7d85 
[   15.874220] x13: ffff00000979ffff x12: 0000000000000008 
[   15.879525] x11: 0088000000000000 x10: 0140000000000040 
[   15.884829] x9 : 0000000000000000 x8 : ffff000009796500 
[   15.890135] x7 : 0000000000000006 x6 : ffff800fcb618000 
[   15.895439] x5 : ffff800fcb901b00 x4 : 0000000000000000 
[   15.900744] x3 : ffff00001b000104 x2 : ffff800fcb451118 
[   15.906049] x1 : 0000000000000040 x0 : 0000000000000000 
[   15.911354] 
[   15.912835] ---[ end trace 2c145cc81872d49e ]---
[   15.917440] Call trace:
[   15.919876] Exception stack(0xffff800fcb61b9e0 to 0xffff800fcb61bb10)
[   15.926306] b9e0: ffff800fcb451218 0001000000000000 ffff800fcb61bbb0 ffff0000087b7868
[   15.934124] ba00: ffff000009780000 0000000000020000 0000000000000008 00e800000000070f
[   15.941942] ba20: 0000000000000000 ffff7fe000300100 ffff800fcb61bab0 ffff000008776250
[   15.949760] ba40: ffff800fca8e40a0 ffff800fca8e4150 0000000000000004 0000000000000040
[   15.957578] ba60: 0000000000016500 ffff800fcb451118 ffff800fcb61bab0 ffff0000087d10e8
[   15.965396] ba80: 0000000000000000 0000000000000040 ffff800fcb451118 ffff00001b000104
[   15.973214] baa0: 0000000000000000 ffff800fcb901b00 ffff800fcb618000 0000000000000006
[   15.981032] bac0: ffff000009796500 0000000000000000 0140000000000040 0088000000000000
[   15.988849] bae0: 0000000000000008 ffff00000979ffff ffff0000092f7d85 0000000000000006
[   15.996667] bb00: ffffffffffffff98 ffff7fe003f2e820
[   16.001533] [<ffff0000087b7868>] ata_host_activate+0x138/0x150
[   16.007356] [<ffff0000087d2950>] ahci_host_activate+0x138/0x170
[   16.013264] [<ffff0000087ced84>] ahci_init_one+0x8d4/0xd50
[   16.018740] [<ffff00000850f394>] local_pci_probe+0x3c/0xb8
[   16.024214] [<ffff0000080cc458>] work_for_cpu_fn+0x18/0x28
[   16.029689] [<ffff0000080ce710>] process_one_work+0x118/0x378
[   16.035424] [<ffff0000080cebd8>] worker_thread+0x268/0x4b0
[   16.040900] [<ffff0000080d4c10>] kthread+0xd0/0xe8
[   16.045680] [<ffff000008082e90>] ret_from_fork+0x10/0x40
[   16.051483] scsi host0: ahci
[   16.054531] ata1: SATA max UDMA/133 abar m2097152@0x814000000000 port 0x814000000100
[   16.062464] ahci 0001:00:09.0: AHCI 0001.0300 32 slots 1 ports 6 Gbps 0x1 impl SATA mode
[   16.070558] ahci 0001:00:09.0: flags: 64bit ncq sntf ilck pm led clo only pmp fbs pio slum part ccc apst 
[   16.080121] ahci 0001:00:09.0: port 0 is not capable of FBS
[   16.085790] ------------[ cut here ]------------
[   16.090400] WARNING: CPU: 0 PID: 1601 at drivers/ata/libata-core.c:6426 ata_host_activate+0x138/0x150
[   16.099604] 
[   16.101086] CPU: 0 PID: 1601 Comm: kworker/0:1 Tainted: G        W       4.8.1-00004-gf0dadca853a2 #171
[   16.110464] Hardware name: www.cavium.com ThunderX CRB-2S/ThunderX CRB-2S, BIOS 0.3 Sep 13 2016
[   16.119150] Workqueue: events work_for_cpu_fn
[   16.123498] task: ffff800fcb5e4e00 task.stack: ffff800fcb618000
[   16.129406] PC is at ata_host_activate+0x138/0x150
[   16.134186] LR is at ata_host_activate+0x5c/0x150
[   16.138878] pc : [<ffff0000087b7868>] lr : [<ffff0000087b778c>] pstate: 60000045
[   16.146260] sp : ffff800fcb61bbb0
[   16.149563] x29: ffff800fcb61bbb0 x28: 0000000000000001 
[   16.154868] x27: ffff000009245408 x26: ffff000009245bf0 
[   16.160172] x25: ffff800fca8e60a0 x24: ffff800fcb45ff18 
[   16.165477] x23: 0000000000000080 x22: ffff000009245bf0 
[   16.170781] x21: 0000000000000000 x20: ffff0000087cddc8 
[   16.176086] x19: ffff800fcb45fe18 x18: ffff0000892f7d77 
[   16.181390] x17: ffff7fe040029e60 x16: ffffffffffffff98 
[   16.186695] x15: 0000000000000006 x14: ffff0000092f7d85 
[   16.192000] x13: ffff000009f3ffff x12: 0000000000000008 
[   16.197304] x11: 0088000000000000 x10: 0140000000000040 
[   16.202608] x9 : 0000000000000000 x8 : ffff000009f36500 
[   16.207913] x7 : 0000000000000006 x6 : ffff800fcb618000 
[   16.213218] x5 : ffff800fcb903900 x4 : 0000000000000000 
[   16.218522] x3 : ffff00001b400104 x2 : ffff800fcb45ff18 
[   16.223827] x1 : 0000000000000040 x0 : 0000000000000000 
[   16.229131] 
[   16.230612] ---[ end trace 2c145cc81872d49f ]---
[   16.235216] Call trace:
[   16.237652] Exception stack(0xffff800fcb61b9e0 to 0xffff800fcb61bb10)
[   16.244081] b9e0: ffff800fcb45fe18 0001000000000000 ffff800fcb61bbb0 ffff0000087b7868
[   16.251899] ba00: ffff000009f20000 0000000000020000 0000000000000008 00e800000000070f
[   16.259717] ba20: 0000000000000000 ffff7fe000300180 ffff800fcb61bab0 ffff000008776250
[   16.267535] ba40: ffff800fca8e60a0 ffff800fca8e6150 0000000000000004 0000000000000040
[   16.275353] ba60: 0000000000016500 ffff800fcb45ff18 ffff800fcb61bab0 ffff0000087d10e8
[   16.283170] ba80: 0000000000000000 0000000000000040 ffff800fcb45ff18 ffff00001b400104
[   16.290988] baa0: 0000000000000000 ffff800fcb903900 ffff800fcb618000 0000000000000006
[   16.298806] bac0: ffff000009f36500 0000000000000000 0140000000000040 0088000000000000
[   16.306623] bae0: 0000000000000008 ffff000009f3ffff ffff0000092f7d85 0000000000000006
[   16.314440] bb00: ffffffffffffff98 ffff7fe040029e60
[   16.319307] [<ffff0000087b7868>] ata_host_activate+0x138/0x150
[   16.325128] [<ffff0000087d2950>] ahci_host_activate+0x138/0x170
[   16.331036] [<ffff0000087ced84>] ahci_init_one+0x8d4/0xd50
[   16.336510] [<ffff00000850f394>] local_pci_probe+0x3c/0xb8
[   16.341985] [<ffff0000080cc458>] work_for_cpu_fn+0x18/0x28
[   16.347458] [<ffff0000080ce710>] process_one_work+0x118/0x378
[   16.353192] [<ffff0000080cebd8>] worker_thread+0x268/0x4b0
[   16.358667] [<ffff0000080d4c10>] kthread+0xd0/0xe8
[   16.363447] [<ffff000008082e90>] ret_from_fork+0x10/0x40
[   16.369153] scsi host1: ahci
[   16.372172] ata2: SATA max UDMA/133 abar m2097152@0x815000000000 port 0x815000000100
[   16.380095] ahci 0001:00:0a.0: AHCI 0001.0300 32 slots 1 ports 6 Gbps 0x1 impl SATA mode
[   16.388189] ahci 0001:00:0a.0: flags: 64bit ncq sntf ilck pm led clo only pmp fbs pio slum part ccc apst 
[   16.397752] ahci 0001:00:0a.0: port 0 is not capable of FBS
[   16.403423] ------------[ cut here ]------------
[   16.408033] WARNING: CPU: 0 PID: 1601 at drivers/ata/libata-core.c:6426 ata_host_activate+0x138/0x150
[   16.417238] 
[   16.418719] CPU: 0 PID: 1601 Comm: kworker/0:1 Tainted: G        W       4.8.1-00004-gf0dadca853a2 #171
[   16.428098] Hardware name: www.cavium.com ThunderX CRB-2S/ThunderX CRB-2S, BIOS 0.3 Sep 13 2016
[   16.436784] Workqueue: events work_for_cpu_fn
[   16.441131] task: ffff800fcb5e4e00 task.stack: ffff800fcb618000
[   16.447039] PC is at ata_host_activate+0x138/0x150
[   16.451818] LR is at ata_host_activate+0x5c/0x150
[   16.456511] pc : [<ffff0000087b7868>] lr : [<ffff0000087b778c>] pstate: 60000045
[   16.463893] sp : ffff800fcb61bbb0
[   16.467196] x29: ffff800fcb61bbb0 x28: 0000000000000001 
[   16.472501] x27: ffff000009245408 x26: ffff000009245bf0 
[   16.477806] x25: ffff800fca8e80a0 x24: ffff800fcb451b18 
[   16.483111] x23: 0000000000000080 x22: ffff000009245bf0 
[   16.488415] x21: 0000000000000000 x20: ffff0000087cddc8 
[   16.493720] x19: ffff800fcb451c18 x18: ffff0000892f7d77 
[   16.499025] x17: ffff7fe003f2e6a0 x16: ffffffffffffff98 
[   16.504330] x15: 0000000000000006 x14: ffff0000092f7d85 
[   16.509634] x13: ffff000009f6ffff x12: 0000000000000008 
[   16.514939] x11: 0088000000000000 x10: 0140000000000040 
[   16.520244] x9 : 0000000000000000 x8 : ffff000009f66500 
[   16.525548] x7 : 0000000000000006 x6 : ffff800fcb618000 
[   16.530853] x5 : ffff800fcb905780 x4 : 0000000000000000 
[   16.536158] x3 : ffff00001b800104 [   16.537881] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)

[   16.545541] x2 : ffff800fcb451b18 
[   16.549110] x1 : 0000000000000040 x0 : 0000000000000000 
[   16.554414] 
[   16.555893] ---[ end trace 2c145cc81872d4a0 ]---
[   16.560499] Call trace:
[   16.562934] Exception stack(0xffff800fcb61b9e0 to 0xffff800fcb61bb10)
[   16.569363] b9e0: ffff800fcb451c18 0001000000000000 ffff800fcb61bbb0 ffff0000087b7868
[   16.577181] ba00: ffff000009f50000 0000000000020000 0000000000000008 00e800000000070f
[   16.584999] ba20: 0000000000000000 ffff7fe000300200 ffff800fcb61bab0 ffff000008776250
[   16.592817] ba40: ffff800fca8e80a0 ffff800fca8e8150 0000000000000004 0000000000000040
[   16.600634] ba60: 0000000000016500 ffff800fcb451b18 ffff800fcb61bab0 ffff0000087d10e8
[   16.608452] ba80: 0000000000000000 0000000000000040 ffff800fcb451b18 ffff00001b800104
[   16.616270] baa0: 0000000000000000 ffff800fcb905780 ffff800fcb618000 0000000000000006
[   16.624088] bac0: ffff000009f66500 0000000000000000 0140000000000040 0088000000000000
[   16.631905] bae0: 0000000000000008 ffff000009f6ffff ffff0000092f7d85 0000000000000006
[   16.639723] bb00: ffffffffffffff98 ffff7fe003f2e6a0
[   16.644589] [<ffff0000087b7868>] ata_host_activate+0x138/0x150
[   16.650411] [<ffff0000087d2950>] ahci_host_activate+0x138/0x170
[   16.656318] [<ffff0000087ced84>] ahci_init_one+0x8d4/0xd50
[   16.661793] [<ffff00000850f394>] local_pci_probe+0x3c/0xb8
[   16.667266] [<ffff0000080cc458>] work_for_cpu_fn+0x18/0x28
[   16.672741] [<ffff0000080ce710>] process_one_work+0x118/0x378
[   16.678475] [<ffff0000080cebd8>] worker_thread+0x268/0x4b0
[   16.683949] [<ffff0000080d4c10>] kthread+0xd0/0xe8
[   16.688728] [<ffff000008082e90>] ret_from_fork+0x10/0x40
[   16.692073] ata2: SATA link down (SStatus 0 SControl 300)
[   16.699826] scsi host2: ahci
[   16.702835] ata3: SATA max UDMA/133 abar m2097152@0x816000000000 port 0x816000000100
[   16.710759] ahci 0001:00:0b.0: AHCI 0001.0300 32 slots 1 ports 6 Gbps 0x1 impl SATA mode
[   16.718852] ahci 0001:00:0b.0: flags: 64bit ncq sntf ilck pm led clo only pmp fbs pio slum part ccc apst 
[   16.728416] ahci 0001:00:0b.0: port 0 is not capable of FBS
[   16.734084] ------------[ cut here ]------------
[   16.738693] WARNING: CPU: 0 PID: 1601 at drivers/ata/libata-core.c:6426 ata_host_activate+0x138/0x150
[   16.747898] 
[   16.749379] CPU: 0 PID: 1601 Comm: kworker/0:1 Tainted: G        W       4.8.1-00004-gf0dadca853a2 #171
[   16.758758] Hardware name: www.cavium.com ThunderX CRB-2S/ThunderX CRB-2S, BIOS 0.3 Sep 13 2016
[   16.767444] Workqueue: events work_for_cpu_fn
[   16.771792] task: ffff800fcb5e4e00 task.stack: ffff800fcb618000
[   16.777699] PC is at ata_host_activate+0x138/0x150
[   16.782479] LR is at ata_host_activate+0x5c/0x150
[   16.787171] pc : [<ffff0000087b7868>] lr : [<ffff0000087b778c>] pstate: 60000045
[   16.794553] sp : ffff800fcb61bbb0
[   16.797856] x29: ffff800fcb61bbb0 x28: 0000000000000001 
[   16.803161] x27: ffff000009245408 x26: ffff000009245bf0 
[   16.808466] x25: ffff800fca8ea0a0 x24: ffff800fcb45f518 
[   16.813770] x23: 0000000000000080 x22: ffff000009245bf0 
[   16.819075] x21: 0000000000000000 x20: ffff0000087cddc8 
[   16.824380] x19: ffff800fcb45f418 x18: ffff0000892f7d77 
[   16.829685] x17: ffff7fe003f2e6a0 x16: ffffffffffffff98 
[   16.834989] x15: 0000000000000006 x14: ffff0000092f7d85 
[   16.840294] x13: ffff000009fbffff x12: 0000000000000008 
[   16.845599] x11: 0088000000000000 x10: 0140000000000040 
[   16.850903] x9 : 0000000000000000 x8 : ffff000009fb6500 
[   16.856208] x7 : 0000000000000006 x6 : ffff800fcb618000 
[   16.861512] x5 : ffff800fcb907500 x4 : 0000000000000000 
[   16.866817] x3 : ffff00001bc00104 x2 : ffff800fcb45f518 
[   16.872122] x1 : 0000000000000040 x0 : 0000000000000000 
[   16.877426] 
[   16.878906] ---[ end trace 2c145cc81872d4a1 ]---
[   16.883511] Call trace:
[   16.885946] Exception stack(0xffff800fcb61b9e0 to 0xffff800fcb61bb10)
[   16.892376] b9e0: ffff800fcb45f418 0001000000000000 ffff800fcb61bbb0 ffff0000087b7868
[   16.900194] ba00: ffff000009fa0000 0000000000020000 0000000000000008 00e800000000070f
[   16.908011] ba20: 0000000000000000 ffff7fe000300280 ffff800fcb61bab0 ffff000008776250
[   16.915829] ba40: ffff800fca8ea0a0 ffff800fca8ea150 0000000000000004 0000000000000040
[   16.923647] ba60: 0000000000016500 ffff800fcb45f518 ffff800fcb61bab0 ffff0000087d10e8
[   16.931465] ba80: 0000000000000000 0000000000000040 ffff800fcb45f518 ffff00001bc00104
[   16.939283] baa0: 0000000000000000 ffff800fcb907500 ffff800fcb618000 0000000000000006
[   16.947101] bac0: ffff000009fb6500 0000000000000000 0140000000000040 0088000000000000
[   16.954918] bae0: 0000000000000008 ffff000009fbffff ffff0000092f7d85 0000000000000006
[   16.962735] bb00: ffffffffffffff98 ffff7fe003f2e6a0
[   16.967602] [<ffff0000087b7868>] ata_host_activate+0x138/0x150
[   16.973424] [<ffff0000087d2950>] ahci_host_activate+0x138/0x170
[   16.979332] [<ffff0000087ced84>] ahci_init_one+0x8d4/0xd50
[   16.984805] [<ffff00000850f394>] local_pci_probe+0x3c/0xb8
[   16.990280] [<ffff0000080cc458>] work_for_cpu_fn+0x18/0x28
[   16.995753] [<ffff0000080ce710>] process_one_work+0x118/0x378
[   17.001488] [<ffff0000080cebd8>] worker_thread+0x268/0x4b0
[   17.006963] [<ffff0000080d4c10>] kthread+0xd0/0xe8
[   17.011742] [<ffff000008082e90>] ret_from_fork+0x10/0x40
[   17.017465] scsi host3: ahci
[   17.020476] ata4: SATA max UDMA/133 abar m2097152@0x817000000000 port 0x817000000100
[   17.024054] ata3: SATA link down (SStatus 0 SControl 300)
[   17.033978] ahci 0005:00:08.0: AHCI 0001.0300 32 slots 1 ports 6 Gbps 0x1 impl SATA mode
[   17.042077] ahci 0005:00:08.0: flags: 64bit ncq sntf ilck pm led clo only pmp fbs pio slum part ccc apst 
[   17.051650] ahci 0005:00:08.0: port 0 is not capable of FBS
[   17.057638] ------------[ cut here ]------------
[   17.062263] WARNING: CPU: 49 PID: 1 at drivers/ata/libata-core.c:6426 ata_host_activate+0x138/0x150
[   17.071295] 
[   17.072781] CPU: 49 PID: 1 Comm: swapper/0 Tainted: G        W       4.8.1-00004-gf0dadca853a2 #171
[   17.081814] Hardware name: www.cavium.com ThunderX CRB-2S/ThunderX CRB-2S, BIOS 0.3 Sep 13 2016
[   17.090500] task: ffff800fc8340000 task.stack: ffff810000484000
[   17.096409] PC is at ata_host_activate+0x138/0x150
[   17.101190] LR is at ata_host_activate+0x5c/0x150
[   17.105883] pc : [<ffff0000087b7868>] lr : [<ffff0000087b778c>] pstate: 60000045
[   17.113266] sp : ffff810000487a90
[   17.116570] x29: ffff810000487a90 x28: 0000000000000001 
[   17.121879] x27: ffff000009245408 x26: ffff000009245bf0 
[   17.127187] x25: ffff8100084810a0 x24: ffff81000a705018 
[   17.132495] x23: 0000000000000080 x22: ffff000009245bf0 
[   17.137803] x21: 0000000000000000 x20: ffff0000087cddc8 
[   17.143110] x19: ffff81000a705118 x18: ffff0000892f7d77 
[   17.148418] x17: ffff7fe003f2e620 x16: 0000000000000002 
[   17.153726] x15: 0000000000000006 x14: ffff0000092f7d85 
[   17.159033] x13: ffff00000a62ffff x12: 0000000000000008 
[   17.164341] x11: 0088000000000000 x10: 0140000000000040 
[   17.169649] x9 : 0000000000000000 x8 : ffff00000a626500 
[   17.174956] x7 : 0000000000000006 x6 : ffff810000484000 
[   17.180264] x5 : ffff81000a71f480 x4 : 0000000000000000 
[   17.185571] x3 : ffff00001e400104 x2 : ffff81000a705018 
[   17.190879] x1 : 0000000000000040 x0 : 0000000000000000 
[   17.196186] 
[   17.197667] ---[ end trace 2c145cc81872d4a2 ]---
[   17.202274] Call trace:
[   17.204712] Exception stack(0xffff8100004878c0 to 0xffff8100004879f0)
[   17.211143] 78c0: ffff81000a705118 0001000000000000 ffff810000487a90 ffff0000087b7868
[   17.218961] 78e0: ffff00000a610000 0000000000020000 0000000000000008 00e800000000070f
[   17.226780] 7900: 0000000000000000 ffff7fe000300300 ffff810000487990 ffff000008776250
[   17.234598] 7920: ffff8100084810a0 ffff810008481150 0000000000000004 0000000000000040
[   17.242417] 7940: 0000000000016500 ffff81000a705018 ffff810000487990 ffff0000087d10e8
[   17.250235] 7960: 0000000000000000 0000000000000040 ffff81000a705018 ffff00001e400104
[   17.258054] 7980: 0000000000000000 ffff81000a71f480 ffff810000484000 0000000000000006
[   17.265872] 79a0: ffff00000a626500 0000000000000000 0140000000000040 0088000000000000
[   17.273691] 79c0: 0000000000000008 ffff00000a62ffff ffff0000092f7d85 0000000000000006
[   17.281508] 79e0: 0000000000000002 ffff7fe003f2e620
[   17.286376] [<ffff0000087b7868>] ata_host_activate+0x138/0x150
[   17.292201] [<ffff0000087d2950>] ahci_host_activate+0x138/0x170
[   17.298111] [<ffff0000087ced84>] ahci_init_one+0x8d4/0xd50
[   17.303590] [<ffff00000850f394>] local_pci_probe+0x3c/0xb8
[   17.309065] [<ffff000008510330>] pci_device_probe+0x110/0x148
[   17.314808] [<ffff00000876ac54>] driver_probe_device+0x204/0x2b0
[   17.320803] [<ffff00000876adac>] __driver_attach+0xac/0xb0
[   17.326279] [<ffff000008768d24>] bus_for_each_dev+0x5c/0xa0
[   17.331840] [<ffff00000876aee8>] driver_attach+0x20/0x28
[   17.337141] [<ffff0000087697d0>] bus_add_driver+0x1c8/0x230
[   17.342703] [<ffff00000876b620>] driver_register+0x60/0xf8
[   17.348178] [<ffff0000085103a0>] __pci_register_driver+0x38/0x40
[   17.354183] [<ffff0000090b2fec>] ahci_pci_driver_init+0x20/0x28
[   17.360100] [<ffff000009080c88>] do_one_initcall+0x84/0x114
[   17.365662] [<ffff000009080ed0>] kernel_init_freeable+0x1b8/0x25c
[   17.371754] [<ffff000008c20f30>] kernel_init+0x10/0x108
[   17.376972] [<ffff000008082e90>] ret_from_fork+0x10/0x40
[   17.382862] scsi host4: ahci
[   17.385910] ata5: SATA max UDMA/133 abar m2097152@0x914000000000 port 0x914000000100
[   17.393763] ahci 0005:00:09.0: AHCI 0001.0300 32 slots 1 ports 6 Gbps 0x1 impl SATA mode
[   17.401864] ahci 0005:00:09.0: flags: 64bit ncq sntf ilck pm led clo only pmp fbs pio slum part ccc apst 
[   17.411425] ahci 0005:00:09.0: port 0 is not capable of FBS
[   17.417096] ------------[ cut here ]------------
[   17.421707] WARNING: CPU: 49 PID: 1 at drivers/ata/libata-core.c:6426 ata_host_activate+0x138/0x150
[   17.430739] 
[   17.432221] CPU: 49 PID: 1 Comm: swapper/0 Tainted: G        W       4.8.1-00004-gf0dadca853a2 #171
[   17.441253] Hardware name: www.cavium.com ThunderX CRB-2S/ThunderX CRB-2S, BIOS 0.3 Sep 13 2016
[   17.449939] task: ffff800fc8340000 task.stack: ffff810000484000
[   17.455847] PC is at ata_host_activate+0x138/0x150
[   17.460627] LR is at ata_host_activate+0x5c/0x150
[   17.465320] pc : [<ffff0000087b7868>] lr : [<ffff0000087b778c>] pstate: 60000045
[   17.472703] sp : ffff810000487a90
[   17.476007] x29: ffff810000487a90 x28: 0000000000000001 
[   17.481314] x27: ffff000009245408 x26: ffff000009245bf0 
[   17.486621] x25: ffff8100084830a0 x24: ffff81000a70fa18 
[   17.491929] x23: 0000000000000080 x22: ffff000009245bf0 
[   17.497236] x21: 0000000000000000 x20: ffff0000087cddc8 
[   17.502544] x19: ffff81000a70f918 x18: ffff0000892f7d77 
[   17.507851] x17: ffff7fe040029ea0 [   17.509883] ata4: SATA link up 6.0 Gbps (SStatus 133 SControl 300)

[   17.517234] x16: ffffffffffffff98 
[   17.520804] x15: 0000000000000006 x14: ffff0000092f7d85 
[   17.526112] x13: ffff00000a67ffff x12: 0000000000000008 
[   17.531420] x11: 0088000000000000 x10: 0140000000000040 
[   17.536727] x9 : 0000000000000000 x8 : ffff00000a676500 
[   17.542035] x7 : 0000000000000006 x6 : ffff810000484000 
[   17.547342] x5 : ffff81000a71d680 x4 : 0000000000000000 
[   17.552650] x3 : ffff00001e800104 x2 : ffff81000a70fa18 
[   17.557957] x1 : 0000000000000040 x0 : 0000000000000000 
[   17.563264] 
[   17.564745] ---[ end trace 2c145cc81872d4a3 ]---
[   17.569351] Call trace:
[   17.571788] Exception stack(0xffff8100004878c0 to 0xffff8100004879f0)
[   17.578218] 78c0: ffff81000a70f918 0001000000000000 ffff810000487a90 ffff0000087b7868
[   17.586036] 78e0: ffff00000a660000 0000000000020000 0000000000000008 00e800000000070f
[   17.593855] 7900: 0000000000000000 ffff7fe000300380 ffff810000487990 ffff000008776250
[   17.601673] 7920: ffff8100084830a0 ffff810008483150 0000000000000004 0000000000000040
[   17.609492] 7940: 0000000000016500 ffff81000a70fa18 ffff810000487990 ffff0000087d10e8
[   17.617310] 7960: 0000000000000000 0000000000000040 ffff81000a70fa18 ffff00001e800104
[   17.625129] 7980: 0000000000000000 ffff81000a71d680 ffff810000484000 0000000000000006
[   17.632947] 79a0: ffff00000a676500 0000000000000000 0140000000000040 0088000000000000
[   17.640765] 79c0: 0000000000000008 ffff00000a67ffff ffff0000092f7d85 0000000000000006
[   17.648583] 79e0: ffffffffffffff98 ffff7fe040029ea0
[   17.653451] [<ffff0000087b7868>] ata_host_activate+0x138/0x150
[   17.659273] [<ffff0000087d2950>] ahci_host_activate+0x138/0x170
[   17.665182] [<ffff0000087ced84>] ahci_init_one+0x8d4/0xd50
[   17.670657] [<ffff00000850f394>] local_pci_probe+0x3c/0xb8
[   17.676131] [<ffff000008510330>] pci_device_probe+0x110/0x148
[   17.681867] [<ffff00000876ac54>] driver_probe_device+0x204/0x2b0
[   17.687863] [<ffff00000876adac>] __driver_attach+0xac/0xb0
[   17.693337] [<ffff000008768d24>] bus_for_each_dev+0x5c/0xa0
[   17.698899] [<ffff00000876aee8>] driver_attach+0x20/0x28
[   17.704200] [<ffff0000087697d0>] bus_add_driver+0x1c8/0x230
[   17.708031] ata5: SATA link down (SStatus 0 SControl 300)
[   17.715147] [<ffff00000876b620>] driver_register+0x60/0xf8
[   17.720621] [<ffff0000085103a0>] __pci_register_driver+0x38/0x40
[   17.726617] [<ffff0000090b2fec>] ahci_pci_driver_init+0x20/0x28
[   17.732527] [<ffff000009080c88>] do_one_initcall+0x84/0x114
[   17.738089] [<ffff000009080ed0>] kernel_init_freeable+0x1b8/0x25c
[   17.744172] [<ffff000008c20f30>] kernel_init+0x10/0x108
[   17.749386] [<ffff000008082e90>] ret_from_fork+0x10/0x40
[   17.755136] scsi host5: ahci
[   17.758152] ata6: SATA max UDMA/133 abar m2097152@0x915000000000 port 0x915000000100
[   17.766004] ahci 0005:00:0a.0: AHCI 0001.0300 32 slots 1 ports 6 Gbps 0x1 impl SATA mode
[   17.774095] ahci 0005:00:0a.0: flags: 64bit ncq sntf ilck pm led clo only pmp fbs pio slum part ccc apst 
[   17.783660] ahci 0005:00:0a.0: port 0 is not capable of FBS
[   17.789335] ------------[ cut here ]------------
[   17.793946] WARNING: CPU: 49 PID: 1 at drivers/ata/libata-core.c:6426 ata_host_activate+0x138/0x150
[   17.802977] 
[   17.804460] CPU: 49 PID: 1 Comm: swapper/0 Tainted: G        W       4.8.1-00004-gf0dadca853a2 #171
[   17.813491] Hardware name: www.cavium.com ThunderX CRB-2S/ThunderX CRB-2S, BIOS 0.3 Sep 13 2016
[   17.822177] task: ffff800fc8340000 task.stack: ffff810000484000
[   17.828085] PC is at ata_host_activate+0x138/0x150
[   17.832866] LR is at ata_host_activate+0x5c/0x150
[   17.837559] pc : [<ffff0000087b7868>] lr : [<ffff0000087b778c>] pstate: 60000045
[   17.844942] sp : ffff810000487a90
[   17.848246] x29: ffff810000487a90 x28: 0000000000000001 
[   17.853553] x27: ffff000009245408 x26: ffff000009245bf0 
[   17.858861] x25: ffff8100084850a0 x24: ffff81000a705e18 
[   17.864169] x23: 0000000000000080 x22: ffff000009245bf0 
[   17.869477] x21: 0000000000000000 x20: ffff0000087cddc8 
[   17.874784] x19: ffff81000a705f18 x18: ffff0000892f7d77 
[   17.880092] x17: ffff7fe040029ea0 x16: ffffffffffffff98 
[   17.885399] x15: 0000000000000006 x14: ffff0000092f7d85 
[   17.890707] x13: ffff00000a6dffff x12: 0000000000000008 
[   17.896014] x11: 0088000000000000 x10: 0140000000000040 
[   17.901321] x9 : 0000000000000000 x8 : ffff00000a6d6500 
[   17.906628] x7 : 0000000000000006 x6 : ffff810000484000 
[   17.911936] x5 : ffff81000a71b880 x4 : 0000000000000000 
[   17.917244] x3 : ffff00001ec00104 x2 : ffff81000a705e18 
[   17.922551] x1 : 0000000000000040 x0 : 0000000000000000 
[   17.927858] 
[   17.929339] ---[ end trace 2c145cc81872d4a4 ]---
[   17.933945] Call trace:
[   17.936381] Exception stack(0xffff8100004878c0 to 0xffff8100004879f0)
[   17.942811] 78c0: ffff81000a705f18 0001000000000000 ffff810000487a90 ffff0000087b7868
[   17.950630] 78e0: ffff00000a6c0000 0000000000020000 0000000000000008 00e800000000070f
[   17.958449] 7900: 0000000000000000 ffff7fe000300400 ffff810000487990 ffff000008776250
[   17.966267] 7920: ffff8100084850a0 ffff810008485150 0000000000000004 0000000000000040
[   17.974085] 7940: 0000000000016500 ffff81000a705e18 ffff810000487990 ffff0000087d10e8
[   17.981904] 7960: 0000000000000000 0000000000000040 ffff81000a705e18 ffff00001ec00104
[   17.989722] 7980: 0000000000000000 ffff81000a71b880 ffff810000484000 0000000000000006
[   17.997541] 79a0: ffff00000a6d6500 0000000000000000 0140000000000040 0088000000000000
[   18.005359] 79c0: 0000000000000008 ffff00000a6dffff ffff0000092f7d85 0000000000000006
[   18.013177] 79e0: ffffffffffffff98 ffff7fe040029ea0
[   18.018044] [<ffff0000087b7868>] ata_host_activate+0x138/0x150
[   18.023867] [<ffff0000087d2950>] ahci_host_activate+0x138/0x170
[   18.029775] [<ffff0000087ced84>] ahci_init_one+0x8d4/0xd50
[   18.035250] [<ffff00000850f394>] local_pci_probe+0x3c/0xb8
[   18.040725] [<ffff000008510330>] pci_device_probe+0x110/0x148
[   18.046460] [<ffff00000876ac54>] driver_probe_device+0x204/0x2b0
[   18.052456] [<ffff00000876adac>] __driver_attach+0xac/0xb0
[   18.057931] [<ffff000008768d24>] bus_for_each_dev+0x5c/0xa0
[   18.063492] [<ffff00000876aee8>] driver_attach+0x20/0x28
[   18.068793] [<ffff0000087697d0>] bus_add_driver+0x1c8/0x230
[   18.074355] [<ffff00000876b620>] driver_register+0x60/0xf8
[   18.079829] [<ffff0000085103a0>] __pci_register_driver+0x38/0x40
[   18.080051] ata6: SATA link down (SStatus 0 SControl 300)
[   18.091210] [<ffff0000090b2fec>] ahci_pci_driver_init+0x20/0x28
[   18.097120] [<ffff000009080c88>] do_one_initcall+0x84/0x114
[   18.102682] [<ffff000009080ed0>] kernel_init_freeable+0x1b8/0x25c
[   18.108765] [<ffff000008c20f30>] kernel_init+0x10/0x108
[   18.113979] [<ffff000008082e90>] ret_from_fork+0x10/0x40
[   18.119725] scsi host6: ahci
[   18.122747] ata7: SATA max UDMA/133 abar m2097152@0x916000000000 port 0x916000000100
[   18.130601] ahci 0005:00:0b.0: AHCI 0001.0300 32 slots 1 ports 6 Gbps 0x1 impl SATA mode
[   18.138693] ahci 0005:00:0b.0: flags: 64bit ncq sntf ilck pm led clo only pmp fbs pio slum part ccc apst 
[   18.148258] ahci 0005:00:0b.0: port 0 is not capable of FBS
[   18.153931] ------------[ cut here ]------------
[   18.158542] WARNING: CPU: 49 PID: 1 at drivers/ata/libata-core.c:6426 ata_host_activate+0x138/0x150
[   18.167574] 
[   18.169057] CPU: 49 PID: 1 Comm: swapper/0 Tainted: G        W       4.8.1-00004-gf0dadca853a2 #171
[   18.178089] Hardware name: www.cavium.com ThunderX CRB-2S/ThunderX CRB-2S, BIOS 0.3 Sep 13 2016
[   18.186774] task: ffff800fc8340000 task.stack: ffff810000484000
[   18.192683] PC is at ata_host_activate+0x138/0x150
[   18.197463] LR is at ata_host_activate+0x5c/0x150
[   18.202156] pc : [<ffff0000087b7868>] lr : [<ffff0000087b778c>] pstate: 60000045
[   18.209539] sp : ffff810000487a90
[   18.212843] x29: ffff810000487a90 x28: 0000000000000001 
[   18.218150] x27: ffff000009245408 x26: ffff000009245bf0 
[   18.223458] x25: ffff8100084870a0 x24: ffff81000a70ec18 
[   18.228765] x23: 0000000000000080 x22: ffff000009245bf0 
[   18.234073] x21: 0000000000000000 x20: ffff0000087cddc8 
[   18.239380] x19: ffff81000a70eb18 x18: ffff0000892f7d77 
[   18.244688] x17: ffff7fe040029ee0 x16: ffffffffffffff98 
[   18.249995] x15: 0000000000000006 x14: ffff0000092f7d85 
[   18.255303] x13: ffff00000a73ffff x12: 0000000000000008 
[   18.260611] x11: 0088000000000000 x10: 0140000000000040 
[   18.265918] x9 : 0000000000000000 x8 : ffff00000a736500 
[   18.271225] x7 : 0000000000000006 x6 : ffff810000484000 
[   18.276533] x5 : ffff81000a719a80 x4 : 0000000000000000 
[   18.281840] x3 : ffff00001f000104 x2 : ffff81000a70ec18 
[   18.287148] x1 : 0000000000000040 x0 : 0000000000000000 
[   18.292455] 
[   18.293936] ---[ end trace 2c145cc81872d4a5 ]---
[   18.298542] Call trace:
[   18.300979] Exception stack(0xffff8100004878c0 to 0xffff8100004879f0)
[   18.307409] 78c0: ffff81000a70eb18 0001000000000000 ffff810000487a90 ffff0000087b7868
[   18.315228] 78e0: ffff00000a720000 0000000000020000 0000000000000008 00e800000000070f
[   18.323046] 7900: 0000000000000000 ffff7fe000300480 ffff810000487990 ffff000008776250
[   18.330865] 7920: ffff8100084870a0 ffff810008487150 0000000000000004 0000000000000040
[   18.338683] 7940: 0000000000016500 ffff81000a70ec18 ffff810000487990 ffff0000087d10e8
[   18.346502] 7960: 0000000000000000 0000000000000040 ffff81000a70ec18 ffff00001f000104
[   18.354320] 7980: 0000000000000000 ffff81000a719a80 ffff810000484000 0000000000000006
[   18.362139] 79a0: ffff00000a736500 0000000000000000 0140000000000040 0088000000000000
[   18.369957] 79c0: 0000000000000008 ffff00000a73ffff ffff0000092f7d85 0000000000000006
[   18.377775] 79e0: ffffffffffffff98 ffff7fe040029ee0
[   18.382643] [<ffff0000087b7868>] ata_host_activate+0x138/0x150
[   18.388465] [<ffff0000087d2950>] ahci_host_activate+0x138/0x170
[   18.394373] [<ffff0000087ced84>] ahci_init_one+0x8d4/0xd50
[   18.399848] [<ffff00000850f394>] local_pci_probe+0x3c/0xb8
[   18.405323] [<ffff000008510330>] pci_device_probe+0x110/0x148
[   18.411059] [<ffff00000876ac54>] driver_probe_device+0x204/0x2b0
[   18.417055] [<ffff00000876adac>] __driver_attach+0xac/0xb0
[   18.422529] [<ffff000008768d24>] bus_for_each_dev+0x5c/0xa0
[   18.428091] [<ffff00000876aee8>] driver_attach+0x20/0x28
[   18.433392] [<ffff0000087697d0>] bus_add_driver+0x1c8/0x230
[   18.438954] [<ffff00000876b620>] driver_register+0x60/0xf8
[   18.444010] ata7: SATA link down (SStatus 0 SControl 300)
[   18.449813] [<ffff0000085103a0>] __pci_register_driver+0x38/0x40
[   18.455809] [<ffff0000090b2fec>] ahci_pci_driver_init+0x20/0x28
[   18.461719] [<ffff000009080c88>] do_one_initcall+0x84/0x114
[   18.467281] [<ffff000009080ed0>] kernel_init_freeable+0x1b8/0x25c
[   18.473364] [<ffff000008c20f30>] kernel_init+0x10/0x108
[   18.478578] [<ffff000008082e90>] ret_from_fork+0x10/0x40
[   18.484409] scsi host7: ahci
[   18.487425] ata8: SATA max UDMA/133 abar m2097152@0x917000000000 port 0x917000000100
...
[   18.808074] ata8: SATA link down (SStatus 0 SControl 300)
...
[   21.765921] ata1.00: qc timeout (cmd 0xec)
[   21.770031] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[   22.249869] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[   22.533896] ata4.00: qc timeout (cmd 0xec)
[   22.537996] ata4.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[   23.017874] ata4: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[   32.261874] ata1.00: qc timeout (cmd 0xec)
[   32.265972] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[   32.272059] ata1: limiting SATA link speed to 3.0 Gbps
[   32.753873] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[   33.029878] ata4.00: qc timeout (cmd 0xec)
[   33.033978] ata4.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[   33.040066] ata4: limiting SATA link speed to 3.0 Gbps
[   33.521884] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[   63.493874] ata1.00: qc timeout (cmd 0xec)
[   63.497973] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[   63.977867] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[   65.541890] ata4.00: qc timeout (cmd 0xec)
[   65.545987] ata4.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[   66.025873] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[   66.032337] VFS: Cannot open root device "sda2" or unknown-block(0,0): error -6
[   66.039682] Please append a correct "root=" boot option; here are the available partitions:
[   66.048047] Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0)
[   66.056304] CPU: 55 PID: 1 Comm: swapper/0 Tainted: G        W       4.8.1-00004-gf0dadca853a2 #171
[   66.065337] Hardware name: www.cavium.com ThunderX CRB-2S/ThunderX CRB-2S, BIOS 0.3 Sep 13 2016
[   66.074023] Call trace:
[   66.076474] [<ffff0000080883c8>] dump_backtrace+0x0/0x1a0
[   66.081863] [<ffff00000808857c>] show_stack+0x14/0x20
[   66.086908] [<ffff00000849adf4>] dump_stack+0x94/0xb8
[   66.091956] [<ffff00000815df94>] panic+0x10c/0x26c
[   66.096744] [<ffff000009081318>] mount_block_root+0x18c/0x264
[   66.102480] [<ffff00000908150c>] mount_root+0x11c/0x134
[   66.107695] [<ffff000009081660>] prepare_namespace+0x13c/0x184
[   66.113517] [<ffff000009080f50>] kernel_init_freeable+0x238/0x25c
[   66.119607] [<ffff000008c20f30>] kernel_init+0x10/0x108
[   66.124822] [<ffff000008082e90>] ret_from_fork+0x10/0x40
[   66.130125] SMP: stopping secondary CPUs
