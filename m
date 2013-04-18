From: Tejun Heo <tj@kernel.org>
Subject: Re: [Bug 56781] New: BUG: scheduling while atomic:
 modprobe/256/0x00000100
Date: Thu, 18 Apr 2013 11:32:09 -0700
Message-ID: <20130418183209.GG9897@mtj.dyndns.org>
References: <bug-56781-12015@https.bugzilla.kernel.org/>
 <87zjww2w3x.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:50037 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752411Ab3DRScO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 Apr 2013 14:32:14 -0400
Received: by mail-pd0-f169.google.com with SMTP id 10so1743562pdc.28
        for <linux-ide@vger.kernel.org>; Thu, 18 Apr 2013 11:32:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87zjww2w3x.fsf@rustcorp.com.au>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: bugzilla-daemon@bugzilla.kernel.org, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Hello,

(cc'ing Jeff, linux-ide and copying the whole message)

So, the problem seems to be inside pata_acpi driver.  It's calling
pacpi_set_piomode() from qc_issue path while holding the queue lock.
pacpi_set_piomode() calls into acpi which may sleep.  It gets blocked
on a semaphore and triggers the bug.  Maybe some changes between 3.8.6
and 3.8.8 made it more likely to trigger but fundamentally it's a bug
in the pata_acpi driver.  It can't directly call into acpi while
holding queue lock.

Thanks.

On Thu, Apr 18, 2013 at 03:55:54PM +0930, Rusty Russell wrote:
> Tejun, you touched it last?
> 
> Cheers,
> Rusty.
> 
> bugzilla-daemon@bugzilla.kernel.org writes:
> > https://bugzilla.kernel.org/show_bug.cgi?id=56781
> >
> >            Summary: BUG: scheduling while atomic: modprobe/256/0x00000100
> >            Product: Other
> >            Version: 2.5
> >     Kernel Version: 3.8.6, 3.8.7, 3.8.8
> >           Platform: All
> >         OS/Version: Linux
> >               Tree: Mainline
> >             Status: NEW
> >           Severity: high
> >           Priority: P1
> >          Component: Modules
> >         AssignedTo: other_modules@kernel-bugs.osdl.org
> >         ReportedBy: kenzopl@o2.pl
> >                 CC: airlied@linux.ie
> >         Regression: No
> >
> >
> > Created an attachment (id=99151)
> >  --> (https://bugzilla.kernel.org/attachment.cgi?id=99151)
> > kern.log
> >
> > Please be gently as this is my first bug report here.
> >
> > This issue is repeating since kernel version 3.8.6 up to 3.8.8 (current stable)
> > and since I haven't found any solution I decided to post it here because it
> > became really annoying. It maybe related to my Radeon card or my DVB USB
> > adapter. It happens randomly while booting (kernel panic), sometimes I need to
> > reboot my system for several times until it boots up properly, unfortunatelly I
> > do not have any other log files, only pictures taken by camera. Please let me
> > know if you need more information.
> >
> >
> > kernel: [    4.633786] BUG: scheduling while atomic: modprobe/256/0x00000100
> > kernel: [    4.633852] Modules linked in: wmi(+) ttm drm_kms_helper drm
> > forcedeth(+) i2c_algo_bit
> > kernel: [    4.633861] Pid: 256, comm: modprobe Not tainted 3.8.6 #1
> > kernel: [    4.633863] Call Trace:
> > kernel: [    4.633865]  <IRQ>  [<ffffffff81752bc9>] __schedule_bug+0x4d/0x59
> > kernel: [    4.633881]  [<ffffffff8175e0f6>] __schedule+0x726/0x7b0
> > kernel: [    4.633884]  [<ffffffff8175e4c9>] schedule+0x29/0x70
> > kernel: [    4.633886]  [<ffffffff8175c96c>] schedule_timeout+0x1fc/0x2c0
> > kernel: [    4.633892]  [<ffffffff8108d6f5>] ? check_preempt_curr+0x85/0xa0
> > kernel: [    4.633894]  [<ffffffff8108d73c>] ? ttwu_do_wakeup+0x2c/0xf0
> > kernel: [    4.633897]  [<ffffffff8175d75b>] __down_common+0xa0/0xf7
> > kernel: [    4.633899]  [<ffffffff8175d7c8>] __down_timeout+0x16/0x18
> > kernel: [    4.633904]  [<ffffffff810844fe>] down_timeout+0x5e/0x70
> > kernel: [    4.633908]  [<ffffffff813d2181>] acpi_os_wait_semaphore+0x49/0x5f
> > kernel: [    4.633913]  [<ffffffff813f880e>] acpi_ut_acquire_mutex+0x51/0x93
> > kernel: [    4.633917]  [<ffffffff813eae40>]
> > acpi_ex_enter_interpreter+0x10/0x30
> > kernel: [    4.633922]  [<ffffffff813f0037>] acpi_evaluate_object+0x1f5/0x233
> > kernel: [    4.633927]  [<ffffffff814dd157>] ata_acpi_stm+0x97/0xe0
> > kernel: [    4.633930]  [<ffffffff814e07b1>] pacpi_set_piomode+0x51/0x70
> > kernel: [    4.633932]  [<ffffffff814e0816>] pacpi_qc_issue+0x46/0x80
> > kernel: [    4.633936]  [<ffffffff814c73b3>] ata_qc_issue+0x173/0x380
> > kernel: [    4.633940]  [<ffffffff814cd470>] ?
> > ata_scsi_set_sense.constprop.24+0x30/0x30
> > kernel: [    4.633942]  [<ffffffff814cc097>] ata_scsi_translate+0xa7/0x180
> > kernel: [    4.633945]  [<ffffffff814d0259>] ata_scsi_queuecmd+0xa9/0x2b0
> > kernel: [    4.633949]  [<ffffffff814a342e>] scsi_dispatch_cmd+0xde/0x2c0
> > kernel: [    4.633953]  [<ffffffff814aae70>] scsi_request_fn+0x350/0x560
> > kernel: [    4.633956]  [<ffffffff81768b1d>] ?
> > call_function_single_interrupt+0x6d/0x80
> > kernel: [    4.633960]  [<ffffffff8133e1c7>] __blk_run_queue+0x37/0x50
> > kernel: [    4.633963]  [<ffffffff814a9ef9>] scsi_run_queue+0x179/0x2b0
> > kernel: [    4.633966]  [<ffffffff81464ce7>] ? put_device+0x17/0x20
> > kernel: [    4.633969]  [<ffffffff814ab462>] scsi_next_command+0x42/0x60
> > kernel: [    4.633971]  [<ffffffff814ab6ce>] scsi_io_completion+0x1ee/0x6c0
> > kernel: [    4.633974]  [<ffffffff814a166d>] scsi_finish_command+0xbd/0x120
> > kernel: [    4.633977]  [<ffffffff814ab3ee>] scsi_softirq_done+0x13e/0x150
> > kernel: [    4.633981]  [<ffffffff81344ce3>] blk_done_softirq+0x83/0xa0
> > kernel: [    4.633984]  [<ffffffff81061aef>] __do_softirq+0xcf/0x210
> > kernel: [    4.633989]  [<ffffffff8103b948>] ? ack_apic_level+0x78/0x130
> > kernel: [    4.633991]  [<ffffffff8176905c>] call_softirq+0x1c/0x30
> > kernel: [    4.633996]  [<ffffffff810161b5>] do_softirq+0x75/0xb0
> > kernel: [    4.633999]  [<ffffffff81061da5>] irq_exit+0xa5/0xb0
> > kernel: [    4.634002]  [<ffffffff817698f3>] do_IRQ+0x63/0xe0
> > kernel: [    4.634005]  [<ffffffff8175f9ad>] common_interrupt+0x6d/0x6d
> > kernel: [    4.634006]  <EOI>  [<ffffffff817633f4>] ?
> > __do_page_fault+0x264/0x4e0
> > kernel: [    4.634011]  [<ffffffff817633ec>] ? __do_page_fault+0x25c/0x4e0
> > kernel: [    4.634014]  [<ffffffff81086bda>] ? lg_local_unlock+0x1a/0x20
> > kernel: [    4.634019]  [<ffffffff811ab116>] ? mntput+0x26/0x40
> > kernel: [    4.634023]  [<ffffffff8118d9fe>] ? __fput+0x16e/0x240
> > kernel: [    4.634026]  [<ffffffff8118dade>] ? ____fput+0xe/0x10
> > kernel: [    4.634031]  [<ffffffff8107af71>] ? task_work_run+0xc1/0xe0
> > kernel: [    4.634034]  [<ffffffff8176367e>] do_page_fault+0xe/0x10
> > kernel: [    4.634037]  [<ffffffff8175fc98>] page_fault+0x28/0x30
> > kernel: [    4.640098] BUG: scheduling while atomic: modprobe/256/0x00000100
> > kernel: [    4.640167] Modules linked in: wmi(+) ttm drm_kms_helper drm
> > forcedeth(+) i2c_algo_bit
> > kernel: [    4.640179] Pid: 256, comm: modprobe Tainted: G        W    3.8.6 #1
> > kernel: [    4.640181] Call Trace:
> > kernel: [    4.640183]  <IRQ>  [<ffffffff81752bc9>] __schedule_bug+0x4d/0x59
> > kernel: [    4.640201]  [<ffffffff8175e0f6>] __schedule+0x726/0x7b0
> > kernel: [    4.640204]  [<ffffffff8175e4c9>] schedule+0x29/0x70
> > kernel: [    4.640206]  [<ffffffff8175c96c>] schedule_timeout+0x1fc/0x2c0
> > kernel: [    4.640212]  [<ffffffff813ef0ee>] ?
> > acpi_ns_search_one_scope+0x22/0x45
> > kernel: [    4.640215]  [<ffffffff813ef19c>] ?
> > acpi_ns_search_and_enter+0x8b/0x147
> > kernel: [    4.640217]  [<ffffffff8175d75b>] __down_common+0xa0/0xf7
> > kernel: [    4.640220]  [<ffffffff8175d7c8>] __down_timeout+0x16/0x18
> > kernel: [    4.640225]  [<ffffffff810844fe>] down_timeout+0x5e/0x70
> > kernel: [    4.640229]  [<ffffffff813d2181>] acpi_os_wait_semaphore+0x49/0x5f
> > kernel: [    4.640233]  [<ffffffff813f880e>] acpi_ut_acquire_mutex+0x51/0x93
> > kernel: [    4.640236]  [<ffffffff813eae40>]
> > acpi_ex_enter_interpreter+0x10/0x30
> > kernel: [    4.640239]  [<ffffffff813ed28d>] acpi_ns_evaluate+0x13d/0x1ad
> > kernel: [    4.640242]  [<ffffffff813eff69>] acpi_evaluate_object+0x127/0x233
> > kernel: [    4.640245]  [<ffffffff813d4d69>] ? acpi_get_child+0x4f/0x4f
> > kernel: [    4.640248]  [<ffffffff813d25aa>] acpi_evaluate_integer+0x34/0x53
> > kernel: [    4.640250]  [<ffffffff813d4d96>] do_acpi_find_child+0x2d/0x52
> > kernel: [    4.640253]  [<ffffffff813ef970>] acpi_ns_walk_namespace+0xd5/0x179
> > kernel: [    4.640256]  [<ffffffff813d4d69>] ? acpi_get_child+0x4f/0x4f
> > kernel: [    4.640258]  [<ffffffff813efe0f>] acpi_walk_namespace+0x98/0xcb
> > kernel: [    4.640261]  [<ffffffff813d4d5f>] acpi_get_child+0x45/0x4f
> > kernel: [    4.640266]  [<ffffffff814dceeb>] ata_ap_acpi_handle+0x2b/0x30
> > kernel: [    4.640268]  [<ffffffff814dd1cb>] ata_acpi_gtm+0x2b/0x100
> > kernel: [    4.640271]  [<ffffffff814e07bc>] pacpi_set_piomode+0x5c/0x70
> > kernel: [    4.640274]  [<ffffffff814e0816>] pacpi_qc_issue+0x46/0x80
> > kernel: [    4.640278]  [<ffffffff814c73b3>] ata_qc_issue+0x173/0x380
> > kernel: [    4.640282]  [<ffffffff814cd470>] ?
> > ata_scsi_set_sense.constprop.24+0x30/0x30
> > kernel: [    4.640285]  [<ffffffff814cc097>] ata_scsi_translate+0xa7/0x180
> > kernel: [    4.640287]  [<ffffffff814d0259>] ata_scsi_queuecmd+0xa9/0x2b0
> > kernel: [    4.640291]  [<ffffffff814a342e>] scsi_dispatch_cmd+0xde/0x2c0
> > kernel: [    4.640294]  [<ffffffff814aae70>] scsi_request_fn+0x350/0x560
> > kernel: [    4.640298]  [<ffffffff81768b1d>] ?
> > call_function_single_interrupt+0x6d/0x80
> > kernel: [    4.640302]  [<ffffffff8133e1c7>] __blk_run_queue+0x37/0x50
> > kernel: [    4.640304]  [<ffffffff814a9ef9>] scsi_run_queue+0x179/0x2b0
> > kernel: [    4.640310]  [<ffffffff81464ce7>] ? put_device+0x17/0x20
> > kernel: [    4.640314]  [<ffffffff814ab462>] scsi_next_command+0x42/0x60
> > kernel: [    4.640316]  [<ffffffff814ab6ce>] scsi_io_completion+0x1ee/0x6c0
> > kernel: [    4.640319]  [<ffffffff814a166d>] scsi_finish_command+0xbd/0x120
> > kernel: [    4.640322]  [<ffffffff814ab3ee>] scsi_softirq_done+0x13e/0x150
> > kernel: [    4.640328]  [<ffffffff81344ce3>] blk_done_softirq+0x83/0xa0
> > kernel: [    4.640333]  [<ffffffff81061aef>] __do_softirq+0xcf/0x210
> > kernel: [    4.640338]  [<ffffffff8103b948>] ? ack_apic_level+0x78/0x130
> > kernel: [    4.640340]  [<ffffffff8176905c>] call_softirq+0x1c/0x30
> > kernel: [    4.640349]  [<ffffffff810161b5>] do_softirq+0x75/0xb0
> > kernel: [    4.640352]  [<ffffffff81061da5>] irq_exit+0xa5/0xb0
> > kernel: [    4.640355]  [<ffffffff817698f3>] do_IRQ+0x63/0xe0
> > kernel: [    4.640358]  [<ffffffff8175f9ad>] common_interrupt+0x6d/0x6d
> > kernel: [    4.640360]  <EOI>  [<ffffffff817633f4>] ?
> > __do_page_fault+0x264/0x4e0
> > kernel: [    4.640366]  [<ffffffff817633ec>] ? __do_page_fault+0x25c/0x4e0
> > kernel: [    4.640369]  [<ffffffff81086bda>] ? lg_local_unlock+0x1a/0x20
> > kernel: [    4.640374]  [<ffffffff811ab116>] ? mntput+0x26/0x40
> > kernel: [    4.640378]  [<ffffffff8118d9fe>] ? __fput+0x16e/0x240
> > kernel: [    4.640381]  [<ffffffff8118dade>] ? ____fput+0xe/0x10
> > kernel: [    4.640385]  [<ffffffff8107af71>] ? task_work_run+0xc1/0xe0
> > kernel: [    4.640388]  [<ffffffff8176367e>] do_page_fault+0xe/0x10
> > kernel: [    4.640390]  [<ffffffff8175fc98>] page_fault+0x28/0x30
> >
> > -- 
> > Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
> > ------- You are receiving this mail because: -------
> > You are watching the assignee of the bug.

-- 
tejun
