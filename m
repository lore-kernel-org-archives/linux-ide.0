From: =?iso-8859-1?Q?R=FAben?= Fonseca <krani1@0x82.com>
Subject: libata [ata_piix] still no resume from S3 ?
Date: Tue, 17 Jul 2007 17:49:27 +0100
Message-ID: <20070717164927.GA13137@0x82.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:49840 "HELO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1756323AbXGQQzi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 17 Jul 2007 12:55:38 -0400
Received: from unknown (HELO server) (krani1@sapo.pt@[82.155.123.4])
          (envelope-sender <krani1@0x82.com>)
          by mta13 (qmail-ldap-1.03) with SMTP
          for <linux-ide@vger.kernel.org>; 17 Jul 2007 16:48:54 -0000
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linux IDE Kernel Mailling List <linux-ide@vger.kernel.org>

Hi to all!

I'm on Debian Sid with kernel 2.6.21 and I still can't resume my laptop
(Sony Vaio SZ2) from S3. Searched on the archive and it seems that SATA 
drives are getting problems when used via the "new" libata. When the
laptop tries to resume, it can't access the hard drive anymore (the LED
never blinks), the filesystem is mounted read-only and of course, the
system hangs. 

Is this still a know problem? Does 2.6.22 solve this already? If you
need more information about my environment, please ask :)

Here's more info about the problem.
I had to manually copy the trace, so I remove the hexadecimal parts
(if you need them, please ask i Will try to copy them too). For now
I just want to know if you can diagnose this problem, or need more info.
So here's the interesting (I think) part of the log after resume:

irq 23: nobody cared (try booting with the "irqpool" option)
 __report_bad_irq
 note_interrupt
 handle_IRQ_event
 handle_fasteoi_irq
 do_IRQ
 do_IRQ
 irq_exit
 smp_acpi_timer
 common_interrupt
 acpi_pm_read
 getnstimeofday
 ktime_get_ts
 ktime_egt
 tick_nohz_restart_sched_tick
 cpu_idle
 start_kernel
 unkown_bootoption
 =====
handlers:
 (ata_interrupt [libata])
 (tifm_7xx1_isr [tifm_7xx1])
Disabling IRQ #23
(...)
ATA: abnormal status 0x7F on port 0x000118cf

And hard drive never cames up.. have to hard reboot the machine..

Any help? TIA

Ruben

-- 
Will work for bandwidth
