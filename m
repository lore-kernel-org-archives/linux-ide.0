From: Hans-Peter Jansen <hpj@urpla.net>
Subject: Re: MCE 4 during install/rescue with dual opteron and promise sata 150/TX4
Date: Sat, 6 Nov 2004 13:34:40 +0100
Message-ID: <200411061334.40614.hpj@urpla.net>
References: <200411051935.46987.hpj@urpla.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.176]:62932 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261375AbUKFMc7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 6 Nov 2004 07:32:59 -0500
Received: from [212.227.126.208] (helo=mrelayng.kundenserver.de)
	by moutng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1CQPkZ-0004Dd-00
	for linux-ide@vger.kernel.org; Sat, 06 Nov 2004 13:32:59 +0100
Received: from [217.231.149.213] (helo=mail)
	by mrelayng.kundenserver.de with asmtp (Exim 3.35 #1)
	id 1CQPkZ-0004If-00
	for linux-ide@vger.kernel.org; Sat, 06 Nov 2004 13:32:59 +0100
In-Reply-To: <200411051935.46987.hpj@urpla.net>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi, 

some more data points (based on Jeff's current libata-dev-2.6 tree):
 - problem seems not related to SMP, since it also happen with maxcpus=1
   (should I try with SMP build disabled?)
 - a single bonnie++ -f is enough to trigger it reproducible
   (typically in rewrite test)
 - about 30 sec. before crash, it stops transfering data
 - it most often crashes with a divide error then:

CPU 0: Machine Check Exception:                4 Bank 4: b200000000070f0f
TSC e94837bc24 
Kernel panic - not syncing: Machine check
 <0>divide error: 0000 [1] SMP 
CPU 0 
Modules linked in: autofs4 usbserial parport_pc lp parport freq_table thermal
processor fan button battery ac ipv6 af_packet edd reiserfs joydev sg st 
sr_mod tg3 ohci_hcd i2c_amd756 i2c_amd8111 i2c_core dm_mod evdev raid1 usbcore 
raid5 xor xfs sata_sil sata_promise libata sd_mod scsi_mod
Pid: 1490, comm: scsi_eh_1 Tainted: G   M  2.6.10-rc1
RIP: 0010:[<ffffffff80134d7d>] <ffffffff80134d7d>{scheduler_tick+1037}
RSP: 0018:ffffffff804474e8  EFLAGS: 00010046
RAX: 0000000000000033 RBX: 0000000000000000 RCX: 0000000000000005
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff8044e5c8
RBP: ffffffff80447518 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000033
R13: 000001003fa1c130 R14: 0000010001e11b60 R15: 0000000000000000
FS:  0000007fb782b0a0(0000) GS:ffffffff804c3c80(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000007fbffff7c6 CR3: 0000000000101000 CR4: 00000000000006e0
Process scsi_eh_1 (pid: 1490, threadinfo 000001003fa66000, task 000001003fa1c130)
Stack: 0000000000000096 ffffffff8037c486 0000000000000000 ffffffff803d5bc0 
       000000e94837b697 ffffffff8037c486 00000000ffffffff ffffffff8011caa4 
       0000000000000046 ffffffff80110f47 
Call Trace:<IRQ> <ffffffff8011caa4>{smp_apic_timer_interrupt+52} <ffffffff80110f47>{apic_timer_interrupt+99} 
        <EOI> <ffffffff8011bfaf>{smp_stop_cpu+31} <ffffffff8013762b>{panic+203} 
       <ffffffff801181f8>{print_mce+136} <ffffffff801182e6>{mce_panic+166} 
       <ffffffff8011874b>{do_machine_check+1115} <ffffffff80111787>{machine_check+127} 
       <ffffffffa002a150>{:libata:ata_check_status+16} <ffffffff801144d0>{handle_cpufreq_delayed_get+0} 
       

Code: f7 f3 85 d2 0f 85 9e 00 00 00 be 08 00 00 00 48 c7 c7 c8 e5 
RIP <ffffffff80134d7d>{scheduler_tick+1037} RSP <ffffffff804474e8>
 <0>Kernel panic - not syncing: Aiee, killing interrupt handler!

Any ideas on how to preceed with this one are highly appreciated (until
Monday, then the Promise's will be replaced by a 3ware 9500S-8).

Pete
