From: Hans-Peter Jansen <hpj@urpla.net>
Subject: MCE 4 during install/rescue with dual opteron and promise sata 150/TX4
Date: Fri, 5 Nov 2004 19:35:46 +0100
Message-ID: <200411051935.46987.hpj@urpla.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.177]:61182 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261151AbUKESeO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 5 Nov 2004 13:34:14 -0500
Received: from [212.227.126.179] (helo=mrelayng.kundenserver.de)
	by moutng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1CQ8ub-0002C4-00
	for linux-ide@vger.kernel.org; Fri, 05 Nov 2004 19:34:13 +0100
Received: from [217.231.144.252] (helo=mail)
	by mrelayng.kundenserver.de with asmtp (Exim 3.35 #1)
	id 1CQ8ub-0004Cl-00
	for linux-ide@vger.kernel.org; Fri, 05 Nov 2004 19:34:13 +0100
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

while setting up a new server with SuSE 9.2, I'm constantly caught
by machine check exceptions:

CPU 1: Machine Check Exception:                4 Bank 4: b200000000070f0f
TSC 238d24cdbc

CPU 0: Machine Check Exception:                4 Bank 4: b200000000070f0f
TSC 238d24e25e

Hardware: 
MB: Tyan Thunder K8S Pro (S2882) BIOS v. 2.03
RAM: 2 x 1GB Corsair PC3200 ECC REG. 
CPU: 2 x AMD Opteron 246 
IDE: 2 x Promise SATA 150/TX4 BIOS v. 1.00.0.33
HD: 6 x Western Digital WD740GD 
PS: 600W ETASIS EFRP-3300  

It's enough to have the md background syncer running to hit this.
I was able to track it down to the Promise controllers. Even in a
single controller scenario with 4 hds attached (containing mostly 
raid5 mds), I hit the MCE. Contrary, with the drives attached to 
the on board SIL 3114, it behaves stable (at least to the point to
install the distribution and build Jeff's current libata-2.6 tree
;-)).

Here's the crash immediately following above MCE:

Kernel panic - not syncing: Machine check
 NMI Watchdog detected LOCKUP on CPU1, registers:
CPU 1
Modules linked in: ohci_hcd i2c_amd756 i2c_amd8111 i2c_core evdev 
raid1 dm_mod usbcore raid5 xor xfs sata_sil sata_promise libata sd_mod scsi_mod
Pid: 1489, comm: scsi_eh_0 Tainted: G   M  2.6.10-rc1
RIP: 0010:[<ffffffff8011bd0a>] <ffffffff8011bd0a>{__smp_call_function+122}
RSP: 0018:0000010001e35ca8  EFLAGS: 00000097
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000002
RDX: 0000ffff0000ffff RSI: 0000000000000000 RDI: ffffffff8044e748
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000000 R12: ffffffff8011bdc0
R13: 0000000000000000 R14: 000000238d24c6aa R15: ffffffff8037c41d
FS:  0000002a9588f4c0(0000) GS:ffffffff804c3f80(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000002a95761c50 CR3: 0000000001e32000 CR4: 00000000000006e0
Process scsi_eh_0 (pid: 1489, threadinfo 000001007faec000, task 000001007fad8fd0)
Stack: ffffffff8011bdc0 0000000000000000 0000000000000000 ffffffff00000000
       ffffffff8037c42a 0000000000000000 00000000ffffffff 0000000000000000
       ffffffff803d58c0 ffffffff8011bda7
Call Trace:<ffffffff8011bdc0>{smp_really_stop_cpu+0} <ffffffff8011bda7>{smp_send_stop+55}
<ffffffff801376cc>{panic+204} <ffffffff80118096>{mce_panic+166}
<ffffffff801184fb>{do_machine_check+1115} <ffffffff80111727>{machine_check+127}
<ffffffffa002a150>{:libata:ata_check_status+16}  <EOE> <ffffffffa00383da>{:sata_promise:pdc_eng_timeout+138}
<ffffffffa002e262>{:libata:ata_scsi_error+18} <ffffffffa00044e2>{:scsi_mod:scsi_error_handler+322}
<ffffffff801111ef>{child_rip+8} <ffffffffa00043a0>{:scsi_mod:scsi_error_handler+0}
<ffffffff801111e7>{child_rip+0}

Code: 39 d8 75 f8 85 ed 74 16 8b 44 24 14 39 d8 74 0e 66 66 90 66
console shuts up ...

Here's another one:

CPU 0: Machine Check Exception:                4 Bank 4: b200000000070f0f
TSC 6bdafb0406 
Kernel panic - not syncing: Machine check
 <0>divide error: 0000 [1] SMP 
CPU 0 
Modules linked in: autofs4 usbserial parport_pc lp parport edd freq_table thermal 
processor fan button battery ac ipv6 af_packet joydev sg st sr_mod reiserfs tg3 
ohci_hcd i2c_amd756 i2c_amd8111 i2c_core evdev raid1 dm_mod usbcore raid5 xor xfs 
sata_sil sata_promise libata sd_mod scsi_mod
Pid: 1492, comm: scsi_eh_3 Tainted: G   M  2.6.10-rc1
RIP: 0010:[<ffffffff80134e6d>] <ffffffff80134e6d>{scheduler_tick+1037}
RSP: 0018:ffffffff80447668  EFLAGS: 00010046
RAX: 0000000000000033 RBX: 0000000000000000 RCX: 0000000000000005
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff8044e748
RBP: ffffffff80447698 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000033
R13: 000001003ff0d010 R14: 0000010001e11b60 R15: 0000000000000000
FS:  0000002a95e0a0a0(0000) GS:ffffffff804c3f00(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000002a9556d000 CR3: 0000000000101000 CR4: 00000000000006e0
Process scsi_eh_3 (pid: 1492, threadinfo 000001007faec000, task 000001003ff0d010)
Stack: 0000000000000092 ffffffff8037c41d 0000000000000000 ffffffff803d58c0 
       0000006bdafafd88 ffffffff8037c41d 00000000ffffffff ffffffff8011c864 
       0000000000000046 ffffffff80110ee7 
Call Trace:<IRQ> <ffffffff8011c864>{smp_apic_timer_interrupt+52} <ffffffff80110ee7>{apic_timer_interrupt+99} 
        <EOI> <ffffffff8011bdc0>{smp_really_stop_cpu+0} <ffffffff8011bd6f>{smp_stop_cpu+31} 
       <ffffffff801376cc>{panic+204} <ffffffff80118096>{mce_panic+166} 
       <ffffffff801184fb>{do_machine_check+1115} <ffffffff80111727>{machine_check+127} 
       <ffffffffa002a150>{:libata:ata_check_status+16} <ffffffff80114300>{handle_cpufreq_delayed_get+0} 
       

Code: f7 f3 85 d2 0f 85 9e 00 00 00 be 08 00 00 00 48 c7 c7 48 e7 
RIP <ffffffff80134e6d>{scheduler_tick+1037} RSP <ffffffff80447668>
 <0>Kernel panic - not syncing: Aiee, killing interrupt handler!


Let me know, if I can provide more infos.

Pete
