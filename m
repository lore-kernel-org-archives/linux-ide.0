From: Fabio Estevam <festevam@gmail.com>
Subject: Warning at ahci_enable_ahci() during resume
Date: Fri, 28 Mar 2014 11:38:53 -0300
Message-ID: <CAOMZO5BXMmtsqQAsfdPw5fkziNUABBYwab69gbdGDMM_9bmMFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-we0-f172.google.com ([74.125.82.172]:37382 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751642AbaC1Oiz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 28 Mar 2014 10:38:55 -0400
Received: by mail-we0-f172.google.com with SMTP id t61so2763509wes.3
        for <linux-ide@vger.kernel.org>; Fri, 28 Mar 2014 07:38:53 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shawn Guo <shawn.guo@freescale.com>, r65037@freescale.com
Cc: =?UTF-8?B?TWFyZWsgVmHFoXV0?= <marex@denx.de>, hdegoede@redhat.com, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-ide@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi,

I am running linux-next 20140328 on a mx6qsabresd board and I am
getting the following warning at ahci_enable_ahci() during a
suspend/resume cycle:

/$ echo mem > /sys/power/state
PM: Syncing filesystems ... done.
Freezing user space processes ... (elapsed 0.001 seconds) done.
Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
Suspending console(s) (use no_console_suspend to debug)

, and then I press the GPIO key to wake-up the system:

PM: suspend of devices complete after 15.504 msecs
PM: suspend devices took 0.020 seconds
PM: late suspend of devices complete after 3.601 msecs
PM: noirq suspend of devices complete after 3.838 msecs
Disabling non-boot CPUs ...
CPU1: shutdown
CPU2: shutdown
CPU3: shutdown
Enabling non-boot CPUs ...
CPU1: Booted secondary processor
CPU1 is up
CPU2: Booted secondary processor
CPU2 is up
CPU3: Booted secondary processor
CPU3 is up
PM: noirq resume of devices complete after 2.172 msecs
PM: early resume of devices complete after 2.748 msecs
------------[ cut here ]------------
WARNING: CPU: 0 PID: 722 at drivers/ata/libahci.c:224 ahci_enable_ahci+0x74/0x8)
Modules linked in:
CPU: 0 PID: 722 Comm: sh Tainted: G        W     3.14.0-rc8-next-20140328+ #960
Backtrace:
[<80011cd4>] (dump_backtrace) from [<80011e70>] (show_stack+0x18/0x1c)
 r6:8039b6b8 r5:00000000 r4:00000000 r3:00000000
[<80011e58>] (show_stack) from [<8061d438>] (dump_stack+0x88/0xa4)
[<8061d3b0>] (dump_stack) from [<80028f78>] (warn_slowpath_common+0x70/0x94)
 r5:00000009 r4:00000000
[<80028f08>] (warn_slowpath_common) from [<80028fc0>] (warn_slowpath_null+0x24/)
 r8:808968c4 r7:00000000 r6:00000000 r5:00000000 r4:c09d8004
[<80028f9c>] (warn_slowpath_null) from [<8039b6b8>] (ahci_enable_ahci+0x74/0x80)
[<8039b644>] (ahci_enable_ahci) from [<8039b6e8>] (ahci_reset_controller+0x24/0)
 r8:bf1ea810 r7:8034cccc r6:bf1ea844 r5:bf0df190 r4:c09d8000 r3:be882c90
[<8039b6c4>] (ahci_reset_controller) from [<8039bfd0>] (ahci_platform_resume_ho)
 r7:8034cccc r6:bf1ea844 r5:bf0df190 r4:bf1ea810
[<8039bf98>] (ahci_platform_resume_host) from [<8039c848>] (imx_ahci_resume+0x2)
 r5:00000000 r4:bf1ea810
[<8039c81c>] (imx_ahci_resume) from [<8034cd00>] (platform_pm_resume+0x34/0x54)
 r4:00000000 r3:8039c81c
[<8034cccc>] (platform_pm_resume) from [<80354210>] (dpm_run_callback.isra.6+0x)
[<803541dc>] (dpm_run_callback.isra.6) from [<80354688>] (device_resume+0xbc/0x)
 r8:00000010 r7:00000010 r6:bf1ea844 r5:00000001 r4:bf1ea810
[<803545cc>] (device_resume) from [<803559d4>] (dpm_resume+0xf4/0x21c)
 r7:80e33544 r6:808c1db8 r5:808c1d60 r4:bf1ea810
[<803558e0>] (dpm_resume) from [<80355cb8>] (dpm_resume_end+0x14/0x20)
 r10:00000000 r9:bebe758c r8:80897608 r7:80dddf50 r6:00000000 r5:00000003
 r4:00000010
[<80355ca4>] (dpm_resume_end) from [<8006b224>] (suspend_devices_and_enter+0x12)
 r4:80dddf50 r3:80dddf58
[<8006b100>] (suspend_devices_and_enter) from [<8006b688>] (pm_suspend+0x218/0x)
 r10:00000004 r8:be64c3c0 r7:00000003 r6:80780a14 r5:00000003 r4:00000000
[<8006b470>] (pm_suspend) from [<8006a234>] (state_store+0x70/0xc0)
 r6:80628228 r5:80780a14 r4:00000003 r3:0000006d
[<8006a1c4>] (state_store) from [<8029934c>] (kobj_attr_store+0x1c/0x28)
 r10:bebe7580 r8:00000004 r7:bebe5f78 r6:be64c3c0 r5:00000004 r4:bebe7580
[<80299330>] (kobj_attr_store) from [<801473c0>] (sysfs_kf_write+0x54/0x58)
[<8014736c>] (sysfs_kf_write) from [<80146804>] (kernfs_fop_write+0xc8/0x188)
 r6:be64c3c0 r5:00000000 r4:00000000 r3:8014736c
[<8014673c>] (kernfs_fop_write) from [<800e18dc>] (vfs_write+0xb0/0x188)
 r10:00a251e8 r9:bebe4000 r8:00000004 r7:bebe5f78 r6:00a251e8 r5:00000004
 r4:be647b80
[<800e182c>] (vfs_write) from [<800e1cb4>] (SyS_write+0x44/0x90)
 r10:00a251e8 r8:00000004 r7:be647b80 r6:be647b80 r5:00000000 r4:00000000
[<800e1c70>] (SyS_write) from [<8000eb20>] (ret_fast_syscall+0x0/0x48)
 r10:00000000 r8:8000ece4 r7:00000004 r6:76ff44d0 r5:00a251e8 r4:00000004
---[ end trace e97275d572c1fe8d ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 722 at drivers/ata/libahci.c:224 ahci_enable_ahci+0x74/0x8)
Modules linked in:
CPU: 0 PID: 722 Comm: sh Tainted: G        W     3.14.0-rc8-next-20140328+ #960
Backtrace:
[<80011cd4>] (dump_backtrace) from [<80011e70>] (show_stack+0x18/0x1c)
 r6:8039b6b8 r5:00000000 r4:00000000 r3:00000000
[<80011e58>] (show_stack) from [<8061d438>] (dump_stack+0x88/0xa4)
[<8061d3b0>] (dump_stack) from [<80028f78>] (warn_slowpath_common+0x70/0x94)
 r5:00000009 r4:00000000
[<80028f08>] (warn_slowpath_common) from [<80028fc0>] (warn_slowpath_null+0x24/)
 r8:808968c4 r7:00000000 r6:00000000 r5:00000000 r4:c09d8004
[<80028f9c>] (warn_slowpath_null) from [<8039b6b8>] (ahci_enable_ahci+0x74/0x80)
[<8039b644>] (ahci_enable_ahci) from [<8039b76c>] (ahci_reset_controller+0xa8/0)
 r8:bf1ea810 r7:c09d8004 r6:00000000 r5:bf0df190 r4:c09d8000 r3:00000001
[<8039b6c4>] (ahci_reset_controller) from [<8039bfd0>] (ahci_platform_resume_ho)
 r7:8034cccc r6:bf1ea844 r5:bf0df190 r4:bf1ea810
[<8039bf98>] (ahci_platform_resume_host) from [<8039c848>] (imx_ahci_resume+0x2)
 r5:00000000 r4:bf1ea810
[<8039c81c>] (imx_ahci_resume) from [<8034cd00>] (platform_pm_resume+0x34/0x54)
 r4:00000000 r3:8039c81c
[<8034cccc>] (platform_pm_resume) from [<80354210>] (dpm_run_callback.isra.6+0x)
[<803541dc>] (dpm_run_callback.isra.6) from [<80354688>] (device_resume+0xbc/0x)
 r8:00000010 r7:00000010 r6:bf1ea844 r5:00000001 r4:bf1ea810
[<803545cc>] (device_resume) from [<803559d4>] (dpm_resume+0xf4/0x21c)
 r7:80e33544 r6:808c1db8 r5:808c1d60 r4:bf1ea810
[<803558e0>] (dpm_resume) from [<80355cb8>] (dpm_resume_end+0x14/0x20)
 r10:00000000 r9:bebe758c r8:80897608 r7:80dddf50 r6:00000000 r5:00000003
 r4:00000010
[<80355ca4>] (dpm_resume_end) from [<8006b224>] (suspend_devices_and_enter+0x12)
 r4:80dddf50 r3:80dddf58
[<8006b100>] (suspend_devices_and_enter) from [<8006b688>] (pm_suspend+0x218/0x)
 r10:00000004 r8:be64c3c0 r7:00000003 r6:80780a14 r5:00000003 r4:00000000
[<8006b470>] (pm_suspend) from [<8006a234>] (state_store+0x70/0xc0)
 r6:80628228 r5:80780a14 r4:00000003 r3:0000006d
[<8006a1c4>] (state_store) from [<8029934c>] (kobj_attr_store+0x1c/0x28)
 r10:bebe7580 r8:00000004 r7:bebe5f78 r6:be64c3c0 r5:00000004 r4:bebe7580
[<80299330>] (kobj_attr_store) from [<801473c0>] (sysfs_kf_write+0x54/0x58)
[<8014736c>] (sysfs_kf_write) from [<80146804>] (kernfs_fop_write+0xc8/0x188)
 r6:be64c3c0 r5:00000000 r4:00000000 r3:8014736c
[<8014673c>] (kernfs_fop_write) from [<800e18dc>] (vfs_write+0xb0/0x188)
 r10:00a251e8 r9:bebe4000 r8:00000004 r7:bebe5f78 r6:00a251e8 r5:00000004
 r4:be647b80
[<800e182c>] (vfs_write) from [<800e1cb4>] (SyS_write+0x44/0x90)
 r10:00a251e8 r8:00000004 r7:be647b80 r6:be647b80 r5:00000000 r4:00000000
[<800e1c70>] (SyS_write) from [<8000eb20>] (ret_fast_syscall+0x0/0x48)
 r10:00000000 r8:8000ece4 r7:00000004 r6:76ff44d0 r5:00a251e8 r4:00000004
---[ end trace e97275d572c1fe8e ]---
PM: resume of devices complete after 262.697 msecs
PM: resume devices took 0.260 seconds
Restarting tasks ... done.
ata1: failed to resume link (SControl 0)
ata1: SATA link down (SStatus 0 SControl 0)
fec 2188000.ethernet eth0: Link is Down
fec 2188000.ethernet eth0: Link is Up - 100Mbps/Full - flow control rx/tx

HOST_AHCI_EN seems to never get set and then we get into the
WARN_ON(1) inside ahci_enable_ahci().

Any ideas?

Thanks,

Fabio Estevam
