From: Harri Olin <harri.olin@gmail.com>
Subject: Re: sata_mv, io stucks
Date: Sun, 16 Nov 2008 19:32:37 +0200
Message-ID: <49205935.7020807@gmail.com>
References: <48F88449.1000704@ngs.ru> <49003B9C.1010303@ngs.ru> <4900A12F.3030307@rtr.ca> <491EE84B.1010600@gmail.com> <491F4096.9090701@rtr.ca> <491F5E42.8010906@gmail.com> <491FA4D8.1010708@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gw03.mail.saunalahti.fi ([195.197.172.111]:34998 "EHLO
	gw03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752027AbYKPRco (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 16 Nov 2008 12:32:44 -0500
In-Reply-To: <491FA4D8.1010708@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: linux-ide@vger.kernel.org, Artem Bokhan <aptem@ngs.ru>

Mark Lord wrote:
>> ata14.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x6 frozen
>> ata14.00: cmd 61/08:00:3f:52:54/00:00:57:00:00/40 tag 0 ncq 4096 out
>>         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> Yeah, I see what I was missing earlier:   "(timeout)".
> So it's "none of" the driver paths.
>
> This could very well be due to one/several of the as-yet un-addressed
> chipset errata for the 6081.  Someday we'll have software workarounds
> for those, but I'm (still) waiting on Marvell for stuff.
>

After a bit of testing, it seems that writing is required to trigger the 
bug, dstat output follows:

--dsk/sde-----dsk/sdf-----dsk/sdg-----dsk/sdh-----dsk/sdi-----dsk/sdj-----dsk/sdk--
read  writ: read  writ: read  writ: read  writ: read  writ: read  writ: 
read  writ
 37M    0 :  35M    0 :  35M    0 :  37M    0 :  34M    0 :  35M    0 :  
32M    0
 35M    0 :  34M    0 :  34M    0 :  35M    0 :  37M    0 :  37M    0 :  
36M    0
 34M    0 :  35M    0 :  35M    0 :  40M    0 :  36M    0 :  33M    0 :  
35M    0
 30M 8192B:  28M 8192B:  30M 8192B:  30M    0 :  28M 8192B:  30M 8192B:  
28M 8192B
 35M    0 :  37M    0 :  33M    0 :   0     0 :  36M    0 :  34M    0 :  
35M    0
 36M    0 :  35M    0 :  35M    0 :   0     0 :  35M    0 :  34M    0 :  
34M    0
 34M    0 :  37M    0 :  38M    0 :   0     0 :  36M    0 :  36M    0 :  
35M    0

I was running fio, reading from all drives connected to 6081. After 
nothing happened for a while, I decided to mount the xfs filesystem 
read-write and it hung immediately before mount was even complete.

I also managed to catch the panic I mentioned, running kernel 2.6.28-rc5:

[  503.918122] BUG: unable to handle kernel NULL pointer dereference at 
0000000000000000
[  503.918399] IP: [<ffffffff804d3938>] scsi_times_out+0x8/0x70
[  503.918561] PGD 229068067 PUD 22a1f0067 PMD 0
[  503.918814] Oops: 0000 [#1] SMP
[  503.919009] last sysfs file: /sys/block/sdk/stat
[  503.919123] CPU 2
[  503.919273] Modules linked in: kvm_intel kvm coretemp w83627hf w83793 
hwmon_vid hwmon nf_conntrack_ftp 3c59x i2c_i801 i2c_core e100 iTCO_wdt
[  503.920074] Pid: 0, comm: swapper Not tainted 2.6.28-rc5 #4
[  503.920190] RIP: 0010:[<ffffffff804d3938>]  [<ffffffff804d3938>] 
scsi_times_out+0x8/0x70
[  503.920417] RSP: 0018:ffff88022f0f3e60  EFLAGS: 00010046
[  503.920540] RAX: ffff88022d4f5470 RBX: 0000000000000000 RCX: 
ffff88022d4f5ac8
[  503.920659] RDX: ffff88022d4f57e8 RSI: 0000000000000eae RDI: 
ffff8801f8188848
[  503.920777] RBP: ffff88022d4f5988 R08: 0000000000000000 R09: 
0000000000000000
[  503.920897] R10: ffffffff804d6142 R11: ffffffff805dc480 R12: 
ffff88022f0e4000
[  503.921015] R13: ffff88022d4f57e8 R14: 0000000000000000 R15: 
ffff88022d4f5470
[  503.921134] FS:  0000000000000000(0000) GS:ffff88022f08bac0(0000) 
knlGS:0000000000000000
[  503.921317] CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
[  503.921434] CR2: 0000000000000000 CR3: 000000022a0cf000 CR4: 
00000000000026e0
[  503.921553] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[  503.921674] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 
0000000000000400
[  503.921793] Process swapper (pid: 0, threadinfo ffff88022f0ee000, 
task ffff88022f0e2c30)
[  503.921985] Stack:
[  503.922094]  ffff8801f8188848 ffffffff80416eee ffff8801f8188848 
ffffffff80416fea
[  503.922116]  0000000000000282 ffff88022d4f5470 0000000000000100 
ffff88022f0e4000
[  503.922116]  ffff88022f0f3ee0 ffffffff80416f30 ffff88022f0e5018 
ffffffff8024393b
[  503.922116] Call Trace:
[  503.922116]  <IRQ> <0> [<ffffffff80416eee>] ? blk_rq_timed_out+0xe/0x50
[  503.922116]  [<ffffffff80416fea>] ? blk_rq_timed_out_timer+0xba/0x120
[  503.922116]  [<ffffffff80416f30>] ? blk_rq_timed_out_timer+0x0/0x120
[  503.922116]  [<ffffffff8024393b>] ? run_timer_softirq+0x1bb/0x230
[  503.922116]  [<ffffffff8023f00b>] ? __do_softirq+0x8b/0x150
[  503.922116]  [<ffffffff8020e7db>] ? profile_pc+0x3b/0x80
[  503.922116]  [<ffffffff8020c8fc>] ? call_softirq+0x1c/0x40
[  503.922116]  [<ffffffff8020db55>] ? do_softirq+0x35/0x70
[  503.922116]  [<ffffffff802205b5>] ? smp_apic_timer_interrupt+0x85/0xd0
[  503.922116]  [<ffffffff8020c34b>] ? apic_timer_interrupt+0x6b/0x70
[  503.922116]  <EOI> <0> [<ffffffff805dc480>] ? udp_poll+0x0/0x150
[  503.922116]  [<ffffffff80212d8c>] ? mwait_idle+0x3c/0x40
[  503.922116]  [<ffffffff80209d5a>] ? cpu_idle+0x3a/0x70
[  503.922116] Code: 18 4c 8b 74 24 20 48 83 c4 28 c3 be 06 00 00 00 48 
89 df e8 9b c8 ff ff 85 c0 75 c3 eb 87 0f 1f 44 00 00 53 48 8b 9f e0 00 
00 00 <48> 8b 03 48
[  503.922116] RIP  [<ffffffff804d3938>] scsi_times_out+0x8/0x70
[  503.922116]  RSP <ffff88022f0f3e60>
[  503.922116] CR2: 0000000000000000
[  503.922116] Kernel panic - not syncing: Fatal exception in interrupt
[  503.922116] ------------[ cut here ]------------
[  503.922116] WARNING: at kernel/smp.c:333 
smp_call_function_mask+0x236/0x240()
[  503.922116] Modules linked in: kvm_intel kvm coretemp w83627hf w83793 
hwmon_vid hwmon nf_conntrack_ftp 3c59x i2c_i801 i2c_core e100 iTCO_wdt
[  503.922116] Pid: 0, comm: swapper Tainted: G      D    2.6.28-rc5 #4
[  503.922116] Call Trace:
[  503.922116]  <IRQ>  [<ffffffff80239ea4>] warn_on_slowpath+0x64/0xa0
[  503.922116]  [<ffffffff80252396>] up+0x16/0x50
[  503.922116]  [<ffffffff8023a657>] release_console_sem+0x197/0x1e0
[  503.922116]  [<ffffffff8025c126>] smp_call_function_mask+0x236/0x240
[  503.922116]  [<ffffffff8023b0fe>] printk+0x4e/0x60
[  503.922116]  [<ffffffff80252396>] up+0x16/0x50
[  503.922116]  [<ffffffff8021f290>] native_smp_send_stop+0x20/0x30
[  503.922116]  [<ffffffff80239f7e>] panic+0x8e/0x150
[  503.922116]  [<ffffffff8020e582>] show_registers+0x192/0x250
[  503.922116]  [<ffffffff8047d745>] do_unblank_screen+0x15/0x140
[  503.922116]  [<ffffffff80636370>] oops_end+0xa0/0xb0
[  503.922116]  [<ffffffff80637f43>] do_page_fault+0x6a3/0x830
[  503.922116]  [<ffffffff80635799>] error_exit+0x0/0x51
[  503.922116]  [<ffffffff805dc480>] udp_poll+0x0/0x150
[  503.922116]  [<ffffffff804d6142>] scsi_request_fn+0xe2/0x400
[  503.922116]  [<ffffffff804d3938>] scsi_times_out+0x8/0x70
[  503.922116]  [<ffffffff80416eee>] blk_rq_timed_out+0xe/0x50
[  503.922116]  [<ffffffff80416fea>] blk_rq_timed_out_timer+0xba/0x120
[  503.922116]  [<ffffffff80416f30>] blk_rq_timed_out_timer+0x0/0x120
[  503.922116]  [<ffffffff8024393b>] run_timer_softirq+0x1bb/0x230
[  503.922116]  [<ffffffff8023f00b>] __do_softirq+0x8b/0x150
[  503.922116]  [<ffffffff8020e7db>] profile_pc+0x3b/0x80
[  503.922116]  [<ffffffff8020c8fc>] call_softirq+0x1c/0x40
[  503.922116]  [<ffffffff8020db55>] do_softirq+0x35/0x70
[  503.922116]  [<ffffffff802205b5>] smp_apic_timer_interrupt+0x85/0xd0
[  503.922116]  [<ffffffff8020c34b>] apic_timer_interrupt+0x6b/0x70
[  503.922116]  <EOI>  [<ffffffff805dc480>] udp_poll+0x0/0x150
[  503.922116]  [<ffffffff80212d8c>] mwait_idle+0x3c/0x40
[  503.922116]  [<ffffffff80209d5a>] cpu_idle+0x3a/0x70
[  503.922116] ---[ end trace 3eef0898db52fd7a ]---


-- 
Harri.
