From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: v3.6 and up can't find HDD
Date: Fri, 14 Dec 2012 22:50:41 +0800
Message-ID: <50CB3CC1.6000300@intel.com>
References: <CAOQxz3zHBtO=d1agOZQwfM4uVu7ysgAiNyoiziN6KUdu25=cQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:43427 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752282Ab2LNOuQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 14 Dec 2012 09:50:16 -0500
In-Reply-To: <CAOQxz3zHBtO=d1agOZQwfM4uVu7ysgAiNyoiziN6KUdu25=cQQ@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Michael Labriola <michael.d.labriola@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Matthew Garrett <mjg@redhat.com>, linux-ide@vger.kernel.org, "Labriola, Michael" <mlabriol@gdeb.com>, jbolano@gdeb.com, "Dyke, Jayson" <jdyke@gdeb.com>, "Wehrly, Stuart" <swehrly@gdeb.com>

On 12/14/2012 06:32 AM, Michael Labriola wrote:
> Jeff, Matthew,
> 
> After updating from 3.3 to 3.6.8, the kernel fails to detect my hard
> drive.  I'm using the included .config, which I migrated over from a
> 3.3 kernel by just accepting all the defaults.  I bisected the problem
> back to this commit:

Hello Michael,

I believe this is the same problem discussed here:
https://bugzilla.kernel.org/show_bug.cgi?id=49151

And the patch to fix this problem didn't reach Linus' tree yet, but is
already queued in Jeff's NEXT branch:
https://git.kernel.org/?p=linux/kernel/git/jgarzik/libata-dev.git;a=commit;h=5416912af75de9cba5d1c75b99a7888b0bbbd2fb

Please give it a test to see if it fixed your problem, thanks.

Thanks,
Aaron

> 
> 30dcf76acc695cbd2fa919e294670fe9552e16e7 is first bad commit
> commit 30dcf76acc695cbd2fa919e294670fe9552e16e7
> Author: Matthew Garrett <mjg@redhat.com>
> Date:   Mon Jun 25 16:13:04 2012 +0800
> 
>     libata: migrate ACPI code over to new bindings
> 
>     Now that we have the ability to directly glue the ACPI namespace to the
>     driver model in libata, we don't need the custom code to handle the same
>     thing. Remove it and migrate the functions over to the new code.
> 
>     Signed-off-by: Matthew Garrett <mjg@redhat.com>
>     Signed-off-by: Holger Macht <holger@homac.de>
>     Signed-off-by: Lin Ming <ming.m.lin@intel.com>
>     Signed-off-by: Jeff Garzik <jgarzik@redhat.com>
> 
> :040000 040000 6a659a9d4a92b2085f6d0b58484cb2f82cd12cfa
> 125fe5d5fa8b208a08792b03e752571d825465d2 M      drivers
> :040000 040000 b7c3819be4e82ae6e2ac9688055aeb2bc1bc4ebd
> 9cbc8fd15b147a178f723bcdb9e7c34f9868400f M      include
> 
> 
> I've got a Quad-core i7 and a really old dual Xeon (circa-2002) that both
> fail to find any disk drives.  The dual Xeon also spits out a kernel trace
> with a bunch of scsi functions.  Both systems boot up fine if I disable
> CONFIG_ATA_ACPI entirely, but still fail to boot if I pass libata.noacpi=1
> on the command line.
> 
> FYI, I also just tried the latest from Linus' tree and it behaves the same
> exact way.
> 
> Any ideas?  Are there any gotchas regarding the .config for 3.6 that I've
> messed up?
> 
> Here's the traceback from the Xeon:
> 
> [    1.959003] BUG: unable to handle kernel NULL pointer dereference at 00000010
> [    1.959003] IP: [<f844b1b5>] 0xf844b1b4
> [    1.959003] *pdpt = 0000000000000000 *pde = f000ff53f000ff53
> [    1.959003] Oops: 0000 [#1] PREEMPT SMP
> [    1.959003] Modules linked in: pata_acpi floppy
> [    1.959003] Pid: 961, comm: scsi_eh_1 Tainted: G        W
> 3.7.0-ebtaxi3+ #1 Supermicro X5DA8/X5DA8
> [    1.959003] EIP: 0060:[<f844b1b5>] EFLAGS: 00010093 CPU: 3
> [    1.959003] EIP is at 0xf844b1b5
> [    1.959003] EAX: 00000000 EBX: f6b31c8c ECX: 0000025c EDX: f62ca000
> [    1.959003] ESI: f62e0000 EDI: 00000000 EBP: f62e1f14 ESP: f62cbc68
> [    1.959003]  DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068
> [    1.959003] CR0: 8005003b CR2: 00000010 CR3: 00a4a000 CR4: 000007f0
> [    1.959003] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
> [    1.959003] DR6: ffff0ff0 DR7: 00000400
> [    1.959003] Process scsi_eh_1 (pid: 961, ti=f62ca000 task=f606d1f0
> task.ti=f62ca000)
> [    1.959003] Stack:
> [    1.959003]  f62e1f14 f62e140c f6b31c8c f62e0000 f844b256 f62e140c
> f62e0000 00000000
> [    1.959003]  00000802 c0694f33 f62cbcb8 c043c5e6 00000286 f62cbcb8
> fffb7301 c043c61b
> [    1.959003]  f62cbcb8 c0428560 f62e0000 00000200 00000001 0000001f
> c069585f f6894000
> [    1.959003] Call Trace:
> [    1.959003]  [<f844b256>] ? 0xf844b255
> [    1.959003]  [<c0694f33>] ? ata_qc_issue+0x26d/0x292
> [    1.959003]  [<c043c5e6>] ? try_to_del_timer_sync+0x5d/0x63
> [    1.959003]  [<c043c61b>] ? del_timer_sync+0x2f/0x39
> [    1.959003]  [<c0428560>] ? default_spin_lock_flags+0x5/0x9
> [    1.959003]  [<c069585f>] ? ata_exec_internal_sg+0x1d6/0x3d7
> [    1.959003]  [<c043c6c1>] ? del_timer+0x60/0x60
> [    1.959003]  [<c0695acf>] ? ata_exec_internal+0x6f/0x77
> [    1.959003]  [<c0695b63>] ? ata_do_dev_read_id+0x25/0x29
> [    1.959003]  [<c0695c46>] ? ata_dev_read_id+0xdf/0x3f9
> [    1.959003]  [<c069e6f7>] ? ata_eh_reset+0x848/0x980
> [    1.959003]  [<c0455b82>] ? enqueue_task_fair+0x271/0x2d8
> [    1.959003]  [<c069ee47>] ? ata_eh_recover+0x618/0xeb7
> [    1.959003]  [<c06a1bb3>] ? ata_sff_drain_fifo+0x5f/0x5f
> [    1.959003]  [<f844b130>] ? 0xf844b12f
> [    1.959003]  [<c06a2c51>] ? ata_sff_wait_after_reset+0xda/0xda
> [    1.959003]  [<c0408106>] ? __switch_to+0x182/0x2d6
> [    1.959003]  [<c06a1bb3>] ? ata_sff_drain_fifo+0x5f/0x5f
> [    1.959003]  [<c069f728>] ? ata_do_eh+0x42/0x7f
> [    1.959003]  [<c06a1bb3>] ? ata_sff_drain_fifo+0x5f/0x5f
> [    1.959003]  [<c06a2c51>] ? ata_sff_wait_after_reset+0xda/0xda
> [    1.959003]  [<f844b130>] ? 0xf844b12f
> [    1.959003]  [<c06a2c51>] ? ata_sff_wait_after_reset+0xda/0xda
> [    1.959003]  [<c06a1a79>] ? ata_sff_error_handler+0xbb/0xc3
> [    1.959003]  [<c06a1bb3>] ? ata_sff_drain_fifo+0x5f/0x5f
> [    1.959003]  [<c069f989>] ? ata_scsi_port_error_handler+0x1dc/0x498
> [    1.959003]  [<c081a927>] ? _raw_spin_unlock_irqrestore+0x27/0x33
> [    1.959003]  [<c069dddd>] ? ata_scsi_cmd_error_handler+0xc7/0xfc
> [    1.959003]  [<c06808e9>] ? scsi_eh_get_sense+0x18f/0x18f
> [    1.959003]  [<c069fcb2>] ? ata_scsi_error+0x6d/0x90
> [    1.959003]  [<c06808e9>] ? scsi_eh_get_sense+0x18f/0x18f
> [    1.959003]  [<c06809eb>] ? scsi_error_handler+0x102/0x59d
> [    1.959003]  [<c0451c46>] ? try_to_wake_up+0x155/0x15e
> [    1.959003]  [<c06808e9>] ? scsi_eh_get_sense+0x18f/0x18f
> [    1.959003]  [<c044ecf6>] ? complete+0x36/0x44
> [    1.959003]  [<c06808e9>] ? scsi_eh_get_sense+0x18f/0x18f
> [    1.959003]  [<c04478e7>] ? kthread+0x67/0x6c
> [    1.959003]  [<c081e737>] ? ret_from_kernel_thread+0x1b/0x28
> [    1.959003]  [<c0447880>] ? kthread_freezable_should_stop+0x3c/0x3c
> [    1.959003] Code: b6 82 81 01 00 00 e8 58 a1 24 c8 80 bd 81 01 00
> 00 3f 76 17 0f b7 40 12 8d 0c 3f 89 44 fb 04 b8 01 00 00 00 d3 e0 09
> 43 10 eb 15 <0f> b7 40 10 8d 0c 3f 89 44 fb 04 b8 fe ff ff ff d3 c0 21
> 43 10
> [    1.959003] EIP: [<f844b1b5>] 0xf844b1b5 SS:ESP 0068:f62cbc68
> [    1.959003] CR2: 0000000000000010
> [    1.959003] ---[ end trace e2bb848ce42f4dcd ]---
> [    1.959003] note: scsi_eh_1[961] exited with preempt_count 1
