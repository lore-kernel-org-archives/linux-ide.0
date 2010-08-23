From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: ahci port hangs while hard resetting link
Date: Mon, 23 Aug 2010 18:11:59 +0300
Message-ID: <201008231811.59828.anssi.hannula@iki.fi>
References: <201008230010.48355.anssi.hannula@iki.fi> <4C723FF4.1020208@kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from saarni.dnainternet.net ([83.102.40.136]:60891 "EHLO
	saarni.dnainternet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751589Ab0HWPMH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Aug 2010 11:12:07 -0400
In-Reply-To: <4C723FF4.1020208@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

On Monday 23 August 2010 12:31:32 Tejun Heo wrote:
> Hello,
> 
> On 08/22/2010 11:10 PM, Anssi Hannula wrote:
> > 22:52:18 : ata6: exception Emask 0x10 SAct 0x0 SErr 0x4050002 action 0xe
> > frozen
> > 22:52:18 : ata6: irq_stat 0x00400040, connection status changed
> > 22:52:18 : ata6: SError: { RecovComm PHYRdyChg CommWake DevExch }
> > 22:52:18 : ata6: hard resetting link
> > 22:52:28 : ata6: softreset failed (device not ready)
> > 22:52:28 : ata6: hard resetting link
> > 22:52:38 : ata6: softreset failed (device not ready)
> > 22:52:38 : ata6: hard resetting link
> > 22:52:49 : ata6: link is slow to respond, please be patient (ready=0)
> > 22:53:13 : ata6: softreset failed (device not ready)
> > 22:53:13 : ata6: limiting SATA link speed to 1.5 Gbps
> > 22:53:13 : ata6: hard resetting link
> > =====================
> > I disconnect the drive for a few moments, but nothing is output by
> > kernel. I reconnect it again, but again, nothing is output by the
> > kernel. I run: echo "- - -" >
> > /sys/devices/pci0000:00/0000:00:1f.2/host5/scsi_host/host5/scan
> > However, it appeared stuck and still no messages in the kernel log, so
> > I disconnected the device again. Still nothing is output, and the
> > following messages started to be output, indicating that the process
> 
> > had become stuck:
> Looks like EH got stuck somehow.  Maybe the timeout calculation is
> wrong?  Can you please trigger sysrq-t while the system is stuck and
> post the result?

Ok, here's the output. And the system is not stuck, just the bash process that 
is writing to 'scan' file.

In this occasion, the hard reset had been stuck for some 16 hours, and it is 
on ata5 (scsi4):

SysRq : Show State
  task                        PC stack   pid father
init          S 0000000103dbd656     0     1      0 0x00000000
 ffff8801338bb8e8 0000000000000082 ffff880100000000 00000000000153c0
 ffff8801338bbfd8 00000000000153c0 ffff8801338bbfd8 ffff8801338c0000
 00000000000153c0 00000000000153c0 ffff8801338bbfd8 00000000000153c0
Call Trace:
 [<ffffffff813e0515>] schedule_hrtimeout_range_clock+0xc5/0x160
 [<ffffffff8107c270>] ? hrtimer_wakeup+0x0/0x30
 [<ffffffff8107cc14>] ? hrtimer_start_range_ns+0x14/0x20
 [<ffffffff813e05c3>] schedule_hrtimeout_range+0x13/0x20
 [<ffffffff8114cef9>] poll_schedule_timeout+0x49/0x70
 [<ffffffff8114d588>] do_select+0x598/0x6c0
 [<ffffffffa00bd439>] ? ext4_mark_iloc_dirty+0x339/0x5c0 [ext4]
 [<ffffffff8114d6b0>] ? __pollwait+0x0/0xf0
 [<ffffffff8114d7a0>] ? pollwake+0x0/0x60
 [<ffffffff8114f20a>] ? __d_lookup+0xaa/0x140
 [<ffffffff8114f46f>] ? dput+0xbf/0x190
 [<ffffffff81146c05>] ? path_to_nameidata+0x25/0x60
 [<ffffffff81148a3f>] ? link_path_walk+0x5bf/0xbd0
 [<ffffffff81156e29>] ? mntput_no_expire+0x29/0xf0
 [<ffffffff8114e293>] core_sys_select+0x1c3/0x2f0
 [<ffffffff8110a266>] ? handle_mm_fault+0x466/0xb60
 [<ffffffff81140508>] ? cp_new_stat+0xf8/0x110
 [<ffffffff81011419>] ? read_tsc+0x9/0x20
 [<ffffffff81082f59>] ? ktime_get_ts+0xa9/0xe0
 [<ffffffff8114e617>] sys_select+0x47/0x110
 [<ffffffff81009fc2>] system_call_fastpath+0x16/0x1b
kthreadd      S 0000000103da1459     0     2      0 0x00000000
 ffff8801338c9f00 0000000000000046 0000000000000001 00000000000153c0
 ffff8801338c9fd8 00000000000153c0 ffff8801338c9fd8 ffff8801338c16c0
 00000000000153c0 00000000000153c0 ffff8801338c9fd8 00000000000153c0
Call Trace:
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
 [<ffffffff810787f5>] kthreadd+0x125/0x130
 [<ffffffff8100ade4>] kernel_thread_helper+0x4/0x10
 [<ffffffff810786d0>] ? kthreadd+0x0/0x130
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
ksoftirqd/0   S 00000000ffffffff     0     3      2 0x00000000
 ffff8801338cbea0 0000000000000046 ffff880100000000 00000000000153c0
 ffff8801338cbfd8 00000000000153c0 ffff8801338cbfd8 ffff8801338c2d80
 00000000000153c0 00000000000153c0 ffff8801338cbfd8 00000000000153c0
Call Trace:
 [<ffffffff81061005>] run_ksoftirqd+0xe5/0x140
 [<ffffffff81060f20>] ? run_ksoftirqd+0x0/0x140
 [<ffffffff810786c6>] kthread+0x96/0xa0
 [<ffffffff8100ade4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81078630>] ? kthread+0x0/0xa0
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
migration/0   S 0000000103da9d4f     0     4      2 0x00000000
 ffff8801338cdde0 0000000000000046 ffff880100000000 00000000000153c0
 ffff8801338cdfd8 00000000000153c0 ffff8801338cdfd8 ffff8801338c4440
 00000000000153c0 00000000000153c0 ffff8801338cdfd8 00000000000153c0
Call Trace:
 [<ffffffff8104bc40>] ? migration_cpu_stop+0x0/0x30
 [<ffffffff810a9f65>] cpu_stopper_thread+0x125/0x1b0
 [<ffffffff813def41>] ? schedule+0x3e1/0x820
 [<ffffffff810a9e40>] ? cpu_stopper_thread+0x0/0x1b0
 [<ffffffff810786c6>] kthread+0x96/0xa0
 [<ffffffff8100ade4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81078630>] ? kthread+0x0/0xa0
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
watchdog/0    S 00000000ffffffff     0     5      2 0x00000000
 ffff8801338cfea0 0000000000000046 ffff8801338c5b00 00000000000153c0
 ffff8801338cffd8 00000000000153c0 ffff8801338cffd8 ffff8801338c5b00
 00000000000153c0 00000000000153c0 ffff8801338cffd8 00000000000153c0
Call Trace:
 [<ffffffff810b6520>] ? watchdog+0x0/0xa0
 [<ffffffff810b657a>] watchdog+0x5a/0xa0
 [<ffffffff810b6520>] ? watchdog+0x0/0xa0
 [<ffffffff810786c6>] kthread+0x96/0xa0
 [<ffffffff8100ade4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81078630>] ? kthread+0x0/0xa0
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
migration/1   S 0000000103db1b33     0     6      2 0x00000000
 ffff8801338e1de0 0000000000000046 ffff880100000000 00000000000153c0
 ffff8801338e1fd8 00000000000153c0 ffff8801338e1fd8 ffff8801338d8000
 00000000000153c0 00000000000153c0 ffff8801338e1fd8 00000000000153c0
Call Trace:
 [<ffffffff8104bc40>] ? migration_cpu_stop+0x0/0x30
 [<ffffffff810a9f65>] cpu_stopper_thread+0x125/0x1b0
 [<ffffffff813def41>] ? schedule+0x3e1/0x820
 [<ffffffff810a9e40>] ? cpu_stopper_thread+0x0/0x1b0
 [<ffffffff810786c6>] kthread+0x96/0xa0
 [<ffffffff8100ade4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81078630>] ? kthread+0x0/0xa0
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
ksoftirqd/1   S 0000000103dbde84     0     7      2 0x00000000
 ffff8801338e3ea0 0000000000000046 ffff880100000000 00000000000153c0
 ffff8801338e3fd8 00000000000153c0 ffff8801338e3fd8 ffff8801338d96c0
 00000000000153c0 00000000000153c0 ffff8801338e3fd8 00000000000153c0
Call Trace:
 [<ffffffff81061005>] run_ksoftirqd+0xe5/0x140
 [<ffffffff81060f20>] ? run_ksoftirqd+0x0/0x140
 [<ffffffff810786c6>] kthread+0x96/0xa0
 [<ffffffff8100ade4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81078630>] ? kthread+0x0/0xa0
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
watchdog/1    S 00000000fffb70b3     0     8      2 0x00000000
 ffff880133907ea0 0000000000000046 ffff8801338dad80 00000000000153c0
 ffff880133907fd8 00000000000153c0 ffff880133907fd8 ffff8801338dad80
 00000000000153c0 00000000000153c0 ffff880133907fd8 00000000000153c0
Call Trace:
 [<ffffffff810b6520>] ? watchdog+0x0/0xa0
 [<ffffffff810b657a>] watchdog+0x5a/0xa0
 [<ffffffff810b6520>] ? watchdog+0x0/0xa0
 [<ffffffff810786c6>] kthread+0x96/0xa0
 [<ffffffff8100ade4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81078630>] ? kthread+0x0/0xa0
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
migration/2   S 0000000103dbbee4     0     9      2 0x00000000
 ffff88013390bde0 0000000000000046 ffff880100000000 00000000000153c0
 ffff88013390bfd8 00000000000153c0 ffff88013390bfd8 ffff8801338ddb00
 00000000000153c0 00000000000153c0 ffff88013390bfd8 00000000000153c0
Call Trace:
 [<ffffffff8104bc40>] ? migration_cpu_stop+0x0/0x30
 [<ffffffff810a9f65>] cpu_stopper_thread+0x125/0x1b0
 [<ffffffff813def41>] ? schedule+0x3e1/0x820
 [<ffffffff810a9e40>] ? cpu_stopper_thread+0x0/0x1b0
 [<ffffffff810786c6>] kthread+0x96/0xa0
 [<ffffffff8100ade4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81078630>] ? kthread+0x0/0xa0
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
ksoftirqd/2   S 00000000ffffffff     0    10      2 0x00000000
 ffff880133915ea0 0000000000000046 ffff880100000000 00000000000153c0
 ffff880133915fd8 00000000000153c0 ffff880133915fd8 ffff880133918000
 00000000000153c0 00000000000153c0 ffff880133915fd8 00000000000153c0
Call Trace:
 [<ffffffff81061005>] run_ksoftirqd+0xe5/0x140
 [<ffffffff81060f20>] ? run_ksoftirqd+0x0/0x140
 [<ffffffff810786c6>] kthread+0x96/0xa0
 [<ffffffff8100ade4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81078630>] ? kthread+0x0/0xa0
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
watchdog/2    S 00000000fffb70fb     0    11      2 0x00000000
 ffff880133917ea0 0000000000000046 ffff8801339196c0 00000000000153c0
 ffff880133917fd8 00000000000153c0 ffff880133917fd8 ffff8801339196c0
 00000000000153c0 00000000000153c0 ffff880133917fd8 00000000000153c0
Call Trace:
 [<ffffffff810b6520>] ? watchdog+0x0/0xa0
 [<ffffffff810b657a>] watchdog+0x5a/0xa0
 [<ffffffff810b6520>] ? watchdog+0x0/0xa0
 [<ffffffff810786c6>] kthread+0x96/0xa0
 [<ffffffff8100ade4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81078630>] ? kthread+0x0/0xa0
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
migration/3   S 0000000103da9862     0    12      2 0x00000000
 ffff880133923de0 0000000000000046 ffff880100000000 00000000000153c0
 ffff880133923fd8 00000000000153c0 ffff880133923fd8 ffff88013391c440
 00000000000153c0 00000000000153c0 ffff880133923fd8 00000000000153c0
Call Trace:
 [<ffffffff8104bc40>] ? migration_cpu_stop+0x0/0x30
 [<ffffffff810a9f65>] cpu_stopper_thread+0x125/0x1b0
 [<ffffffff813def41>] ? schedule+0x3e1/0x820
 [<ffffffff810a9e40>] ? cpu_stopper_thread+0x0/0x1b0
 [<ffffffff810786c6>] kthread+0x96/0xa0
 [<ffffffff8100ade4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81078630>] ? kthread+0x0/0xa0
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
ksoftirqd/3   S 00000000ffffffff     0    13      2 0x00000000
 ffff880133929ea0 0000000000000046 ffff880100000000 00000000000153c0
 ffff880133929fd8 00000000000153c0 ffff880133929fd8 ffff88013391db00
 00000000000153c0 00000000000153c0 ffff880133929fd8 00000000000153c0
Call Trace:
 [<ffffffff81061005>] run_ksoftirqd+0xe5/0x140
 [<ffffffff81060f20>] ? run_ksoftirqd+0x0/0x140
 [<ffffffff810786c6>] kthread+0x96/0xa0
 [<ffffffff8100ade4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81078630>] ? kthread+0x0/0xa0
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
watchdog/3    S 00000000fffb7143     0    14      2 0x00000000
 ffff88013392bea0 0000000000000046 ffff880133930000 00000000000153c0
 ffff88013392bfd8 00000000000153c0 ffff88013392bfd8 ffff880133930000
 00000000000153c0 00000000000153c0 ffff88013392bfd8 00000000000153c0
Call Trace:
 [<ffffffff810b6520>] ? watchdog+0x0/0xa0
 [<ffffffff810b657a>] watchdog+0x5a/0xa0
 [<ffffffff810b6520>] ? watchdog+0x0/0xa0
 [<ffffffff810786c6>] kthread+0x96/0xa0
 [<ffffffff8100ade4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81078630>] ? kthread+0x0/0xa0
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
events/0      S 0000000103dbde8d     0    15      2 0x00000000
 ffff88013392fe30 0000000000000046 ffff880100000000 00000000000153c0
 ffff88013392ffd8 00000000000153c0 ffff88013392ffd8 ffff880133940000
 00000000000153c0 00000000000153c0 ffff88013392ffd8 00000000000153c0
Call Trace:
 [<ffffffff812a9b90>] ? console_callback+0x0/0x140
 [<ffffffff812a9b90>] ? console_callback+0x0/0x140
 [<ffffffff81074635>] worker_thread+0x1f5/0x2a0
 [<ffffffff81078c00>] ? autoremove_wake_function+0x0/0x40
 [<ffffffff81074440>] ? worker_thread+0x0/0x2a0
 [<ffffffff810786c6>] kthread+0x96/0xa0
 [<ffffffff8100ade4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81078630>] ? kthread+0x0/0xa0
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
events/1      S 0000000103dbde84     0    16      2 0x00000000
 ffff880133975e30 0000000000000046 0000000000000000 00000000000153c0
 ffff880133975fd8 00000000000153c0 ffff880133975fd8 ffff8801339416c0
 00000000000153c0 00000000000153c0 ffff880133975fd8 00000000000153c0
Call Trace:
 [<ffffffff811024c0>] ? vmstat_update+0x0/0x40
 [<ffffffff81074635>] worker_thread+0x1f5/0x2a0
 [<ffffffff81078c00>] ? autoremove_wake_function+0x0/0x40
 [<ffffffff81074440>] ? worker_thread+0x0/0x2a0
 [<ffffffff810786c6>] kthread+0x96/0xa0
 [<ffffffff8100ade4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81078630>] ? kthread+0x0/0xa0
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
events/2      S 00000000ffffffff     0    17      2 0x00000000
 ffff880133977e30 0000000000000046 00000000ffffffff 00000000000153c0
 ffff880133977fd8 00000000000153c0 ffff880133977fd8 ffff880133942d80
 00000000000153c0 00000000000153c0 ffff880133977fd8 00000000000153c0
Call Trace:
 [<ffffffff81078f10>] ? prepare_to_wait+0x60/0x90
 [<ffffffff811024c0>] ? vmstat_update+0x0/0x40
 [<ffffffff81074635>] worker_thread+0x1f5/0x2a0
 [<ffffffff81078c00>] ? autoremove_wake_function+0x0/0x40
 [<ffffffff81074440>] ? worker_thread+0x0/0x2a0
 [<ffffffff810786c6>] kthread+0x96/0xa0
 [<ffffffff8100ade4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81078630>] ? kthread+0x0/0xa0
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
events/3      S 00000000ffffffff     0    18      2 0x00000000
 ffff880133979e30 0000000000000046 00000000ffffffff 00000000000153c0
 ffff880133979fd8 00000000000153c0 ffff880133979fd8 ffff880133944440
 00000000000153c0 00000000000153c0 ffff880133979fd8 00000000000153c0
Call Trace:
 [<ffffffff81078f10>] ? prepare_to_wait+0x60/0x90
 [<ffffffff811024c0>] ? vmstat_update+0x0/0x40
 [<ffffffff81074635>] worker_thread+0x1f5/0x2a0
 [<ffffffff81078c00>] ? autoremove_wake_function+0x0/0x40
 [<ffffffff81074440>] ? worker_thread+0x0/0x2a0
 [<ffffffff810786c6>] kthread+0x96/0xa0
 [<ffffffff8100ade4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81078630>] ? kthread+0x0/0xa0
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
cpuset        S 00000000fffb6d60     0    19      2 0x00000000
 ffff88013397be30 0000000000000046 ffff880000000000 00000000000153c0
 ffff88013397bfd8 00000000000153c0 ffff88013397bfd8 ffff880133945b00
 00000000000153c0 00000000000153c0 ffff88013397bfd8 00000000000153c0
Call Trace:
 [<ffffffff81074440>] ? worker_thread+0x0/0x2a0
 [<ffffffff81074635>] worker_thread+0x1f5/0x2a0
 [<ffffffff81078c00>] ? autoremove_wake_function+0x0/0x40
 [<ffffffff81074440>] ? worker_thread+0x0/0x2a0
 [<ffffffff810786c6>] kthread+0x96/0xa0
 [<ffffffff8100ade4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81078630>] ? kthread+0x0/0xa0
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
khelper       S 0000000103da11a3     0    20      2 0x00000000
 ffff88013397de30 0000000000000046 0000000000000000 00000000000153c0
 ffff88013397dfd8 00000000000153c0 ffff88013397dfd8 ffff880133980000
 00000000000153c0 00000000000153c0 ffff88013397dfd8 00000000000153c0
Call Trace:
 [<ffffffff81073210>] ? __call_usermodehelper+0x0/0xb0
 [<ffffffff81074635>] worker_thread+0x1f5/0x2a0
 [<ffffffff81078c00>] ? autoremove_wake_function+0x0/0x40
 [<ffffffff81074440>] ? worker_thread+0x0/0x2a0
 [<ffffffff810786c6>] kthread+0x96/0xa0
 [<ffffffff8100ade4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81078630>] ? kthread+0x0/0xa0
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
netns         S 0000000103d9d7cc     0    21      2 0x00000000
 ffff88013397fe30 0000000000000046 ffff880100000000 00000000000153c0
 ffff88013397ffd8 00000000000153c0 ffff88013397ffd8 ffff8801339816c0
 00000000000153c0 00000000000153c0 ffff88013397ffd8 00000000000153c0
Call Trace:
 [<ffffffff8132c100>] ? cleanup_net+0x0/0x1b0
 [<ffffffff81074635>] worker_thread+0x1f5/0x2a0
 [<ffffffff81078c00>] ? autoremove_wake_function+0x0/0x40
 [<ffffffff81074440>] ? worker_thread+0x0/0x2a0
 [<ffffffff810786c6>] kthread+0x96/0xa0
 [<ffffffff8100ade4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81078630>] ? kthread+0x0/0xa0
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
async/mgr     S 00000000ffffffff     0    22      2 0x00000000
 ffff8801339abe80 0000000000000046 ffff880001a153c0 00000000000153c0
 ffff8801339abfd8 00000000000153c0 ffff8801339abfd8 ffff880133982d80
 00000000000153c0 00000000000153c0 ffff8801339abfd8 00000000000153c0
Call Trace:
 [<ffffffff8107fd95>] async_manager_thread+0x65/0x110
 [<ffffffff8104d280>] ? default_wake_function+0x0/0x20
 [<ffffffff8107fd30>] ? async_manager_thread+0x0/0x110
 [<ffffffff810786c6>] kthread+0x96/0xa0
 [<ffffffff8100ade4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81078630>] ? kthread+0x0/0xa0
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
pm            S 0000000103c1dd24     0    23      2 0x00000000
 ffff8801339ade30 0000000000000046 ffff880000000000 00000000000153c0
 ffff8801339adfd8 00000000000153c0 ffff8801339adfd8 ffff880133984440
 00000000000153c0 00000000000153c0 ffff8801339adfd8 00000000000153c0
Call Trace:
 [<ffffffff812d0680>] ? pm_runtime_work+0x0/0xb0
 [<ffffffff81074635>] worker_thread+0x1f5/0x2a0
 [<ffffffff81078c00>] ? autoremove_wake_function+0x0/0x40
 [<ffffffff81074440>] ? worker_thread+0x0/0x2a0
 [<ffffffff810786c6>] kthread+0x96/0xa0
 [<ffffffff8100ade4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81078630>] ? kthread+0x0/0xa0
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
sync_supers   S 00000000ffffffff     0    24      2 0x00000000
 ffff880133a31eb0 0000000000000046 ffffffff00000000 00000000000153c0
 ffff880133a31fd8 00000000000153c0 ffff880133a31fd8 ffff880133985b00
 00000000000153c0 00000000000153c0 ffff880133a31fd8 00000000000153c0
Call Trace:
 [<ffffffff81102ca0>] ? bdi_sync_supers+0x0/0x60
 [<ffffffff81102ce4>] bdi_sync_supers+0x44/0x60
 [<ffffffff810786c6>] kthread+0x96/0xa0
 [<ffffffff8100ade4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81078630>] ? kthread+0x0/0xa0
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
bdi-default   S 0000000103dbd59c     0    25      2 0x00000000
 ffff880133a33d70 0000000000000046 0000000000000000 00000000000153c0
 ffff880133a33fd8 00000000000153c0 ffff880133a33fd8 ffff880133a38000
 00000000000153c0 00000000000153c0 ffff880133a33fd8 00000000000153c0
Call Trace:
 [<ffffffff813df93d>] schedule_timeout+0x18d/0x300
 [<ffffffff81069a00>] ? process_timeout+0x0/0x10
 [<ffffffff81103693>] bdi_forker_task+0x2b3/0x390
 [<ffffffff811033e0>] ? bdi_forker_task+0x0/0x390
 [<ffffffff810786c6>] kthread+0x96/0xa0
 [<ffffffff8100ade4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81078630>] ? kthread+0x0/0xa0
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
kintegrityd/0 S 00000000fffb6d99     0    26      2 0x00000000
 ffff880133a35e30 0000000000000046 0000000000000000 00000000000153c0
 ffff880133a35fd8 00000000000153c0 ffff880133a35fd8 ffff880133a396c0
 00000000000153c0 00000000000153c0 ffff880133a35fd8 00000000000153c0
Call Trace:
 [<ffffffff81078f10>] ? prepare_to_wait+0x60/0x90
 [<ffffffff81074440>] ? worker_thread+0x0/0x2a0
 [<ffffffff81074635>] worker_thread+0x1f5/0x2a0
 [<ffffffff81078c00>] ? autoremove_wake_function+0x0/0x40
 [<ffffffff81074440>] ? worker_thread+0x0/0x2a0
 [<ffffffff810786c6>] kthread+0x96/0xa0
 [<ffffffff8100ade4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81078630>] ? kthread+0x0/0xa0
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
kintegrityd/1 S 00000000fffb6d60     0    27      2 0x00000000
 ffff880133a37e30 0000000000000046 0000000000000000 00000000000153c0
 ffff880133a37fd8 00000000000153c0 ffff880133a37fd8 ffff880133a3ad80
 00000000000153c0 00000000000153c0 ffff880133a37fd8 00000000000153c0
Call Trace:
 [<ffffffff81074440>] ? worker_thread+0x0/0x2a0
 [<ffffffff81074635>] worker_thread+0x1f5/0x2a0
 [<ffffffff81078c00>] ? autoremove_wake_function+0x0/0x40
 [<ffffffff81074440>] ? worker_thread+0x0/0x2a0
 [<ffffffff810786c6>] kthread+0x96/0xa0
 [<ffffffff8100ade4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81078630>] ? kthread+0x0/0xa0
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
kintegrityd/2 S 00000000fffb6d99     0    28      2 0x00000000
 ffff880133a41e30 0000000000000046 0000000000000000 00000000000153c0
 ffff880133a41fd8 00000000000153c0 ffff880133a41fd8 ffff880133a3c440
 00000000000153c0 00000000000153c0 ffff880133a41fd8 00000000000153c0
Call Trace:
 [<ffffffff81078f10>] ? prepare_to_wait+0x60/0x90
 [<ffffffff81074440>] ? worker_thread+0x0/0x2a0
 [<ffffffff81074635>] worker_thread+0x1f5/0x2a0
 [<ffffffff81078c00>] ? autoremove_wake_function+0x0/0x40
 [<ffffffff81074440>] ? worker_thread+0x0/0x2a0
 [<ffffffff810786c6>] kthread+0x96/0xa0
 [<ffffffff8100ade4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81078630>] ? kthread+0x0/0xa0
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
kintegrityd/3 S 00000000fffb6d60     0    29      2 0x00000000
 ffff880133a43e30 0000000000000046 0000000000000000 00000000000153c0
 ffff880133a43fd8 00000000000153c0 ffff880133a43fd8 ffff880133a3db00
 00000000000153c0 00000000000153c0 ffff880133a43fd8 00000000000153c0
Call Trace:
 [<ffffffff81074440>] ? worker_thread+0x0/0x2a0
 [<ffffffff81074635>] worker_thread+0x1f5/0x2a0
 [<ffffffff81078c00>] ? autoremove_wake_function+0x0/0x40
 [<ffffffff81074440>] ? worker_thread+0x0/0x2a0
 [<ffffffff810786c6>] kthread+0x96/0xa0
 [<ffffffff8100ade4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81078630>] ? kthread+0x0/0xa0
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
kblockd/0     S 00000000ffffffff     0    30      2 0x00000000
 ffff880133a45e30 0000000000000046 ffff880131ef1bd8 00000000000153c0
 ffff880133a45fd8 00000000000153c0 ffff880133a45fd8 ffff880133a50000
 00000000000153c0 00000000000153c0 ffff880133a45fd8 00000000000153c0
Call Trace:
 [<ffffffff81078f10>] ? prepare_to_wait+0x60/0x90
 [<ffffffff811ead60>] ? blk_unplug_work+0x0/0x70
 [<ffffffff81074635>] worker_thread+0x1f5/0x2a0
 [<ffffffff81078c00>] ? autoremove_wake_function+0x0/0x40
 [<ffffffff81074440>] ? worker_thread+0x0/0x2a0
 [<ffffffff810786c6>] kthread+0x96/0xa0
 [<ffffffff8100ade4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81078630>] ? kthread+0x0/0xa0
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
kblockd/1     S 00000000ffffffff     0    31      2 0x00000000
 ffff880133a47e30 0000000000000046 ffff880131ef1bd8 00000000000153c0
 ffff880133a47fd8 00000000000153c0 ffff880133a47fd8 ffff880133a516c0
 00000000000153c0 00000000000153c0 ffff880133a47fd8 00000000000153c0
Call Trace:
 [<ffffffff81078f10>] ? prepare_to_wait+0x60/0x90
 [<ffffffff811ead60>] ? blk_unplug_work+0x0/0x70
 [<ffffffff81074635>] worker_thread+0x1f5/0x2a0
 [<ffffffff81078c00>] ? autoremove_wake_function+0x0/0x40
 [<ffffffff81074440>] ? worker_thread+0x0/0x2a0
 [<ffffffff810786c6>] kthread+0x96/0xa0
 [<ffffffff8100ade4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81078630>] ? kthread+0x0/0xa0
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
kblockd/2     S 00000000ffffffff     0    32      2 0x00000000
 ffff880133a65e30 0000000000000046 ffff880100000000 00000000000153c0
 ffff880133a65fd8 00000000000153c0 ffff880133a65fd8 ffff880133a52d80
 00000000000153c0 00000000000153c0 ffff880133a65fd8 00000000000153c0
Call Trace:
 [<ffffffff81078f10>] ? prepare_to_wait+0x60/0x90
 [<ffffffff811fb340>] ? cfq_kick_queue+0x0/0x60
 [<ffffffff81074635>] worker_thread+0x1f5/0x2a0
 [<ffffffff81078c00>] ? autoremove_wake_function+0x0/0x40
 [<ffffffff81074440>] ? worker_thread+0x0/0x2a0
 [<ffffffff810786c6>] kthread+0x96/0xa0
 [<ffffffff8100ade4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81078630>] ? kthread+0x0/0xa0
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
kblockd/3     S 0000000103dae8b1     0    33      2 0x00000000
 ffff880133a67e30 0000000000000046 ffff880100000000 00000000000153c0
 ffff880133a67fd8 00000000000153c0 ffff880133a67fd8 ffff880133a54440
 00000000000153c0 00000000000153c0 ffff880133a67fd8 00000000000153c0
Call Trace:
 [<ffffffff811fb340>] ? cfq_kick_queue+0x0/0x60
 [<ffffffff81074635>] worker_thread+0x1f5/0x2a0
 [<ffffffff81078c00>] ? autoremove_wake_function+0x0/0x40
 [<ffffffff81074440>] ? worker_thread+0x0/0x2a0
 [<ffffffff810786c6>] kthread+0x96/0xa0
 [<ffffffff8100ade4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81078630>] ? kthread+0x0/0xa0
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
kacpid        S 00000000fffb6d99     0    34      2 0x00000000
 ffff880133a69e30 0000000000000046 ffffffff8104bc40 00000000000153c0
 ffff880133a69fd8 00000000000153c0 ffff880133a69fd8 ffff880133a55b00
 00000000000153c0 00000000000153c0 ffff880133a69fd8 00000000000153c0
Call Trace:
 [<ffffffff8104bc40>] ? migration_cpu_stop+0x0/0x30
 [<ffffffff81078f10>] ? prepare_to_wait+0x60/0x90
 [<ffffffff81255775>] ? bind_to_cpu0+0x0/0x32
 [<ffffffff81074635>] worker_thread+0x1f5/0x2a0
 [<ffffffff81078c00>] ? autoremove_wake_function+0x0/0x40
 [<ffffffff81074440>] ? worker_thread+0x0/0x2a0
 [<ffffffff810786c6>] kthread+0x96/0xa0
 [<ffffffff8100ade4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81078630>] ? kthread+0x0/0xa0
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
kacpi_notify  S 00000000fffb6d99     0    35      2 0x00000000
 ffff880133a6be30 0000000000000046 ffffffff8104bc40 00000000000153c0
 ffff880133a6bfd8 00000000000153c0 ffff880133a6bfd8 ffff880133a70000
 00000000000153c0 00000000000153c0 ffff880133a6bfd8 00000000000153c0
Call Trace:
 [<ffffffff8104bc40>] ? migration_cpu_stop+0x0/0x30
 [<ffffffff81078f10>] ? prepare_to_wait+0x60/0x90
 [<ffffffff81255775>] ? bind_to_cpu0+0x0/0x32
 [<ffffffff81074635>] worker_thread+0x1f5/0x2a0
 [<ffffffff81078c00>] ? autoremove_wake_function+0x0/0x40
 [<ffffffff81074440>] ? worker_thread+0x0/0x2a0
 [<ffffffff810786c6>] kthread+0x96/0xa0
 [<ffffffff8100ade4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81078630>] ? kthread+0x0/0xa0
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
kacpi_hotplug S 00000000fffb6da1     0    36      2 0x00000000
 ffff880133a6de30 0000000000000046 ffff880133871d40 00000000000153c0
 ffff880133a6dfd8 00000000000153c0 ffff880133a6dfd8 ffff880133a716c0
 00000000000153c0 00000000000153c0 ffff880133a6dfd8 00000000000153c0
Call Trace:
 [<ffffffff81078f10>] ? prepare_to_wait+0x60/0x90
 [<ffffffff81255775>] ? bind_to_cpu0+0x0/0x32
 [<ffffffff81074635>] worker_thread+0x1f5/0x2a0
 [<ffffffff81078c00>] ? autoremove_wake_function+0x0/0x40
 [<ffffffff81074440>] ? worker_thread+0x0/0x2a0
 [<ffffffff810786c6>] kthread+0x96/0xa0
 [<ffffffff8100ade4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81078630>] ? kthread+0x0/0xa0
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
kseriod       S 00000000fffb8fbd     0    37      2 0x00000000
 ffff880133b6be50 0000000000000046 ffff880100000000 00000000000153c0
 ffff880133b6bfd8 00000000000153c0 ffff880133b6bfd8 ffff880133932d80
 00000000000153c0 00000000000153c0 ffff880133b6bfd8 00000000000153c0
Call Trace:
 [<ffffffff812e22bb>] serio_thread+0x32b/0x3b0
 [<ffffffff81078c00>] ? autoremove_wake_function+0x0/0x40
 [<ffffffff812e1f90>] ? serio_thread+0x0/0x3b0
 [<ffffffff810786c6>] kthread+0x96/0xa0
 [<ffffffff8100ade4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81078630>] ? kthread+0x0/0xa0
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
khungtaskd    S 0000000103dbdc46     0    38      2 0x00000000
 ffff880132a7fdd0 0000000000000046 ffff880100000000 00000000000153c0
 ffff880132a7ffd8 00000000000153c0 ffff880132a7ffd8 ffff880133934440
 00000000000153c0 00000000000153c0 ffff880132a7ffd8 00000000000153c0
Call Trace:
 [<ffffffff813df93d>] schedule_timeout+0x18d/0x300
 [<ffffffff81069a00>] ? process_timeout+0x0/0x10
 [<ffffffff813dfb0e>] schedule_timeout_interruptible+0x1e/0x20
 [<ffffffff810b68e2>] watchdog+0x52/0x210
 [<ffffffff810b6890>] ? watchdog+0x0/0x210
 [<ffffffff810786c6>] kthread+0x96/0xa0
 [<ffffffff8100ade4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81078630>] ? kthread+0x0/0xa0
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
kswapd0       S 00000000fffb6d60     0    39      2 0x00000000
 ffff880131e21e40 0000000000000046 0000000000000000 00000000000153c0
 ffff880131e21fd8 00000000000153c0 ffff880131e21fd8 ffff880133a72d80
 00000000000153c0 00000000000153c0 ffff880131e21fd8 00000000000153c0
Call Trace:
 [<ffffffff810fb045>] kswapd+0x1e5/0x230
 [<ffffffff81078c00>] ? autoremove_wake_function+0x0/0x40
 [<ffffffff810fae60>] ? kswapd+0x0/0x230
 [<ffffffff810786c6>] kthread+0x96/0xa0
 [<ffffffff8100ade4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81078630>] ? kthread+0x0/0xa0
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
ksmd          S 0000000103d95a94     0    40      2 0x00000000
 ffff880131e23e30 0000000000000046 ffff880100000000 00000000000153c0
 ffff880131e23fd8 00000000000153c0 ffff880131e23fd8 ffff880133a74440
 00000000000153c0 00000000000153c0 ffff880131e23fd8 00000000000153c0
Call Trace:
 [<ffffffff811261f0>] ? ksm_scan_thread+0x0/0xc40
 [<ffffffff81126992>] ksm_scan_thread+0x7a2/0xc40
 [<ffffffff81078c00>] ? autoremove_wake_function+0x0/0x40
 [<ffffffff811261f0>] ? ksm_scan_thread+0x0/0xc40
 [<ffffffff810786c6>] kthread+0x96/0xa0
 [<ffffffff8100ade4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81078630>] ? kthread+0x0/0xa0
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
aio/0         S 00000000fffb6d60     0    41      2 0x00000000
 ffff880131e45e30 0000000000000046 ffff880000000000 00000000000153c0
 ffff880131e45fd8 00000000000153c0 ffff880131e45fd8 ffff880133a75b00
 00000000000153c0 00000000000153c0 ffff880131e45fd8 00000000000153c0
Call Trace:
 [<ffffffff81074440>] ? worker_thread+0x0/0x2a0
 [<ffffffff81074635>] worker_thread+0x1f5/0x2a0
 [<ffffffff81078c00>] ? autoremove_wake_function+0x0/0x40
 [<ffffffff81074440>] ? worker_thread+0x0/0x2a0
 [<ffffffff810786c6>] kthread+0x96/0xa0
 [<ffffffff8100ade4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81078630>] ? kthread+0x0/0xa0
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
aio/1         S 00000000fffb6d60     0    42      2 0x00000000
 ffff880131e47e30 0000000000000046 ffff880000000000 00000000000153c0
 ffff880131e47fd8 00000000000153c0 ffff880131e47fd8 ffff880131e48000
 00000000000153c0 00000000000153c0 ffff880131e47fd8 00000000000153c0
Call Trace:
 [<ffffffff81074440>] ? worker_thread+0x0/0x2a0
 [<ffffffff81074635>] worker_thread+0x1f5/0x2a0
 [<ffffffff81078c00>] ? autoremove_wake_function+0x0/0x40
 [<ffffffff81074440>] ? worker_thread+0x0/0x2a0
 [<ffffffff810786c6>] kthread+0x96/0xa0
 [<ffffffff8100ade4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81078630>] ? kthread+0x0/0xa0
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
aio/2         S 00000000fffb6d60     0    43      2 0x00000000
 ffff880131e51e30 0000000000000046 ffff880000000000 00000000000153c0
 ffff880131e51fd8 00000000000153c0 ffff880131e51fd8 ffff880131e496c0
 00000000000153c0 00000000000153c0 ffff880131e51fd8 00000000000153c0
Call Trace:
 [<ffffffff81074440>] ? worker_thread+0x0/0x2a0
 [<ffffffff81074635>] worker_thread+0x1f5/0x2a0
 [<ffffffff81078c00>] ? autoremove_wake_function+0x0/0x40
 [<ffffffff81074440>] ? worker_thread+0x0/0x2a0
 [<ffffffff810786c6>] kthread+0x96/0xa0
 [<ffffffff8100ade4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81078630>] ? kthread+0x0/0xa0
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
aio/3         S 00000000fffb6d60     0    44      2 0x00000000
 ffff880131e53e30 0000000000000046 ffff880000000000 00000000000153c0
 ffff880131e53fd8 00000000000153c0 ffff880131e53fd8 ffff880131e4ad80
 00000000000153c0 00000000000153c0 ffff880131e53fd8 00000000000153c0
Call Trace:
 [<ffffffff81074440>] ? worker_thread+0x0/0x2a0
 [<ffffffff81074635>] worker_thread+0x1f5/0x2a0
 [<ffffffff81078c00>] ? autoremove_wake_function+0x0/0x40
 [<ffffffff81074440>] ? worker_thread+0x0/0x2a0
 [<ffffffff810786c6>] kthread+0x96/0xa0
 [<ffffffff8100ade4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81078630>] ? kthread+0x0/0xa0
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
crypto/0      S 00000000fffb6e29     0    45      2 0x00000000
 ffff880131e77e30 0000000000000046 ffff880001b153c0 00000000000153c0
 ffff880131e77fd8 00000000000153c0 ffff880131e77fd8 ffff880131e4c440
 00000000000153c0 00000000000153c0 ffff880131e77fd8 00000000000153c0
Call Trace:
 [<ffffffff81078f10>] ? prepare_to_wait+0x60/0x90
 [<ffffffff81074440>] ? worker_thread+0x0/0x2a0
 [<ffffffff81074635>] worker_thread+0x1f5/0x2a0
 [<ffffffff81078c00>] ? autoremove_wake_function+0x0/0x40
 [<ffffffff81074440>] ? worker_thread+0x0/0x2a0
 [<ffffffff810786c6>] kthread+0x96/0xa0
 [<ffffffff8100ade4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81078630>] ? kthread+0x0/0xa0
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
crypto/1      S 00000000fffb6e29     0    46      2 0x00000000
 ffff880131e7de30 0000000000000046 ffff880001b153c0 00000000000153c0
 ffff880131e7dfd8 00000000000153c0 ffff880131e7dfd8 ffff880131e4db00
 00000000000153c0 00000000000153c0 ffff880131e7dfd8 00000000000153c0
Call Trace:
 [<ffffffff81078f10>] ? prepare_to_wait+0x60/0x90
 [<ffffffff81074440>] ? worker_thread+0x0/0x2a0
 [<ffffffff81074635>] worker_thread+0x1f5/0x2a0
 [<ffffffff81078c00>] ? autoremove_wake_function+0x0/0x40
 [<ffffffff81074440>] ? worker_thread+0x0/0x2a0
 [<ffffffff810786c6>] kthread+0x96/0xa0
 [<ffffffff8100ade4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81078630>] ? kthread+0x0/0xa0
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
crypto/2      S 00000000fffb6d60     0    47      2 0x00000000
 ffff880131e7fe30 0000000000000046 ffff880000000000 00000000000153c0
 ffff880131e7ffd8 00000000000153c0 ffff880131e7ffd8 ffff880131e80000
 00000000000153c0 00000000000153c0 ffff880131e7ffd8 00000000000153c0
Call Trace:
 [<ffffffff81074440>] ? worker_thread+0x0/0x2a0
 [<ffffffff81074635>] worker_thread+0x1f5/0x2a0
 [<ffffffff81078c00>] ? autoremove_wake_function+0x0/0x40
 [<ffffffff81074440>] ? worker_thread+0x0/0x2a0
 [<ffffffff810786c6>] kthread+0x96/0xa0
 [<ffffffff8100ade4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81078630>] ? kthread+0x0/0xa0
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
crypto/3      S 00000000fffb6d60     0    48      2 0x00000000
 ffff880131e95e30 0000000000000046 ffff880000000000 00000000000153c0
 ffff880131e95fd8 00000000000153c0 ffff880131e95fd8 ffff880131e816c0
 00000000000153c0 00000000000153c0 ffff880131e95fd8 00000000000153c0
Call Trace:
 [<ffffffff81074440>] ? worker_thread+0x0/0x2a0
 [<ffffffff81074635>] worker_thread+0x1f5/0x2a0
 [<ffffffff81078c00>] ? autoremove_wake_function+0x0/0x40
 [<ffffffff81074440>] ? worker_thread+0x0/0x2a0
 [<ffffffff810786c6>] kthread+0x96/0xa0
 [<ffffffff8100ade4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81078630>] ? kthread+0x0/0xa0
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
kpsmoused     S 00000000fffb6e67     0    51      2 0x00000000
 ffff880131f1fe30 0000000000000046 ffff880001b153c0 00000000000153c0
 ffff880131f1ffd8 00000000000153c0 ffff880131f1ffd8 ffff880131e85b00
 00000000000153c0 00000000000153c0 ffff880131f1ffd8 00000000000153c0
Call Trace:
 [<ffffffff81078f10>] ? prepare_to_wait+0x60/0x90
 [<ffffffff81074440>] ? worker_thread+0x0/0x2a0
 [<ffffffff81074635>] worker_thread+0x1f5/0x2a0
 [<ffffffff81078c00>] ? autoremove_wake_function+0x0/0x40
 [<ffffffff81074440>] ? worker_thread+0x0/0x2a0
 [<ffffffff810786c6>] kthread+0x96/0xa0
 [<ffffffff8100ade4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81078630>] ? kthread+0x0/0xa0
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
khubd         S 0000000103c1d384     0    63      2 0x00000000
 ffff880131937e60 0000000000000046 0000000000000000 00000000000153c0
 ffff880131937fd8 00000000000153c0 ffff880131937fd8 ffff8801318896c0
 00000000000153c0 00000000000153c0 ffff880131937fd8 00000000000153c0
Call Trace:
 [<ffffffffa0006692>] hub_thread+0xf2/0x1c0 [usbcore]
 [<ffffffff81078c00>] ? autoremove_wake_function+0x0/0x40
 [<ffffffffa00065a0>] ? hub_thread+0x0/0x1c0 [usbcore]
 [<ffffffff810786c6>] kthread+0x96/0xa0
 [<ffffffff8100ade4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81078630>] ? kthread+0x0/0xa0
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
usbhid_resume S 00000000fffb744b     0    64      2 0x00000000
 ffff88013196de30 0000000000000046 ffff880000000000 00000000000153c0
 ffff88013196dfd8 00000000000153c0 ffff88013196dfd8 ffff88013188ad80
 00000000000153c0 00000000000153c0 ffff88013196dfd8 00000000000153c0
Call Trace:
 [<ffffffff81074440>] ? worker_thread+0x0/0x2a0
 [<ffffffff81074635>] worker_thread+0x1f5/0x2a0
 [<ffffffff81078c00>] ? autoremove_wake_function+0x0/0x40
 [<ffffffff81074440>] ? worker_thread+0x0/0x2a0
 [<ffffffff810786c6>] kthread+0x96/0xa0
 [<ffffffff8100ade4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81078630>] ? kthread+0x0/0xa0
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
ata_aux       S 00000000fffb7767     0    73      2 0x00000000
 ffff880131ffde30 0000000000000046 ffff880000000000 00000000000153c0
 ffff880131ffdfd8 00000000000153c0 ffff880131ffdfd8 ffff88013188c440
 00000000000153c0 00000000000153c0 ffff880131ffdfd8 00000000000153c0
Call Trace:
 [<ffffffffa0180350>] ? ata_scsi_dev_rescan+0x0/0x110 [libata]
 [<ffffffff81074635>] worker_thread+0x1f5/0x2a0
 [<ffffffff81078c00>] ? autoremove_wake_function+0x0/0x40
 [<ffffffff81074440>] ? worker_thread+0x0/0x2a0
 [<ffffffff810786c6>] kthread+0x96/0xa0
 [<ffffffff8100ade4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81078630>] ? kthread+0x0/0xa0
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
ata_sff/0     S 00000000fffb74c2     0    74      2 0x00000000
 ffff880131a93e30 0000000000000046 ffff880000000000 00000000000153c0
 ffff880131a93fd8 00000000000153c0 ffff880131a93fd8 ffff88013188db00
 00000000000153c0 00000000000153c0 ffff880131a93fd8 00000000000153c0
Call Trace:
 [<ffffffff81074440>] ? worker_thread+0x0/0x2a0
 [<ffffffff81074635>] worker_thread+0x1f5/0x2a0
 [<ffffffff81078c00>] ? autoremove_wake_function+0x0/0x40
 [<ffffffff81074440>] ? worker_thread+0x0/0x2a0
 [<ffffffff810786c6>] kthread+0x96/0xa0
 [<ffffffff8100ade4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81078630>] ? kthread+0x0/0xa0
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
ata_sff/1     S 00000000fffb760b     0    75      2 0x00000000
 ffff880131a95e30 0000000000000046 ffff880000000000 00000000000153c0
 ffff880131a95fd8 00000000000153c0 ffff880131a95fd8 ffff880131888000
 00000000000153c0 00000000000153c0 ffff880131a95fd8 00000000000153c0
Call Trace:
 [<ffffffff81074440>] ? worker_thread+0x0/0x2a0
 [<ffffffff81074635>] worker_thread+0x1f5/0x2a0
 [<ffffffff81078c00>] ? autoremove_wake_function+0x0/0x40
 [<ffffffff81074440>] ? worker_thread+0x0/0x2a0
 [<ffffffff810786c6>] kthread+0x96/0xa0
 [<ffffffff8100ade4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81078630>] ? kthread+0x0/0xa0
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
ata_sff/2     S 00000000fffb753e     0    76      2 0x00000000
 ffff880131a97e30 0000000000000046 ffff880000000000 00000000000153c0
 ffff880131a97fd8 00000000000153c0 ffff880131a97fd8 ffff880131e82d80
 00000000000153c0 00000000000153c0 ffff880131a97fd8 00000000000153c0
Call Trace:
 [<ffffffff81074440>] ? worker_thread+0x0/0x2a0
 [<ffffffff81074635>] worker_thread+0x1f5/0x2a0
 [<ffffffff81078c00>] ? autoremove_wake_function+0x0/0x40
 [<ffffffff81074440>] ? worker_thread+0x0/0x2a0
 [<ffffffff810786c6>] kthread+0x96/0xa0
 [<ffffffff8100ade4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81078630>] ? kthread+0x0/0xa0
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
ata_sff/3     S 00000000fffb74f2     0    77      2 0x00000000
 ffff880131aa1e30 0000000000000046 ffff880000000000 00000000000153c0
 ffff880131aa1fd8 00000000000153c0 ffff880131aa1fd8 ffff880131a98000
 00000000000153c0 00000000000153c0 ffff880131aa1fd8 00000000000153c0
Call Trace:
 [<ffffffff81074440>] ? worker_thread+0x0/0x2a0
 [<ffffffff81074635>] worker_thread+0x1f5/0x2a0
 [<ffffffff81078c00>] ? autoremove_wake_function+0x0/0x40
 [<ffffffff81074440>] ? worker_thread+0x0/0x2a0
 [<ffffffff810786c6>] kthread+0x96/0xa0
 [<ffffffff8100ade4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81078630>] ? kthread+0x0/0xa0
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
scsi_eh_0     S 00000000fffb776b     0    80      2 0x00000000
 ffff880131981e20 0000000000000046 0000000000000000 00000000000153c0
 ffff880131981fd8 00000000000153c0 ffff880131981fd8 ffff880131a996c0
 00000000000153c0 00000000000153c0 ffff880131981fd8 00000000000153c0
Call Trace:
 [<ffffffffa0123d53>] scsi_error_handler+0xb3/0x6c0 [scsi_mod]
 [<ffffffff813def41>] ? schedule+0x3e1/0x820
 [<ffffffffa0123ca0>] ? scsi_error_handler+0x0/0x6c0 [scsi_mod]
 [<ffffffff810786c6>] kthread+0x96/0xa0
 [<ffffffff8100ade4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81078630>] ? kthread+0x0/0xa0
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
scsi_eh_1     S 00000000ffffffff     0    81      2 0x00000000
 ffff880131fa9e20 0000000000000046 ffffffffa01bf480 00000000000153c0
 ffff880131fa9fd8 00000000000153c0 ffff880131fa9fd8 ffff880131a9ad80
 00000000000153c0 00000000000153c0 ffff880131fa9fd8 00000000000153c0
Call Trace:
 [<ffffffffa0123d53>] scsi_error_handler+0xb3/0x6c0 [scsi_mod]
 [<ffffffff813def41>] ? schedule+0x3e1/0x820
 [<ffffffffa0123ca0>] ? scsi_error_handler+0x0/0x6c0 [scsi_mod]
 [<ffffffff810786c6>] kthread+0x96/0xa0
 [<ffffffff8100ade4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81078630>] ? kthread+0x0/0xa0
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
scsi_eh_2     S 00000000fffb7a78     0    82      2 0x00000000
 ffff88013186de20 0000000000000046 ffff880100000000 00000000000153c0
 ffff88013186dfd8 00000000000153c0 ffff88013186dfd8 ffff880131a9c440
 00000000000153c0 00000000000153c0 ffff88013186dfd8 00000000000153c0
Call Trace:
 [<ffffffffa0123d53>] scsi_error_handler+0xb3/0x6c0 [scsi_mod]
 [<ffffffff813def41>] ? schedule+0x3e1/0x820
 [<ffffffffa0123ca0>] ? scsi_error_handler+0x0/0x6c0 [scsi_mod]
 [<ffffffff810786c6>] kthread+0x96/0xa0
 [<ffffffff8100ade4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81078630>] ? kthread+0x0/0xa0
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
scsi_eh_3     S 00000000fffb7aab     0    83      2 0x00000000
 ffff880131849e20 0000000000000046 ffff880100000000 00000000000153c0
 ffff880131849fd8 00000000000153c0 ffff880131849fd8 ffff880131a9db00
 00000000000153c0 00000000000153c0 ffff880131849fd8 00000000000153c0
Call Trace:
 [<ffffffffa0123d53>] scsi_error_handler+0xb3/0x6c0 [scsi_mod]
 [<ffffffff813def41>] ? schedule+0x3e1/0x820
 [<ffffffffa0123ca0>] ? scsi_error_handler+0x0/0x6c0 [scsi_mod]
 [<ffffffff810786c6>] kthread+0x96/0xa0
 [<ffffffff8100ade4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81078630>] ? kthread+0x0/0xa0
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
scsi_eh_4     D 0000000103dbe089     0    84      2 0x00000000
 ffff880133ab1870 0000000000000046 0000000000000000 00000000000153c0
 ffff880133ab1fd8 00000000000153c0 ffff880133ab1fd8 ffff880131b40000
 00000000000153c0 00000000000153c0 ffff880133ab1fd8 00000000000153c0
Call Trace:
 [<ffffffff813df93d>] schedule_timeout+0x18d/0x300
 [<ffffffff81069a00>] ? process_timeout+0x0/0x10
 [<ffffffff813dface>] schedule_timeout_uninterruptible+0x1e/0x20
 [<ffffffff8106ad30>] msleep+0x20/0x30
 [<ffffffffa0178654>] ata_wait_register+0x84/0xb0 [libata]
 [<ffffffffa01bd587>] T.944+0xe7/0x100 [libahci]
 [<ffffffffa01bd674>] ahci_do_softreset+0xd4/0x2b0 [libahci]
 [<ffffffffa01bb150>] ? ahci_check_ready+0x0/0x50 [libahci]
 [<ffffffffa01bd850>] ? ahci_softreset+0x0/0x60 [libahci]
 [<ffffffffa01bd8a1>] ahci_softreset+0x51/0x60 [libahci]
 [<ffffffffa018229d>] ata_do_reset+0x3d/0xa0 [libata]
 [<ffffffffa01bc470>] ? ahci_hardreset+0x0/0x130 [libahci]
 [<ffffffffa018592a>] ata_eh_reset+0x53a/0xee0 [libata]
 [<ffffffffa01bd850>] ? ahci_softreset+0x0/0x60 [libahci]
 [<ffffffffa01bc3b0>] ? ahci_postreset+0x0/0x60 [libahci]
 [<ffffffffa01bc470>] ? ahci_hardreset+0x0/0x130 [libahci]
 [<ffffffffa0184f32>] ? ata_eh_schedule_probe+0xe2/0x110 [libata]
 [<ffffffffa01bc470>] ? ahci_hardreset+0x0/0x130 [libahci]
 [<ffffffffa01bc3b0>] ? ahci_postreset+0x0/0x60 [libahci]
 [<ffffffffa018658c>] ata_eh_recover+0x2bc/0x1140 [libata]
 [<ffffffffa01bc3b0>] ? ahci_postreset+0x0/0x60 [libahci]
 [<ffffffffa01bc470>] ? ahci_hardreset+0x0/0x130 [libahci]
 [<ffffffffa01bd850>] ? ahci_softreset+0x0/0x60 [libahci]
 [<ffffffffa0178960>] ? ata_std_prereset+0x0/0xd0 [libata]
 [<ffffffffa018c843>] sata_pmp_error_handler+0x113/0xc30 [libata]
 [<ffffffff810699cc>] ? lock_timer_base+0x3c/0x70
 [<ffffffff8106a4b3>] ? try_to_del_timer_sync+0x83/0xe0
 [<ffffffffa01bc34f>] ahci_error_handler+0x1f/0x80 [libahci]
 [<ffffffffa0187b9c>] ata_scsi_error+0x64c/0x900 [libata]
 [<ffffffffa0123dfa>] scsi_error_handler+0x15a/0x6c0 [scsi_mod]
 [<ffffffff813def41>] ? schedule+0x3e1/0x820
 [<ffffffffa0123ca0>] ? scsi_error_handler+0x0/0x6c0 [scsi_mod]
 [<ffffffff810786c6>] kthread+0x96/0xa0
 [<ffffffff8100ade4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81078630>] ? kthread+0x0/0xa0
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
scsi_eh_5     S 00000000fffb7d58     0    85      2 0x00000000
 ffff880131a5be20 0000000000000046 ffff880100000000 00000000000153c0
 ffff880131a5bfd8 00000000000153c0 ffff880131a5bfd8 ffff880131b416c0
 00000000000153c0 00000000000153c0 ffff880131a5bfd8 00000000000153c0
Call Trace:
 [<ffffffffa0123d53>] scsi_error_handler+0xb3/0x6c0 [scsi_mod]
 [<ffffffff813def41>] ? schedule+0x3e1/0x820
 [<ffffffffa0123ca0>] ? scsi_error_handler+0x0/0x6c0 [scsi_mod]
 [<ffffffff810786c6>] kthread+0x96/0xa0
 [<ffffffff8100ade4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81078630>] ? kthread+0x0/0xa0
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
jbd2/sda6-8   S 0000000103da9e3d     0    94      2 0x00000000
 ffff8801318bde60 0000000000000046 0000000000000000 00000000000153c0
 ffff8801318bdfd8 00000000000153c0 ffff8801318bdfd8 ffff88013180c440
 00000000000153c0 00000000000153c0 ffff8801318bdfd8 00000000000153c0
Call Trace:
 [<ffffffffa00a188d>] kjournald2+0x1dd/0x200 [jbd2]
 [<ffffffff81078c00>] ? autoremove_wake_function+0x0/0x40
 [<ffffffffa00a16b0>] ? kjournald2+0x0/0x200 [jbd2]
 [<ffffffff810786c6>] kthread+0x96/0xa0
 [<ffffffff8100ade4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81078630>] ? kthread+0x0/0xa0
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
ext4-dio-unwr S 00000000fffb7f4b     0    95      2 0x00000000
 ffff880131b69e30 0000000000000046 ffff880000000000 00000000000153c0
 ffff880131b69fd8 00000000000153c0 ffff880131b69fd8 ffff88013180db00
 00000000000153c0 00000000000153c0 ffff880131b69fd8 00000000000153c0
Call Trace:
 [<ffffffff81074440>] ? worker_thread+0x0/0x2a0
 [<ffffffff81074635>] worker_thread+0x1f5/0x2a0
 [<ffffffff81078c00>] ? autoremove_wake_function+0x0/0x40
 [<ffffffff81074440>] ? worker_thread+0x0/0x2a0
 [<ffffffff810786c6>] kthread+0x96/0xa0
 [<ffffffff8100ade4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81078630>] ? kthread+0x0/0xa0
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
ext4-dio-unwr S 00000000fffb7f37     0    96      2 0x00000000
 ffff8801318b3e30 0000000000000046 ffff880000000000 00000000000153c0
 ffff8801318b3fd8 00000000000153c0 ffff8801318b3fd8 ffff88013180ad80
 00000000000153c0 00000000000153c0 ffff8801318b3fd8 00000000000153c0
Call Trace:
 [<ffffffff81074440>] ? worker_thread+0x0/0x2a0
 [<ffffffff81074635>] worker_thread+0x1f5/0x2a0
 [<ffffffff81078c00>] ? autoremove_wake_function+0x0/0x40
 [<ffffffff81074440>] ? worker_thread+0x0/0x2a0
 [<ffffffff810786c6>] kthread+0x96/0xa0
 [<ffffffff8100ade4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81078630>] ? kthread+0x0/0xa0
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
ext4-dio-unwr S 00000000fffb7f2b     0    97      2 0x00000000
 ffff8801318b5e30 0000000000000046 ffff880000000000 00000000000153c0
 ffff8801318b5fd8 00000000000153c0 ffff8801318b5fd8 ffff8801318096c0
 00000000000153c0 00000000000153c0 ffff8801318b5fd8 00000000000153c0
Call Trace:
 [<ffffffff81074440>] ? worker_thread+0x0/0x2a0
 [<ffffffff81074635>] worker_thread+0x1f5/0x2a0
 [<ffffffff81078c00>] ? autoremove_wake_function+0x0/0x40
 [<ffffffff81074440>] ? worker_thread+0x0/0x2a0
 [<ffffffff810786c6>] kthread+0x96/0xa0
 [<ffffffff8100ade4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81078630>] ? kthread+0x0/0xa0
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
ext4-dio-unwr S 00000000fffb7e34     0    98      2 0x00000000
 ffff8801318b7e30 0000000000000046 ffff880000000000 00000000000153c0
 ffff8801318b7fd8 00000000000153c0 ffff8801318b7fd8 ffff880131b45b00
 00000000000153c0 00000000000153c0 ffff8801318b7fd8 00000000000153c0
Call Trace:
 [<ffffffff81074440>] ? worker_thread+0x0/0x2a0
 [<ffffffff81074635>] worker_thread+0x1f5/0x2a0
 [<ffffffff81078c00>] ? autoremove_wake_function+0x0/0x40
 [<ffffffff81074440>] ? worker_thread+0x0/0x2a0
 [<ffffffff810786c6>] kthread+0x96/0xa0
 [<ffffffff8100ade4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81078630>] ? kthread+0x0/0xa0
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
flush-8:0     S 0000000103dbd674     0   102      2 0x00000000
 ffff880132aadd90 0000000000000046 ffff880100000000 00000000000153c0
 ffff880132aadfd8 00000000000153c0 ffff880132aadfd8 ffff880131fe2d80
 00000000000153c0 00000000000153c0 ffff880132aadfd8 00000000000153c0
Call Trace:
 [<ffffffff813df93d>] schedule_timeout+0x18d/0x300
 [<ffffffff81069a00>] ? process_timeout+0x0/0x10
 [<ffffffff813dfb0e>] schedule_timeout_interruptible+0x1e/0x20
 [<ffffffff8115e83c>] bdi_writeback_task+0x12c/0x160
 [<ffffffff81078ac7>] ? bit_waitqueue+0x17/0xd0
 [<ffffffff81103300>] ? bdi_start_fn+0x0/0xe0
 [<ffffffff81103371>] bdi_start_fn+0x71/0xe0
 [<ffffffff81103300>] ? bdi_start_fn+0x0/0xe0
 [<ffffffff810786c6>] kthread+0x96/0xa0
 [<ffffffff8100ade4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81078630>] ? kthread+0x0/0xa0
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
ktpacpid      S 00000000fffbdd00     0   500      2 0x00000000
 ffff88012fa49e30 0000000000000046 ffff880100000000 00000000000153c0
 ffff88012fa49fd8 00000000000153c0 ffff88012fa49fd8 ffff880132010000
 00000000000153c0 00000000000153c0 ffff88012fa49fd8 00000000000153c0
Call Trace:
 [<ffffffffa02d78e0>] ? fan_watchdog_fire+0x0/0x50 [thinkpad_acpi]
 [<ffffffff81074635>] worker_thread+0x1f5/0x2a0
 [<ffffffff81078c00>] ? autoremove_wake_function+0x0/0x40
 [<ffffffff81074440>] ? worker_thread+0x0/0x2a0
 [<ffffffff810786c6>] kthread+0x96/0xa0
 [<ffffffff8100ade4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81078630>] ? kthread+0x0/0xa0
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
kvm-irqfd-cle S 00000000fffba252     0   517      2 0x00000000
 ffff88013253fe30 0000000000000046 ffff880000000000 00000000000153c0
 ffff88013253ffd8 00000000000153c0 ffff88013253ffd8 ffff880131fe4440
 00000000000153c0 00000000000153c0 ffff88013253ffd8 00000000000153c0
Call Trace:
 [<ffffffff81074440>] ? worker_thread+0x0/0x2a0
 [<ffffffff81074635>] worker_thread+0x1f5/0x2a0
 [<ffffffff81078c00>] ? autoremove_wake_function+0x0/0x40
 [<ffffffff81074440>] ? worker_thread+0x0/0x2a0
 [<ffffffff810786c6>] kthread+0x96/0xa0
 [<ffffffff8100ade4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81078630>] ? kthread+0x0/0xa0
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
kstriped      S 00000000fffba33f     0   550      2 0x00000000
 ffff880131f7de30 0000000000000046 ffff880000000000 00000000000153c0
 ffff880131f7dfd8 00000000000153c0 ffff880131f7dfd8 ffff88012f9716c0
 00000000000153c0 00000000000153c0 ffff880131f7dfd8 00000000000153c0
Call Trace:
 [<ffffffff81074440>] ? worker_thread+0x0/0x2a0
 [<ffffffff81074635>] worker_thread+0x1f5/0x2a0
 [<ffffffff81078c00>] ? autoremove_wake_function+0x0/0x40
 [<ffffffff81074440>] ? worker_thread+0x0/0x2a0
 [<ffffffff810786c6>] kthread+0x96/0xa0
 [<ffffffff8100ade4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81078630>] ? kthread+0x0/0xa0
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
kconservative S 00000000fffba690     0   594      2 0x00000000
 ffff880132501e30 0000000000000046 ffff880000000000 00000000000153c0
 ffff880132501fd8 00000000000153c0 ffff880132501fd8 ffff880132015b00
 00000000000153c0 00000000000153c0 ffff880132501fd8 00000000000153c0
Call Trace:
 [<ffffffff81074440>] ? worker_thread+0x0/0x2a0
 [<ffffffff81074635>] worker_thread+0x1f5/0x2a0
 [<ffffffff81078c00>] ? autoremove_wake_function+0x0/0x40
 [<ffffffff81074440>] ? worker_thread+0x0/0x2a0
 [<ffffffff810786c6>] kthread+0x96/0xa0
 [<ffffffff8100ade4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81078630>] ? kthread+0x0/0xa0
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
kconservative S 00000000fffba665     0   595      2 0x00000000
 ffff88012f915e30 0000000000000046 ffff880000000000 00000000000153c0
 ffff88012f915fd8 00000000000153c0 ffff88012f915fd8 ffff8801320116c0
 00000000000153c0 00000000000153c0 ffff88012f915fd8 00000000000153c0
Call Trace:
 [<ffffffff81074440>] ? worker_thread+0x0/0x2a0
 [<ffffffff81074635>] worker_thread+0x1f5/0x2a0
 [<ffffffff81078c00>] ? autoremove_wake_function+0x0/0x40
 [<ffffffff81074440>] ? worker_thread+0x0/0x2a0
 [<ffffffff810786c6>] kthread+0x96/0xa0
 [<ffffffff8100ade4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81078630>] ? kthread+0x0/0xa0
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
kconservative S 00000000fffba690     0   596      2 0x00000000
 ffff88012f895e30 0000000000000046 ffff880000000000 00000000000153c0
 ffff88012f895fd8 00000000000153c0 ffff88012f895fd8 ffff880132014440
 00000000000153c0 00000000000153c0 ffff88012f895fd8 00000000000153c0
Call Trace:
 [<ffffffff81074440>] ? worker_thread+0x0/0x2a0
 [<ffffffff81074635>] worker_thread+0x1f5/0x2a0
 [<ffffffff81078c00>] ? autoremove_wake_function+0x0/0x40
 [<ffffffff81074440>] ? worker_thread+0x0/0x2a0
 [<ffffffff810786c6>] kthread+0x96/0xa0
 [<ffffffff8100ade4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81078630>] ? kthread+0x0/0xa0
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
kconservative S 00000000fffba68d     0   597      2 0x00000000
 ffff880132031e30 0000000000000046 ffff880000000000 00000000000153c0
 ffff880132031fd8 00000000000153c0 ffff880132031fd8 ffff880132012d80
 00000000000153c0 00000000000153c0 ffff880132031fd8 00000000000153c0
Call Trace:
 [<ffffffff81074440>] ? worker_thread+0x0/0x2a0
 [<ffffffff81074635>] worker_thread+0x1f5/0x2a0
 [<ffffffff81078c00>] ? autoremove_wake_function+0x0/0x40
 [<ffffffff81074440>] ? worker_thread+0x0/0x2a0
 [<ffffffff810786c6>] kthread+0x96/0xa0
 [<ffffffff8100ade4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81078630>] ? kthread+0x0/0xa0
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
kondemand/0   S 00000000ffffffff     0   600      2 0x00000000
 ffff88013251de30 0000000000000046 ffff88013251de30 00000000000153c0
 ffff88013251dfd8 00000000000153c0 ffff88013251dfd8 ffff88012f974440
 00000000000153c0 00000000000153c0 ffff88013251dfd8 00000000000153c0
Call Trace:
 [<ffffffff81078f10>] ? prepare_to_wait+0x60/0x90
 [<ffffffffa042af40>] ? do_dbs_timer+0x0/0x3a4 [cpufreq_ondemand]
 [<ffffffff81074635>] worker_thread+0x1f5/0x2a0
 [<ffffffff81078c00>] ? autoremove_wake_function+0x0/0x40
 [<ffffffff81074440>] ? worker_thread+0x0/0x2a0
 [<ffffffff810786c6>] kthread+0x96/0xa0
 [<ffffffff8100ade4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81078630>] ? kthread+0x0/0xa0
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
kondemand/1   S 0000000103dbe085     0   601      2 0x00000000
 ffff880131dabe30 0000000000000046 ffff880100000000 00000000000153c0
 ffff880131dabfd8 00000000000153c0 ffff880131dabfd8 ffff88012f970000
 00000000000153c0 00000000000153c0 ffff880131dabfd8 00000000000153c0
Call Trace:
 [<ffffffffa042af40>] ? do_dbs_timer+0x0/0x3a4 [cpufreq_ondemand]
 [<ffffffff81074635>] worker_thread+0x1f5/0x2a0
 [<ffffffff81078c00>] ? autoremove_wake_function+0x0/0x40
 [<ffffffff81074440>] ? worker_thread+0x0/0x2a0
 [<ffffffff810786c6>] kthread+0x96/0xa0
 [<ffffffff8100ade4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81078630>] ? kthread+0x0/0xa0
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
kondemand/2   S 00000000ffffffff     0   602      2 0x00000000
 ffff880132a85e30 0000000000000046 ffff880132a85e30 00000000000153c0
 ffff880132a85fd8 00000000000153c0 ffff880132a85fd8 ffff88012f972d80
 00000000000153c0 00000000000153c0 ffff880132a85fd8 00000000000153c0
Call Trace:
 [<ffffffff81078f10>] ? prepare_to_wait+0x60/0x90
 [<ffffffffa042af40>] ? do_dbs_timer+0x0/0x3a4 [cpufreq_ondemand]
 [<ffffffff81074635>] worker_thread+0x1f5/0x2a0
 [<ffffffff81078c00>] ? autoremove_wake_function+0x0/0x40
 [<ffffffff81074440>] ? worker_thread+0x0/0x2a0
 [<ffffffff810786c6>] kthread+0x96/0xa0
 [<ffffffff8100ade4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81078630>] ? kthread+0x0/0xa0
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
kondemand/3   S 00000000ffffffff     0   603      2 0x00000000
 ffff880131d1de30 0000000000000046 ffff880131d1de30 00000000000153c0
 ffff880131d1dfd8 00000000000153c0 ffff880131d1dfd8 ffff88012f975b00
 00000000000153c0 00000000000153c0 ffff880131d1dfd8 00000000000153c0
Call Trace:
 [<ffffffff81078f10>] ? prepare_to_wait+0x60/0x90
 [<ffffffffa042af40>] ? do_dbs_timer+0x0/0x3a4 [cpufreq_ondemand]
 [<ffffffff81074635>] worker_thread+0x1f5/0x2a0
 [<ffffffff81078c00>] ? autoremove_wake_function+0x0/0x40
 [<ffffffff81074440>] ? worker_thread+0x0/0x2a0
 [<ffffffff810786c6>] kthread+0x96/0xa0
 [<ffffffff8100ade4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81078630>] ? kthread+0x0/0xa0
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
kauditd       S 00000000fffbb21c     0  1140      2 0x00000000
 ffff880131811e80 0000000000000046 ffff880131e00380 00000000000153c0
 ffff880131811fd8 00000000000153c0 ffff880131811fd8 ffff8801275416c0
 00000000000153c0 00000000000153c0 ffff880131811fd8 00000000000153c0
Call Trace:
 [<ffffffff8104a243>] ? __wake_up+0x53/0x70
 [<ffffffff810aabea>] kauditd_thread+0x15a/0x190
 [<ffffffff8104d280>] ? default_wake_function+0x0/0x20
 [<ffffffff810aaa90>] ? kauditd_thread+0x0/0x190
 [<ffffffff810786c6>] kthread+0x96/0xa0
 [<ffffffff8100ade4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81078630>] ? kthread+0x0/0xa0
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
l2cap         S 00000000fffbcd3d     0  1386      2 0x00000000
 ffff88012f951e30 0000000000000046 ffff880000000000 00000000000153c0
 ffff88012f951fd8 00000000000153c0 ffff88012f951fd8 ffff8801279bc440
 00000000000153c0 00000000000153c0 ffff88012f951fd8 00000000000153c0
Call Trace:
 [<ffffffff81074440>] ? worker_thread+0x0/0x2a0
 [<ffffffff81074635>] worker_thread+0x1f5/0x2a0
 [<ffffffff81078c00>] ? autoremove_wake_function+0x0/0x40
 [<ffffffff81074440>] ? worker_thread+0x0/0x2a0
 [<ffffffff810786c6>] kthread+0x96/0xa0
 [<ffffffff8100ade4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81078630>] ? kthread+0x0/0xa0
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
kmmcd         S 00000000fffbcd83     0  1391      2 0x00000000
 ffff88011e035e30 0000000000000046 ffff880100000000 00000000000153c0
 ffff88011e035fd8 00000000000153c0 ffff88011e035fd8 ffff8801279b96c0
 00000000000153c0 00000000000153c0 ffff88011e035fd8 00000000000153c0
Call Trace:
 [<ffffffffa022dd20>] ? mmc_rescan+0x0/0x2e0 [mmc_core]
 [<ffffffff81074635>] worker_thread+0x1f5/0x2a0
 [<ffffffff81078c00>] ? autoremove_wake_function+0x0/0x40
 [<ffffffff81074440>] ? worker_thread+0x0/0x2a0
 [<ffffffff810786c6>] kthread+0x96/0xa0
 [<ffffffff8100ade4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81078630>] ? kthread+0x0/0xa0
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
khpsbpkt      S 00000000fffbd326     0  1394      2 0x00000000
 ffff880131cc7e90 0000000000000046 ffff880131cc7e00 00000000000153c0
 ffff880131cc7fd8 00000000000153c0 ffff880131cc7fd8 ffff8801279b8000
 00000000000153c0 00000000000153c0 ffff880131cc7fd8 00000000000153c0
Call Trace:
 [<ffffffff8104a142>] ? complete+0x52/0x60
 [<ffffffffa03ab26b>] hpsbpkt_thread+0x14b/0x150 [ieee1394]
 [<ffffffffa03ab120>] ? hpsbpkt_thread+0x0/0x150 [ieee1394]
 [<ffffffff810786c6>] kthread+0x96/0xa0
 [<ffffffff8100ade4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81078630>] ? kthread+0x0/0xa0
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
cfg80211      S 0000000100e1cc6f     0  1398      2 0x00000000
 ffff880132561e30 0000000000000046 ffff880100000000 00000000000153c0
 ffff880132561fd8 00000000000153c0 ffff880132561fd8 ffff88011e0b8000
 00000000000153c0 00000000000153c0 ffff880132561fd8 00000000000153c0
Call Trace:
 [<ffffffffa0ed65d0>] ? wdev_cleanup_work+0x0/0x110 [cfg80211]
 [<ffffffff81074635>] worker_thread+0x1f5/0x2a0
 [<ffffffff81078c00>] ? autoremove_wake_function+0x0/0x40
 [<ffffffff81074440>] ? worker_thread+0x0/0x2a0
 [<ffffffff810786c6>] kthread+0x96/0xa0
 [<ffffffff8100ade4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81078630>] ? kthread+0x0/0xa0
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
knodemgrd_0   S 00000000fffbddf7     0  1404      2 0x00000000
 ffff880132563df0 0000000000000046 ffffffff00000000 00000000000153c0
 ffff880132563fd8 00000000000153c0 ffff880132563fd8 ffff88011e0bad80
 00000000000153c0 00000000000153c0 ffff880132563fd8 00000000000153c0
Call Trace:
 [<ffffffffa03b228a>] nodemgr_host_thread+0x48a/0xc90 [ieee1394]
 [<ffffffffa03b1e00>] ? nodemgr_host_thread+0x0/0xc90 [ieee1394]
 [<ffffffff810786c6>] kthread+0x96/0xa0
 [<ffffffff8100ade4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81078630>] ? kthread+0x0/0xa0
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
krfcommd      S 00000000fffbcda3     0  1410      2 0x00000000
 ffff88011e069df0 0000000000000046 ffff880100000000 00000000000153c0
 ffff88011e069fd8 00000000000153c0 ffff88011e069fd8 ffff8801275e2d80
 00000000000153c0 00000000000153c0 ffff88011e069fd8 00000000000153c0
Call Trace:
 [<ffffffffa0f41820>] ? rfcomm_run+0x0/0xb60 [rfcomm]
 [<ffffffffa0f42059>] rfcomm_run+0x839/0xb60 [rfcomm]
 [<ffffffff813def41>] ? schedule+0x3e1/0x820
 [<ffffffffa0f41820>] ? rfcomm_run+0x0/0xb60 [rfcomm]
 [<ffffffff810786c6>] kthread+0x96/0xa0
 [<ffffffff8100ade4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81078630>] ? kthread+0x0/0xa0
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
iwlagn        S 0000000100e1ccb4     0  1440      2 0x00000000
 ffff88011e173e30 0000000000000046 ffff880100000000 00000000000153c0
 ffff88011e173fd8 00000000000153c0 ffff88011e173fd8 ffff880132bddb00
 00000000000153c0 00000000000153c0 ffff88011e173fd8 00000000000153c0
Call Trace:
 [<ffffffffa0fe8f60>] ? iwl_bg_run_time_calib_work+0x0/0x90 [iwlagn]
 [<ffffffff81074635>] worker_thread+0x1f5/0x2a0
 [<ffffffff81078c00>] ? autoremove_wake_function+0x0/0x40
 [<ffffffff81074440>] ? worker_thread+0x0/0x2a0
 [<ffffffff810786c6>] kthread+0x96/0xa0
 [<ffffffff8100ade4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81078630>] ? kthread+0x0/0xa0
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
phy0          S 0000000100e1cc73     0  1443      2 0x00000000
 ffff88011e1a3e30 0000000000000046 ffff880100000000 00000000000153c0
 ffff88011e1a3fd8 00000000000153c0 ffff88011e1a3fd8 ffff8801279bad80
 00000000000153c0 00000000000153c0 ffff88011e1a3fd8 00000000000153c0
Call Trace:
 [<ffffffffa0f64b90>] ? ieee80211_reconfig_filter+0x0/0x20 [mac80211]
 [<ffffffff81074635>] worker_thread+0x1f5/0x2a0
 [<ffffffff81078c00>] ? autoremove_wake_function+0x0/0x40
 [<ffffffff81074440>] ? worker_thread+0x0/0x2a0
 [<ffffffff810786c6>] kthread+0x96/0xa0
 [<ffffffff8100ade4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81078630>] ? kthread+0x0/0xa0
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
rpciod/0      S 0000000103da0cf1     0 15510      2 0x00000000
 ffff880127927e30 0000000000000046 ffff880100000000 00000000000153c0
 ffff880127927fd8 00000000000153c0 ffff880127927fd8 ffff880126b8db00
 00000000000153c0 00000000000153c0 ffff880127927fd8 00000000000153c0
Call Trace:
 [<ffffffffa12806c0>] ? xs_tcp_connect_worker4+0x0/0x30 [sunrpc]
 [<ffffffff81074635>] worker_thread+0x1f5/0x2a0
 [<ffffffff81078c00>] ? autoremove_wake_function+0x0/0x40
 [<ffffffff81074440>] ? worker_thread+0x0/0x2a0
 [<ffffffff810786c6>] kthread+0x96/0xa0
 [<ffffffff8100ade4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81078630>] ? kthread+0x0/0xa0
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
rpciod/1      S 00000000ffffffff     0 15511      2 0x00000000
 ffff880131d23e30 0000000000000046 ffff880131d23db0 00000000000153c0
 ffff880131d23fd8 00000000000153c0 ffff880131d23fd8 ffff8801325ddb00
 00000000000153c0 00000000000153c0 ffff880131d23fd8 00000000000153c0
Call Trace:
 [<ffffffff81078f10>] ? prepare_to_wait+0x60/0x90
 [<ffffffffa127e8e0>] ? xprt_autoclose+0x0/0x70 [sunrpc]
 [<ffffffff81074635>] worker_thread+0x1f5/0x2a0
 [<ffffffff81078c00>] ? autoremove_wake_function+0x0/0x40
 [<ffffffff81074440>] ? worker_thread+0x0/0x2a0
 [<ffffffff810786c6>] kthread+0x96/0xa0
 [<ffffffff8100ade4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81078630>] ? kthread+0x0/0xa0
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
rpciod/2      S 0000000103d95b0c     0 15512      2 0x00000000
 ffff88013270be30 0000000000000046 ffff88013270bfd8 00000000000153c0
 ffff88013270bfd8 00000000000153c0 ffff88013270bfd8 ffff880132aedb00
 00000000000153c0 00000000000153c0 ffff88013270bfd8 00000000000153c0
Call Trace:
 [<ffffffff81078f10>] ? prepare_to_wait+0x60/0x90
 [<ffffffffa12806c0>] ? xs_tcp_connect_worker4+0x0/0x30 [sunrpc]
 [<ffffffff81074635>] worker_thread+0x1f5/0x2a0
 [<ffffffff81078c00>] ? autoremove_wake_function+0x0/0x40
 [<ffffffff81074440>] ? worker_thread+0x0/0x2a0
 [<ffffffff810786c6>] kthread+0x96/0xa0
 [<ffffffff8100ade4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81078630>] ? kthread+0x0/0xa0
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
rpciod/3      S 00000000ffffffff     0 15513      2 0x00000000
 ffff880127ab9e30 0000000000000046 ffff880127ab9db0 00000000000153c0
 ffff880127ab9fd8 00000000000153c0 ffff880127ab9fd8 ffff880132aec440
 00000000000153c0 00000000000153c0 ffff880127ab9fd8 00000000000153c0
Call Trace:
 [<ffffffff81078f10>] ? prepare_to_wait+0x60/0x90
 [<ffffffffa127e8e0>] ? xprt_autoclose+0x0/0x70 [sunrpc]
 [<ffffffff81074635>] worker_thread+0x1f5/0x2a0
 [<ffffffff81078c00>] ? autoremove_wake_function+0x0/0x40
 [<ffffffff81074440>] ? worker_thread+0x0/0x2a0
 [<ffffffff810786c6>] kthread+0x96/0xa0
 [<ffffffff8100ade4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81078630>] ? kthread+0x0/0xa0
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
kslowd000     S 00000000fffd0407     0 15514      2 0x00000000
 ffff880127bffe60 0000000000000046 ffff000300000000 00000000000153c0
 ffff880127bfffd8 00000000000153c0 ffff880127bfffd8 ffff880132ae96c0
 00000000000153c0 00000000000153c0 ffff880127bfffd8 00000000000153c0
Call Trace:
 [<ffffffff810e04f1>] slow_work_thread+0x321/0x340
 [<ffffffff81078c00>] ? autoremove_wake_function+0x0/0x40
 [<ffffffff810e01d0>] ? slow_work_thread+0x0/0x340
 [<ffffffff810786c6>] kthread+0x96/0xa0
 [<ffffffff8100ade4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81078630>] ? kthread+0x0/0xa0
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
kslowd001     S 00000000fffd0407     0 15515      2 0x00000000
 ffff880127905e60 0000000000000046 ffff000300000000 00000000000153c0
 ffff880127905fd8 00000000000153c0 ffff880127905fd8 ffff880131d2db00
 00000000000153c0 00000000000153c0 ffff880127905fd8 00000000000153c0
Call Trace:
 [<ffffffff810e04f1>] slow_work_thread+0x321/0x340
 [<ffffffff81078c00>] ? autoremove_wake_function+0x0/0x40
 [<ffffffff810e01d0>] ? slow_work_thread+0x0/0x340
 [<ffffffff810786c6>] kthread+0x96/0xa0
 [<ffffffff8100ade4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81078630>] ? kthread+0x0/0xa0
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
nfsiod        S 0000000100aad1b3     0 15516      2 0x00000000
 ffff88011e355e30 0000000000000046 ffff88011e355da0 00000000000153c0
 ffff88011e355fd8 00000000000153c0 ffff88011e355fd8 ffff880131d2ad80
 00000000000153c0 00000000000153c0 ffff88011e355fd8 00000000000153c0
Call Trace:
 [<ffffffff81078f10>] ? prepare_to_wait+0x60/0x90
 [<ffffffffa12828b0>] ? rpc_async_release+0x0/0x20 [sunrpc]
 [<ffffffff81074635>] worker_thread+0x1f5/0x2a0
 [<ffffffff81078c00>] ? autoremove_wake_function+0x0/0x40
 [<ffffffff81074440>] ? worker_thread+0x0/0x2a0
 [<ffffffff810786c6>] kthread+0x96/0xa0
 [<ffffffff8100ade4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81078630>] ? kthread+0x0/0xa0
 [<ffffffff8100ade0>] ? kernel_thread_helper+0x0/0x10
bash          D 00000000ffffffff     0  4278      1 0x00000004
 ffff8800b2107d68 0000000000000082 ffff8800b2107ce8 00000000000153c0
 ffff8800b2107fd8 00000000000153c0 ffff8800b2107fd8 ffff8801320196c0
 00000000000153c0 00000000000153c0 ffff8800b2107fd8 00000000000153c0
Call Trace:
 [<ffffffff81078f10>] ? prepare_to_wait+0x60/0x90
 [<ffffffffa0184ba1>] ata_port_wait_eh+0x71/0xe0 [libata]
 [<ffffffff81078c00>] ? autoremove_wake_function+0x0/0x40
 [<ffffffffa0181dcf>] ata_scsi_user_scan+0xbf/0x150 [libata]
 [<ffffffffa012aee4>] store_scan+0xe4/0x120 [scsi_mod]
 [<ffffffff812c2e00>] dev_attr_store+0x20/0x30
 [<ffffffff811a6282>] sysfs_write_file+0xf2/0x180
 [<ffffffff8113bf08>] vfs_write+0xb8/0x1a0
 [<ffffffff813e5389>] ? do_page_fault+0x1a9/0x340
 [<ffffffff8113c951>] sys_write+0x51/0x90
 [<ffffffff81009fc2>] system_call_fastpath+0x16/0x1b
init          S 0000000103da27eb     0  7004      1 0x00000000
 ffff8801320f7e68 0000000000000082 ffff880100000000 00000000000153c0
 ffff8801320f7fd8 00000000000153c0 ffff8801320f7fd8 ffff8800379a0000
 00000000000153c0 00000000000153c0 ffff8801320f7fd8 00000000000153c0
Call Trace:
 [<ffffffff8105ed2d>] do_wait+0x1cd/0x260
 [<ffffffff8105ee63>] sys_wait4+0xa3/0x100
 [<ffffffff8105c730>] ? child_wait_callback+0x0/0x70
 [<ffffffff81009fc2>] system_call_fastpath+0x16/0x1b
sh            R  running task        0  7005   7004 0x00000000
 ffff8801325a1dd8 ffffffff810495e8 0000000000000000 ffff88012790c440
 ffff8801325a1e08 ffffffff810501bb 00007f1b25b47000 0000000000000074
 0000000000000000 ffffffff81684dc0 ffff8801325a1e18 ffffffff812aaaf0
Call Trace:
 [<ffffffff810495e8>] ? sched_show_task+0x98/0x100
 [<ffffffff810501bb>] ? show_state_filter+0x7b/0xc0
 [<ffffffff812aaaf0>] ? sysrq_handle_showstate+0x10/0x20
 [<ffffffff812aaff1>] ? __handle_sysrq+0x131/0x1a0
 [<ffffffff812ab0ae>] ? write_sysrq_trigger+0x4e/0x50
 [<ffffffff81194455>] ? proc_reg_write+0x75/0xb0
 [<ffffffff8113bf08>] ? vfs_write+0xb8/0x1a0
 [<ffffffff813e5389>] ? do_page_fault+0x1a9/0x340
 [<ffffffff8113c951>] ? sys_write+0x51/0x90
 [<ffffffff81009fc2>] ? system_call_fastpath+0x16/0x1b
Sched Debug Version: v0.09, 2.6.35.1-desktop-1mnb #1
now at 65041191.312205 msecs
  .jiffies                                 : 4359708487
  .sysctl_sched_latency                    : 18.000000
  .sysctl_sched_min_granularity            : 6.000000
  .sysctl_sched_wakeup_granularity         : 3.000000
  .sysctl_sched_child_runs_first           : 0.000000
  .sysctl_sched_features                   : 15471
  .sysctl_sched_tunable_scaling            : 1 (logaritmic)

cpu#0, 2660.619 MHz
  .nr_running                    : 1
  .load                          : 1024
  .nr_switches                   : 79499580
  .nr_load_updates               : 20186987
  .nr_uninterruptible            : 0
  .next_balance                  : 4359.708553
  .curr->pid                     : 7005
  .clock                         : 64877022.879136
  .cpu_load[0]                   : 2048
  .cpu_load[1]                   : 2048
  .cpu_load[2]                   : 2048
  .cpu_load[3]                   : 1974
  .cpu_load[4]                   : 1631
  .yld_count                     : 75715053
  .sched_switch                  : 0
  .sched_count                   : 160390007
  .sched_goidle                  : 40797178
  .avg_idle                      : 1000000
  .ttwu_count                    : 40996040
  .ttwu_local                    : 18680103
  .bkl_count                     : 2862

cfs_rq[0]:/
  .exec_clock                    : 5394479.941607
  .MIN_vruntime                  : 0.000001
  .min_vruntime                  : 4553921.944303
  .max_vruntime                  : 0.000001
  .spread                        : 0.000000
  .spread0                       : 0.000000
  .nr_running                    : 1
  .load                          : 1024
  .nr_spread_over                : 2182
  .shares                        : 0

rt_rq[0]:/
  .rt_nr_running                 : 0
  .rt_throttled                  : 0
  .rt_time                       : 0.000000
  .rt_runtime                    : 950.000000

runnable tasks:
            task   PID         tree-key  switches  prio     exec-runtime         
sum-exec        sum-sleep
----------------------------------------------------------------------------------------------------------
R             sh  7005   4553914.295141       277   120   4553914.295141       
128.388224    111984.598460 /

cpu#1, 2660.619 MHz
  .nr_running                    : 0
  .load                          : 0
  .nr_switches                   : 77158850
  .nr_load_updates               : 18688316
  .nr_uninterruptible            : 1
  .next_balance                  : 4359.708805
  .curr->pid                     : 0
  .clock                         : 64877025.151606
  .cpu_load[0]                   : 0
  .cpu_load[1]                   : 0
  .cpu_load[2]                   : 0
  .cpu_load[3]                   : 0
  .cpu_load[4]                   : 0
  .yld_count                     : 82411217
  .sched_switch                  : 0
  .sched_count                   : 163590140
  .sched_goidle                  : 38414984
  .avg_idle                      : 1000000
  .ttwu_count                    : 39781643
  .ttwu_local                    : 18015246
  .bkl_count                     : 982

cfs_rq[1]:/
  .exec_clock                    : 5202036.885870
  .MIN_vruntime                  : 0.000001
  .min_vruntime                  : 7291067.771311
  .max_vruntime                  : 0.000001
  .spread                        : 0.000000
  .spread0                       : 2737145.827008
  .nr_running                    : 0
  .load                          : 0
  .nr_spread_over                : 12960
  .shares                        : 0

rt_rq[1]:/
  .rt_nr_running                 : 0
  .rt_throttled                  : 0
  .rt_time                       : 0.000000
  .rt_runtime                    : 950.000000

runnable tasks:
            task   PID         tree-key  switches  prio     exec-runtime         
sum-exec        sum-sleep
----------------------------------------------------------------------------------------------------------

cpu#2, 2660.619 MHz
  .nr_running                    : 0
  .load                          : 0
  .nr_switches                   : 48947251
  .nr_load_updates               : 16001421
  .nr_uninterruptible            : 1
  .next_balance                  : 4359.708553
  .curr->pid                     : 0
  .clock                         : 64877025.066767
  .cpu_load[0]                   : 0
  .cpu_load[1]                   : 0
  .cpu_load[2]                   : 0
  .cpu_load[3]                   : 0
  .cpu_load[4]                   : 0
  .yld_count                     : 1735709593
  .sched_switch                  : 0
  .sched_count                   : 1786385888
  .sched_goidle                  : 23583074
  .avg_idle                      : 1000000
  .ttwu_count                    : 25830756
  .ttwu_local                    : 16981825
  .bkl_count                     : 91814

cfs_rq[2]:/
  .exec_clock                    : 3270782.004839
  .MIN_vruntime                  : 0.000001
  .min_vruntime                  : 6056828.325504
  .max_vruntime                  : 0.000001
  .spread                        : 0.000000
  .spread0                       : 1502906.381201
  .nr_running                    : 0
  .load                          : 0
  .nr_spread_over                : 13147
  .shares                        : 0

rt_rq[2]:/
  .rt_nr_running                 : 0
  .rt_throttled                  : 0
  .rt_time                       : 0.000000
  .rt_runtime                    : 950.000000

runnable tasks:
            task   PID         tree-key  switches  prio     exec-runtime         
sum-exec        sum-sleep
----------------------------------------------------------------------------------------------------------

cpu#3, 2660.619 MHz
  .nr_running                    : 0
  .load                          : 0
  .nr_switches                   : 31778637
  .nr_load_updates               : 11018141
  .nr_uninterruptible            : 0
  .next_balance                  : 4359.711159
  .curr->pid                     : 0
  .clock                         : 64877025.428507
  .cpu_load[0]                   : 0
  .cpu_load[1]                   : 128
  .cpu_load[2]                   : 432
  .cpu_load[3]                   : 686
  .cpu_load[4]                   : 843
  .yld_count                     : 108621804
  .sched_switch                  : 0
  .sched_count                   : 141445219
  .sched_goidle                  : 15185389
  .avg_idle                      : 1000000
  .ttwu_count                    : 16675626
  .ttwu_local                    : 13142969
  .bkl_count                     : 67019

cfs_rq[3]:/
  .exec_clock                    : 1809129.880387
  .MIN_vruntime                  : 0.000001
  .min_vruntime                  : 2811734.281417
  .max_vruntime                  : 0.000001
  .spread                        : 0.000000
  .spread0                       : -1742187.662886
  .nr_running                    : 0
  .load                          : 0
  .nr_spread_over                : 4175
  .shares                        : 0

rt_rq[3]:/
  .rt_nr_running                 : 0
  .rt_throttled                  : 0
  .rt_time                       : 0.000000
  .rt_runtime                    : 950.000000

runnable tasks:
            task   PID         tree-key  switches  prio     exec-runtime         
sum-exec        sum-sleep
----------------------------------------------------------------------------------------------------------


-- 
Anssi Hannula
