From: "Albert Astals Cid" <albert@miraveo.com>
Subject: =?UTF-8?Q?sata=5Fvia=20oops=20on=20copying=20files=3F?=
Date: Tue, 19 May 2009 09:16:55 -0700
Message-ID: <20090519091655.c0bed8b1fc13fcbc567bd8d4c339afd4.8d107e4704.wbe@email.secureserver.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtpoutwbe02.prod.mesa1.secureserver.net ([208.109.78.113]:41831
	"HELO smtpoutwbe02.prod.mesa1.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753006AbZESQXd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 19 May 2009 12:23:33 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Please CC me, i'm not in the list.

Not sure if this or bugzilla is preferred, so doing both, shout me if i
should wait on bugzilla.

Description of the hardware:
 * Soekris net 4526 motherboard [0]
 * MiniPci to Compact Flash adapter that uses Via VT6421A chipset [1] 

When booting up the sata_via module says

sata_via 0000:00:11.0: version 2.4                                      
       
sata_via 0000:00:11.0: routed to hard irq line 11                       
       
scsi0 : sata_via                                                        
       
scsi1 : sata_via                                                        
       
scsi2 : sata_via                                                        
       
ata1: SATA max UDMA/133 port i16@0xe000 bmdma 0xe040 irq 11             
       
ata2: SATA max UDMA/133 port i16@0xe010 bmdma 0xe048 irq 11             
       
ata3: PATA max UDMA/133 port i16@0xe020 bmdma 0xe050 irq 11             
       
ata1: SATA link down (SStatus 0 SControl 310)                           
       
ata2: SATA link down (SStatus 0 SControl 310)                           
       
irq 11: nobody cared (try booting with the "irqpoll" option)            
       
Pid: 787, comm: scsi_eh_2 Not tainted 2.6.29.3 #1                       
       
Call Trace:                                                             
       
 [<c0134c16>] __report_bad_irq+0x2e/0x6f                                
       
 [<c0134d44>] note_interrupt+0xed/0x149                                 
       
 [<c013537c>] handle_level_irq+0x8d/0xcf                                
       
 [<c01043d8>] do_IRQ+0x50/0x68                                          
       
 [<c0103227>] common_interrupt+0x27/0x30                                
       
 [<c0119484>] ? __do_softirq+0x31/0xbb                                  
       
 [<c0119533>] do_softirq+0x25/0x2a                                      
       
 [<c011965e>] irq_exit+0x28/0x5c                                        
       
 [<c01043dd>] do_IRQ+0x55/0x68                                          
       
 [<c0103227>] common_interrupt+0x27/0x30                                
       
 [<c01f007b>] ? cfq_insert_request+0x21b/0x383                          
       
 [<c0250000>] ? sata_link_init_spd+0xc1/0x185                           
       
 [<c01f8cbc>] ? iowrite8+0x20/0x30                                      
       
 [<c025ba7c>] ata_sff_dev_select+0x1c/0x26                              
       
 [<c025d7a1>] ata_sff_softreset+0x53/0x106                              
       
 [<c0257447>] ata_do_reset+0x49/0x4f                                    
       
 [<c025d74e>] ? ata_sff_softreset+0x0/0x106                             
       
 [<c02587e1>] ata_eh_reset+0x431/0xa10                                  
       
 [<c025d854>] ? ata_sff_prereset+0x0/0x98                               
       
 [<c025d74e>] ? ata_sff_softreset+0x0/0x106                             
       
 [<c0259c9e>] ata_eh_recover+0x270/0xa79                                
       
 [<c025d74e>] ? ata_sff_softreset+0x0/0x106                             
       
 [<c025bc7c>] ? ata_sff_postreset+0x0/0x5b                              
       
 [<c025d74e>] ? ata_sff_softreset+0x0/0x106                             
       
 [<c025d854>] ? ata_sff_prereset+0x0/0x98                               
       
 [<c025d74e>] ? ata_sff_softreset+0x0/0x106                             
       
 [<c025d854>] ? ata_sff_prereset+0x0/0x98                               
       
 [<c025a62b>] ata_do_eh+0x2b/0x6d                                       
       
 [<c025bc7c>] ? ata_sff_postreset+0x0/0x5b                              
       
 [<c025bc72>] ata_sff_error_handler+0x13d/0x147                         
       
 [<c025bc7c>] ? ata_sff_postreset+0x0/0x5b                              
       
 [<c025d74e>] ? ata_sff_softreset+0x0/0x106                             
       
 [<c025ad6c>] ata_scsi_error+0x1fb/0x46b                                
       
 [<c02456dd>] scsi_error_handler+0x6a/0x298                             
       
 [<c031e075>] ? schedule+0x290/0x2eb                                    
       
 [<c011327f>] ? complete+0x2a/0x48                                      
       
 [<c0245673>] ? scsi_error_handler+0x0/0x298                            
       
 [<c012472f>] kthread+0x39/0x5e                                         
       
 [<c01246f6>] ? kthread+0x0/0x5e                                        
       
 [<c0103397>] kernel_thread_helper+0x7/0x10                             
       
handlers:                                                               
       
[<c025d04c>] (ata_sff_interrupt+0x0/0x205)                              
       
Disabling IRQ #11                                                       
       
ata3.01: ATA-0: CF CARD 4GB, Ver2.19K, max UDMA/100                     
       
ata3.01: 7880544 sectors, multi 0: LBA
ata3.01: limited to UDMA/33 due to 40-wire cable
ata3.01: configured for UDMA/33
ata3.01: configured for UDMA/33
ata3: EH complete
scsi 2:0:1:0: Direct-Access     ATA      CF CARD 4GB      Ver2 PQ: 0
ANSI: 5
sd 2:0:1:0: [sda] 7880544 512-byte hardware sectors: (4.03 GB/3.75 GiB)
sd 2:0:1:0: [sda] Write Protect is off
sd 2:0:1:0: [sda] Mode Sense: 00 3a 00 00
sd 2:0:1:0: [sda] Write cache: disabled, read cache: enabled, doesn't
support
DPO or FUA
sd 2:0:1:0: [sda] 7880544 512-byte hardware sectors: (4.03 GB/3.75 GiB)
sd 2:0:1:0: [sda] Write Protect is off
sd 2:0:1:0: [sda] Mode Sense: 00 3a 00 00
sd 2:0:1:0: [sda] Write cache: disabled, read cache: enabled, doesn't
support
DPO or FUA
 sda: sda1 sda2
sd 2:0:1:0: [sda] Attached SCSI disk


When copying files with a simple script like
i=1; while [ true ]; do echo "Round $i"; cp blabla blabla2; sync; rm
blabla2;
sync; i=$(($i + 1)); done

I get crashes like

BUG: unable to handle kernel paging request at 6545a000
IP: [<c012d8eb>] tick_nohz_stop_idle+0x20/0x49
*pde = 00000000
Oops: 0002 [#1] PREEMPT
last sysfs file: /sys/class/net/lo/operstate
Modules linked in:

Pid: 0, comm: swapper Not tainted (2.6.29.3 #1)
EIP: 0060:[<c012d8eb>] EFLAGS: 00010002 CPU: 0
EIP is at tick_nohz_stop_idle+0x20/0x49
EAX: cdd635da EBX: 00000000 ECX: 0000016c EDX: 00000054
ESI: ffffffcf EDI: 00000000 EBP: c03f7f58 ESP: c03f7f58
 DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068
Process swapper (pid: 0, ti=c03f6000 task=c03c5388 task.ti=c03f6000)
Stack:
 c03f7f64 c012d926 c041a8e0 c03f7f6c c01193bc c03f7f80 c01043a1 c041a8e0
 00049800 c03f0000 c03f7fc0 c0103227 c041a8e0 c0459e0c 00000054 00049800
 c03f0000 c03f7fc0 c03f6000 c3a4007b c03c007b 00000000 ffffffcf c0107662
Call Trace:
 [<c012d926>] ? tick_check_idle+0x12/0x3f
 [<c01193bc>] ? irq_enter+0x2f/0x41
 [<c01043a1>] ? do_IRQ+0x19/0x68
 [<c0103227>] ? common_interrupt+0x27/0x30
 [<c0107662>] ? default_idle+0x28/0x3d
 [<c0101dde>] ? cpu_idle+0x30/0x5e
 [<c0318c9a>] ? rest_init+0x66/0x68
Code: 02 00 00 00 8d 65 f8 5b 5e 5d c3 83 3d d8 9f 45 c0 00 55 89 e5 74
3b e8
20 9f ff ff c7 05 d8 9f 45 c0 00 00 00 00 a3 fc 9f 45 c0 <89> 15 00 a0
45 c0 2b
05 dc 9f 45 c0 1b 15
EIP: [<c012d8eb>] tick_nohz_stop_idle+0x20/0x49 SS:ESP 0068:c03f7f58


and

BUG: unable to handle kernel NULL pointer dereference at (null)
IP: [<c0129f24>] update_wall_time+0x1a/0x6f2
*pde = 00000000
Oops: 0000 [#1] PREEMPT
last sysfs file: /sys/class/net/lo/operstate
Modules linked in:

Pid: 2416, comm: bash Not tainted (2.6.29.3 #1)
EIP: 0060:[<c0129f24>] EFLAGS: 00010202 CPU: 0
EIP is at update_wall_time+0x1a/0x6f2
EAX: 00000001 EBX: 00000001 ECX: c03c9100 EDX: 00000000
ESI: 00000000 EDI: ffffff9c EBP: c281ff30 ESP: c281fed4
 DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 0068
Process bash (pid: 2416, ti=c281e000 task=c3996670 task.ti=c281e000)
Stack:
 c380c320 c39a254c 00067442 00000031 3ba096ed 00000001 00000001 00000000
 c399669c aa88243a 0000000d c3996670 00000000 c399669c c281ff20 c0111777
 c03235d4 00000000 00000008 c281ff3c 00000001 00000000 c03c98e0 c281ff4c
Call Trace:
 [<c0111777>] ? task_tick_fair+0x1b/0x90
 [<c011cb87>] ? do_timer+0x1e/0xab
 [<c01676bd>] ? mntput_no_expire+0x19/0xf9
 [<c012ca9e>] ? tick_periodic+0x3c/0x72
 [<c012cae3>] ? tick_handle_periodic+0xf/0x68
 [<c0104754>] ? timer_interrupt+0x3c/0x44
 [<c01342dc>] ? handle_IRQ_event+0x21/0x48
 [<c0135368>] ? handle_level_irq+0x79/0xcf
 [<c01043d8>] ? do_IRQ+0x50/0x68
 [<c0103227>] ? common_interrupt+0x27/0x30
Code: 9e 45 c0 55 89 e5 f7 d9 f7 da e8 e9 eb fe ff 5d c3 55 89 e5 57 56
53 83
ec 54 83 3d 30 2c 3f c0 00 0f 85 d4 06 00 00 a1 68 9e 45 <c0> ff 50 10
8b 1d 68
9e 45 c0 8b 4b 14 2b
EIP: [<c0129f24>] update_wall_time+0x1a/0x6f2 SS:ESP 0068:c281fed4



I've tried passing the irqpoll option to the kernel boot line, the
sata_via
boot warning disappears but the crashes are still present.

Can it be workaround? Like e.g. making it go at PIO mode 0 i don't need
huge speeds here.

Any idea of what can be causing this? Is it a problem of the
motherboard? Of the adapter? Of the software?

Albert

[0] http://www.soekris.com/net4526.htm
[1]
http://www.globalamericaninc.com/Mini_PCI_Modules-Storage_Controller/c55_429/p1801120/1801120_-_Mini-PCI_Type_IIIB_124-pin_Storage_Interface_Module_Supports_1x_44-pin_EIDE,_2x_SATA-150,_1x_Compact_Flash/product_info.html

