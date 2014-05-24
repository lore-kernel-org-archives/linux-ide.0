From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] ahci: imx: PLL clock needs 100us to settle down
Date: Sat, 24 May 2014 16:35:42 -0300
Message-ID: <CAOMZO5AUFkRY2VJYdTNQvs=vTagFQBaYBynpBRj5e_DsD2EXqQ@mail.gmail.com>
References: <1400330761-2432-1-git-send-email-shawn.guo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vc0-f169.google.com ([209.85.220.169]:47533 "EHLO
	mail-vc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751176AbaEXTfn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 24 May 2014 15:35:43 -0400
Received: by mail-vc0-f169.google.com with SMTP id ij19so7792883vcb.0
        for <linux-ide@vger.kernel.org>; Sat, 24 May 2014 12:35:42 -0700 (PDT)
In-Reply-To: <1400330761-2432-1-git-send-email-shawn.guo@freescale.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Shawn,

On Sat, May 17, 2014 at 9:46 AM, Shawn Guo <shawn.guo@freescale.com> wrote:
> The commit e783c51 (ahci: imx: software workaround for phy reset issue
> in resume) calls imx_sata_phy_reset() to reset phy immediately after
> SATA MPLL is enabled.  It seems working fine mostly, but fails in some
> case as below.
>
> ...
> ahci-imx 2200000.sata: failed to reset phy: -110
> ahci-imx: probe of 2200000.sata failed with error -110
>
> After talking to the designer, we learnt that when enabling i.MX6Q SATA
> MPLL, we need to wait 100us for it to settle down for safety.  Add this
> required delay to fix above failure.

Do you know if other tweaking like this would be necessary to fix
suspend/resume of the ahci-imx driver?

I see the following issue on mx53 and mx6q:

root@freescale /home$ echo mem > /sys/power/state
PM: Syncing filesystems ... done.
Freezing user space processes ... (elapsed 0.001 seconds) done.
Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
Suspending console(s) (use no_console_suspend to debug)
PM: suspend of devices complete after 25.816 msecs
PM: suspend devices took 0.030 seconds
PM: late suspend of devices complete after 4.361 msecs
PM: noirq suspend of devices complete after 4.658 msecs
Disabling non-boot CPUs ...
PM: noirq resume of devices complete after 2.767 msecs
PM: early resume of devices complete after 3.438 msecs
------------[ cut here ]------------
WARNING: CPU: 0 PID: 661 at drivers/ata/libahci.c:224 ahci_enable_ahci+0x74/0x8)
Modules linked in:
CPU: 0 PID: 661 Comm: sh Tainted: G        W     3.15.0-rc5-next-20140521-000027
Backtrace:
[<80011c90>] (dump_backtrace) from [<80011e2c>] (show_stack+0x18/0x1c)
 r6:803a22f4 r5:00000000 r4:00000000 r3:00000000
[<80011e14>] (show_stack) from [<80661e60>] (dump_stack+0x88/0xa4)
[<80661dd8>] (dump_stack) from [<80028fdc>] (warn_slowpath_common+0x70/0x94)
 r5:00000009 r4:00000000
[<80028f6c>] (warn_slowpath_common) from [<80029024>] (warn_slowpath_null+0x24/)
 r8:808f68c4 r7:00000000 r6:00000000 r5:00000000 r4:e0810004
[<80029000>] (warn_slowpath_null) from [<803a22f4>] (ahci_enable_ahci+0x74/0x80)
[<803a2280>] (ahci_enable_ahci) from [<803a2324>] (ahci_reset_controller+0x24/0)
 r8:ddcd9410 r7:80351178 r6:ddcd9444 r5:dde8b850 r4:e0810000 r3:ddf35e90
[<803a2300>] (ahci_reset_controller) from [<803a2c68>] (ahci_platform_resume_ho)
 r7:80351178 r6:ddcd9444 r5:dde8b850 r4:ddcd9410
[<803a2c30>] (ahci_platform_resume_host) from [<803a38f0>] (imx_ahci_resume+0x2)
 r5:00000000 r4:ddcd9410
[<803a38c4>] (imx_ahci_resume) from [<803511ac>] (platform_pm_resume+0x34/0x54)
 r4:00000000 r3:803a38c4
[<80351178>] (platform_pm_resume) from [<803589fc>] (dpm_run_callback.isra.5+0x)
[<803589c8>] (dpm_run_callback.isra.5) from [<80359238>] (device_resume+0xb8/0x)
 r8:00000000 r7:00000010 r6:ddcd9444 r5:00000001 r4:ddcd9410
[<80359180>] (device_resume) from [<8035a28c>] (dpm_resume+0xf4/0x220)
 r8:00000010 r7:8115884c r6:80921d7c r5:80921d24 r4:ddcd9410 r3:dd4dce00
[<8035a198>] (dpm_resume) from [<8035a574>] (dpm_resume_end+0x14/0x20)
 r10:00000000 r9:ddee248c r8:808f761c r7:81102f80 r6:00000000 r5:00000003
 r4:00000010
[<8035a560>] (dpm_resume_end) from [<8006b3e8>] (suspend_devices_and_enter+0x14)
 r4:81102f80 r3:81102f8c
[<8006b2a0>] (suspend_devices_and_enter) from [<8006b868>] (pm_suspend+0x218/0x)
 r10:00000004 r8:dd4a6e80 r7:00000003 r6:807d643c r5:00000003 r4:00000000
[<8006b650>] (pm_suspend) from [<8006a36c>] (state_store+0x70/0xc0)
 r6:8066c430 r5:807d643c r4:00000003 r3:0000006d
[<8006a2fc>] (state_store) from [<8029b27c>] (kobj_attr_store+0x1c/0x28)
 r10:ddee2480 r8:00000004 r7:dd4a5f78 r6:dd4a6e80 r5:00000004 r4:ddee2480
[<8029b260>] (kobj_attr_store) from [<801459cc>] (sysfs_kf_write+0x54/0x58)
[<80145978>] (sysfs_kf_write) from [<80144ddc>] (kernfs_fop_write+0xc8/0x188)
 r6:dd4a6e80 r5:00000000 r4:00000000 r3:80145978
[<80144d14>] (kernfs_fop_write) from [<800e3450>] (vfs_write+0xa8/0x1b0)
 r10:00fabdf8 r9:dd4a4000 r8:00000004 r7:dd4a5f78 r6:00fabdf8 r5:00000004
 r4:dd581a00
[<800e33a8>] (vfs_write) from [<800e3874>] (SyS_write+0x44/0x90)
 r10:00fabdf8 r8:00000004 r7:dd581a00 r6:dd581a00 r5:00000000 r4:00000000
[<800e3830>] (SyS_write) from [<8000eae0>] (ret_fast_syscall+0x0/0x48)
 r10:00000000 r8:8000eca4 r7:00000004 r6:76f6f4d0 r5:00fabdf8 r4:00000004
---[ end trace f936a22e464842c1 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 661 at drivers/ata/libahci.c:224 ahci_enable_ahci+0x74/0x8)
Modules linked in:
CPU: 0 PID: 661 Comm: sh Tainted: G        W     3.15.0-rc5-next-20140521-000027
Backtrace:
[<80011c90>] (dump_backtrace) from [<80011e2c>] (show_stack+0x18/0x1c)
 r6:803a22f4 r5:00000000 r4:00000000 r3:00000000
[<80011e14>] (show_stack) from [<80661e60>] (dump_stack+0x88/0xa4)
[<80661dd8>] (dump_stack) from [<80028fdc>] (warn_slowpath_common+0x70/0x94)
 r5:00000009 r4:00000000
[<80028f6c>] (warn_slowpath_common) from [<80029024>] (warn_slowpath_null+0x24/)
 r8:808f68c4 r7:00000000 r6:00000000 r5:00000000 r4:e0810004
[<80029000>] (warn_slowpath_null) from [<803a22f4>] (ahci_enable_ahci+0x74/0x80)
[<803a2280>] (ahci_enable_ahci) from [<803a23a8>] (ahci_reset_controller+0xa8/0)
 r8:ddcd9410 r7:e0810004 r6:00000000 r5:dde8b850 r4:e0810000 r3:00000001
[<803a2300>] (ahci_reset_controller) from [<803a2c68>] (ahci_platform_resume_ho)
 r7:80351178 r6:ddcd9444 r5:dde8b850 r4:ddcd9410
[<803a2c30>] (ahci_platform_resume_host) from [<803a38f0>] (imx_ahci_resume+0x2)
 r5:00000000 r4:ddcd9410
[<803a38c4>] (imx_ahci_resume) from [<803511ac>] (platform_pm_resume+0x34/0x54)
 r4:00000000 r3:803a38c4
[<80351178>] (platform_pm_resume) from [<803589fc>] (dpm_run_callback.isra.5+0x)
[<803589c8>] (dpm_run_callback.isra.5) from [<80359238>] (device_resume+0xb8/0x)
 r8:00000000 r7:00000010 r6:ddcd9444 r5:00000001 r4:ddcd9410
[<80359180>] (device_resume) from [<8035a28c>] (dpm_resume+0xf4/0x220)
 r8:00000010 r7:8115884c r6:80921d7c r5:80921d24 r4:ddcd9410 r3:dd4dce00
[<8035a198>] (dpm_resume) from [<8035a574>] (dpm_resume_end+0x14/0x20)
 r10:00000000 r9:ddee248c r8:808f761c r7:81102f80 r6:00000000 r5:00000003
 r4:00000010
[<8035a560>] (dpm_resume_end) from [<8006b3e8>] (suspend_devices_and_enter+0x14)
 r4:81102f80 r3:81102f8c
[<8006b2a0>] (suspend_devices_and_enter) from [<8006b868>] (pm_suspend+0x218/0x)
 r10:00000004 r8:dd4a6e80 r7:00000003 r6:807d643c r5:00000003 r4:00000000
[<8006b650>] (pm_suspend) from [<8006a36c>] (state_store+0x70/0xc0)
 r6:8066c430 r5:807d643c r4:00000003 r3:0000006d
[<8006a2fc>] (state_store) from [<8029b27c>] (kobj_attr_store+0x1c/0x28)
 r10:ddee2480 r8:00000004 r7:dd4a5f78 r6:dd4a6e80 r5:00000004 r4:ddee2480
[<8029b260>] (kobj_attr_store) from [<801459cc>] (sysfs_kf_write+0x54/0x58)
[<80145978>] (sysfs_kf_write) from [<80144ddc>] (kernfs_fop_write+0xc8/0x188)
 r6:dd4a6e80 r5:00000000 r4:00000000 r3:80145978
[<80144d14>] (kernfs_fop_write) from [<800e3450>] (vfs_write+0xa8/0x1b0)
 r10:00fabdf8 r9:dd4a4000 r8:00000004 r7:dd4a5f78 r6:00fabdf8 r5:00000004
 r4:dd581a00
[<800e33a8>] (vfs_write) from [<800e3874>] (SyS_write+0x44/0x90)
 r10:00fabdf8 r8:00000004 r7:dd581a00 r6:dd581a00 r5:00000000 r4:00000000
[<800e3830>] (SyS_write) from [<8000eae0>] (ret_fast_syscall+0x0/0x48)
 r10:00000000 r8:8000eca4 r7:00000004 r6:76f6f4d0 r5:00fabdf8 r4:00000004
---[ end trace f936a22e464842c2 ]---
PM: resume of devices complete after 260.366 msecs
PM: resume devices took 0.260 seconds
Restarting tasks ... done.
ata1: failed to resume link (SControl 0)
ata1: SATA link down (SStatus 0 SControl 0)
